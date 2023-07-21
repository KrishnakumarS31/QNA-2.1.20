import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/Teacher/response_entity.dart';
import '../../../Components/custom_incorrect_popup.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import '../../../Entity/user_details.dart';
import '../../../EntityModel/CreateAssessmentModel.dart';
import '../../../Providers/LanguageChangeProvider.dart';
import '../../../Providers/create_assessment_provider.dart';
import '../../../Providers/question_prepare_provider_final.dart';
import '../../../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Components/today_date.dart';
import '../../../DataSource/http_url.dart';
import 'package:qna_test/Entity/Teacher/question_entity.dart' as questionModel;
class DraftAddQuestion extends StatefulWidget {
  DraftAddQuestion({
    Key? key,
  }) : super(key: key);

  bool assessment = false;




  @override
  DraftAddQuestionState createState() =>
      DraftAddQuestionState();
}

class DraftAddQuestionState extends State<DraftAddQuestion> {
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
  List<int> selectedQuesId=[];
  List<questionModel.Question> selectedQuestion=[];
  List<questionModel.Question> providerQuestionList=[];
  String totalQuestionBank='';

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
        continueButton,
        cancelButton,

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

  showDialogSave(BuildContext context, double height) {
    // set up the buttons
    Widget cancelButton =
    ElevatedButton(
      style:
      ElevatedButton
          .styleFrom(
        backgroundColor:Colors.white,
        // const Color
        //     .fromRGBO(
        //     82, 165, 160,
        //     1),
        minimumSize:
        Size(height * 0.13, height * 0.05),
        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius
              .circular(
              39),
        ),
      ),
      onPressed: () async {
        Navigator.of(context).pop();
      },
      child: Text(
        // AppLocalizations.of(
        //     context)!
        //     .save_continue,
        AppLocalizations.of(context)!.no,
        style: TextStyle(
            fontSize:
            height * 0.025,
            fontFamily: "Inter",
            color: const Color
                .fromRGBO(
                82,165,160,1),
            fontWeight:
            FontWeight
                .w600),
      ),
    );
    Widget continueButton = ElevatedButton(
      style:
      ElevatedButton
          .styleFrom(
        backgroundColor:
        //Colors.white,
        const Color
            .fromRGBO(
            82, 165, 160,
            1),
        minimumSize:
        Size(height * 0.13, height * 0.05),
        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius
              .circular(
              39),
        ),
      ),
      child: Text(
        AppLocalizations.of(context)!.yes,
        //'Yes',
       style: TextStyle(
          fontSize:
          height * 0.025,
          fontFamily: "Inter",
          color: Colors.white,
          fontWeight:
          FontWeight
              .w600),
      ),
      onPressed: () async {
        assessment.userId=userDetails.userId;
        assessment.totalQuestions=questionList.length;
        assessment.assessmentType='practice';
        assessment.assessmentStatus = 'inprogress';
        assessment.assessmentStartdate = DateTime.now().microsecondsSinceEpoch;
        for(int i=0;i<questionList.length;i++){
          Question tempQues=Question(questionId: questionList[i].questionId,questionMarks: questionList[i].questionMark);
          assessment.questions?.add(tempQues);
        }
        assessment.totalScore=questionList.length;
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
        statusCode = await QnaService.createAssessmentTeacherService(assessment,userDetails);
        if (statusCode.code == 200) {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamedAndRemoveUntil('/assessmentLandingPage', ModalRoute.withName('/teacherSelectionPage'));
        }
        else{
          print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
          print(assessment);
          print(statusCode.code);
          print(statusCode.data);
          print(statusCode.message);
        }
      },
      // {
      //   showDialog(
      //       context: context,
      //       builder: (context) {
      //         return const Center(
      //             child: CircularProgressIndicator(
      //               color: Color.fromRGBO(48, 145, 139, 1),
      //             ));
      //       });
      //
      //   create_question_model.CreateQuestionModel createQuestionModel = create_question_model.CreateQuestionModel();
      //   createQuestionModel.questions = finalQuesList;
      //   createQuestionModel.authorId = userDetails.userId;
      //   print("-------------------------------------------------------");
      //   print(createQuestionModel);
      //   ResponseEntity statusCode =
      //   await QnaService.createQuestionTeacherService(createQuestionModel,userDetails);
      //   Navigator.of(context).pop();
      //   if (statusCode.code == 200) {
      //     Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'));
      //     // Navigator.pushNamed(
      //     //     context,
      //     //     '/teacherMyQuestionBank',
      //     //     arguments: widget.assessment
      //     // );
      //     //Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'),arguments: widget.assessment);
      //   }
      // },
    );
    // set up the AlertDialog
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
        //AppLocalizations.of(context)!.sure_to_submit_qn_bank,
        'Do you want to save this assessment as a draft and create new questions?',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontWeight: FontWeight.w400),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            continueButton,
            cancelButton,
          ],
        ),

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
          responseEntity.data['questions'].map((x) => questionModel.Question.fromJson(x)));
      totalQuestionBank=responseEntity.data['total_count'].toString();
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
      totalQuestionBank;
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
          responseEntity.data['questions'].map((x) => questionModel.Question.fromJson(x)));
      totalQuestionBank=responseEntity.data['total_count'].toString();
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
      totalQuestionBank;

    });
    //Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    assessment =Provider.of<CreateAssessmentProvider>(context, listen: false).getAssessment;

    subjectController.text=assessment.subject!;
    topicController.text=assessment.topic!;
    degreeController.text=assessment.createAssessmentModelClass!;
    semesterController.text=assessment.subTopic ?? '';
    providerQuestionList=Provider.of<QuestionPrepareProviderFinal>(context, listen: false).getAllQuestion;
    for(questionModel.Question q in providerQuestionList){
      selectedQuesId.add(q.questionId);
      selectedQuestion.add(q);
    }
    getInitData('');
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
                              "Add Questions",
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
                                                                  child: TextFormField(
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
                                                                    validator: (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return
                                                                          'Enter Subject';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    onChanged: (value) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
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
                                                                  child: TextFormField(
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
                                                                    validator: (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return
                                                                          'Enter Topic';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    onChanged: (value) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
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
                                                                  child: TextFormField(
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
                                                                    validator: (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return
                                                                          'Enter Degree';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    onChanged: (value) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
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
                                                                      assessment.subject=subjectController.text;
                                                                      assessment.topic=topicController.text;
                                                                      assessment.createAssessmentModelClass=degreeController.text;
                                                                      assessment.subTopic=semesterController.text;
                                                                      Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(assessment);
                                                                      setState(() {
                                                                        assessment;
                                                                      });
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
                                                fontSize: height * 0.02,
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                //AppLocalizations.of(context)!.lib_online_qn,
                                "Search My Questions  ",
                                style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: height * 0.016,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextField(
                              onChanged: (t){
                                setState(() {
                                });
                              },
                              controller: questionSearchController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                //floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintStyle: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.016),
                                hintText: "Subject, Topic, Degree",
                                suffixIcon:
                                Column(children: [
                                  Container(
                                      height: height * 0.035,
                                      width: width * 0.07,
                                      decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        // borderRadius:
                                        // BorderRadius.all(Radius.circular(100)),
                                        color: questionSearchController.text.isEmpty?
                                        Color.fromRGBO(153, 153, 153, 0.5):Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      child: IconButton(
                                        iconSize: height * 0.025,
                                        color: const Color.fromRGBO(255, 255, 255, 1),
                                        onPressed: () {
                                          questionStart=0;
                                          questionList=[];
                                          pageNumber=1;
                                          getQuestionData(questionSearchController.text);
                                        },
                                        icon: const Icon(Icons.search),
                                      )),
                                ]
                                ),
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
                            SizedBox(height: height * 0.015,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tap to select & add questions',
                                style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.016),
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
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (int i=questionStart;i<questionList.length;i++)
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap:(){
                                            if(selectedQuesId.contains(questionList[i].questionId)){
                                              int index = selectedQuesId.indexOf(questionList[i].questionId);
                                              selectedQuesId.removeAt(index);
                                              selectedQuestion.removeAt(index);
                                            }else{
                                              selectedQuesId.add(questionList[i].questionId);
                                              questionList[i].questionType=="MCQ"?questionList[i].questionMark=1:questionList[i].questionMark=0;
                                              selectedQuestion.add(questionList[i]);
                                            }
                                            setState(() {
                                              selectedQuesId;
                                              selectedQuestion;
                                            });
                                          },
                                          child: QuestionPreview(
                                            height: height,
                                            width: width,
                                            question: questionList[i],
                                            selected: !selectedQuesId.contains(questionList[i].questionId),
                                          ),
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left:height * 0.02),
                                          child: Text(
                                            'Showing ${questionStart + 1} to ${questionStart+10 <questionList.length?questionStart+10:questionList.length} of $totalQuestionBank',
                                            style: TextStyle(
                                                color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.016),
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap:(){
                                                    if(questionList.length>11){
                                                      setState(() {
                                                        pageNumber--;
                                                        questionStart=questionStart-10;
                                                        questionList.removeRange(questionList.length-10, questionList.length);
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: height * 0.03,
                                                    width: width * 0.09,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(5)),
                                                    ),
                                                    child: Icon(
                                                      Icons.keyboard_double_arrow_left,
                                                      size: height * 0.015,
                                                      color: const Color.fromRGBO(28, 78, 80, 1),),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: width * 0.005,left: width * 0.005),
                                                  child: Container(
                                                    height: height * 0.03,
                                                    width: width * 0.09,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(5)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '${questionStart==0?1:((questionStart/10)+1).toInt()}',
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right:height * 0.02),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        questionStart=questionStart+10;
                                                      });
                                                      getQuestionData(questionSearchController.text);
                                                    },
                                                    child: Container(
                                                      height: height * 0.03,
                                                      width: width * 0.1,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(5)),
                                                      ),
                                                      child: Icon(
                                                        Icons.keyboard_double_arrow_right,
                                                        size: height * 0.015,
                                                        color: const Color.fromRGBO(28, 78, 80, 1),),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: height * 0.05,)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
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
                                          showDialogSave(context,height);
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
                                          "New Question",
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
                                          assessment.userId=userDetails.userId;
                                          assessment.totalQuestions=questionList.length;
                                          assessment.assessmentType='practice';
                                          assessment.assessmentStatus = 'inprogress';
                                          assessment.assessmentStartdate = DateTime.now().microsecondsSinceEpoch;
                                          assessment.questions=[];
                                          int mark=0;
                                          for(int i=0;i<selectedQuestion.length;i++){
                                            Question tempQues=Question(questionId: selectedQuestion[i].questionId,questionMarks: selectedQuestion[i].questionMark);
                                            assessment.questions?.add(tempQues);
                                            mark=mark+selectedQuestion[i].questionMark!;
                                          }
                                          assessment.totalScore=mark;
                                          assessment.totalQuestions=selectedQuestion.length;
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
                                          statusCode = await QnaService.editAssessmentTeacherService(assessment, assessment.assessmentId!,userDetails);
                                          //statusCode = await QnaService.createAssessmentTeacherService(assessment,userDetails);
                                          if (statusCode.code == 200) {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pushNamedAndRemoveUntil('/assessmentLandingPage', ModalRoute.withName('/teacherSelectionPage'));
                                          }
                                          else{
                                            print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                            print(assessment);
                                            print(statusCode.code);
                                            print(statusCode.data);
                                            print(statusCode.message);
                                          }

                                          // Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                          // Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'));
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
                                          if(selectedQuestion.isEmpty){
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.rightToLeft,
                                                child: CustomDialog(
                                                  title:
                                                  AppLocalizations.of(context)!.alert_popup,
                                                  //'Alert',
                                                  content:
                                                  //AppLocalizations.of(context)!.no_question_found,
                                                  'No Questions were selected',
                                                  button:
                                                  AppLocalizations.of(context)!.retry,
                                                  //"Retry",
                                                ),
                                              ),
                                            );
                                          }
                                          else{
                                            Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                            for(questionModel.Question q in selectedQuestion) {
                                              Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(q);
                                            }
                                            Navigator.of(context).pushNamedAndRemoveUntil('/draftReview', ModalRoute.withName('/draftAssessmentLanding'));

                                          }
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
                            // ElevatedButton(
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                            //     minimumSize: const Size(280, 48),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(39),
                            //     ),
                            //   ),
                            //   //shape: StadiumBorder(),
                            //   onPressed: () {
                            //     showAlertDialog(context, height);
                            //   },
                            //   child: Text(
                            //     AppLocalizations.of(context)!.submit,
                            //     //'Submit',
                            //     style: TextStyle(
                            //         fontSize: height * 0.025,
                            //         fontFamily: "Inter",
                            //         color: const Color.fromRGBO(255, 255, 255, 1),
                            //         fontWeight: FontWeight.w600),
                            //   ),
                            // ),
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
                              "Add Questions",
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
                            //top: height * 0.023,
                            left: height * 0.5,
                            right: height * 0.5),
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
                                                                  child: TextFormField(
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
                                                                    validator: (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return
                                                                          'Enter Subject';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    onChanged: (value) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
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
                                                                  child: TextFormField(
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
                                                                    validator: (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return
                                                                          'Enter Topic';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    onChanged: (value) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
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
                                                                  child: TextFormField(
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
                                                                    validator: (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return
                                                                          'Enter Degree';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    onChanged: (value) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
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
                                                                      assessment.subject=subjectController.text;
                                                                      assessment.topic=topicController.text;
                                                                      assessment.createAssessmentModelClass=degreeController.text;
                                                                      assessment.subTopic=semesterController.text;
                                                                      Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(assessment);
                                                                      setState(() {
                                                                        assessment;
                                                                      });
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
                                                fontSize: height * 0.02,
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                //AppLocalizations.of(context)!.lib_online_qn,
                                "Search My Questions  ",
                                style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: height * 0.016,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextField(
                              onChanged: (t){
                                setState(() {
                                });
                              },
                              controller: questionSearchController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                //floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintStyle: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.016),
                                hintText: "Subject, Topic, Degree",
                                suffixIcon:
                                Column(children: [
                                  Container(
                                      height: height * 0.05,
                                      width: width * 0.07,
                                      decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        // borderRadius:
                                        // BorderRadius.all(Radius.circular(100)),
                                        color: questionSearchController.text.isEmpty?
                                        Color.fromRGBO(153, 153, 153, 0.5):Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      child: IconButton(
                                        iconSize: height * 0.025,
                                        color: const Color.fromRGBO(255, 255, 255, 1),
                                        onPressed: () {
                                          questionStart=0;
                                          questionList=[];
                                          pageNumber=1;
                                          getQuestionData(questionSearchController.text);
                                        },
                                        icon: const Icon(Icons.search),
                                      )),
                                ]
                                ),
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
                            SizedBox(height: height * 0.015,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tap to select & add questions',
                                style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.016),
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
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (int i=questionStart;i<questionList.length;i++)
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap:(){
                                            if(selectedQuesId.contains(questionList[i].questionId)){
                                              int index = selectedQuesId.indexOf(questionList[i].questionId);
                                              selectedQuesId.removeAt(index);
                                              selectedQuestion.removeAt(index);
                                            }else{
                                              selectedQuesId.add(questionList[i].questionId);
                                              questionList[i].questionType=="MCQ"?questionList[i].questionMark=1:questionList[i].questionMark=0;
                                              selectedQuestion.add(questionList[i]);
                                            }
                                            setState(() {
                                              selectedQuesId;
                                              selectedQuestion;
                                            });
                                          },
                                          child: QuestionPreview(
                                            height: height,
                                            width: width,
                                            question: questionList[i],
                                            selected: !selectedQuesId.contains(questionList[i].questionId),
                                          ),
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left:height * 0.02),
                                          child: Text(
                                            'Showing ${questionStart + 1} to ${questionStart+10 <questionList.length?questionStart+10:questionList.length} of $totalQuestionBank',
                                            style: TextStyle(
                                                color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.016),
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap:(){
                                                    if(questionList.length>11){
                                                      setState(() {
                                                        pageNumber--;
                                                        questionStart=questionStart-10;
                                                        questionList.removeRange(questionList.length-10, questionList.length);
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: height * 0.03,
                                                    width: width * 0.09,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(5)),
                                                    ),
                                                    child: Icon(
                                                      Icons.keyboard_double_arrow_left,
                                                      size: height * 0.015,
                                                      color: const Color.fromRGBO(28, 78, 80, 1),),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: width * 0.005,left: width * 0.005),
                                                  child: Container(
                                                    height: height * 0.03,
                                                    width: width * 0.09,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(5)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '${questionStart==0?1:((questionStart/10)+1).toInt()}',
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right:height * 0.02),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        questionStart=questionStart+10;
                                                      });
                                                      getQuestionData(questionSearchController.text);
                                                    },
                                                    child: Container(
                                                      height: height * 0.03,
                                                      width: width * 0.1,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(5)),
                                                      ),
                                                      child: Icon(
                                                        Icons.keyboard_double_arrow_right,
                                                        size: height * 0.015,
                                                        color: const Color.fromRGBO(28, 78, 80, 1),),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: height * 0.05,)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
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
                                          showDialogSave(context,height);
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
                                          "New Question",
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
                                          assessment.userId=userDetails.userId;
                                          assessment.totalQuestions=questionList.length;
                                          assessment.assessmentType='practice';
                                          assessment.assessmentStatus = 'inprogress';
                                          assessment.assessmentStartdate = DateTime.now().microsecondsSinceEpoch;
                                          assessment.questions=[];
                                          int mark=0;
                                          for(int i=0;i<selectedQuestion.length;i++){
                                            Question tempQues=Question(questionId: selectedQuestion[i].questionId,questionMarks: selectedQuestion[i].questionMark);
                                            assessment.questions?.add(tempQues);
                                            mark=mark+selectedQuestion[i].questionMark!;
                                          }
                                          assessment.totalScore=mark;
                                          assessment.totalQuestions=selectedQuestion.length;
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
                                          statusCode = await QnaService.editAssessmentTeacherService(assessment, assessment.assessmentId!,userDetails);
                                          //statusCode = await QnaService.createAssessmentTeacherService(assessment,userDetails);
                                          if (statusCode.code == 200) {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pushNamedAndRemoveUntil('/assessmentLandingPage', ModalRoute.withName('/teacherSelectionPage'));
                                          }
                                          else{
                                            print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                            print(assessment);
                                            print(statusCode.code);
                                            print(statusCode.data);
                                            print(statusCode.message);
                                          }

                                          // Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                          // Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'));
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
                                          if(selectedQuestion.isEmpty){
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.rightToLeft,
                                                child: CustomDialog(
                                                  title:
                                                  AppLocalizations.of(context)!.alert_popup,
                                                  //'Alert',
                                                  content:
                                                  //AppLocalizations.of(context)!.no_question_found,
                                                  'No Questions were selected',
                                                  button:
                                                  AppLocalizations.of(context)!.retry,
                                                  //"Retry",
                                                ),
                                              ),
                                            );
                                          }
                                          else{
                                            Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                            for(questionModel.Question q in selectedQuestion) {
                                              Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(q);
                                            }
                                            Navigator.of(context).pushNamedAndRemoveUntil('/draftReview', ModalRoute.withName('/draftAssessmentLanding'));

                                          }
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
                            // ElevatedButton(
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                            //     minimumSize: const Size(280, 48),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(39),
                            //     ),
                            //   ),
                            //   //shape: StadiumBorder(),
                            //   onPressed: () {
                            //     showAlertDialog(context, height);
                            //   },
                            //   child: Text(
                            //     AppLocalizations.of(context)!.submit,
                            //     //'Submit',
                            //     style: TextStyle(
                            //         fontSize: height * 0.025,
                            //         fontFamily: "Inter",
                            //         color: const Color.fromRGBO(255, 255, 255, 1),
                            //         fontWeight: FontWeight.w600),
                            //   ),
                            // ),
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
                              "Add Questions",
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
                                                                  child: TextFormField(
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
                                                                    validator: (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return
                                                                          'Enter Subject';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    onChanged: (value) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
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
                                                                  child: TextFormField(
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
                                                                    validator: (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return
                                                                          'Enter Topic';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    onChanged: (value) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
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
                                                                  child: TextFormField(
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
                                                                    validator: (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return
                                                                          'Enter Degree';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    onChanged: (value) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
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
                                                                      assessment.subject=subjectController.text;
                                                                      assessment.topic=topicController.text;
                                                                      assessment.createAssessmentModelClass=degreeController.text;
                                                                      assessment.subTopic=semesterController.text;
                                                                      Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(assessment);
                                                                      setState(() {
                                                                        assessment;
                                                                      });
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                //AppLocalizations.of(context)!.lib_online_qn,
                                "Search My Questions  ",
                                style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: height * 0.016,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextField(
                              onChanged: (t){
                                setState(() {
                                });
                              },
                              controller: questionSearchController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                //floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintStyle: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.016),
                                hintText: "Subject, Topic, Degree",
                                suffixIcon:
                                Column(children: [
                                  Container(
                                      height: height * 0.053,
                                      width: width * 0.1,
                                      decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        // borderRadius:
                                        // BorderRadius.all(Radius.circular(100)),
                                        color: questionSearchController.text.isEmpty?
                                        Color.fromRGBO(153, 153, 153, 0.5):Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      child: IconButton(
                                        iconSize: height * 0.025,
                                        color: const Color.fromRGBO(255, 255, 255, 1),
                                        onPressed: () {
                                          questionStart=0;
                                          questionList=[];
                                          pageNumber=1;
                                          getQuestionData(questionSearchController.text);
                                        },
                                        icon: const Icon(Icons.search),
                                      )),
                                ]
                                ),
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
                            SizedBox(height: height * 0.015,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tap to select & add questions',
                                style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.016),
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
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (int i=questionStart;i<questionList.length;i++)
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap:(){
                                            if(selectedQuesId.contains(questionList[i].questionId)){
                                              int index = selectedQuesId.indexOf(questionList[i].questionId);
                                              selectedQuesId.removeAt(index);
                                              selectedQuestion.removeAt(index);
                                            }else{
                                              selectedQuesId.add(questionList[i].questionId);
                                              questionList[i].questionType=="MCQ"?questionList[i].questionMark=1:questionList[i].questionMark=0;
                                              selectedQuestion.add(questionList[i]);
                                            }
                                            setState(() {
                                              selectedQuesId;
                                              selectedQuestion;
                                            });
                                          },
                                          child: QuestionPreview(
                                            height: height,
                                            width: width,
                                            question: questionList[i],
                                            selected: !selectedQuesId.contains(questionList[i].questionId),
                                          ),
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Showing ${questionStart + 1} to ${questionStart+10 <questionList.length?questionStart+10:questionList.length} of $totalQuestionBank',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016),
                                        ),
                                        Wrap(
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap:(){
                                                    if(questionList.length>11){
                                                      setState(() {
                                                        pageNumber--;
                                                        questionStart=questionStart-10;
                                                        questionList.removeRange(questionList.length-10, questionList.length);
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: height * 0.03,
                                                    width: width * 0.1,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(5)),
                                                    ),
                                                    child: Icon(
                                                      Icons.keyboard_double_arrow_left,
                                                      size: height * 0.015,
                                                      color: const Color.fromRGBO(28, 78, 80, 1),),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: width * 0.005,left: width * 0.005),
                                                  child: Container(
                                                    height: height * 0.03,
                                                    width: width * 0.15,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(5)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '${questionStart==0?1:((questionStart/10)+1).toInt()}',
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
                                                      questionStart=questionStart+10;
                                                    });
                                                    getQuestionData(questionSearchController.text);
                                                  },
                                                  child: Container(
                                                    height: height * 0.03,
                                                    width: width * 0.1,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(5)),
                                                    ),
                                                    child: Icon(
                                                      Icons.keyboard_double_arrow_right,
                                                      size: height * 0.015,
                                                      color: const Color.fromRGBO(28, 78, 80, 1),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
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
                                          showDialogSave(context,height);
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
                                          "New Question",
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
                                          assessment.userId=userDetails.userId;
                                          assessment.totalQuestions=questionList.length;
                                          assessment.assessmentType='practice';
                                          assessment.assessmentStatus = 'inprogress';
                                          assessment.assessmentStartdate = DateTime.now().microsecondsSinceEpoch;
                                          assessment.questions=[];
                                          int mark=0;
                                          for(int i=0;i<selectedQuestion.length;i++){
                                            Question tempQues=Question(questionId: selectedQuestion[i].questionId,questionMarks: selectedQuestion[i].questionMark);
                                            assessment.questions?.add(tempQues);
                                            mark=mark+selectedQuestion[i].questionMark!;
                                          }
                                          assessment.totalScore=mark;
                                          assessment.totalQuestions=selectedQuestion.length;
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
                                          statusCode = await QnaService.editAssessmentTeacherService(assessment, assessment.assessmentId!,userDetails);
                                          //statusCode = await QnaService.createAssessmentTeacherService(assessment,userDetails);
                                          if (statusCode.code == 200) {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pushNamedAndRemoveUntil('/assessmentLandingPage', ModalRoute.withName('/teacherSelectionPage'));
                                          }
                                          else{
                                            print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                            print(assessment);
                                            print(statusCode.code);
                                            print(statusCode.data);
                                            print(statusCode.message);
                                          }

                                          // Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                          // Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'));
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
                                          if(selectedQuestion.isEmpty){
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.rightToLeft,
                                                child: CustomDialog(
                                                  title:
                                                  AppLocalizations.of(context)!.alert_popup,
                                                  //'Alert',
                                                  content:
                                                  //AppLocalizations.of(context)!.no_question_found,
                                                  'No Questions were selected',
                                                  button:
                                                  AppLocalizations.of(context)!.retry,
                                                  //"Retry",
                                                ),
                                              ),
                                            );
                                          }
                                          else{
                                            Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                            for(questionModel.Question q in selectedQuestion) {
                                              Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(q);
                                            }
                                            print("INSIDE CONTINUE ONPRESSED");
                                            print( Provider.of<QuestionPrepareProviderFinal>(context, listen: false).getAllQuestion);
                                            Navigator.of(context).pushNamedAndRemoveUntil('/draftReview', ModalRoute.withName('/draftAssessmentLanding'));

                                          }
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
                            // ElevatedButton(
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                            //     minimumSize: const Size(280, 48),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(39),
                            //     ),
                            //   ),
                            //   //shape: StadiumBorder(),
                            //   onPressed: () {
                            //     showAlertDialog(context, height);
                            //   },
                            //   child: Text(
                            //     AppLocalizations.of(context)!.submit,
                            //     //'Submit',
                            //     style: TextStyle(
                            //         fontSize: height * 0.025,
                            //         fontFamily: "Inter",
                            //         color: const Color.fromRGBO(255, 255, 255, 1),
                            //         fontWeight: FontWeight.w600),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    )));
          }

        }
    );
  }
}

class QuestionPreview extends StatelessWidget {
  const QuestionPreview(
      {Key? key,
        required this.height,
        required this.width,
        required this.question,
        required this.selected,
      })
      : super(key: key);

  final double height;
  final bool selected;
  final double width;
  final questionModel.Question question;

  @override
  Widget build(BuildContext context) {
    List<String> temp = [];
    // for (int i = 0; i < question.choices!.length; i++) {
    //   if (question.choices![i].rightChoice!) {
    //     temp.add(question.choices![i].choiceText!);
    //   }
    // }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: selected?Color.fromRGBO(82, 165, 160, 0.07):Color.fromRGBO(82, 165, 160, 1),
          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
          borderRadius: BorderRadius.all(
              Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${question.subject ?? ''} | ${question.topic??''}",
                  style: TextStyle(
                      fontSize: height * 0.016,
                      fontFamily: "Inter",
                      color:!selected?Colors.white:
                      Color.fromRGBO(28, 78, 80, 1),
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${question.degreeStudent ?? ''} | ${question.semester??''}",
                  style: TextStyle(
                      color: !selected?Colors.white: Color.fromRGBO(102, 102, 102, 1),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: height * 0.016),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Divider(
                thickness: 2,
                color: !selected?Color.fromRGBO(255, 255, 255, 0.7):Color.fromRGBO(0, 0, 0, 0.3),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    question.questionType??'',
                    style: TextStyle(
                        fontSize: height * 0.016,
                        fontFamily: "Inter",
                        color:
                        !selected?Colors.white: Color.fromRGBO(28, 78, 80, 1),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  question.question??'',
                  style: TextStyle(
                      fontSize: height * 0.0175,
                      fontFamily: "Inter",
                      color: !selected?Colors.white: Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              SizedBox(
                height: height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
