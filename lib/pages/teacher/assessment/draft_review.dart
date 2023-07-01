import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/Teacher/response_entity.dart';
import '../../../Components/custom_incorrect_popup.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import '../../../Entity/Teacher/get_assessment_model.dart';
import '../../../Entity/user_details.dart';
import '../../../EntityModel/CreateAssessmentModel.dart';
import '../../../Providers/LanguageChangeProvider.dart';
import '../../../Providers/create_assessment_provider.dart';
import '../../../Providers/edit_assessment_provider.dart';
import '../../../Providers/question_prepare_provider_final.dart';
import '../../../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Components/today_date.dart';
import '../../../DataSource/http_url.dart';
import 'package:qna_test/Entity/Teacher/question_entity.dart' as questionModel;
class DraftReview extends StatefulWidget {
  DraftReview({
    Key? key,
  }) : super(key: key);

  bool assessment = false;




  @override
  DraftReviewState createState() =>
      DraftReviewState();
}

class DraftReviewState extends State<DraftReview> {
  //List<Question> finalQuesList = [];
  UserDetails userDetails=UserDetails();
  final formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  CreateAssessmentModel assessment =CreateAssessmentModel(questions: [],removeQuestions: []);
  TextEditingController questionSearchController = TextEditingController();

  List<questionModel.Question> questionList = [];
  int pageNumber=1;
  int questionStart=0;
  List<int> selectedQuesIndex=[];
  List<questionModel.Question> selectedQuestion=[];
  List<List<String>> temp = [];
  GetAssessmentModel getAssessment=GetAssessmentModel();
  List<int> getAssessmentQuestionId=[];
  int totalMarks=0;
  List<List<String>> choiceText= [];

  alertDialogDeleteQuestion(BuildContext context, double height,int index) {
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(AppLocalizations.of(context)!.no,
        // 'No',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(AppLocalizations.of(context)!.yes,
        //'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () async {
        if(getAssessmentQuestionId.contains(questionList[index].questionId)){
          assessment.removeQuestions?.add(questionList[index].questionId);
        }
        questionList.removeAt(index);
        setState(() {
        });
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.info,
            color: Color.fromRGBO(238, 71, 0, 1),
          ),
          Text(
            AppLocalizations.of(context)!.confirm,
            //'Confirm',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        //AppLocalizations.of(context)!.want_to_del_qn,
        'Are you sure you want to delete this Question?',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontWeight: FontWeight.w400),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context, double height) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        AppLocalizations.of(context)!.no,
        //'No',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        AppLocalizations.of(context)!.yes,
        //'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () async {

      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.confirm,
        //'Confirm',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(0, 106, 100, 1),
            fontWeight: FontWeight.w700),
      ),
      content: Text(
        AppLocalizations.of(context)!.sure_to_submit_qn_bank,
        //'Are you sure you want to submit to My Question Bank?',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontWeight: FontWeight.w400),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getQuestionData(String search) async {
    ResponseEntity responseEntity =
    await QnaService.getQuestionBankService(10, pageNumber, search,userDetails);
    List<questionModel.Question> questions = [];
    if (responseEntity.code == 200) {
      questions = List<questionModel.Question>.from(
          responseEntity.data.map((x) => questionModel.Question.fromJson(x)));
    }
    else{
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: CustomDialog(
            title:
            AppLocalizations.of(context)!.alert_popup,
            //'Alert',
            content:
            AppLocalizations.of(context)!.no_question_found,
            //'No Questions Found.',
            button:
            AppLocalizations.of(context)!.retry,
            //"Retry",
          ),
        ),
      );
    }
    setState(() {
      pageNumber++;
      questionList.addAll(questions);
      //pageNumber++;
      //searchVal = search;
    });
    //Navigator.of(context).pop();
  }

  getInitData(String search) async {
    ResponseEntity responseEntity =
    await QnaService.getQuestionBankService(10, pageNumber, search,userDetails);
    List<questionModel.Question> questions = [];
    if (responseEntity.code == 200) {
      questions = List<questionModel.Question>.from(
          responseEntity.data.map((x) => questionModel.Question.fromJson(x)));
    }
    else{
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: CustomDialog(
            title:
            AppLocalizations.of(context)!.alert_popup,
            //'Alert',
            content:
            AppLocalizations.of(context)!.no_question_found,
            //'No Questions Found.',
            button:
            AppLocalizations.of(context)!.retry,
            //"Retry",
          ),
        ),
      );
    }
    for(int j=0;j<questionList.length;j++){
      List<String> chTemp=[];
      if (questionList[j].question != "MCQ") {
        for (int i = 0; i < questionList[j].choices!.length; i++) {
          if (questionList[j].choices![i].rightChoice!) {
            chTemp.add(questionList[j].choices![i].choiceText!);
          }
        }
      }
      temp.add(chTemp);
    }
    setState(() {
      pageNumber++;
      questionList.addAll(questions);
      //pageNumber++;
      //searchVal = search;
    });
    //Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    assessment =Provider.of<CreateAssessmentProvider>(context, listen: false).getAssessment;
    assessment.removeQuestions=[];
    getAssessment =Provider.of<EditAssessmentProvider>(context, listen: false).getAssessment;
    questionList=Provider.of<QuestionPrepareProviderFinal>(context, listen: false).getAllQuestion;
    for(int i=0;i<questionList.length;i++){
      selectedQuesIndex.add(i);
    }
    for(int i=0;i<getAssessment.questions!.length;i++){
      getAssessmentQuestionId.add(getAssessment.questions![i].questionId);
      totalMarks=totalMarks+getAssessment.questions![i].questionMark!;
      if(getAssessment.questions![i].questionType=='MCQ'){
        choiceText.add([]);
        for(int j=0;j<getAssessment.questions![i].choices!.length;j++){
          choiceText[i].add(getAssessment.questions![i].choices![j].choiceText!);
        }
      }else{
        choiceText.add(['']);
      }
      
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > webWidth) {
            return Center(
              child: SizedBox(
                width: webWidth,
                child: WillPopScope(
                    onWillPop: () async => false,
                    child: Scaffold(
                        resizeToAvoidBottomInset: true,
                        endDrawer: const EndDrawerMenuTeacher(),
                        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                        appBar: AppBar(
                          // leading: IconButton(
                          //   icon: const Icon(
                          //     Icons.chevron_left,
                          //     size: 40.0,
                          //     color: Colors.white,
                          //   ),
                          //   onPressed: () {
                          //     Navigator.of(context).pop();
                          //   },
                          // ),
                          automaticallyImplyLeading: false,
                          toolbarHeight: height * 0.100,
                          centerTitle: true,
                          title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.add,
                                  //'ADD',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: height * 0.0175,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.add_my_qn,
                                  //"MY QUESTION",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: height * 0.0225,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ]),
                          flexibleSpace: Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    end: Alignment.bottomCenter,
                                    begin: Alignment.topCenter,
                                    colors: [
                                      Color.fromRGBO(0, 106, 100, 1),
                                      Color.fromRGBO(82, 165, 160, 1),
                                    ])),
                          ),
                        ),
                        body: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.0375,
                                    left: webWidth * 0.055,
                                    right: webWidth * 0.055),
                                child: Container(
                                  height: height * 0.1412,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(82, 165, 160, 0.08),
                                      border: Border.all(
                                        color: const Color.fromRGBO(28, 78, 80, 0.08),
                                      ),
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(20))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: webWidth * 0.02, right: webWidth * 0.02),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "sd",
                                              style: TextStyle(
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  color:
                                                  const Color.fromRGBO(28, 78, 80, 1),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              todayDate(),
                                              style: TextStyle(
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  color:
                                                  const Color.fromRGBO(82, 165, 160, 1),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: webWidth * 0.02, right: webWidth * 0.02),
                                        child: Divider(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: webWidth * 0.02),
                                        child: Row(
                                          children: [
                                            Text(
                                              "fdv",
                                              style: TextStyle(
                                                  fontSize: height * 0.0175,
                                                  fontFamily: "Inter",
                                                  color:
                                                  const Color.fromRGBO(82, 165, 160, 1),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              width: webWidth * 0.01,
                                            ),
                                            Text(
                                              '|',
                                              style: TextStyle(
                                                  fontSize: height * 0.0175,
                                                  fontFamily: "Inter",
                                                  color:
                                                  const Color.fromRGBO(82, 165, 160, 1),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              width: webWidth * 0.01,
                                            ),
                                            Text(
                                              "dfsv",
                                              style: TextStyle(
                                                  fontSize: height * 0.0175,
                                                  fontFamily: "Inter",
                                                  color:
                                                  const Color.fromRGBO(82, 165, 160, 1),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: webWidth * 0.02),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "dfv",
                                            style: TextStyle(
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(102, 102, 102, 1),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: webWidth * 0.055, right: webWidth * 0.055),
                                    height: height * 0.55,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // ListView.builder(
                                          //   itemCount: quesList.length,
                                          //     itemBuilder: (context, index){
                                          //     return
                                          //     }),
                                          // for (int i = 0; i < finalQuesList.length; i++)
                                          //   QuestionPreview(
                                          //     height: height,
                                          //     width: webWidth,
                                          //     question: finalQuesList[i],
                                          //     quesNum: i,
                                          //   ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: height * 0.47,
                                      left: webWidth * 0.8,
                                      child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    '/teacherPrepareQnBank',
                                                    arguments: [false, '']
                                                );

                                                // Navigator.push(
                                                //   context,
                                                //   PageTransition(
                                                //     type: PageTransitionType.rightToLeft,
                                                //     child: TeacherPrepareQnBank(
                                                //         assessment: false,
                                                //         ),
                                                //   ),
                                                // );
                                              },
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      '/teacherPrepareQnBank',
                                                      arguments: [
                                                        false,
                                                        ''
                                                      ]);

                                                  // Navigator.push(
                                                  //   context,
                                                  //   PageTransition(
                                                  //     type: PageTransitionType.rightToLeft,
                                                  //     child: TeacherPrepareQnBank(
                                                  //         assessment: false,
                                                  //         ),
                                                  //   ),
                                                  // );
                                                },
                                                backgroundColor:
                                                const Color.fromRGBO(28, 78, 80, 1),
                                                child: const Icon(Icons.add),
                                              )
                                          ))
                                  )
                                ],
                              ),
                              SizedBox(height: height * 0.02),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                  minimumSize: const Size(280, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39),
                                  ),
                                ),
                                //shape: StadiumBorder(),
                                onPressed: () {
                                  showAlertDialog(context, height);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.submit,
                                  //'Submit',
                                  style: TextStyle(
                                      fontSize: height * 0.025,
                                      fontFamily: "Inter",
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ))),
              ),
            );
          }
          else{
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    endDrawer: const EndDrawerMenuTeacher(),
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: Colors.black,size: height * 0.05),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          size: height * 0.06,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      //automaticallyImplyLeading: false,
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              //AppLocalizations.of(context)!.my_qns,
                              "Review Questions",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white
                        ),
                      ),
                    ),
                    body: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(right:width * 0.04,left:width * 0.04),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height : height * 0.05,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(82, 165, 160, 0.08),
                                  border: Border.all(
                                    color: const Color.fromRGBO(28, 78, 80, 0.08),
                                  ),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(5))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.02, right: width * 0.02),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${assessment.subject} | ${assessment.topic}",
                                          style: TextStyle(
                                              fontSize: height * 0.02,
                                              fontFamily: "Inter",
                                              color:
                                              const Color.fromRGBO(28, 78, 80, 1),
                                              fontWeight: FontWeight.w700),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Dialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(17))),
                                                    child: SingleChildScrollView(
                                                      scrollDirection: Axis.vertical,
                                                      child: Container(
                                                        height: height * 0.6,
                                                        width: width * 0.88,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.black38,
                                                              width: 1),
                                                          borderRadius:
                                                          BorderRadius.circular(17),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: width * 0.02,
                                                              right: width * 0.02,
                                                              top: height * 0.02,
                                                              bottom: height * 0.02),
                                                          child: Form(
                                                            key: formKey,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                  Alignment.centerLeft,
                                                                  child: Text(
                                                                    // AppLocalizations.of(
                                                                    //     context)!
                                                                    //     .assessment_title,
                                                                    'Question Details',
                                                                    style: TextStyle(
                                                                        fontSize: height *
                                                                            0.02,
                                                                        fontFamily: "Inter",
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  thickness: 2,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                  child: Align(
                                                                    alignment:
                                                                    Alignment.centerLeft,
                                                                    child: Text(
                                                                      //AppLocalizations.of(context)!.my_qn_bank,
                                                                      "Subject",
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontSize: height * 0.02,
                                                                        fontFamily: "Inter",
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02),
                                                                  child: TextField(
                                                                    controller: subjectController,
                                                                    keyboardType: TextInputType.text,
                                                                    decoration: InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: height * 0.016),
                                                                      hintText: "Type here",
                                                                      enabledBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      focusedBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                  child: Align(
                                                                    alignment:
                                                                    Alignment.centerLeft,
                                                                    child: Text(
                                                                      //AppLocalizations.of(context)!.my_qn_bank,
                                                                      "Topic",
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontSize: height * 0.02,
                                                                        fontFamily: "Inter",
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02),
                                                                  child: TextField(
                                                                    controller: topicController,
                                                                    keyboardType: TextInputType.text,
                                                                    decoration: InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: height * 0.016),
                                                                      hintText: "Type here",
                                                                      enabledBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      focusedBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                  child: Align(
                                                                    alignment:
                                                                    Alignment.centerLeft,
                                                                    child: Text(
                                                                      //AppLocalizations.of(context)!.my_qn_bank,
                                                                      "Degree",
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontSize: height * 0.02,
                                                                        fontFamily: "Inter",
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02),
                                                                  child: TextField(
                                                                    controller: degreeController,
                                                                    keyboardType: TextInputType.text,
                                                                    decoration: InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: height * 0.016),
                                                                      hintText: "Type here",
                                                                      enabledBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      focusedBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                  child: Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text(
                                                                      //AppLocalizations.of(context)!.my_qn_bank,
                                                                      "Semester (optional)",
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontSize: height * 0.02,
                                                                        fontFamily: "Inter",
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02),
                                                                  child: TextField(
                                                                    controller: semesterController,
                                                                    keyboardType: TextInputType.text,
                                                                    decoration: InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: height * 0.016),
                                                                      hintText: "Type here",
                                                                      enabledBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      focusedBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: height * 0.02,
                                                                ),
                                                                ElevatedButton(
                                                                  style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                    const Color
                                                                        .fromRGBO(
                                                                        82, 165, 160,
                                                                        1),
                                                                    minimumSize:
                                                                    const Size(280, 48),
                                                                    shape:
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          39),
                                                                    ),
                                                                  ),
                                                                  onPressed: () async {
                                                                    bool valid = formKey
                                                                        .currentState!
                                                                        .validate();
                                                                    if (valid) {
                                                                      // for(int i =0;i<finalQuesList.length;i++){
                                                                      //   finalQuesList[i].subject=subjectController.text;
                                                                      //   finalQuesList[i].topic=topicController.text;
                                                                      //   finalQuesList[i].degreeStudent=degreeController.text;
                                                                      //   finalQuesList[i].semester=semesterController.text;
                                                                      //   Provider.of<QuestionPrepareProviderFinal>(context, listen: false).updateQuestionList(i,finalQuesList[i]);
                                                                      //   setState(() {
                                                                      //
                                                                      //   });
                                                                      // }
                                                                      Navigator.of(context).pop();
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    // AppLocalizations.of(
                                                                    //     context)!
                                                                    //     .save_continue,
                                                                    'Save',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        height * 0.025,
                                                                        fontFamily: "Inter",
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            255, 255,
                                                                            255, 1),
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.01,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Total Marks: ",
                                      style: TextStyle(
                                          fontSize: height * 0.016,
                                          fontFamily: "Inter",
                                          color:
                                          const Color.fromRGBO(51, 51, 51, 1),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "$totalMarks",
                                      style: TextStyle(
                                          fontSize: height * 0.016,
                                          fontFamily: "Inter",
                                          color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Total Questions: ",
                                      style: TextStyle(
                                          fontSize: height * 0.016,
                                          fontFamily: "Inter",
                                          color:
                                          const Color.fromRGBO(51, 51, 51, 1),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "${questionList.length}",
                                      style: TextStyle(
                                          fontSize: height * 0.016,
                                          fontFamily: "Inter",
                                          color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.015,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tap question to view and edit',
                                style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.016),
                              ),
                            ),
                            SizedBox(height: height * 0.01,),
                            Container(
                              height: height * 0.6,
                              width: width * 0.93,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (int i=questionStart;i<questionList.length;i++)
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Color.fromRGBO(82, 165, 160, 0.5),),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Q${i+1} ",
                                                              style: TextStyle(
                                                                  fontSize: height * 0.016,
                                                                  fontFamily: "Inter",
                                                                  color:
                                                                  Color.fromRGBO(28, 78, 80, 1),
                                                                  fontWeight: FontWeight.w700),
                                                            ),
                                                            Text(
                                                              questionList[i].questionType!,
                                                              style: TextStyle(
                                                                  fontSize: height * 0.016,
                                                                  fontFamily: "Inter",
                                                                  color:
                                                                  Color.fromRGBO(28, 78, 80, 1),
                                                                  fontWeight: FontWeight.w700),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Marks ",
                                                              style: TextStyle(
                                                                  fontSize: height * 0.016,
                                                                  fontFamily: "Inter",
                                                                  color:
                                                                  Color.fromRGBO(28, 78, 80, 1),
                                                                  fontWeight: FontWeight.w700),
                                                            ),
                                                            Container(
                                                              height: height * 0.04,
                                                              width: width * 0.3,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: Color.fromRGBO(82, 165, 160, 0.5),),
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(5)),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap:(){
                                                                      if(questionList[i].questionMark!=null || questionList[i].questionMark!=0){
                                                                        questionList[i].questionMark=questionList[i].questionMark!-1;
                                                                        Provider.of<QuestionPrepareProviderFinal>(context, listen: false).updatemark(questionList[i].questionMark!, i);
                                                                        setState(() {
                                                                          totalMarks--;
                                                                        });
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                      height: height * 0.03,
                                                                      width: width * 0.05,
                                                                      child: Icon(
                                                                        Icons.remove,
                                                                        size: height * 0.02,
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: width * 0.005,left: width * 0.005),
                                                                    child: Container(
                                                                      height: height * 0.03,
                                                                      width: width * 0.1,
                                                                      decoration: BoxDecoration(
                                                                        border: Border.all(color: const Color.fromRGBO(28, 78, 80, 0.5),),
                                                                        borderRadius: BorderRadius.all(
                                                                            Radius.circular(5)),
                                                                      ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          '${questionList[i].questionMark}',
                                                                          style: TextStyle(
                                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: height * 0.016),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      if(questionList[i].questionMark!=null){
                                                                        questionList[i].questionMark=questionList[i].questionMark!+1;
                                                                        Provider.of<QuestionPrepareProviderFinal>(context, listen: false).updatemark(questionList[i].questionMark!, i);
                                                                        setState(() {
                                                                          totalMarks++;
                                                                        });
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                      height: height * 0.03,
                                                                      width: width * 0.05,

                                                                      child: Icon(
                                                                        Icons.add,
                                                                        size: height * 0.02,
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        "${questionList[i].question}",
                                                        style: TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        choiceText[i].toString().substring(1,choiceText[i].toString().length-1),
                                                        // temp[i].toString().substring(1,temp[i].toString().length-1),
                                                        style: TextStyle(
                                                            fontSize: height * 0.016,
                                                            fontFamily: "Inter",
                                                            color:
                                                            Color.fromRGBO(82, 165, 160, 1),
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                      color: Color.fromRGBO(204, 204, 204, 0.5),
                                                    ),
                                                    Align(
                                                        alignment: Alignment.centerRight,
                                                        child: IconButton(
                                                          onPressed: () async {
                                                            alertDialogDeleteQuestion(context,height,i);
                                                            setState(() {
                                                              questionList;
                                                            });

                                                            //Provider.of<QuestionPrepareProviderFinal>(context, listen: false).removeQuestion(widget.question.questionId);

                                                          },
                                                          icon: Icon(
                                                            Icons.delete_outline,
                                                            size: height * 0.03,
                                                            color: const Color.fromRGBO(82, 165, 160, 1),),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Padding(
                              padding: EdgeInsets.only(right:width * 0.02,left: width * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/draftAddQuestion',
                                          );
                                        },
                                        child: Icon(Icons.add, color: const Color.fromRGBO(82, 165, 160, 1),),
                                        style: ElevatedButton.styleFrom(
                                          side: const BorderSide(
                                            width: 2,
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(20),
                                          backgroundColor: Colors.white, // <-- Button color
                                        ),
                                      ),
                                      Text(
                                        //AppLocalizations.of(context)!.subject_topic,
                                          "Add Question",
                                          //textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          String assessmentCode='';
                                          ResponseEntity statusCode = ResponseEntity();
                                          assessment.assessmentType = 'test';
                                          assessment.assessmentStatus='inprogress';
                                          assessment.questions=[];
                                          int totalMark=0;
                                          for(int i=0;i<selectedQuestion.length;i++){
                                            Question tempQues=Question(questionId: selectedQuestion[i].questionId,questionMarks: selectedQuestion[i].questionMark);
                                            assessment.questions?.add(tempQues);
                                            totalMark=totalMark+selectedQuestion[i].questionMark!;
                                          }
                                          assessment.totalScore=totalMark;
                                          print("---------------------------------------------------------------");
                                          debugPrint(assessment.toString());
                                          statusCode = await QnaService.editAssessmentTeacherService(assessment, assessment.assessmentId!,userDetails);
                                          if (statusCode.code == 200) {
                                            print(statusCode.message);
                                            // assessmentCode = statusCode.data.toString().substring(18, statusCode.data
                                            //     .toString()
                                            //     .length -
                                            //     1);

                                            Navigator.of(context).pushNamedAndRemoveUntil('/assessmentLandingPage', ModalRoute.withName('/teacherSelectionPage'));
                                          }

                                        },
                                        child: Icon(Icons.save, color: const Color.fromRGBO(82, 165, 160, 1),),
                                        style: ElevatedButton.styleFrom(
                                          side: const BorderSide(
                                            width: 2,
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(20),
                                          backgroundColor: Colors.white, // <-- Button color
                                        ),
                                      ),
                                      Text(
                                        //AppLocalizations.of(context)!.subject_topic,
                                          "Save Draft",
                                          //textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          List<questionModel.Question> ques=[];
                                          ques.addAll(questionList);
                                          Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                          for(questionModel.Question q in ques) {
                                            Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(q);
                                          }
                                          Navigator.pushNamed(
                                            context,
                                            '/draftAssessmentSettings',
                                          );
                                        },
                                        child: Icon(Icons.arrow_forward_outlined, color: Colors.white),
                                        style: ElevatedButton.styleFrom(
                                          side: const BorderSide(
                                            width: 2,
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(20),
                                          backgroundColor: const Color.fromRGBO(82, 165, 160, 1),// <-- Button color
                                        ),
                                      ),
                                      Text(
                                        //AppLocalizations.of(context)!.subject_topic,
                                          "Continue",
                                          //textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )));
          }

        }
    );
  }
}
