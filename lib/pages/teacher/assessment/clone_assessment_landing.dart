import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/Teacher/response_entity.dart';
import '../../../Components/custom_incorrect_popup.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import '../../../Entity/Teacher/assessment_settings_model.dart';
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
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CloneAssessmentLanding extends StatefulWidget {
  CloneAssessmentLanding({
    Key? key,
  }) : super(key: key);

  bool assessment = false;




  @override
  CloneAssessmentLandingState createState() =>
      CloneAssessmentLandingState();
}

class CloneAssessmentLandingState extends State<CloneAssessmentLanding> {
  //List<Question> finalQuesList = [];
  UserDetails userDetails=UserDetails();
  final formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  //CreateAssessmentModel assessment =CreateAssessmentModel(questions: []);
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
  bool allowPublishPublic=false;
  bool showName=false;
  bool showEmail=false;
  bool showWhatsappGroup=false;
  GetAssessmentModel assessment=GetAssessmentModel();
  int totalMarks=0;
  String startDateTime='';
  String endDateTime='';
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
    print("Inside Clone Assessment Landing Page");
    super.initState();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    assessment =Provider.of<EditAssessmentProvider>(context, listen: false).getAssessment;
    questionList=Provider.of<QuestionPrepareProviderFinal>(context, listen: false).getAllQuestion;
    DateTime tsDate = DateTime.fromMicrosecondsSinceEpoch(assessment.assessmentStartdate!);
    startDateTime = "${tsDate.day}/${tsDate.month}/${tsDate.year} ${tsDate.hour>12?tsDate.hour-12:tsDate.hour}:${tsDate.hour} ${tsDate.hour>12?"PM":"AM"}";
    DateTime teDate = DateTime.fromMicrosecondsSinceEpoch(assessment.assessmentEnddate!);
    endDateTime = "${teDate.day}/${teDate.month}/${teDate.year} ${teDate.hour>12?teDate.hour-12:teDate.hour}:${teDate.hour} ${teDate.hour>12?"PM":"AM"}";
    for(int i=0;i<assessment.questions!.length;i++){
      totalMarks=totalMarks+assessment.questions![i].questionMark!;
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                          "Practice Assessment",
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
                    padding: EdgeInsets.only(left: height * 0.045,
                        right: height * 0.045,
                        bottom: height * 0.045),
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
                                      "${assessment.getAssessmentModelClass} | ${assessment.subTopic}",
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
                                        Text(assessment.assessmentCode!,
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
                                    height: height * 0.4,
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
                                            "Additional Details",
                                            style: TextStyle(
                                                fontSize: height * 0.022,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(28, 78, 80, 1),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                        //   child: Text(
                                        //     "Please note, Test paper will automatically become Practice paper after End Date & Time.",
                                        //     style: TextStyle(
                                        //         fontSize: height * 0.014,
                                        //         fontFamily: "Inter",
                                        //         color: const Color.fromRGBO(102, 102, 102, 1),
                                        //         fontWeight: FontWeight.w400),
                                        //   ),
                                        // ),
                                        Divider(
                                          thickness: 2,
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Category: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                "${assessment.assessmentType}",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Number of Attempts: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                "${assessment.assessmentSettings?.allowedNumberOfTestRetries}",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Guest Students: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                assessment.assessmentSettings!.allowGuestStudent!?"Allowed":"Not Allowed",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Answer Sheet in Practice: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                assessment.assessmentSettings!.showAnswerSheetDuringPractice!?"Viewable":"Not Viewable",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Published in LOOQ: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                assessment.assessmentSettings!.notAvailable!?"Yes":"No",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Advisor Name: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                assessment.assessmentSettings!.showAdvisorName!?assessment.assessmentSettings!.advisorName!:"-",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Advisor Email: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                assessment.assessmentSettings!.showAdvisorEmail!?assessment.assessmentSettings!.advisorEmail!:"-",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Whatsapp Group Link: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                "-",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
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
                                    height: height * 0.08,
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
                                            "Questions",
                                            style: TextStyle(
                                                fontSize: height * 0.022,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(28, 78, 80, 1),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                for(int i=0;i<assessment.questions!.length;i++)
                                  QuestionCard(width: width, height: height, question: assessment.questions![i],index: i,)
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
                                      Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                      CreateAssessmentModel createassessmentModel=CreateAssessmentModel(questions: [],addQuestion: []);
                                      createassessmentModel.assessmentId=assessment.assessmentId;
                                      createassessmentModel.userId=userDetails.userId;
                                      createassessmentModel.assessmentCode=assessment.assessmentCode;
                                      createassessmentModel.assessmentType=assessment.assessmentType;
                                      createassessmentModel.assessmentStatus=assessment.assessmentStatus;
                                      createassessmentModel.totalScore=assessment.totalScore;
                                      createassessmentModel.totalQuestions=assessment.questions!.length;
                                      createassessmentModel.assessmentStartdate=assessment.assessmentStartdate;
                                      createassessmentModel.assessmentEnddate=assessment.assessmentEnddate;
                                      createassessmentModel.assessmentDuration=assessment.assessmentDuration;
                                      createassessmentModel.subject=assessment.subject;
                                      createassessmentModel.topic=assessment.topic;
                                      createassessmentModel.subTopic=assessment.subTopic;
                                      createassessmentModel.createAssessmentModelClass=assessment.getAssessmentModelClass;
                                      createassessmentModel.assessmentSettings=assessment.assessmentSettings;
                                      int totalMark=0;
                                      for(int i=0;i<assessment.questions!.length;i++){
                                        //assessment.questions![i].questionId=null;
                                        createassessmentModel.addQuestion?.add(assessment.questions![i]);
                                        totalMark=totalMark+assessment.questions![i].questionMark!;
                                        Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(assessment.questions![i]);
                                      }
                                      assessment.totalScore=totalMark;
                                      Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(createassessmentModel);
                                      Navigator.pushNamed(
                                        context,
                                        '/cloneReviewQuestion',
                                      );
                                    },
                                    child: Icon(Icons.copy, color: const Color.fromRGBO(82, 165, 160, 1),),
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
                                      "Clone",
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
                          "Practice Assessment",
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
                                      "${assessment.getAssessmentModelClass} | ${assessment.subTopic}",
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
                                        Text(assessment.assessmentCode!,
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
                                    height: height * 0.4,
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
                                            "Additional Details",
                                            style: TextStyle(
                                                fontSize: height * 0.022,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(28, 78, 80, 1),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                        //   child: Text(
                                        //     "Please note, Test paper will automatically become Practice paper after End Date & Time.",
                                        //     style: TextStyle(
                                        //         fontSize: height * 0.014,
                                        //         fontFamily: "Inter",
                                        //         color: const Color.fromRGBO(102, 102, 102, 1),
                                        //         fontWeight: FontWeight.w400),
                                        //   ),
                                        // ),
                                        Divider(
                                          thickness: 2,
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Category: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                "${assessment.assessmentType}",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Number of Attempts: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                "${assessment.assessmentSettings?.allowedNumberOfTestRetries}",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Guest Students: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                assessment.assessmentSettings!.allowGuestStudent!?"Allowed":"Not Allowed",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Answer Sheet in Practice: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                assessment.assessmentSettings!.showAnswerSheetDuringPractice!?"Viewable":"Not Viewable",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Published in LOOQ: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                assessment.assessmentSettings!.notAvailable!?"Yes":"No",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Advisor Name: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                assessment.assessmentSettings!.showAdvisorName!?assessment.assessmentSettings!.advisorName!:"-",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Advisor Email: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                assessment.assessmentSettings!.showAdvisorEmail!?assessment.assessmentSettings!.advisorEmail!:"-",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Whatsapp Group Link: ",
                                                style: TextStyle(
                                                  fontSize: height * 0.016,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                                ),
                                              ),
                                              Text(
                                                "-",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontWeight: FontWeight.w400),
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
                                    height: height * 0.08,
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
                                            "Questions",
                                            style: TextStyle(
                                                fontSize: height * 0.022,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(28, 78, 80, 1),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                for(int i=0;i<assessment.questions!.length;i++)
                                  QuestionCard(width: width, height: height, question: assessment.questions![i],index: i,)
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
                                      Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                      CreateAssessmentModel createassessmentModel=CreateAssessmentModel(questions: [],addQuestion: []);
                                      createassessmentModel.assessmentId=assessment.assessmentId;
                                      createassessmentModel.userId=userDetails.userId;
                                      createassessmentModel.assessmentCode=assessment.assessmentCode;
                                      createassessmentModel.assessmentType=assessment.assessmentType;
                                      createassessmentModel.assessmentStatus=assessment.assessmentStatus;
                                      createassessmentModel.totalScore=assessment.totalScore;
                                      createassessmentModel.totalQuestions=assessment.questions!.length;
                                      createassessmentModel.assessmentStartdate=assessment.assessmentStartdate;
                                      createassessmentModel.assessmentEnddate=assessment.assessmentEnddate;
                                      createassessmentModel.assessmentDuration=assessment.assessmentDuration;
                                      createassessmentModel.subject=assessment.subject;
                                      createassessmentModel.topic=assessment.topic;
                                      createassessmentModel.subTopic=assessment.subTopic;
                                      createassessmentModel.createAssessmentModelClass=assessment.getAssessmentModelClass;
                                      createassessmentModel.assessmentSettings=assessment.assessmentSettings;
                                      int totalMark=0;
                                      for(int i=0;i<assessment.questions!.length;i++){
                                        //assessment.questions![i].questionId=null;
                                        createassessmentModel.addQuestion?.add(assessment.questions![i]);
                                        totalMark=totalMark+assessment.questions![i].questionMark!;
                                        Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(assessment.questions![i]);
                                      }
                                      assessment.totalScore=totalMark;
                                      Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(createassessmentModel);
                                      Navigator.pushNamed(
                                        context,
                                        '/cloneReviewQuestion',
                                      );
                                    },
                                    child: Icon(Icons.copy, color: const Color.fromRGBO(82, 165, 160, 1),),
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
                                      "Clone",
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
          else {
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
                              "Practice Assessment",
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
                                          "${assessment.subject} | ${assessment.topic}",
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
                                            Text(assessment.assessmentCode!,
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
                                        height: height * 0.4,
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
                                                "Additional Details",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                            //   child: Text(
                                            //     "Please note, Test paper will automatically become Practice paper after End Date & Time.",
                                            //     style: TextStyle(
                                            //         fontSize: height * 0.014,
                                            //         fontFamily: "Inter",
                                            //         color: const Color.fromRGBO(102, 102, 102, 1),
                                            //         fontWeight: FontWeight.w400),
                                            //   ),
                                            // ),
                                            Divider(
                                              thickness: 2,
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Category: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${assessment.assessmentType}",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Number of Attempts: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${assessment.assessmentSettings?.allowedNumberOfTestRetries}",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Guest Students: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    assessment.assessmentSettings!.allowGuestStudent!?"Allowed":"Not Allowed",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Answer Sheet in Practice: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    assessment.assessmentSettings!.showAnswerSheetDuringPractice!?"Viewable":"Not Viewable",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Published in LOOQ: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    assessment.assessmentSettings!.notAvailable!?"Yes":"No",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Advisor Name: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    assessment.assessmentSettings!.showAdvisorName!?assessment.assessmentSettings!.advisorName!:"-",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Advisor Email: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    assessment.assessmentSettings!.showAdvisorEmail!?assessment.assessmentSettings!.advisorEmail!:"-",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Whatsapp Group Link: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "-",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
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
                                        height: height * 0.08,
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
                                                "Questions",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    for(int i=0;i<assessment.questions!.length;i++)
                                      QuestionCard(width: width, height: height, question: assessment.questions![i],index: i,)
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
                                          Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                          CreateAssessmentModel createassessmentModel=CreateAssessmentModel(questions: [],addQuestion: []);
                                          createassessmentModel.assessmentId=assessment.assessmentId;
                                          createassessmentModel.userId=userDetails.userId;
                                          createassessmentModel.assessmentCode=assessment.assessmentCode;
                                          createassessmentModel.assessmentType=assessment.assessmentType;
                                          createassessmentModel.assessmentStatus=assessment.assessmentStatus;
                                          createassessmentModel.totalScore=assessment.totalScore;
                                          createassessmentModel.totalQuestions=assessment.questions!.length;
                                          createassessmentModel.assessmentStartdate=assessment.assessmentStartdate;
                                          createassessmentModel.assessmentEnddate=assessment.assessmentEnddate;
                                          createassessmentModel.assessmentDuration=assessment.assessmentDuration;
                                          createassessmentModel.subject=assessment.subject;
                                          createassessmentModel.topic=assessment.topic;
                                          createassessmentModel.subTopic=assessment.subTopic;
                                          createassessmentModel.createAssessmentModelClass=assessment.getAssessmentModelClass;
                                          createassessmentModel.assessmentSettings=assessment.assessmentSettings;
                                          int totalMark=0;
                                          for(int i=0;i<assessment.questions!.length;i++){
                                            //assessment.questions![i].questionId=null;
                                            createassessmentModel.addQuestion?.add(assessment.questions![i]);
                                            totalMark=totalMark+assessment.questions![i].questionMark!;
                                            Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(assessment.questions![i]);
                                          }
                                          assessment.totalScore=totalMark;
                                          Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(createassessmentModel);
                                          Navigator.pushNamed(
                                            context,
                                            '/cloneReviewQuestion',
                                          );
                                        },
                                        child: Icon(Icons.copy, color: const Color.fromRGBO(82, 165, 160, 1),),
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
                                          "Clone",
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

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    super.key,
    required this.width,
    required this.height,
    required this.question,
    required this.index
  });

  final double width;
  final double height;
  final questionModel.Question question;
  final int index;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String ans='';

  @override
  void initState() {
    // TODO: implement initState
    if(widget.question.questionType=="MCQ"){
      for(int i=0;i<widget.question.choices!.length;i++){
        if(widget.question.choices![i].rightChoice!){
          ans=ans + widget.question.choices![i].choiceText!;
        }
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(82, 165, 160, 0.2),),
          borderRadius: BorderRadius.all(
              Radius.circular(10)),
          color: Color.fromRGBO(82, 165, 160, 0.07),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only( left : widget.width * 0.03),
                  child: Text(
                    //AppLocalizations.of(context)!.my_qn_bank,
                    "${widget.index+1}  ${widget.question.questionType}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color.fromRGBO(82, 165, 160, 1),
                      fontSize: widget.height * 0.018,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(15)),
                    color: Color.fromRGBO(28, 78, 80, 1),
                  ),
                  height: widget.height * 0.04,
                  width: webWidth * 0.13,
                  child: Center(
                    child: Text(
                      "+${widget.question.questionMark}",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge
                          ?.merge(TextStyle(
                          color:
                          const Color.fromRGBO(
                              255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontWeight:
                          FontWeight.w400,
                          fontSize:
                          widget.height * 0.02)),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: widget.height * 0.01),
            Padding(
              padding: EdgeInsets.only( left : widget.width * 0.03),
              child: Text(
                //AppLocalizations.of(context)!.my_qn_bank,
                "${widget.question.question}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color.fromRGBO(51, 51, 51, 1),
                  fontSize: widget.height * 0.016,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: widget.height * 0.01),
            widget.question.questionType == 'MCQ'
            ?
            Padding(
              padding: EdgeInsets.only( left : widget.width * 0.03),
              child: Text(
                //AppLocalizations.of(context)!.my_qn_bank,
                "Answer: $ans",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color.fromRGBO(82, 165, 160, 1),
                  fontSize: widget.height * 0.018,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
            :
            SizedBox(height: widget.height * 0.01),
            Padding(
              padding: EdgeInsets.only( left : widget.width * 0.03),
              child: Text(
                //AppLocalizations.of(context)!.my_qn_bank,
                "Advisor:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color.fromRGBO(82, 165, 160, 1),
                  fontSize: widget.height * 0.018,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: widget.height * 0.01),
            Padding(
              padding: EdgeInsets.only( left : widget.width * 0.03),
              child: Text(
                //AppLocalizations.of(context)!.my_qn_bank,
                "${widget.question.advisorText}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color.fromRGBO(51, 51, 51, 1),
                  fontSize: widget.height * 0.016,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: widget.height * 0.01),
            Padding(
              padding: EdgeInsets.only( left : widget.width * 0.03),
              child: Row(
                children: [
                  Text(
                    //AppLocalizations.of(context)!.my_qn_bank,
                    "URL: ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color.fromRGBO(51, 51, 51, 1),
                      fontSize: widget.height * 0.016,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      //AppLocalizations.of(context)!.my_qn_bank,
                      "${widget.question.advisorUrl}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: const Color.fromRGBO(58, 137, 210, 1),
                        fontSize: widget.height * 0.016,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: widget.height * 0.01),
          ],
        ),
      ),
    );
  }
}

