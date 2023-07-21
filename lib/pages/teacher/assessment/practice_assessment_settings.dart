import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/Teacher/get_assessment_model.dart';
import 'package:qna_test/Entity/Teacher/response_entity.dart';
import '../../../Components/custom_incorrect_popup.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import '../../../Entity/Teacher/assessment_settings_model.dart';
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
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PracticeAssessmentSettings extends StatefulWidget {
  PracticeAssessmentSettings({
    Key? key,
  }) : super(key: key);

  bool assessment = false;




  @override
  PracticeAssessmentSettingsState createState() =>
      PracticeAssessmentSettingsState();
}

class PracticeAssessmentSettingsState extends State<PracticeAssessmentSettings> {
  //List<Question> finalQuesList = [];
  UserDetails userDetails=UserDetails();
  final formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  CreateAssessmentModel assessment =CreateAssessmentModel(questions: []);
  TextEditingController questionSearchController = TextEditingController();

  List<questionModel.Question> questionList = [];
  int pageNumber=1;
  int questionStart=0;
  List<List<String>> temp = [];

  //-----------------------------------------------------------
  String category='Test';
  DateTime timeLimit = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TextEditingController timeLimitController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  int numberOfAttempts=1;
  bool allowGuestStudent=false;
  bool showAnswerSheetPractice=false;
  bool makeAssessmentInactive=false;
  bool allowPublishPublic=false;
  bool showName=false;
  bool showEmail=false;
  bool showWhatsappGroup=false;
  int totalMarks=0;
  GetAssessmentModel getAssessmentModel=GetAssessmentModel();
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
        print(questionList.length);
        print(index);
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
    Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    assessment =Provider.of<CreateAssessmentProvider>(context, listen: false).getAssessment;
    getAssessmentModel=Provider.of<EditAssessmentProvider>(context, listen: false).getAssessment;
    questionList=Provider.of<QuestionPrepareProviderFinal>(context, listen: false).getAllQuestion;
    print("_____________________________________________________________");
    debugPrint(getAssessmentModel.toString());
    for(int i=0;i<getAssessmentModel.questions!.length;i++){
      totalMarks=totalMarks + getAssessmentModel.questions![i].questionMark!;
    }
    CreateAssessmentModel createassessmentModel=CreateAssessmentModel(questions: []);
    createassessmentModel.assessmentId=getAssessmentModel.assessmentId;
    createassessmentModel.userId=userDetails.userId;
    createassessmentModel.assessmentCode=getAssessmentModel.assessmentCode;
    createassessmentModel.assessmentType=getAssessmentModel.assessmentType;
    createassessmentModel.assessmentStatus=getAssessmentModel.assessmentStatus;
    createassessmentModel.totalScore=getAssessmentModel.totalScore;
    createassessmentModel.totalQuestions=getAssessmentModel.questions!.length;
    createassessmentModel.assessmentStartdate=getAssessmentModel.assessmentStartdate;
    createassessmentModel.assessmentEnddate=getAssessmentModel.assessmentEnddate;
    createassessmentModel.assessmentDuration=getAssessmentModel.assessmentDuration;
    createassessmentModel.subject=getAssessmentModel.subject;
    createassessmentModel.topic=getAssessmentModel.topic;
    createassessmentModel.subTopic=assessment.subTopic;
    createassessmentModel.createAssessmentModelClass=getAssessmentModel.getAssessmentModelClass;
    createassessmentModel.assessmentSettings=getAssessmentModel.assessmentSettings;
    int totalMark=0;
    for(int i=0;i<getAssessmentModel.questions!.length;i++){
      Question tempQues=Question(questionId: getAssessmentModel.questions![i].questionId,questionMarks: getAssessmentModel.questions![i].questionMark);
      createassessmentModel.questions?.add(tempQues);
      totalMark=totalMark+getAssessmentModel.questions![i].questionMark!;
      Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(getAssessmentModel.questions![i]);
    }
    getAssessmentModel.totalScore=totalMark;
    createassessmentModel.totalScore=totalMark;
    Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(createassessmentModel);
    assessment=createassessmentModel;
    numberOfAttempts=assessment.assessmentSettings!.allowedNumberOfTestRetries!;
    allowGuestStudent=assessment.assessmentSettings!.allowGuestStudent!;
    showAnswerSheetPractice=assessment.assessmentSettings!.showAnswerSheetDuringPractice!;
    showName=assessment.assessmentSettings!.showAdvisorName!;
    showEmail=assessment.assessmentSettings!.showAdvisorEmail!;
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
          if (constraints.maxWidth<= 960 && constraints.maxWidth>=500) {
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
                              "Assessment Settings",
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
                        padding: EdgeInsets.only(
                            top: height * 0.023,
                            left: height * 0.045,
                            right: height * 0.045),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height : height * 0.15,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(82, 165, 160, 0.08),
                                  border: Border.all(
                                    color: const Color.fromRGBO(28, 78, 80, 0.08),
                                  ),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(5))
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.02, right: width * 0.02,top: height*0.01,bottom: height*0.01),
                                child: SizedBox(
                                  width: width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
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
                                          Icon(
                                            Icons.circle,
                                            color: const Color.fromRGBO(255, 153, 0, 1),
                                            size: MediaQuery
                                                .of(context)
                                                .copyWith()
                                                .size
                                                .height *
                                                0.02,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height*0.01,),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${assessment.createAssessmentModelClass} | ${assessment.subTopic}",
                                          style: TextStyle(
                                              fontSize: height * 0.016,
                                              fontFamily: "Inter",
                                              color:
                                              const Color.fromRGBO(28, 78, 80, 1),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(height: height*0.01,),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(AppLocalizations.of(context)!.assessment_id_caps,
                                              style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  color:
                                                  const Color.fromRGBO(28, 78, 80, 1),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(getAssessmentModel.assessmentCode!,
                                              style: TextStyle(
                                                color: const Color.fromRGBO(82, 165, 160, 1),
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],),
                                      ),
                                      Divider(),
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
                                                "${assessment.questions!.length}",
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01,),
                            Container(
                              height: height * 0.55,
                              width: width * 0.93,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.35,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Access Control",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Number of attempts allowed",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
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
                                                            setState(() {
                                                              if(numberOfAttempts!=1){
                                                                numberOfAttempts=numberOfAttempts-1;
                                                              }
                                                            });
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
                                                                '${numberOfAttempts}',
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
                                                            setState(() {
                                                              numberOfAttempts=numberOfAttempts+1;
                                                            });
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
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Allow guest students",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    allowGuestStudent,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        allowGuestStudent =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Show answer sheet in Practice",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showAnswerSheetPractice,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showAnswerSheetPractice =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Allow paper to be published in public LOOQ (Library of Online Questions)",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    allowPublishPublic,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        allowPublishPublic =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.3,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Advisor Details",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Show my name",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showName,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showName =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Show my email",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showEmail,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showEmail =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Show Whatsapp Group",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showWhatsappGroup,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showWhatsappGroup =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.17,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Make Assessment Inactive",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    makeAssessmentInactive,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        makeAssessmentInactive =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Text(
                                                "This assessment will not be visible to students and other teachers. ",
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          ],
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      AssessmentSettings assessmentSettings = AssessmentSettings();
                                      assessmentSettings.allowedNumberOfTestRetries = numberOfAttempts;
                                      assessmentSettings.numberOfDaysAfterTestAvailableForPractice = 0;
                                      assessmentSettings.allowGuestStudent = allowGuestStudent;
                                      assessmentSettings.showSolvedAnswerSheetInAdvisor = false;
                                      assessmentSettings.showAnswerSheetDuringPractice = showAnswerSheetPractice;
                                      assessmentSettings.showAdvisorName = showName;
                                      assessmentSettings.showAdvisorEmail = showEmail;
                                      assessmentSettings.notAvailable = false;
                                      assessmentSettings.avalabilityForPractice = true;
                                      showName?assessmentSettings.advisorName=userDetails.firstName:assessmentSettings.advisorName=null;
                                      showEmail?assessmentSettings.advisorEmail=userDetails.email:assessmentSettings.advisorEmail=null;
                                      assessment.assessmentSettings = assessmentSettings;
                                      CreateAssessmentModel finalAssessment = CreateAssessmentModel(questions: []);
                                      finalAssessment.assessmentId=assessment.assessmentId;
                                      finalAssessment.assessmentSettings=assessment.assessmentSettings;
                                      //finalAssessment.questions?.addAll(getAssessmentModel.questions as Iterable<Question>);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                                child:
                                                CircularProgressIndicator(
                                                  color: Color.fromRGBO(
                                                      48, 145, 139, 1),
                                                ));
                                          });
                                      ResponseEntity statusCode = ResponseEntity();
                                      makeAssessmentInactive?
                                      statusCode = await QnaService
                                          .makeInactiveAssessmentTeacherService(
                                        assessment.assessmentSettings!,
                                        assessment
                                            .assessmentId!,
                                        assessment.assessmentType!,
                                        'inactive',userDetails,
                                      ):
                                      statusCode = await QnaService
                                          .editAssessmentTeacherService(
                                          finalAssessment, assessment.assessmentId!,userDetails);
                                      if (statusCode.code == 200) {
                                        Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                        Navigator.of(context).pushNamedAndRemoveUntil('/assessmentLandingPage', ModalRoute.withName('/teacherSelectionPage'));
                                      }
                                      else{
                                        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                        print(assessment);
                                        print(statusCode.code);
                                        print(statusCode.data);
                                        print(statusCode.message);
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(Icons.check, color: Colors.white),
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
                                      "Save Changes",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )));
          }
          else if(constraints.maxWidth > 960) {
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
                              "Assessment Settings",
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
                        padding: EdgeInsets.only(
                            left: height * 0.5,
                            right: height * 0.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height : height * 0.15,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(82, 165, 160, 0.08),
                                  border: Border.all(
                                    color: const Color.fromRGBO(28, 78, 80, 0.08),
                                  ),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(5))
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.02, right: width * 0.02,top: height*0.01,bottom: height*0.01),
                                child: SizedBox(
                                  width: width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
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
                                          Icon(
                                            Icons.circle,
                                            color: const Color.fromRGBO(255, 153, 0, 1),
                                            size: MediaQuery
                                                .of(context)
                                                .copyWith()
                                                .size
                                                .height *
                                                0.02,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height*0.01,),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${assessment.createAssessmentModelClass} | ${assessment.subTopic}",
                                          style: TextStyle(
                                              fontSize: height * 0.016,
                                              fontFamily: "Inter",
                                              color:
                                              const Color.fromRGBO(28, 78, 80, 1),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(height: height*0.01,),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(AppLocalizations.of(context)!.assessment_id_caps,
                                              style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  color:
                                                  const Color.fromRGBO(28, 78, 80, 1),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(getAssessmentModel.assessmentCode!,
                                              style: TextStyle(
                                                color: const Color.fromRGBO(82, 165, 160, 1),
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],),
                                      ),
                                      Divider(),
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
                                                "${assessment.questions!.length}",
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01,),
                            Container(
                              height: height * 0.55,
                              width: width * 0.93,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.35,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Access Control",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.2,
                                                    child: Text(
                                                      "Number of attempts allowed",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: height * 0.04,
                                                    width: width * 0.15,
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
                                                            setState(() {
                                                              if(numberOfAttempts!=1){
                                                                numberOfAttempts=numberOfAttempts-1;
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            height: height * 0.03,
                                                            width: width * 0.02,
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
                                                            width: width * 0.05,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: const Color.fromRGBO(28, 78, 80, 0.5),),
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(5)),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${numberOfAttempts}',
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
                                                            setState(() {
                                                              numberOfAttempts=numberOfAttempts+1;
                                                            });
                                                          },
                                                          child: Container(
                                                            height: height * 0.03,
                                                            width: width * 0.02,

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
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.1,
                                                    child: Text(
                                                      "Allow guest students",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    allowGuestStudent,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        allowGuestStudent =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.1,
                                                    child: Text(
                                                      "Show answer sheet in Practice",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showAnswerSheetPractice,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showAnswerSheetPractice =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.1,
                                                    child: Text(
                                                      "Allow paper to be published in public LOOQ (Library of Online Questions)",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    allowPublishPublic,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        allowPublishPublic =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.3,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Advisor Details",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.1,
                                                    child: Text(
                                                      "Show my name",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showName,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showName =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.1,
                                                    child: Text(
                                                      "Show my email",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showEmail,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showEmail =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.1,
                                                    child: Text(
                                                      "Show Whatsapp Group",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showWhatsappGroup,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showWhatsappGroup =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.17,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.2,
                                                    child: Text(
                                                      "Make Assessment Inactive",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    makeAssessmentInactive,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        makeAssessmentInactive =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Text(
                                                "This assessment will not be visible to students and other teachers. ",
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          ],
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      AssessmentSettings assessmentSettings = AssessmentSettings();
                                      assessmentSettings.allowedNumberOfTestRetries = numberOfAttempts;
                                      assessmentSettings.numberOfDaysAfterTestAvailableForPractice = 0;
                                      assessmentSettings.allowGuestStudent = allowGuestStudent;
                                      assessmentSettings.showSolvedAnswerSheetInAdvisor = false;
                                      assessmentSettings.showAnswerSheetDuringPractice = showAnswerSheetPractice;
                                      assessmentSettings.showAdvisorName = showName;
                                      assessmentSettings.showAdvisorEmail = showEmail;
                                      assessmentSettings.notAvailable = false;
                                      assessmentSettings.avalabilityForPractice = true;
                                      showName?assessmentSettings.advisorName=userDetails.firstName:assessmentSettings.advisorName=null;
                                      showEmail?assessmentSettings.advisorEmail=userDetails.email:assessmentSettings.advisorEmail=null;
                                      assessment.assessmentSettings = assessmentSettings;
                                      CreateAssessmentModel finalAssessment = CreateAssessmentModel(questions: []);
                                      finalAssessment.assessmentId=assessment.assessmentId;
                                      finalAssessment.assessmentSettings=assessment.assessmentSettings;
                                      //finalAssessment.questions?.addAll(getAssessmentModel.questions as Iterable<Question>);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                                child:
                                                CircularProgressIndicator(
                                                  color: Color.fromRGBO(
                                                      48, 145, 139, 1),
                                                ));
                                          });
                                      ResponseEntity statusCode = ResponseEntity();
                                      makeAssessmentInactive?
                                      statusCode = await QnaService
                                          .makeInactiveAssessmentTeacherService(
                                        assessment.assessmentSettings!,
                                        assessment
                                            .assessmentId!,
                                        assessment.assessmentType!,
                                        'inactive',userDetails,
                                      ):
                                      statusCode = await QnaService
                                          .editAssessmentTeacherService(
                                          finalAssessment, assessment.assessmentId!,userDetails);
                                      if (statusCode.code == 200) {
                                        Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                        Navigator.of(context).pushNamedAndRemoveUntil('/assessmentLandingPage', ModalRoute.withName('/teacherSelectionPage'));
                                      }
                                      else{
                                        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                        print(assessment);
                                        print(statusCode.code);
                                        print(statusCode.data);
                                        print(statusCode.message);
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(Icons.check, color: Colors.white),
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
                                      "Save Changes",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )));
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
                              "Assessment Settings",
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
                              height : height * 0.15,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(82, 165, 160, 0.08),
                                  border: Border.all(
                                    color: const Color.fromRGBO(28, 78, 80, 0.08),
                                  ),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(5))
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.02, right: width * 0.02,top: height*0.01,bottom: height*0.01),
                                child: SizedBox(
                                  width: width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
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
                                          Icon(
                                            Icons.circle,
                                            color: const Color.fromRGBO(255, 153, 0, 1),
                                            size: MediaQuery
                                                .of(context)
                                                .copyWith()
                                                .size
                                                .height *
                                                0.02,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height*0.01,),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${assessment.createAssessmentModelClass} | ${assessment.subTopic}",
                                          style: TextStyle(
                                              fontSize: height * 0.016,
                                              fontFamily: "Inter",
                                              color:
                                              const Color.fromRGBO(28, 78, 80, 1),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(height: height*0.01,),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(AppLocalizations.of(context)!.assessment_id_caps,
                                              style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  color:
                                                  const Color.fromRGBO(28, 78, 80, 1),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(getAssessmentModel.assessmentCode!,
                                              style: TextStyle(
                                                color: const Color.fromRGBO(82, 165, 160, 1),
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],),
                                      ),
                                      Divider(),
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
                                                "${assessment.questions!.length}",
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01,),
                            Container(
                              height: height * 0.55,
                              width: width * 0.93,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.35,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Access Control",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Number of attempts allowed",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
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
                                                            setState(() {
                                                              if(numberOfAttempts!=1){
                                                                numberOfAttempts=numberOfAttempts-1;
                                                              }
                                                            });
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
                                                                '${numberOfAttempts}',
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
                                                            setState(() {
                                                              numberOfAttempts=numberOfAttempts+1;
                                                            });
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
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Allow guest students",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    allowGuestStudent,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        allowGuestStudent =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Show answer sheet in Practice",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showAnswerSheetPractice,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showAnswerSheetPractice =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Allow paper to be published in public LOOQ (Library of Online Questions)",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    allowPublishPublic,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        allowPublishPublic =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.3,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Advisor Details",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Show my name",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showName,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showName =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Show my email",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showEmail,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showEmail =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Show Whatsapp Group",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    showWhatsappGroup,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        showWhatsappGroup =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.17,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Make Assessment Inactive",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  FlutterSwitch(
                                                    activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                    inactiveColor:
                                                    const Color
                                                        .fromRGBO(
                                                        217,
                                                        217,
                                                        217,
                                                        1),
                                                    width: 65.0,
                                                    height: 35.0,
                                                    value:
                                                    makeAssessmentInactive,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        makeAssessmentInactive =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015,right:width*0.03),
                                              child: Text(
                                                "This assessment will not be visible to students and other teachers. ",
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          ],
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      AssessmentSettings assessmentSettings = AssessmentSettings();
                                      assessmentSettings.allowedNumberOfTestRetries = numberOfAttempts;
                                      assessmentSettings.numberOfDaysAfterTestAvailableForPractice = 0;
                                      assessmentSettings.allowGuestStudent = allowGuestStudent;
                                      assessmentSettings.showSolvedAnswerSheetInAdvisor = false;
                                      assessmentSettings.showAnswerSheetDuringPractice = showAnswerSheetPractice;
                                      assessmentSettings.showAdvisorName = showName;
                                      assessmentSettings.showAdvisorEmail = showEmail;
                                      assessmentSettings.notAvailable = false;
                                      assessmentSettings.avalabilityForPractice = true;
                                      showName?assessmentSettings.advisorName=userDetails.firstName:assessmentSettings.advisorName=null;
                                      showEmail?assessmentSettings.advisorEmail=userDetails.email:assessmentSettings.advisorEmail=null;
                                      assessment.assessmentSettings = assessmentSettings;
                                      CreateAssessmentModel finalAssessment = CreateAssessmentModel(questions: []);
                                      finalAssessment.assessmentId=assessment.assessmentId;
                                      finalAssessment.assessmentSettings=assessment.assessmentSettings;
                                      //finalAssessment.questions?.addAll(getAssessmentModel.questions as Iterable<Question>);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                                child:
                                                CircularProgressIndicator(
                                                  color: Color.fromRGBO(
                                                      48, 145, 139, 1),
                                                ));
                                          });
                                      ResponseEntity statusCode = ResponseEntity();
                                      makeAssessmentInactive?
                                      statusCode = await QnaService
                                          .makeInactiveAssessmentTeacherService(
                                        assessment.assessmentSettings!,
                                        assessment
                                            .assessmentId!,
                                        assessment.assessmentType!,
                                        'inactive',userDetails,
                                      ):
                                      statusCode = await QnaService
                                          .editAssessmentTeacherService(
                                          finalAssessment, assessment.assessmentId!,userDetails);
                                      if (statusCode.code == 200) {
                                        Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                        Navigator.of(context).pushNamedAndRemoveUntil('/assessmentLandingPage', ModalRoute.withName('/teacherSelectionPage'));
                                      }
                                      else{
                                        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                        print(assessment);
                                        print(statusCode.code);
                                        print(statusCode.data);
                                        print(statusCode.message);
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(Icons.check, color: Colors.white),
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
                                      "Save Changes",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
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

