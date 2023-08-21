import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Providers/new_question_provider.dart';
import '../Components/today_date.dart';
import '../Entity/Teacher/assessment_settings_model.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Entity/user_details.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Providers/create_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Services/qna_service.dart';
import '../Entity/Teacher/question_entity.dart' as questions;
import '../DataSource/http_url.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherAssessmentSettingPublish extends StatefulWidget {
  TeacherAssessmentSettingPublish({
    Key? key,
    required this.assessmentType
  }) : super(key: key);

  String assessmentType;

  @override
  TeacherAssessmentSettingPublishState createState() =>
      TeacherAssessmentSettingPublishState();
}

class TeacherAssessmentSettingPublishState
    extends State<TeacherAssessmentSettingPublish> {
  bool testAgree = false;
  bool practiseAgree = false;
  bool mcqAgree = false;
  bool surveyAgree = false;
  bool descriptiveAgree = false;
  bool numOfRetriesStatus = false;
  bool allowedGuestStatus = false;
  bool showAnsAfterTest = false;
  bool showAnsDuringPractice = false;
  bool showNameStatus = false;
  bool showEmailStatus = false;
  bool activeStatus = false;
  bool publicAccessStatus = false;
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();
  TextEditingController numOfDaysAfterTestController = TextEditingController();

  final bool _value = false;
  int val = -1;
  CreateAssessmentModel assessment = CreateAssessmentModel(questions: []);
  TextEditingController retriesController = TextEditingController();
  TextEditingController instituteTestIdcontroller = TextEditingController();
  TextEditingController timePermitHoursController = TextEditingController();
  TextEditingController timePermitMinutesController = TextEditingController();
  List<questions.Question> questionListForNxtPage = [];
  TextEditingController timeinput = TextEditingController();
  int totalQues = 0;
  int totalMark = 0;
  DateTime startDate = DateTime.now();
  DateTime startTime = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime endTime = DateTime.now();
  int hours = 0;
  int minutes = 0;
  String testTypeBeforeChange='';
  DateTime startDateBeforeChange=DateTime(1890,9,10,0,0,0);
  DateTime endDateBeforeChange=DateTime(1890,9,10,0,0,0);
  String advisorName='';
  String advisorEmail='';
  UserDetails userDetails=UserDetails();

  getData()async{
    SharedPreferences loginData = await SharedPreferences.getInstance();
    setState(() {
      userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
      advisorEmail=loginData.getString('email')!;
      advisorName=loginData.getString('firstName')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    questionListForNxtPage =
        Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
            .getAllQuestion;
    timeinput.text = "";
    assessment = Provider.of<CreateAssessmentProvider>(context, listen: false)
        .getAssessment;
    testTypeBeforeChange=assessment.assessmentType??'';
    for (int i = 0; i < assessment.questions!.length; i++) {
      totalMark = totalMark + assessment.questions![i].questionMarks!;
    }
    int addQuesLen =
    assessment.addQuestion == null ? 0 : assessment.addQuestion!.length;
    for (int i = 0; i < addQuesLen; i++) {
      totalMark = totalMark + assessment.addQuestion![i].questionMark!;
    }
    totalQues = questionListForNxtPage.length;
    totalQues =
    assessment.addQuestion == null ? 0 : assessment.addQuestion!.length;
    totalQues = assessment.questions == null ? 0 : assessment.questions!.length;
    assessment.totalQuestions = totalQues;
    assessment.totalScore = totalMark;
    assessment.assessmentType=='test'?val=1:val=2;
    assessment.assessmentSettings?.numberOfDaysAfterTestAvailableForPractice==null?numOfDaysAfterTestController.text='':numOfDaysAfterTestController.text=
    '${assessment.assessmentSettings!.numberOfDaysAfterTestAvailableForPractice!}';

    if(assessment.assessmentSettings?.allowedNumberOfTestRetries==null){
      retriesController.text='';
      numOfRetriesStatus=false;
    }
    else{
      retriesController.text=
      '${assessment.assessmentSettings!.allowedNumberOfTestRetries!}';
      assessment.assessmentSettings!.allowedNumberOfTestRetries!>0?numOfRetriesStatus=true:numOfRetriesStatus=false;
    }

    if(assessment.assessmentStartdate!=null){
      startDateBeforeChange=DateTime.fromMicrosecondsSinceEpoch(assessment.assessmentStartdate!);
      startDateController.text=convertDate(assessment.assessmentStartdate!);
      startTimeController.text=convertTime(assessment.assessmentStartdate!);
    }
    if(assessment.assessmentEnddate!=null){
      endDateBeforeChange=DateTime.fromMicrosecondsSinceEpoch(assessment.assessmentEnddate!);
      endDateController.text=convertDate(assessment.assessmentEnddate!);
      endTimeController.text=convertTime(assessment.assessmentEnddate!);
    }
    if(assessment.assessmentDuration!=null){
      timePermitHoursController.text="${assessment.assessmentDuration! ~/ 60}";
      timePermitMinutesController.text= "${assessment.assessmentDuration! % 60}";
      hours=assessment.assessmentDuration! ~/ 60;
      minutes=assessment.assessmentDuration! % 60;
    }

    assessment.assessmentSettings?.allowGuestStudent==null?allowedGuestStatus=false:allowedGuestStatus=assessment.assessmentSettings!.allowGuestStudent!;
    assessment.assessmentSettings?.showSolvedAnswerSheetInAdvisor==null?showAnsAfterTest=false:showAnsAfterTest=assessment.assessmentSettings!.showSolvedAnswerSheetInAdvisor!;
    assessment.assessmentSettings?.showAnswerSheetDuringPractice==null?showAnsDuringPractice=false:showAnsDuringPractice=assessment.assessmentSettings!.showAnswerSheetDuringPractice!;
    assessment.assessmentSettings?.showAdvisorName==null?showNameStatus=false:showNameStatus=assessment.assessmentSettings!.showAdvisorName!;
    assessment.assessmentSettings?.showAdvisorEmail==null?showEmailStatus=false:showEmailStatus=assessment.assessmentSettings!.showAdvisorEmail!;
    assessment.assessmentSettings?.notAvailable==null?activeStatus=false:activeStatus=assessment.assessmentSettings!.notAvailable!;
    assessment.assessmentSettings?.avalabilityForPractice==null?publicAccessStatus=false:publicAccessStatus=assessment.assessmentSettings!.avalabilityForPractice!;
  }

  final MaskTextInputFormatter timeMaskFormatter =
  MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'\d')});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double webWidth = 500.0;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(constraints.maxWidth > webWidth) {
            return Center(
              child: WillPopScope(
                  onWillPop: () async => false,
                  child: SizedBox(
                    width:webWidth,
                    child: Scaffold(
                      resizeToAvoidBottomInset: true,
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconButton(
                              icon: const Icon(
                                Icons.menu,
                                size: 40.0,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                        leading: IconButton(
                          icon: const Icon(
                            Icons.chevron_left,
                            size: 40.0,
                            color: Colors.white,
                          ),
                          onPressed: () {

                            Navigator.of(context).pop();
                          },
                        ),
                        toolbarHeight: height * 0.100,
                        centerTitle: true,
                        title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.assessment_setting_caps,
//"ASSESSMENT SETTINGS",
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
                      body: Column(
                        children: <Widget>[
                          SizedBox(
                            height: height * 0.025,
                          ),
                          // Center(
                          //child:
                          Container(
                            height: height * 0.1087,
                            width: webWidth * 0.888,
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                              border: Border.all(
                                color: const Color.fromRGBO(82, 165, 160, 0.15),
                              ),
                              color: const Color.fromRGBO(82, 165, 160, 0.1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: webWidth * 0.02, right: webWidth * 0.02),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${assessment.subject}\t |\t ${assessment.createAssessmentModelClass}",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontSize: height * 0.0175,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Icon(
                                        Icons.circle,
                                        color: const Color.fromRGBO(255, 166, 0, 1),
                                        size: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height *
                                            0.02,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: webWidth * 0.01),
                                    child: Row(children: [
                                      RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: AppLocalizations.of(context)!
                                                  .topic_small,
//"Topic:",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: "Inter"),
                                            ),
                                            TextSpan(
                                              text: "\t${assessment.topic}",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: "Inter"),
                                            ),
                                          ])),
                                      Text(
                                        "\t|\t",
                                        style: TextStyle(
                                          color:
                                          const Color.fromRGBO(209, 209, 209, 1),
                                          fontSize: webWidth * 0.0175,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: AppLocalizations.of(context)!
                                                  .sub_topic,
//"Sub Topic:",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: "Inter"),
                                            ),
                                            TextSpan(
                                              text: "${assessment.subTopic}",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: "Inter"),
                                            ),
                                          ])),
                                    ])),
                                Padding(
                                    padding: EdgeInsets.only(left: webWidth * 0.02),
                                    child: Row(children: [
                                      RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: AppLocalizations.of(context)!
                                                  .total_ques,
//"Total Questions:",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: "Inter"),
                                            ),
                                            TextSpan(
                                              text:
                                              "\t ${questionListForNxtPage.length}",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontFamily: "Inter"),
                                            ),
                                          ])),
                                      SizedBox(width: webWidth * 0.1),
                                      RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: AppLocalizations.of(context)!
                                                  .total_marks,
//"Total Marks:",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: "Inter"),
                                            ),
                                            TextSpan(
                                              text: "\t ${assessment.totalScore}",
                                              style: TextStyle(
                                                  fontSize: height * 0.018,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontFamily: "Inter"),
                                            ),
                                          ])),
                                    ])),
                              ],
                            ),
                          ),
                          // ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
// color: Colors.red,
                                width:webWidth,
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: <Widget>[
//Text('Red container should be scrollable'),
                                    SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: height * 0.025,
                                            ),
                                            Center(
                                              child: Container(
                                                width: webWidth,
                                                padding:
                                                EdgeInsets.only(left: webWidth * 0.01),
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(8.0)),
                                                  border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        230, 230, 230, 1),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.015,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(context)!
                                                              .category,
                                                          //"Category",
                                                          style: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                82, 165, 160, 1),
                                                            fontSize: height * 0.025,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
// ),
                                                        SizedBox(
                                                          height: height * 0.015,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(children: [
                                                              SizedBox(
                                                                width: webWidth * 0.4,
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .test_qn_page,
                                                                  // "Test",
                                                                  style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28, 78, 80, 1),
                                                                    fontSize:
                                                                    height * 0.0175,
                                                                    fontFamily: "Inter",
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              Transform.scale(
                                                                scale: 1.5,
                                                                child: Radio(
                                                                  value: 1,
                                                                  groupValue: val,
                                                                  onChanged: (value) {
                                                                    setState(() {
                                                                      val = value!;
                                                                    });
                                                                  },
                                                                  activeColor:
                                                                  const Color.fromRGBO(
                                                                      82, 165, 160, 1),
                                                                ),
                                                              ),
                                                            ]),
                                                          ],
                                                        ),
                                                        Row(children: [
                                                          SizedBox(
                                                            width: webWidth * 0.4,
                                                            child: Text(AppLocalizations.of(context)!.practice_qn_page,
                                                              // "Practice",
                                                              style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    28, 78, 80, 1),
                                                                fontSize:
                                                                height * 0.0175,
                                                                fontFamily: "Inter",
                                                                fontWeight:
                                                                FontWeight.w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Transform.scale(
                                                            scale: 1.5,
                                                            child: Radio(
                                                              value: 2,
                                                              groupValue: val,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  val = value!;
                                                                });
                                                              },
                                                              activeColor:
                                                              const Color.fromRGBO(
                                                                  82, 165, 160, 1),
                                                            ),
                                                          ),
                                                        ]),
                                                        Row(children: [
                                                          Text(
                                                            AppLocalizations.of(context)!.make_test_practice,
                                                            //"Make Test available for Practice after",

                                                            style: TextStyle(
                                                              color:
                                                              const Color.fromRGBO(
                                                                  28, 78, 80, 1),
                                                              fontSize: height * 0.0175,
                                                              fontFamily: "Inter",
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 400.0 * 0.08),
                                                          SizedBox(
                                                            width: 400.0 * 0.1,
                                                            child: TextField(
                                                              controller:
                                                              numOfDaysAfterTestController,
                                                              keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                  false),
                                                              inputFormatters: <
                                                                  TextInputFormatter>[
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                    "[0-9]")),
                                                              ],
                                                              decoration:
                                                              InputDecoration(
                                                                hintText: "# day/s",
                                                                hintStyle: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        102,
                                                                        102,
                                                                        102,
                                                                        0.3),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight:
                                                                    FontWeight.w400,
                                                                    fontSize:
                                                                    height * 0.020),
                                                              ),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  height * 0.020,
                                                                  color: Colors.black),
                                                            ),
                                                          )
                                                        ]),
                                                        Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .only_mcq_for_practice,
//"Only MCQ will be available for Practice",
                                                                style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      153, 153, 153, 1),
                                                                  fontSize:
                                                                  height * 0.015,
                                                                  fontFamily: "Inter",
                                                                  fontStyle: FontStyle.italic,
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                  height * 0.035),
                                                            ]),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.025,
                                            ),
                                            Center(
                                              child: Container(
                                                width:500.0,
                                                padding:
                                                const EdgeInsets.only(left: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(8.0)),
                                                  border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        230, 230, 230, 1),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    val == 1
                                                        ? Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.015,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                              context)!
                                                              .test_schedule,
//"Test Schedule",
                                                          style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                82, 165, 160, 1),
                                                            fontSize:
                                                            height * 0.025,
                                                            fontFamily: "Inter",
                                                            fontWeight:
                                                            FontWeight.w700,
                                                          ),
                                                        ),
// ),
                                                        SizedBox(
                                                          height: height * 0.002,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                              context)!
                                                              .leave_blank,
// "Leave blank if not required",
                                                          style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                153, 153, 153, 1),
                                                            fontSize:
                                                            height * 0.015,
                                                            fontFamily: "Inter",
                                                            fontWeight:
                                                            FontWeight.w700,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.025,
                                                        ),
                                                        Row(children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .duration,
//"Duration",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  28, 78, 80, 1),
                                                              fontSize:
                                                              height * 0.0175,
                                                              fontFamily: "Inter",
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: webWidth * 0.27),
                                                          SizedBox(
                                                            width: webWidth * 0.1,
                                                            child: TextField(
                                                              controller:
                                                              timePermitHoursController,
                                                              keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                  false),
                                                              inputFormatters: <
                                                                  TextInputFormatter>[
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                    "[0-9]")),
                                                              ],
// O
                                                              decoration:
                                                              InputDecoration(
                                                                hintText: "HH",
                                                                hintStyle: TextStyle(
                                                                    color:
                                                                    const Color
                                                                        .fromRGBO(
                                                                        102,
                                                                        102,
                                                                        102,
                                                                        0.3),
                                                                    fontFamily:
                                                                    'Inter',
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    fontSize:
                                                                    height *
                                                                        0.020),
                                                              ),
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  hours =
                                                                      int.parse(val);
                                                                });
                                                              },
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  height *
                                                                      0.020,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          Text(
                                                            " : ",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  28, 78, 80, 1),
                                                              fontSize:
                                                              height * 0.0175,
                                                              fontFamily: "Inter",
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: webWidth * 0.1,
                                                            child: TextField(
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  minutes =
                                                                      int.parse(
                                                                          val);
                                                                });
                                                              },
                                                              controller:
                                                              timePermitMinutesController,
                                                              keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                  false),
                                                              inputFormatters: <
                                                                  TextInputFormatter>[
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                    "[0-9a-zA-Z]")),
                                                              ],
// O
                                                              decoration:
                                                              InputDecoration(
                                                                hintText: "MM",
                                                                hintStyle: TextStyle(
                                                                    color:
                                                                    const Color
                                                                        .fromRGBO(
                                                                        102,
                                                                        102,
                                                                        102,
                                                                        0.3),
                                                                    fontFamily:
                                                                    'Inter',
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    fontSize:
                                                                    height *
                                                                        0.020),
                                                              ),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  height *
                                                                      0.020,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          )
                                                        ]),
                                                        SizedBox(
                                                            height:
                                                            height * 0.03),
                                                        Row(children: [
                                                          SizedBox(
                                                            height: height * 0.12,
                                                            width: webWidth * 0.23,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .start_date,
//"Start Date",
                                                                  style:
                                                                  TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontSize:
                                                                    height *
                                                                        0.0175,
                                                                    fontFamily:
                                                                    "Inter",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                  ),
                                                                ),
                                                                MouseRegion(
                                                                    cursor: SystemMouseCursors.click,
                                                                    child:
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        var pickedDate =
                                                                        await showDatePicker(
                                                                          context:
                                                                          context,
                                                                          initialDate:
                                                                          DateTime.now(),
                                                                          firstDate:
                                                                          startDate,
                                                                          lastDate:
                                                                          DateTime(2100),
                                                                          builder:
                                                                              (context,
                                                                              child) {
                                                                            return Theme(
                                                                              data:
                                                                              Theme.of(context).copyWith(
                                                                                colorScheme: const ColorScheme.light(
                                                                                  primary: Color.fromRGBO(82, 165, 160, 1),
                                                                                  onPrimary: Colors.white,
                                                                                  onSurface: Colors.black, // <-- SEE HERE
                                                                                ),
                                                                                textButtonTheme: TextButtonThemeData(
                                                                                  style: TextButton.styleFrom(
                                                                                    foregroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              child:
                                                                              child!,
                                                                            );
                                                                          },
                                                                        );
                                                                        final DateFormat
                                                                        formatter =
                                                                        DateFormat(
                                                                            'dd/MM/yyyy');
                                                                        final String
                                                                        formatted =
                                                                        formatter
                                                                            .format(pickedDate!);
                                                                        startDate =
                                                                            pickedDate;
                                                                        startDateController
                                                                            .text =
                                                                            formatted;
                                                                      },
                                                                      child:
                                                                      AbsorbPointer(
                                                                        child:
                                                                        TextFormField(
                                                                          decoration: InputDecoration(
                                                                              hintText:
                                                                              "DD/MM/YYYY",
                                                                              hintStyle: TextStyle(
                                                                                  color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  fontSize: height * 0.020)),
                                                                          controller:
                                                                          startDateController,
                                                                          keyboardType:
                                                                          TextInputType.datetime,
                                                                          enabled:
                                                                          true,
                                                                          onChanged:
                                                                              (value) {},
                                                                        ),
                                                                      ),
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                              webWidth * 0.2),
                                                          SizedBox(
                                                            height: height * 0.12,
                                                            width: webWidth * 0.23,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .start_time,
// "Start Time",
                                                                  style:
                                                                  TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontSize:
                                                                    height *
                                                                        0.0175,
                                                                    fontFamily:
                                                                    "Inter",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                  ),
                                                                ),
                                                                TextField(
                                                                  decoration: InputDecoration(
                                                                      hintText:
                                                                      "00:00",
                                                                      hintStyle: TextStyle(
                                                                          color: const Color.fromRGBO(
                                                                              102,
                                                                              102,
                                                                              102,
                                                                              0.3),
                                                                          fontFamily:
                                                                          'Inter',
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                          height *
                                                                              0.020)),
                                                                  keyboardType:
                                                                  TextInputType
                                                                      .datetime,
                                                                  enabled: true,
                                                                  controller:
                                                                  startTimeController,
//editing controller of this TextField
                                                                  onTap:
                                                                      () async {
                                                                    TimeOfDay? pickedTime = await showTimePicker(
                                                                        initialTime:
                                                                        TimeOfDay
                                                                            .now(),
                                                                        context:
                                                                        context,
                                                                        initialEntryMode:
                                                                        TimePickerEntryMode
                                                                            .dial);

                                                                    if (pickedTime !=
                                                                        null) {
                                                                      DateTime
                                                                      parsedTime =
                                                                      DateFormat.jm().parse(pickedTime
                                                                          .format(context)
                                                                          .toString());
                                                                      startTime =
                                                                          parsedTime;
                                                                      String
                                                                      formattedTime =
                                                                      DateFormat('HH:mm')
                                                                          .format(parsedTime);
                                                                      setState(
                                                                              () {
                                                                            startTimeController
                                                                                .text =
                                                                                formattedTime
                                                                                    .toString(); //set the value of text field.
                                                                          });
                                                                    } else {}
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ]),
                                                        SizedBox(
                                                            height:
                                                            height * 0.001),
                                                        Row(
                                                            children: [

                                                              SizedBox(
                                                                height: height * 0.12,
                                                                width: webWidth * 0.23,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                          context)!
                                                                          .end_date,
// "End Date",
                                                                      style:
                                                                      TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontSize:
                                                                        height *
                                                                            0.0175,
                                                                        fontFamily:
                                                                        "Inter",
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                      ),
                                                                    ),
                                                                    MouseRegion(
                                                                        cursor:
                                                                        SystemMouseCursors
                                                                            .click,
                                                                        child:
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            var pickedDate =
                                                                            await showDatePicker(
                                                                              context:
                                                                              context,
                                                                              initialDate:
                                                                              DateTime.now(),
                                                                              firstDate:
                                                                              DateTime.now(),
                                                                              lastDate:
                                                                              DateTime(2100),
                                                                              builder:
                                                                                  (context,
                                                                                  child) {
                                                                                return Theme(
                                                                                  data:
                                                                                  Theme.of(context).copyWith(
                                                                                    colorScheme: const ColorScheme.light(
                                                                                      primary: Color.fromRGBO(82, 165, 160, 1),
                                                                                      onPrimary: Colors.white,
                                                                                      onSurface: Colors.black, // <-- SEE HERE
                                                                                    ),
                                                                                    textButtonTheme: TextButtonThemeData(
                                                                                      style: TextButton.styleFrom(
                                                                                        foregroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  child:
                                                                                  child!,
                                                                                );
                                                                              },
                                                                            );
                                                                            final DateFormat
                                                                            formatter =
                                                                            DateFormat(
                                                                                'dd/MM/yyyy');
                                                                            final String
                                                                            formatted =
                                                                            formatter
                                                                                .format(pickedDate!);
                                                                            endDate =
                                                                                pickedDate;
                                                                            endDateController
                                                                                .text =
                                                                                formatted;
                                                                          },
                                                                          child:
                                                                          AbsorbPointer(
                                                                            child:
                                                                            TextFormField(
                                                                              decoration: InputDecoration(
                                                                                  hintText:
                                                                                  "DD/MM/YYYY",
                                                                                  hintStyle: TextStyle(
                                                                                      color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                                      fontFamily: 'Inter',
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontSize: height * 0.020)),
                                                                              controller:
                                                                              endDateController,
                                                                              keyboardType:
                                                                              TextInputType.datetime,
                                                                              enabled:
                                                                              true,
                                                                              onChanged:
                                                                                  (value) {},
                                                                            ),
                                                                          ),
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                  webWidth * 0.2),
                                                              SizedBox(
                                                                height: height * 0.12,
                                                                width: webWidth * 0.18,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
//                                                               Text(
//                                                                 AppLocalizations.of(
//                                                                     context)!
//                                                                     .end_time,
// //"End Time",
//                                                                 style:
//                                                                 TextStyle(
//                                                                   color: const Color
//                                                                       .fromRGBO(
//                                                                       28,
//                                                                       78,
//                                                                       80,
//                                                                       1),
//                                                                   fontSize:
//                                                                   height *
//                                                                       0.0175,
//                                                                   fontFamily:
//                                                                   "Inter",
//                                                                   fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                                 ),
//                                                               ),
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                          context)!.end_time,
// "End Date",
                                                                      style:
                                                                      TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontSize:
                                                                        height *
                                                                            0.0175,
                                                                        fontFamily:
                                                                        "Inter",
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                      ),
                                                                    ),
                                                                    MouseRegion(
                                                                        cursor:
                                                                        SystemMouseCursors
                                                                            .click,
                                                                        child:
                                                                        GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              _selectTime(context);
                                                                            },
                                                                            child:
                                                                            TextField(
                                                                              decoration:
                                                                              InputDecoration(hintText: "00:00", hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.020)),
                                                                              keyboardType:
                                                                              TextInputType.datetime,
                                                                              enabled:
                                                                              true,
                                                                              controller:
                                                                              endTimeController,
//editing controller of this TextField
                                                                              onTap:
                                                                                  () async {
                                                                                TimeOfDay? pickedTime = await showTimePicker(
                                                                                  initialTime: TimeOfDay.now(),
                                                                                  context: context,
                                                                                );

                                                                                if (pickedTime != null) {
                                                                                  DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                                                  endTime = parsedTime;
                                                                                  String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                                                  setState(() {
                                                                                    endTimeController.text = formattedTime.toString(); //set the value of text field.
                                                                                  });
                                                                                } else {}
                                                                              },
                                                                            )
                                                                        )),
                                                                  ],
                                                                ),
                                                              )
                                                            ]),
                                                      ],
                                                    )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.025,
                                            ),
                                            Center(
                                              child: Container(
                                                width:webWidth,
                                                padding:
                                                const EdgeInsets.only(left: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(8.0)),
                                                  border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        230, 230, 230, 1),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.015,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(context)!
                                                              .institute_organisation,
//"Institution / Organisation",
                                                          style: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                82, 165, 160, 1),
                                                            fontSize: height * 0.02,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
// ),
                                                        SizedBox(
                                                          height: height * 0.002,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(context)!
                                                              .leave_blank,
//"Leave blank if not required",
                                                          style: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                153, 153, 153, 1),
                                                            fontSize: height * 0.015,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.025,
                                                        ),
                                                        Row(children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .institute_test_id_small,
//"Institute Test ID",
                                                            style: TextStyle(
                                                              color:
                                                              const Color.fromRGBO(
                                                                  28, 78, 80, 1),
                                                              fontSize: height * 0.0175,
                                                              fontFamily: "Inter",
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 500.0 * 0.15),
                                                          SizedBox(
                                                            width: 500.0 * 0.35,
                                                            child: TextField(
                                                              controller:
                                                              instituteTestIdcontroller,
                                                              decoration:
                                                              InputDecoration(
                                                                hintText:
                                                                "UCE1122334455",
                                                                hintStyle: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        102,
                                                                        102,
                                                                        102,
                                                                        0.3),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight:
                                                                    FontWeight.w400,
                                                                    fontSize:
                                                                    height * 0.020),
                                                              ),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  height * 0.020,
                                                                  color: Colors.black),
                                                            ),
                                                          )
                                                        ]),
                                                        SizedBox(height: height * 0.02),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.025,
                                            ),
                                            Center(
                                              child: Container(
                                                width:500.0,
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(8.0)),
                                                  border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        230, 230, 230, 1),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.015,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(context)!
                                                              .access_control,
//"Access Control",
                                                          style: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                82, 165, 160, 1),
                                                            fontSize: height * 0.025,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.025,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .no_of_retries_allowed,
//"Number of Retries allowed",
                                                                style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      51, 51, 51, 1),
                                                                  fontSize: height * 0.015,
                                                                  fontFamily: "Inter",
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                ),
                                                              ),
//SizedBox(width: width * 0.2),
                                                              SizedBox(
                                                                width: 500.0 * 0.1,
                                                                child: TextField(
                                                                  controller:
                                                                  retriesController,
                                                                  keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    hintText: "1",
                                                                    hintStyle: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            102,
                                                                            102,
                                                                            102,
                                                                            0.3),
                                                                        fontFamily:
                                                                        'Inter',
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                        fontSize:
                                                                        height *
                                                                            0.025),
                                                                  ),
                                                                  style: TextStyle(
                                                                      fontSize: height *
                                                                          0.020,
                                                                      color:
                                                                      Colors.black),
                                                                ),
                                                              ),
// SizedBox(width: width * 0.3),
                                                              FlutterSwitch(
                                                                activeColor: const Color
                                                                    .fromRGBO(
                                                                    82, 165, 160, 1),
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
                                                                numOfRetriesStatus,
                                                                borderRadius: 30.0,
                                                                onToggle: (val) {
                                                                  setState(() {
                                                                    numOfRetriesStatus =
                                                                        val;
                                                                  });
                                                                },
                                                              ),
                                                            ]),
                                                        SizedBox(height: height * 0.01),
                                                        Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .allow_guest_test,
//"Allow guest students for test",
                                                                style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      51, 51, 51, 1),
                                                                  fontSize:
                                                                  height * 0.015,
                                                                  fontFamily: "Inter",
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                ),
                                                              ),
                                                              FlutterSwitch(
                                                                activeColor: const Color
                                                                    .fromRGBO(
                                                                    82, 165, 160, 1),
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
                                                                allowedGuestStatus,
                                                                borderRadius: 30.0,
                                                                onToggle: (val) {
                                                                  setState(() {
                                                                    allowedGuestStatus =
                                                                        val;
                                                                  });
                                                                },
                                                              ),
                                                            ]),
                                                        SizedBox(height: height * 0.01),
                                                        Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .show_answersheet_after_test,
//"Show answer sheet after test",
                                                                style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      51, 51, 51, 1),
                                                                  fontSize:
                                                                  height * 0.015,
                                                                  fontFamily: "Inter",
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                ),
                                                              ),
                                                              FlutterSwitch(
                                                                activeColor: const Color
                                                                    .fromRGBO(
                                                                    82, 165, 160, 1),
                                                                inactiveColor:
                                                                const Color
                                                                    .fromRGBO(
                                                                    217,
                                                                    217,
                                                                    217,
                                                                    1),
                                                                width: 65.0,
                                                                height: 35.0,
                                                                value: showAnsAfterTest,
                                                                borderRadius: 30.0,
                                                                onToggle: (val) {
                                                                  setState(() {
                                                                    showAnsAfterTest =
                                                                        val;
                                                                  });
                                                                },
                                                              ),
                                                            ]),
                                                        SizedBox(height: height * 0.01),
                                                        Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .show_answer_practice,
//"Show answer sheet during Practice",
                                                                style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      51, 51, 51, 1),
                                                                  fontSize:
                                                                  height * 0.015,
                                                                  fontFamily: "Inter",
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                ),
                                                              ),
                                                              FlutterSwitch(
                                                                activeColor: const Color
                                                                    .fromRGBO(
                                                                    82, 165, 160, 1),
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
                                                                showAnsDuringPractice,
                                                                borderRadius: 30.0,
                                                                onToggle: (val) {
                                                                  setState(() {
                                                                    showAnsDuringPractice =
                                                                        val;
                                                                  });
                                                                },
                                                              ),
                                                            ]),
                                                        SizedBox(height: height * 0.01),
                                                        Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .show_my_advisor_name,
//"Show my name in Advisor",
                                                                style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      51, 51, 51, 1),
                                                                  fontSize:
                                                                  height * 0.015,
                                                                  fontFamily: "Inter",
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                ),
                                                              ),
                                                              FlutterSwitch(
                                                                activeColor: const Color
                                                                    .fromRGBO(
                                                                    82, 165, 160, 1),
                                                                inactiveColor:
                                                                const Color
                                                                    .fromRGBO(
                                                                    217,
                                                                    217,
                                                                    217,
                                                                    1),
                                                                width: 65.0,
                                                                height: 35.0,
                                                                value: showNameStatus,
                                                                borderRadius: 30.0,
                                                                onToggle: (val) {
                                                                  setState(() {
                                                                    showNameStatus =
                                                                        val;
                                                                  });
                                                                },
                                                              ),
                                                            ]),
                                                        SizedBox(height: height * 0.01),
                                                        Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .show_my_email,
//"Show my Email in Advisor",
                                                                style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      51, 51, 51, 1),
                                                                  fontSize:
                                                                  height * 0.015,
                                                                  fontFamily: "Inter",
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                ),
                                                              ),
                                                              FlutterSwitch(
                                                                activeColor: const Color
                                                                    .fromRGBO(
                                                                    82, 165, 160, 1),
                                                                inactiveColor:
                                                                const Color
                                                                    .fromRGBO(
                                                                    217,
                                                                    217,
                                                                    217,
                                                                    1),
                                                                width: 65.0,
                                                                height: 35.0,
                                                                value: showEmailStatus,
                                                                borderRadius: 30.0,
                                                                onToggle: (val) {
                                                                  setState(() {
                                                                    showEmailStatus =
                                                                        val;
                                                                  });
                                                                },
                                                              ),
                                                            ]),
                                                        SizedBox(height: height * 0.01),
                                                        (widget.assessmentType=='new' || widget.assessmentType=='inprogress')?SizedBox(height: height * 0.00):
                                                        Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                          context)!
                                                                          .make_assessment_inactive,
//"Make assessment inactive",
                                                                      style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            51,
                                                                            51,
                                                                            51,
                                                                            1),
                                                                        fontSize:
                                                                        height *
                                                                            0.015,
                                                                        fontFamily:
                                                                        "Inter",
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                          context)!
                                                                          .not_available_for_student,
//"Not available for student",
                                                                      style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            153,
                                                                            153,
                                                                            153,
                                                                            0.8),
                                                                        fontSize:
                                                                        height *
                                                                            0.015,
                                                                        fontFamily:
                                                                        "Inter",
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                              FlutterSwitch(
                                                                activeColor: const Color
                                                                    .fromRGBO(
                                                                    82, 165, 160, 1),
                                                                inactiveColor:
                                                                const Color
                                                                    .fromRGBO(
                                                                    217,
                                                                    217,
                                                                    217,
                                                                    1),
                                                                width: 65.0,
                                                                height: 35.0,
                                                                value: activeStatus,
                                                                borderRadius: 30.0,
                                                                onToggle: (val) {
                                                                  setState(() {
                                                                    activeStatus = val;
                                                                  });
                                                                },
                                                              ),
                                                            ]),
                                                        SizedBox(height: height * 0.01),
                                                        domainName ==
                                                            "https://dev.qnatest.com"
                                                            ? const SizedBox()
                                                            : Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                          context)!
                                                                          .allow_public_for_practice,
//"Allow public access for practice",
                                                                      style:
                                                                      TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            51,
                                                                            51,
                                                                            51,
                                                                            1),
                                                                        fontSize:
                                                                        height *
                                                                            0.015,
                                                                        fontFamily:
                                                                        "Inter",
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                          context)!
                                                                          .available_to_public,
//"Available to public for practice",
                                                                      style:
                                                                      TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            153,
                                                                            153,
                                                                            153,
                                                                            0.8),
                                                                        fontSize:
                                                                        height *
                                                                            0.015,
                                                                        fontFamily:
                                                                        "Inter",
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                              FlutterSwitch(
                                                                activeColor:
                                                                const Color
                                                                    .fromRGBO(
                                                                    82,
                                                                    165,
                                                                    160,
                                                                    1),
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
                                                                publicAccessStatus,
                                                                borderRadius:
                                                                30.0,
                                                                onToggle: (val) {
                                                                  setState(() {
                                                                    publicAccessStatus =
                                                                        val;
                                                                  });
                                                                },
                                                              ),
                                                            ]),
                                                        SizedBox(height: height * 0.05),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: height * 0.05),
                                            Column(children: [
                                              widget.assessmentType=='editActive'?
                                              const SizedBox(height: 0)
                                                  :Center(
                                                child: SizedBox(
                                                  //width: webWidth  * 0.6,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      side: const BorderSide(
                                                        color: Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                      ),
                                                      backgroundColor:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      minimumSize: const Size(280, 48),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(39),
                                                      ),
                                                    ),
//shape: StadiumBorder(),
                                                    onPressed: () async {
                                                      if (val == 1) {
                                                        assessment.assessmentType =
                                                        'test';
                                                        assessment.assessmentDuration =
                                                            (hours * 60) + minutes;
                                                      } else {
                                                        assessment.assessmentType =
                                                        'practice';
                                                        assessment.assessmentDuration =0;
                                                      }
                                                      assessment.assessmentStatus =
                                                      'inprogress';
                                                      AssessmentSettings
                                                      assessmentSettings =
                                                      AssessmentSettings();
                                                      assessmentSettings
                                                          .allowedNumberOfTestRetries =
                                                      retriesController.text == ''
                                                          ? 0
                                                          : int.parse(
                                                          retriesController
                                                              .text);
                                                      assessmentSettings
                                                          .numberOfDaysAfterTestAvailableForPractice =
                                                      numOfDaysAfterTestController
                                                          .text ==
                                                          ''
                                                          ? 0
                                                          : int.parse(
                                                          numOfDaysAfterTestController
                                                              .text);
                                                      assessmentSettings
                                                          .allowGuestStudent =
                                                          allowedGuestStatus;
                                                      assessmentSettings
                                                          .showSolvedAnswerSheetInAdvisor =
                                                          showAnsAfterTest;
                                                      assessmentSettings
                                                          .showAnswerSheetDuringPractice =
                                                          showAnsDuringPractice;
                                                      assessmentSettings
                                                          .showAdvisorName =
                                                          showNameStatus;
                                                      assessmentSettings
                                                          .showAdvisorEmail =
                                                          showEmailStatus;
                                                      assessmentSettings.notAvailable =
                                                          activeStatus;
                                                      assessmentSettings
                                                          .avalabilityForPractice =
                                                          publicAccessStatus;
                                                      showNameStatus?assessmentSettings.advisorName=advisorName:assessmentSettings.advisorName=null;
                                                      showEmailStatus?assessmentSettings.advisorEmail=advisorEmail:assessmentSettings.advisorEmail=null;
                                                      assessment.assessmentSettings =
                                                          assessmentSettings;
                                                      startDate = DateTime(
                                                          startDate.year,
                                                          startDate.month,
                                                          startDate.day,
                                                          startTime.hour,
                                                          startTime.minute);
                                                      assessment.assessmentStartdate =
                                                          startDate
                                                              .microsecondsSinceEpoch;
                                                      endDate = DateTime(
                                                          endDate.year,
                                                          endDate.month,
                                                          endDate.day,
                                                          endTime.hour,
                                                          endTime.minute);
                                                      assessment.assessmentEnddate =
                                                          endDate
                                                              .microsecondsSinceEpoch;

                                                      int totque=Provider.of<QuestionPrepareProviderFinal>(
                                                          context,
                                                          listen: false).getAllQuestion.length;
                                                      assessment.totalQuestions=totque;
                                                      ResponseEntity statusCode =
                                                      ResponseEntity();
                                                      if (assessment.assessmentId !=
                                                          null) {
                                                        statusCode = await QnaService
                                                            .editAssessmentTeacherService(
                                                            assessment,
                                                            assessment
                                                                .assessmentId!,userDetails);
                                                      } else {
                                                        statusCode = await QnaService
                                                            .createAssessmentTeacherService(
                                                            assessment,userDetails);
                                                      }
                                                      Provider.of<NewQuestionProvider>(
                                                          context,
                                                          listen: false)
                                                          .reSetQuestionList();
                                                      if (statusCode.code == 200) {
                                                        Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));

                                                      }
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(context)!
                                                          .publish_later,
//'Publish Later',
                                                      style: TextStyle(
                                                          fontSize: height * 0.025,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(
                                                              82, 165, 160, 1),
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.03,
                                              ),
                                              widget.assessmentType=='editActive'?
                                              const SizedBox(height: 0)
                                                  :Center(
                                                child: SizedBox(
                                                  //width: 500.0 * 0.6,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                        const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        minimumSize:
                                                        const Size(280, 48),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(39),
                                                        ),
                                                        side: const BorderSide(
                                                          color: Color.fromRGBO(
                                                              82, 165, 160, 1),
                                                        )),
                                                    onPressed: () async {
                                                      if (val == 1) {
                                                        assessment.assessmentType =
                                                        'test';
                                                        assessment.assessmentDuration =
                                                            (hours * 60) + minutes;
                                                      } else {
                                                        assessment.assessmentType =
                                                        'practice';
                                                        assessment.assessmentDuration =0;
                                                      }
                                                      assessment.assessmentStatus =
                                                      'active';
                                                      AssessmentSettings
                                                      assessmentSettings =
                                                      AssessmentSettings();
                                                      assessmentSettings
                                                          .allowedNumberOfTestRetries =
                                                      retriesController.text == ''
                                                          ? 0
                                                          : int.parse(
                                                          retriesController
                                                              .text);
                                                      assessmentSettings
                                                          .numberOfDaysAfterTestAvailableForPractice =
                                                      numOfDaysAfterTestController
                                                          .text ==
                                                          ''
                                                          ? 0
                                                          : int.parse(
                                                          numOfDaysAfterTestController
                                                              .text);
                                                      assessmentSettings
                                                          .allowGuestStudent =
                                                          allowedGuestStatus;
                                                      assessmentSettings
                                                          .showSolvedAnswerSheetInAdvisor =
                                                          showAnsAfterTest;
                                                      assessmentSettings
                                                          .showAnswerSheetDuringPractice =
                                                          showAnsDuringPractice;
                                                      assessmentSettings
                                                          .showAdvisorName =
                                                          showNameStatus;
                                                      assessmentSettings
                                                          .showAdvisorEmail =
                                                          showEmailStatus;
                                                      assessmentSettings.notAvailable =
                                                          activeStatus;
                                                      assessmentSettings
                                                          .avalabilityForPractice =
                                                          publicAccessStatus;
                                                      showNameStatus?assessmentSettings.advisorName=advisorName:assessmentSettings.advisorName=null;
                                                      showEmailStatus?assessmentSettings.advisorEmail=advisorEmail:assessmentSettings.advisorEmail=null;
                                                      assessment.assessmentSettings =
                                                          assessmentSettings;
                                                      startDate = DateTime(
                                                          startDate.year,
                                                          startDate.month,
                                                          startDate.day,
                                                          startTime.hour,
                                                          startTime.minute);
                                                      assessment.assessmentStartdate =
                                                          startDate
                                                              .microsecondsSinceEpoch;
                                                      endDate = DateTime(
                                                          endDate.year,
                                                          endDate.month,
                                                          endDate.day,
                                                          endTime.hour,
                                                          endTime.minute);
                                                      assessment.assessmentEnddate =
                                                          endDate
                                                              .microsecondsSinceEpoch;
                                                      int totque=Provider.of<QuestionPrepareProviderFinal>(
                                                          context,
                                                          listen: false).getAllQuestion.length;
                                                      assessment.totalQuestions=totque;
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
                                                      ResponseEntity statusCode =
                                                      ResponseEntity();
                                                      String assessmentCode = '';
                                                      if (widget.assessmentType=='inprogress') {
                                                        statusCode = await QnaService
                                                            .editAssessmentTeacherService(
                                                            assessment,
                                                            assessment
                                                                .assessmentId!,userDetails);
                                                        assessmentCode =
                                                        assessment.assessmentCode!;
                                                        Navigator.of(context).pop();
                                                        Provider.of<NewQuestionProvider>(
                                                            context,
                                                            listen: false)
                                                            .reSetQuestionList();
                                                        Navigator.pushNamed(context,
                                                            '/teacherPublishedAssessment',
                                                            arguments: [
                                                              assessmentCode,
                                                              questionListForNxtPage
                                                            ]);
                                                      }
                                                      else if (widget.assessmentType=='inactiveReactive') {
                                                        statusCode = await QnaService
                                                            .editAssessmentTeacherService(
                                                            assessment,
                                                            assessment
                                                                .assessmentId!,userDetails);
                                                        assessmentCode =
                                                        assessment.assessmentCode!;
                                                        Navigator.of(context).pop();
                                                        Provider.of<NewQuestionProvider>(
                                                            context,
                                                            listen: false)
                                                            .reSetQuestionList();
                                                        Navigator.pushNamed(context,
                                                            '/teacherPublishedAssessment',
                                                            arguments: [
                                                              assessmentCode,
                                                              questionListForNxtPage
                                                            ]);
                                                      }
                                                      else {
                                                        statusCode = await QnaService
                                                            .createAssessmentTeacherService(
                                                            assessment,userDetails);

                                                        if (statusCode.code == 200) {
                                                          assessmentCode = statusCode
                                                              .data
                                                              .toString()
                                                              .substring(
                                                              18,
                                                              statusCode.data
                                                                  .toString()
                                                                  .length -
                                                                  1);
                                                        }
                                                        Navigator.of(context).pop();
                                                        Provider.of<NewQuestionProvider>(
                                                            context,
                                                            listen: false)
                                                            .reSetQuestionList();
                                                        Navigator.pushNamed(context,
                                                            '/teacherPublishedAssessment',
                                                            arguments: [
                                                              assessmentCode,
                                                              questionListForNxtPage
                                                            ]);
// Navigator.push(
//   context,
//   PageTransition(
//     type: PageTransitionType
//         .rightToLeft,
//     child: TeacherPublishedAssessment(
//         assessmentCode:
//             assessmentCode,
//         questionList:
//             questionListForNxtPage),
//   ),
// );
                                                      }
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(context)!
                                                          .publish_now,
//'Publish Now',
                                                      style: TextStyle(
                                                          fontSize: height * 0.025,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.03,
                                              ),

                                              widget.assessmentType!='editActive'?
                                              const SizedBox(height: 0)
                                                  :Center(
                                                child: SizedBox(
                                                  width: 500.0 * 0.6,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                        const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        minimumSize:
                                                        const Size(280, 48),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(39),
                                                        ),
                                                        side: const BorderSide(
                                                          color: Color.fromRGBO(
                                                              82, 165, 160, 1),
                                                        )),
                                                    onPressed: () async {
                                                      if (val == 1) {
                                                        assessment.assessmentType =
                                                        'test';
                                                      } else {
                                                        assessment.assessmentType =
                                                        'practice';
                                                      }
                                                      assessment.assessmentStatus =
                                                      'active';
                                                      AssessmentSettings
                                                      assessmentSettings =
                                                      AssessmentSettings();
                                                      assessmentSettings
                                                          .allowedNumberOfTestRetries =
                                                      retriesController.text == ''
                                                          ? 0
                                                          : int.parse(
                                                          retriesController
                                                              .text);
                                                      assessmentSettings
                                                          .numberOfDaysAfterTestAvailableForPractice =
                                                      numOfDaysAfterTestController
                                                          .text ==
                                                          ''
                                                          ? 0
                                                          : int.parse(
                                                          numOfDaysAfterTestController
                                                              .text);
                                                      assessmentSettings
                                                          .allowGuestStudent =
                                                          allowedGuestStatus;
                                                      assessmentSettings
                                                          .showSolvedAnswerSheetInAdvisor =
                                                          showAnsAfterTest;
                                                      assessmentSettings
                                                          .showAnswerSheetDuringPractice =
                                                          showAnsDuringPractice;
                                                      assessmentSettings
                                                          .showAdvisorName =
                                                          showNameStatus;
                                                      assessmentSettings
                                                          .showAdvisorEmail =
                                                          showEmailStatus;
                                                      assessmentSettings.notAvailable =
                                                          activeStatus;
                                                      assessmentSettings
                                                          .avalabilityForPractice =
                                                          publicAccessStatus;
                                                      showNameStatus?assessmentSettings.advisorName=advisorName:assessmentSettings.advisorName=null;
                                                      showEmailStatus?assessmentSettings.advisorEmail=advisorEmail:assessmentSettings.advisorEmail=null;
                                                      assessment.assessmentSettings =
                                                          assessmentSettings;
                                                      startDate = DateTime(
                                                          startDate.year,
                                                          startDate.month,
                                                          startDate.day,
                                                          startTime.hour,
                                                          startTime.minute);
                                                      assessment.assessmentStartdate =
                                                          startDate
                                                              .microsecondsSinceEpoch;
                                                      endDate = DateTime(
                                                          endDate.year,
                                                          endDate.month,
                                                          endDate.day,
                                                          endTime.hour,
                                                          endTime.minute);
                                                      assessment.assessmentEnddate =
                                                          endDate
                                                              .microsecondsSinceEpoch;

                                                      assessment.assessmentDuration =
                                                          (hours * 60) + minutes;
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
                                                      ResponseEntity statusCode =
                                                      ResponseEntity();
                                                      String assessmentCode = '';
                                                      if (widget.assessmentType=='editActive') {
                                                        if(activeStatus){
                                                          assessment.assessmentStatus='inactive';

                                                        }
                                                        else{
                                                          assessment.assessmentStatus='active';
                                                        }

                                                        // activeStatus?
                                                        // statusCode = await QnaService
                                                        //     .makeInactiveAssessmentTeacherService(
                                                        //   assessment.assessmentSettings!,
                                                        //   assessment
                                                        //       .assessmentId!,
                                                        //   assessment.assessmentType!,
                                                        //   'inactive',userDetails,
                                                        // )
                                                        //     :
                                                        // statusCode = await QnaService
                                                        //     .editActiveAssessmentTeacherService(
                                                        //     assessment,
                                                        //     assessment.assessmentSettings!,
                                                        //     assessment
                                                        //         .assessmentId!,assessment.assessmentType!,'active',userDetails);
                                                        assessmentCode =
                                                        assessment.assessmentCode!;
                                                        Navigator.of(context).pop();
                                                        Provider.of<NewQuestionProvider>(
                                                            context,
                                                            listen: false)
                                                            .reSetQuestionList();
                                                        Navigator.pushNamed(context,
                                                            '/teacherPublishedAssessment',
                                                            arguments: [
                                                              assessmentCode,
                                                              questionListForNxtPage
                                                            ]);
                                                      }
                                                      else {
                                                        statusCode = await QnaService
                                                            .createAssessmentTeacherService(
                                                            assessment,userDetails);

                                                        if (statusCode.code == 200) {
                                                          assessmentCode = statusCode
                                                              .data
                                                              .toString()
                                                              .substring(
                                                              18,
                                                              statusCode.data
                                                                  .toString()
                                                                  .length -
                                                                  1);
                                                        }
                                                        Navigator.of(context).pop();
                                                        Provider.of<NewQuestionProvider>(
                                                            context,
                                                            listen: false)
                                                            .reSetQuestionList();
                                                        Navigator.pushNamed(context,
                                                            '/teacherPublishedAssessment',
                                                            arguments: [
                                                              assessmentCode,
                                                              questionListForNxtPage
                                                            ]);
                                                        // Navigator.push(
                                                        //   context,
                                                        //   PageTransition(
                                                        //     type: PageTransitionType
                                                        //         .rightToLeft,
                                                        //     child: TeacherPublishedAssessment(
                                                        //         assessmentCode:
                                                        //             assessmentCode,
                                                        //         questionList:
                                                        //             questionListForNxtPage),
                                                        //   ),
                                                        // );
                                                      }
                                                    },
                                                    child: Text(
                                                      'Save changes',
                                                      //'Publish Now',
                                                      style: TextStyle(
                                                          fontSize: height * 0.025,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            );}
          else {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          icon: const Icon(
                            Icons.menu,
                            size: 40.0,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                    leading: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 40.0,
                        color: Colors.white,
                      ),
                      onPressed: () {

                        Navigator.of(context).pop();
                      },
                    ),
                    toolbarHeight: height * 0.100,
                    centerTitle: true,
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.assessment_setting_caps,
//"ASSESSMENT SETTINGS",
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
                  body: Column(
                    children: <Widget>[
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Center(
                        child: Container(
                          height: height * 0.1087,
                          width: width * 0.888,
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(
                              color: const Color.fromRGBO(82, 165, 160, 0.15),
                            ),
                            color: const Color.fromRGBO(82, 165, 160, 0.1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.02, right: width * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${assessment.subject}\t |\t ${assessment.createAssessmentModelClass}",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontSize: height * 0.0175,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: const Color.fromRGBO(255, 166, 0, 1),
                                      size: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                          0.02,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: width * 0.02),
                                  child: Row(children: [
                                    RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .topic_small,
//"Topic:",
                                            style: TextStyle(
                                                fontSize: height * 0.018,
                                                fontWeight: FontWeight.w400,
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: "Inter"),
                                          ),
                                          TextSpan(
                                            text: "\t${assessment.topic}",
                                            style: TextStyle(
                                                fontSize: height * 0.018,
                                                fontWeight: FontWeight.w400,
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: "Inter"),
                                          ),
                                        ])),
                                    Text(
                                      "\t|\t",
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(209, 209, 209, 1),
                                        fontSize: height * 0.0175,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .sub_topic,
//"Sub Topic:",
                                            style: TextStyle(
                                                fontSize: height * 0.018,
                                                fontWeight: FontWeight.w400,
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: "Inter"),
                                          ),
                                          TextSpan(
                                            text: "${assessment.subTopic}",
                                            style: TextStyle(
                                                fontSize: height * 0.018,
                                                fontWeight: FontWeight.w400,
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: "Inter"),
                                          ),
                                        ])),
                                  ])),
                              Padding(
                                  padding: EdgeInsets.only(left: width * 0.02),
                                  child: Row(children: [
                                    RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .total_ques,
//"Total Questions:",
                                            style: TextStyle(
                                                fontSize: height * 0.018,
                                                fontWeight: FontWeight.w500,
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: "Inter"),
                                          ),
                                          TextSpan(
                                            text:
                                            "\t ${questionListForNxtPage.length}",
                                            style: TextStyle(
                                                fontSize: height * 0.018,
                                                fontWeight: FontWeight.w500,
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                fontFamily: "Inter"),
                                          ),
                                        ])),
                                    SizedBox(width: width * 0.1),
                                    RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .total_marks,
//"Total Marks:",
                                            style: TextStyle(
                                                fontSize: height * 0.018,
                                                fontWeight: FontWeight.w500,
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: "Inter"),
                                          ),
                                          TextSpan(
                                            text: "\t ${assessment.totalScore}",
                                            style: TextStyle(
                                                fontSize: height * 0.018,
                                                fontWeight: FontWeight.w500,
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                fontFamily: "Inter"),
                                          ),
                                        ])),
                                  ])),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
// color: Colors.red,
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
//Text('Red container should be scrollable'),
                                SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: height * 0.025,
                                        ),
                                        Center(
                                          child: Container(
                                            padding:
                                            const EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              border: Border.all(
                                                color: const Color.fromRGBO(
                                                    230, 230, 230, 1),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(context)!
                                                          .category,
                                                      //"Category",
                                                      style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontSize: height * 0.025,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
// ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(children: [
                                                          SizedBox(
                                                            width: width * 0.4,
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .test_qn_page,
                                                              // "Test",
                                                              style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    28, 78, 80, 1),
                                                                fontSize:
                                                                height * 0.0175,
                                                                fontFamily: "Inter",
                                                                fontWeight:
                                                                FontWeight.w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Transform.scale(
                                                            scale: 1.5,
                                                            child: Radio(
                                                              value: 1,
                                                              groupValue: val,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  val = value!;
                                                                });
                                                              },
                                                              activeColor:
                                                              const Color.fromRGBO(
                                                                  82, 165, 160, 1),
                                                            ),
                                                          ),
                                                        ]),
                                                      ],
                                                    ),
                                                    Row(children: [
                                                      SizedBox(
                                                        width: width * 0.4,
                                                        child: Text(AppLocalizations.of(context)!.practice_qn_page,
                                                          // "Practice",
                                                          style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                28, 78, 80, 1),
                                                            fontSize:
                                                            height * 0.0175,
                                                            fontFamily: "Inter",
                                                            fontWeight:
                                                            FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Radio(
                                                          value: 2,
                                                          groupValue: val,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              val = value!;
                                                            });
                                                          },
                                                          activeColor:
                                                          const Color.fromRGBO(
                                                              82, 165, 160, 1),
                                                        ),
                                                      ),
                                                    ]),
                                                    Row(children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.make_test_practice,
                                                        //"Make Test available for Practice after",

                                                        style: TextStyle(
                                                          color:
                                                          const Color.fromRGBO(
                                                              28, 78, 80, 1),
                                                          fontSize: height * 0.0175,
                                                          fontFamily: "Inter",
                                                          fontWeight:
                                                          FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(width: width * 0.08),
                                                      SizedBox(
                                                        width: width * 0.1,
                                                        child: TextField(
                                                          controller:
                                                          numOfDaysAfterTestController,
                                                          keyboardType:
                                                          const TextInputType
                                                              .numberWithOptions(
                                                              decimal:
                                                              false),
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                "[0-9]")),
                                                          ],
                                                          decoration:
                                                          InputDecoration(
                                                            hintText: "# day/s",
                                                            hintStyle: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    102,
                                                                    102,
                                                                    102,
                                                                    0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontSize:
                                                                height * 0.020),
                                                          ),
                                                          style: TextStyle(
                                                              fontSize:
                                                              height * 0.020,
                                                              color: Colors.black),
                                                        ),
                                                      )
                                                    ]),
                                                    Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .only_mcq_for_practice,
//"Only MCQ will be available for Practice",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153, 153, 153, 1),
                                                              fontSize:
                                                              height * 0.015,
                                                              fontFamily: "Inter",
                                                              fontStyle: FontStyle.italic,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                              height * 0.035),
                                                        ]),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.025,
                                        ),
                                        Center(
                                          child: Container(
                                            padding:
                                            const EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              border: Border.all(
                                                color: const Color.fromRGBO(
                                                    230, 230, 230, 1),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                val == 1
                                                    ? Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                          context)!
                                                          .test_schedule,
//"Test Schedule",
                                                      style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontSize:
                                                        height * 0.025,
                                                        fontFamily: "Inter",
                                                        fontWeight:
                                                        FontWeight.w700,
                                                      ),
                                                    ),
// ),
                                                    SizedBox(
                                                      height: height * 0.002,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                          context)!
                                                          .leave_blank,
// "Leave blank if not required",
                                                      style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            153, 153, 153, 1),
                                                        fontSize:
                                                        height * 0.015,
                                                        fontFamily: "Inter",
                                                        fontWeight:
                                                        FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.025,
                                                    ),
                                                    Row(children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                            context)!
                                                            .duration,
//"Duration",
                                                        style: TextStyle(
                                                          color: const Color
                                                              .fromRGBO(
                                                              28, 78, 80, 1),
                                                          fontSize:
                                                          height * 0.0175,
                                                          fontFamily: "Inter",
                                                          fontWeight:
                                                          FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width * 0.38),
                                                      SizedBox(
                                                        width: width * 0.1,
                                                        child: TextField(
                                                          controller:
                                                          timePermitHoursController,
                                                          keyboardType:
                                                          const TextInputType
                                                              .numberWithOptions(
                                                              decimal:
                                                              false),
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                "[0-9]")),
                                                          ],
// O
                                                          decoration:
                                                          InputDecoration(
                                                            hintText: "HH",
                                                            hintStyle: TextStyle(
                                                                color:
                                                                const Color
                                                                    .fromRGBO(
                                                                    102,
                                                                    102,
                                                                    102,
                                                                    0.3),
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400,
                                                                fontSize:
                                                                height *
                                                                    0.020),
                                                          ),
                                                          onChanged: (val) {
                                                            setState(() {
                                                              hours =
                                                                  int.parse(val);
                                                            });
                                                          },
                                                          style: TextStyle(
                                                              fontSize:
                                                              height *
                                                                  0.020,
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                      ),
                                                      Text(
                                                        " : ",
                                                        style: TextStyle(
                                                          color: const Color
                                                              .fromRGBO(
                                                              28, 78, 80, 1),
                                                          fontSize:
                                                          height * 0.0175,
                                                          fontFamily: "Inter",
                                                          fontWeight:
                                                          FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.1,
                                                        child: TextField(
                                                          onChanged: (val) {
                                                            setState(() {
                                                              minutes =
                                                                  int.parse(
                                                                      val);
                                                            });
                                                          },
                                                          controller:
                                                          timePermitMinutesController,
                                                          keyboardType:
                                                          const TextInputType
                                                              .numberWithOptions(
                                                              decimal:
                                                              false),
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                "[0-9a-zA-Z]")),
                                                          ],
// O
                                                          decoration:
                                                          InputDecoration(
                                                            hintText: "MM",
                                                            hintStyle: TextStyle(
                                                                color:
                                                                const Color
                                                                    .fromRGBO(
                                                                    102,
                                                                    102,
                                                                    102,
                                                                    0.3),
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400,
                                                                fontSize:
                                                                height *
                                                                    0.020),
                                                          ),
                                                          style: TextStyle(
                                                              fontSize:
                                                              height *
                                                                  0.020,
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                      )
                                                    ]),
                                                    SizedBox(
                                                        height:
                                                        height * 0.03),
                                                    Row(children: [
                                                      SizedBox(
                                                        height: height * 0.12,
                                                        width: height * 0.18,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .start_date,
//"Start Date",
                                                              style:
                                                              TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                height *
                                                                    0.0175,
                                                                fontFamily:
                                                                "Inter",
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                              ),
                                                            ),
                                                            MouseRegion(
                                                                cursor: SystemMouseCursors.click,
                                                                child:
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    var pickedDate =
                                                                    await showDatePicker(
                                                                      context:
                                                                      context,
                                                                      initialDate:
                                                                      DateTime.now(),
                                                                      firstDate:
                                                                      startDate,
                                                                      lastDate:
                                                                      DateTime(2100),
                                                                      builder:
                                                                          (context,
                                                                          child) {
                                                                        return Theme(
                                                                          data:
                                                                          Theme.of(context).copyWith(
                                                                            colorScheme: const ColorScheme.light(
                                                                              primary: Color.fromRGBO(82, 165, 160, 1),
                                                                              onPrimary: Colors.white,
                                                                              onSurface: Colors.black, // <-- SEE HERE
                                                                            ),
                                                                            textButtonTheme: TextButtonThemeData(
                                                                              style: TextButton.styleFrom(
                                                                                foregroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                          child!,
                                                                        );
                                                                      },
                                                                    );
                                                                    final DateFormat
                                                                    formatter =
                                                                    DateFormat(
                                                                        'dd/MM/yyyy');
                                                                    final String
                                                                    formatted =
                                                                    formatter
                                                                        .format(pickedDate!);
                                                                    startDate =
                                                                        pickedDate;
                                                                    startDateController
                                                                        .text =
                                                                        formatted;
                                                                  },
                                                                  child:
                                                                  AbsorbPointer(
                                                                    child:
                                                                    TextFormField(
                                                                      decoration: InputDecoration(
                                                                          hintText:
                                                                          "DD/MM/YYYY",
                                                                          hintStyle: TextStyle(
                                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: height * 0.020)),
                                                                      controller:
                                                                      startDateController,
                                                                      keyboardType:
                                                                      TextInputType.datetime,
                                                                      enabled:
                                                                      true,
                                                                      onChanged:
                                                                          (value) {},
                                                                    ),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                          width * 0.2),
                                                      SizedBox(
                                                        height: height * 0.12,
                                                        width: height * 0.10,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .start_time,
// "Start Time",
                                                              style:
                                                              TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                height *
                                                                    0.0175,
                                                                fontFamily:
                                                                "Inter",
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                              ),
                                                            ),
                                                            TextField(
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                  "00:00",
                                                                  hintStyle: TextStyle(
                                                                      color: const Color.fromRGBO(
                                                                          102,
                                                                          102,
                                                                          102,
                                                                          0.3),
                                                                      fontFamily:
                                                                      'Inter',
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      fontSize:
                                                                      height *
                                                                          0.020)),
                                                              keyboardType:
                                                              TextInputType
                                                                  .datetime,
                                                              enabled: true,
                                                              controller:
                                                              startTimeController,
//editing controller of this TextField
                                                              onTap:
                                                                  () async {
                                                                TimeOfDay? pickedTime = await showTimePicker(
                                                                    initialTime:
                                                                    TimeOfDay
                                                                        .now(),
                                                                    context:
                                                                    context,
                                                                    initialEntryMode:
                                                                    TimePickerEntryMode
                                                                        .dial);

                                                                if (pickedTime !=
                                                                    null) {
                                                                  DateTime
                                                                  parsedTime =
                                                                  DateFormat.jm().parse(pickedTime
                                                                      .format(context)
                                                                      .toString());
                                                                  startTime =
                                                                      parsedTime;
                                                                  String
                                                                  formattedTime =
                                                                  DateFormat('HH:mm')
                                                                      .format(parsedTime);
                                                                  setState(
                                                                          () {
                                                                        startTimeController
                                                                            .text =
                                                                            formattedTime
                                                                                .toString(); //set the value of text field.
                                                                      });
                                                                } else {}
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ]),
                                                    SizedBox(
                                                        height:
                                                        height * 0.001),
                                                    Row(children: [
                                                      SizedBox(
                                                        height: height * 0.12,
                                                        width: height * 0.18,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .end_date,
// "End Date",
                                                              style:
                                                              TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                height *
                                                                    0.0175,
                                                                fontFamily:
                                                                "Inter",
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                              ),
                                                            ),
                                                            MouseRegion(
                                                                cursor:
                                                                SystemMouseCursors
                                                                    .click,
                                                                child:
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    var pickedDate =
                                                                    await showDatePicker(
                                                                      context:
                                                                      context,
                                                                      initialDate:
                                                                      DateTime.now(),
                                                                      firstDate:
                                                                      DateTime.now(),
                                                                      lastDate:
                                                                      DateTime(2100),
                                                                      builder:
                                                                          (context,
                                                                          child) {
                                                                        return Theme(
                                                                          data:
                                                                          Theme.of(context).copyWith(
                                                                            colorScheme: const ColorScheme.light(
                                                                              primary: Color.fromRGBO(82, 165, 160, 1),
                                                                              onPrimary: Colors.white,
                                                                              onSurface: Colors.black, // <-- SEE HERE
                                                                            ),
                                                                            textButtonTheme: TextButtonThemeData(
                                                                              style: TextButton.styleFrom(
                                                                                foregroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                          child!,
                                                                        );
                                                                      },
                                                                    );
                                                                    final DateFormat
                                                                    formatter =
                                                                    DateFormat(
                                                                        'dd/MM/yyyy');
                                                                    final String
                                                                    formatted =
                                                                    formatter
                                                                        .format(pickedDate!);
                                                                    endDate =
                                                                        pickedDate;
                                                                    endDateController
                                                                        .text =
                                                                        formatted;
                                                                  },
                                                                  child:
                                                                  AbsorbPointer(
                                                                    child:
                                                                    TextFormField(
                                                                      decoration: InputDecoration(
                                                                          hintText:
                                                                          "DD/MM/YYYY",
                                                                          hintStyle: TextStyle(
                                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: height * 0.020)),
                                                                      controller:
                                                                      endDateController,
                                                                      keyboardType:
                                                                      TextInputType.datetime,
                                                                      enabled:
                                                                      true,
                                                                      onChanged:
                                                                          (value) {},
                                                                    ),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                          width * 0.2),
                                                      SizedBox(
                                                        height: height * 0.12,
                                                        width: height * 0.10,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .end_time,
//"End Time",
                                                              style:
                                                              TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                height *
                                                                    0.0175,
                                                                fontFamily:
                                                                "Inter",
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                              ),
                                                            ),
                                                            MouseRegion(
                                                                cursor:
                                                                SystemMouseCursors
                                                                    .click,
                                                                child:
                                                                GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      _selectTime(context);
                                                                    },
                                                                    child:
                                                                    TextField(
                                                                      decoration:
                                                                      InputDecoration(hintText: "00:00", hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.020)),
                                                                      keyboardType:
                                                                      TextInputType.datetime,
                                                                      enabled:
                                                                      true,
                                                                      controller:
                                                                      endTimeController,
//editing controller of this TextField
                                                                      onTap:
                                                                          () async {
                                                                        TimeOfDay? pickedTime = await showTimePicker(
                                                                          initialTime: TimeOfDay.now(),
                                                                          context: context,
                                                                        );

                                                                        if (pickedTime != null) {
                                                                          DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                                          endTime = parsedTime;
                                                                          String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                                          setState(() {
                                                                            endTimeController.text = formattedTime.toString(); //set the value of text field.
                                                                          });
                                                                        } else {}
                                                                      },
                                                                    )
                                                                )),
                                                          ],
                                                        ),
                                                      )
                                                    ]),
                                                  ],
                                                )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.025,
                                        ),
                                        Center(
                                          child: Container(
                                            padding:
                                            const EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              border: Border.all(
                                                color: const Color.fromRGBO(
                                                    230, 230, 230, 1),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(context)!
                                                          .institute_organisation,
//"Institution / Organisation",
                                                      style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontSize: height * 0.02,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
// ),
                                                    SizedBox(
                                                      height: height * 0.002,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(context)!
                                                          .leave_blank,
//"Leave blank if not required",
                                                      style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            153, 153, 153, 1),
                                                        fontSize: height * 0.015,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.025,
                                                    ),
                                                    Row(children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                            context)!
                                                            .institute_test_id_small,
//"Institute Test ID",
                                                        style: TextStyle(
                                                          color:
                                                          const Color.fromRGBO(
                                                              28, 78, 80, 1),
                                                          fontSize: height * 0.0175,
                                                          fontFamily: "Inter",
                                                          fontWeight:
                                                          FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(width: width * 0.15),
                                                      SizedBox(
                                                        width: width * 0.35,
                                                        child: TextField(
                                                          controller:
                                                          instituteTestIdcontroller,
                                                          decoration:
                                                          InputDecoration(
                                                            hintText:
                                                            "UCE1122334455",
                                                            hintStyle: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    102,
                                                                    102,
                                                                    102,
                                                                    0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontSize:
                                                                height * 0.020),
                                                          ),
                                                          style: TextStyle(
                                                              fontSize:
                                                              height * 0.020,
                                                              color: Colors.black),
                                                        ),
                                                      )
                                                    ]),
                                                    SizedBox(height: height * 0.02),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.025,
                                        ),
                                        Center(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              border: Border.all(
                                                color: const Color.fromRGBO(
                                                    230, 230, 230, 1),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(context)!
                                                          .access_control,
//"Access Control",
                                                      style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontSize: height * 0.025,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.025,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .no_of_retries_allowed,
//"Number of Retries allowed",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  51, 51, 51, 1),
                                                              fontSize: height * 0.015,
                                                              fontFamily: "Inter",
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
//SizedBox(width: width * 0.2),
                                                          SizedBox(
                                                            width: width * 0.1,
                                                            child: TextField(
                                                              controller:
                                                              retriesController,
                                                              keyboardType:
                                                              TextInputType
                                                                  .number,
                                                              decoration:
                                                              InputDecoration(
                                                                hintText: "1",
                                                                hintStyle: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        102,
                                                                        102,
                                                                        102,
                                                                        0.3),
                                                                    fontFamily:
                                                                    'Inter',
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    fontSize:
                                                                    height *
                                                                        0.025),
                                                              ),
                                                              style: TextStyle(
                                                                  fontSize: height *
                                                                      0.020,
                                                                  color:
                                                                  Colors.black),
                                                            ),
                                                          ),
// SizedBox(width: width * 0.3),
                                                          FlutterSwitch(
                                                            activeColor: const Color
                                                                .fromRGBO(
                                                                82, 165, 160, 1),
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
                                                            numOfRetriesStatus,
                                                            borderRadius: 30.0,
                                                            onToggle: (val) {
                                                              setState(() {
                                                                numOfRetriesStatus =
                                                                    val;
                                                              });
                                                            },
                                                          ),
                                                        ]),
                                                    SizedBox(height: height * 0.01),
                                                    Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .allow_guest_test,
//"Allow guest students for test",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  51, 51, 51, 1),
                                                              fontSize:
                                                              height * 0.015,
                                                              fontFamily: "Inter",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                          ),
                                                          FlutterSwitch(
                                                            activeColor: const Color
                                                                .fromRGBO(
                                                                82, 165, 160, 1),
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
                                                            allowedGuestStatus,
                                                            borderRadius: 30.0,
                                                            onToggle: (val) {
                                                              setState(() {
                                                                allowedGuestStatus =
                                                                    val;
                                                              });
                                                            },
                                                          ),
                                                        ]),
                                                    SizedBox(height: height * 0.01),
                                                    Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .show_answersheet_after_test,
//"Show answer sheet after test",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  51, 51, 51, 1),
                                                              fontSize:
                                                              height * 0.015,
                                                              fontFamily: "Inter",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                          ),
                                                          FlutterSwitch(
                                                            activeColor: const Color
                                                                .fromRGBO(
                                                                82, 165, 160, 1),
                                                            inactiveColor:
                                                            const Color
                                                                .fromRGBO(
                                                                217,
                                                                217,
                                                                217,
                                                                1),
                                                            width: 65.0,
                                                            height: 35.0,
                                                            value: showAnsAfterTest,
                                                            borderRadius: 30.0,
                                                            onToggle: (val) {
                                                              setState(() {
                                                                showAnsAfterTest =
                                                                    val;
                                                              });
                                                            },
                                                          ),
                                                        ]),
                                                    SizedBox(height: height * 0.01),
                                                    Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .show_answer_practice,
//"Show answer sheet during Practice",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  51, 51, 51, 1),
                                                              fontSize:
                                                              height * 0.015,
                                                              fontFamily: "Inter",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                          ),
                                                          FlutterSwitch(
                                                            activeColor: const Color
                                                                .fromRGBO(
                                                                82, 165, 160, 1),
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
                                                            showAnsDuringPractice,
                                                            borderRadius: 30.0,
                                                            onToggle: (val) {
                                                              setState(() {
                                                                showAnsDuringPractice =
                                                                    val;
                                                              });
                                                            },
                                                          ),
                                                        ]),
                                                    SizedBox(height: height * 0.01),
                                                    Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .show_my_advisor_name,
//"Show my name in Advisor",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  51, 51, 51, 1),
                                                              fontSize:
                                                              height * 0.015,
                                                              fontFamily: "Inter",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                          ),
                                                          FlutterSwitch(
                                                            activeColor: const Color
                                                                .fromRGBO(
                                                                82, 165, 160, 1),
                                                            inactiveColor:
                                                            const Color
                                                                .fromRGBO(
                                                                217,
                                                                217,
                                                                217,
                                                                1),
                                                            width: 65.0,
                                                            height: 35.0,
                                                            value: showNameStatus,
                                                            borderRadius: 30.0,
                                                            onToggle: (val) {
                                                              setState(() {
                                                                showNameStatus =
                                                                    val;
                                                              });
                                                            },
                                                          ),
                                                        ]),
                                                    SizedBox(height: height * 0.01),
                                                    Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .show_my_email,
//"Show my Email in Advisor",
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  51, 51, 51, 1),
                                                              fontSize:
                                                              height * 0.015,
                                                              fontFamily: "Inter",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                          ),
                                                          FlutterSwitch(
                                                            activeColor: const Color
                                                                .fromRGBO(
                                                                82, 165, 160, 1),
                                                            inactiveColor:
                                                            const Color
                                                                .fromRGBO(
                                                                217,
                                                                217,
                                                                217,
                                                                1),
                                                            width: 65.0,
                                                            height: 35.0,
                                                            value: showEmailStatus,
                                                            borderRadius: 30.0,
                                                            onToggle: (val) {
                                                              setState(() {
                                                                showEmailStatus =
                                                                    val;
                                                              });
                                                            },
                                                          ),
                                                        ]),
                                                    SizedBox(height: height * 0.01),
                                                    (widget.assessmentType=='new' || widget.assessmentType=='inprogress')?SizedBox(height: height * 0.00):
                                                    Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .make_assessment_inactive,
//"Make assessment inactive",
                                                                  style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        51,
                                                                        51,
                                                                        51,
                                                                        1),
                                                                    fontSize:
                                                                    height *
                                                                        0.015,
                                                                    fontFamily:
                                                                    "Inter",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .not_available_for_student,
//"Not available for student",
                                                                  style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        153,
                                                                        153,
                                                                        153,
                                                                        0.8),
                                                                    fontSize:
                                                                    height *
                                                                        0.015,
                                                                    fontFamily:
                                                                    "Inter",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                  ),
                                                                ),
                                                              ]),
                                                          FlutterSwitch(
                                                            activeColor: const Color
                                                                .fromRGBO(
                                                                82, 165, 160, 1),
                                                            inactiveColor:
                                                            const Color
                                                                .fromRGBO(
                                                                217,
                                                                217,
                                                                217,
                                                                1),
                                                            width: 65.0,
                                                            height: 35.0,
                                                            value: activeStatus,
                                                            borderRadius: 30.0,
                                                            onToggle: (val) {
                                                              setState(() {
                                                                activeStatus = val;
                                                              });
                                                            },
                                                          ),
                                                        ]),
                                                    SizedBox(height: height * 0.01),
                                                    domainName ==
                                                        "https://dev.qnatest.com"
                                                        ? const SizedBox()
                                                        : Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .allow_public_for_practice,
//"Allow public access for practice",
                                                                  style:
                                                                  TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        51,
                                                                        51,
                                                                        51,
                                                                        1),
                                                                    fontSize:
                                                                    height *
                                                                        0.015,
                                                                    fontFamily:
                                                                    "Inter",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .available_to_public,
//"Available to public for practice",
                                                                  style:
                                                                  TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        153,
                                                                        153,
                                                                        153,
                                                                        0.8),
                                                                    fontSize:
                                                                    height *
                                                                        0.015,
                                                                    fontFamily:
                                                                    "Inter",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                  ),
                                                                ),
                                                              ]),
                                                          FlutterSwitch(
                                                            activeColor:
                                                            const Color
                                                                .fromRGBO(
                                                                82,
                                                                165,
                                                                160,
                                                                1),
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
                                                            publicAccessStatus,
                                                            borderRadius:
                                                            30.0,
                                                            onToggle: (val) {
                                                              setState(() {
                                                                publicAccessStatus =
                                                                    val;
                                                              });
                                                            },
                                                          ),
                                                        ]),
                                                    SizedBox(height: height * 0.05),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: height * 0.05),
                                        Column(children: [
                                          widget.assessmentType=='editActive'?
                                          const SizedBox(height: 0)
                                              :Center(
                                            child: SizedBox(
                                              width: width * 0.6,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  side: const BorderSide(
                                                    color: Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                  ),
                                                  backgroundColor:
                                                  const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  minimumSize: const Size(280, 48),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(39),
                                                  ),
                                                ),
//shape: StadiumBorder(),
                                                onPressed: () async {
                                                  if (val == 1) {
                                                    assessment.assessmentType =
                                                    'test';
                                                    assessment.assessmentDuration =
                                                        (hours * 60) + minutes;
                                                  } else {
                                                    assessment.assessmentType =
                                                    'practice';
                                                    assessment.assessmentDuration =0;
                                                  }
                                                  assessment.assessmentStatus =
                                                  'inprogress';
                                                  AssessmentSettings
                                                  assessmentSettings =
                                                  AssessmentSettings();
                                                  assessmentSettings
                                                      .allowedNumberOfTestRetries =
                                                  retriesController.text == ''
                                                      ? 0
                                                      : int.parse(
                                                      retriesController
                                                          .text);
                                                  assessmentSettings
                                                      .numberOfDaysAfterTestAvailableForPractice =
                                                  numOfDaysAfterTestController
                                                      .text ==
                                                      ''
                                                      ? 0
                                                      : int.parse(
                                                      numOfDaysAfterTestController
                                                          .text);
                                                  assessmentSettings
                                                      .allowGuestStudent =
                                                      allowedGuestStatus;
                                                  assessmentSettings
                                                      .showSolvedAnswerSheetInAdvisor =
                                                      showAnsAfterTest;
                                                  assessmentSettings
                                                      .showAnswerSheetDuringPractice =
                                                      showAnsDuringPractice;
                                                  assessmentSettings
                                                      .showAdvisorName =
                                                      showNameStatus;
                                                  assessmentSettings
                                                      .showAdvisorEmail =
                                                      showEmailStatus;
                                                  assessmentSettings.notAvailable =
                                                      activeStatus;
                                                  assessmentSettings
                                                      .avalabilityForPractice =
                                                      publicAccessStatus;
                                                  showNameStatus?assessmentSettings.advisorName=advisorName:assessmentSettings.advisorName=null;
                                                  showEmailStatus?assessmentSettings.advisorEmail=advisorEmail:assessmentSettings.advisorEmail=null;
                                                  assessment.assessmentSettings =
                                                      assessmentSettings;
                                                  startDate = DateTime(
                                                      startDate.year,
                                                      startDate.month,
                                                      startDate.day,
                                                      startTime.hour,
                                                      startTime.minute);
                                                  assessment.assessmentStartdate =
                                                      startDate
                                                          .microsecondsSinceEpoch;
                                                  endDate = DateTime(
                                                      endDate.year,
                                                      endDate.month,
                                                      endDate.day,
                                                      endTime.hour,
                                                      endTime.minute);
                                                  assessment.assessmentEnddate =
                                                      endDate
                                                          .microsecondsSinceEpoch;

                                                  int totque=Provider.of<QuestionPrepareProviderFinal>(
                                                      context,
                                                      listen: false).getAllQuestion.length;
                                                  assessment.totalQuestions=totque;
                                                  ResponseEntity statusCode =
                                                  ResponseEntity();
                                                  if (assessment.assessmentId !=
                                                      null) {
                                                    statusCode = await QnaService
                                                        .editAssessmentTeacherService(
                                                        assessment,
                                                        assessment
                                                            .assessmentId!,userDetails);
                                                  } else {
                                                    statusCode = await QnaService
                                                        .createAssessmentTeacherService(
                                                        assessment,userDetails);
                                                  }
                                                  Provider.of<NewQuestionProvider>(
                                                      context,
                                                      listen: false)
                                                      .reSetQuestionList();
                                                  if (statusCode.code == 200) {
                                                    Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));

                                                  }
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .publish_later,
//'Publish Later',
                                                  style: TextStyle(
                                                      fontSize: height * 0.025,
                                                      fontFamily: "Inter",
                                                      color: const Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          widget.assessmentType=='editActive'?
                                          const SizedBox(height: 0)
                                              :Center(
                                            child: SizedBox(
                                              width: width * 0.6,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    minimumSize:
                                                    const Size(280, 48),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(39),
                                                    ),
                                                    side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                    )),
                                                onPressed: () async {
                                                  if (val == 1) {
                                                    assessment.assessmentType =
                                                    'test';
                                                    assessment.assessmentDuration =
                                                        (hours * 60) + minutes;
                                                  } else {
                                                    assessment.assessmentType =
                                                    'practice';
                                                    assessment.assessmentDuration =0;
                                                  }
                                                  assessment.assessmentStatus =
                                                  'active';
                                                  AssessmentSettings
                                                  assessmentSettings =
                                                  AssessmentSettings();
                                                  assessmentSettings
                                                      .allowedNumberOfTestRetries =
                                                  retriesController.text == ''
                                                      ? 0
                                                      : int.parse(
                                                      retriesController
                                                          .text);
                                                  assessmentSettings
                                                      .numberOfDaysAfterTestAvailableForPractice =
                                                  numOfDaysAfterTestController
                                                      .text ==
                                                      ''
                                                      ? 0
                                                      : int.parse(
                                                      numOfDaysAfterTestController
                                                          .text);
                                                  assessmentSettings
                                                      .allowGuestStudent =
                                                      allowedGuestStatus;
                                                  assessmentSettings
                                                      .showSolvedAnswerSheetInAdvisor =
                                                      showAnsAfterTest;
                                                  assessmentSettings
                                                      .showAnswerSheetDuringPractice =
                                                      showAnsDuringPractice;
                                                  assessmentSettings
                                                      .showAdvisorName =
                                                      showNameStatus;
                                                  assessmentSettings
                                                      .showAdvisorEmail =
                                                      showEmailStatus;
                                                  assessmentSettings.notAvailable =
                                                      activeStatus;
                                                  assessmentSettings
                                                      .avalabilityForPractice =
                                                      publicAccessStatus;
                                                  showNameStatus?assessmentSettings.advisorName=advisorName:assessmentSettings.advisorName=null;
                                                  showEmailStatus?assessmentSettings.advisorEmail=advisorEmail:assessmentSettings.advisorEmail=null;
                                                  assessment.assessmentSettings =
                                                      assessmentSettings;
                                                  startDate = DateTime(
                                                      startDate.year,
                                                      startDate.month,
                                                      startDate.day,
                                                      startTime.hour,
                                                      startTime.minute);
                                                  assessment.assessmentStartdate =
                                                      startDate
                                                          .microsecondsSinceEpoch;
                                                  endDate = DateTime(
                                                      endDate.year,
                                                      endDate.month,
                                                      endDate.day,
                                                      endTime.hour,
                                                      endTime.minute);
                                                  assessment.assessmentEnddate =
                                                      endDate
                                                          .microsecondsSinceEpoch;
                                                  int totque=Provider.of<QuestionPrepareProviderFinal>(
                                                      context,
                                                      listen: false).getAllQuestion.length;
                                                  assessment.totalQuestions=totque;
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
                                                  ResponseEntity statusCode =
                                                  ResponseEntity();
                                                  String assessmentCode = '';
                                                  if (widget.assessmentType=='inprogress') {
                                                    statusCode = await QnaService
                                                        .editAssessmentTeacherService(
                                                        assessment,
                                                        assessment
                                                            .assessmentId!,userDetails);
                                                    assessmentCode =
                                                    assessment.assessmentCode!;
                                                    Navigator.of(context).pop();
                                                    Provider.of<NewQuestionProvider>(
                                                        context,
                                                        listen: false)
                                                        .reSetQuestionList();
                                                    Navigator.pushNamed(context,
                                                        '/teacherPublishedAssessment',
                                                        arguments: [
                                                          assessmentCode,
                                                          questionListForNxtPage
                                                        ]);
                                                  }
                                                  else if (widget.assessmentType=='inactiveReactive') {
                                                    statusCode = await QnaService
                                                        .editAssessmentTeacherService(
                                                        assessment,
                                                        assessment
                                                            .assessmentId!,userDetails);
                                                    assessmentCode =
                                                    assessment.assessmentCode!;
                                                    Navigator.of(context).pop();
                                                    Provider.of<NewQuestionProvider>(
                                                        context,
                                                        listen: false)
                                                        .reSetQuestionList();
                                                    Navigator.pushNamed(context,
                                                        '/teacherPublishedAssessment',
                                                        arguments: [
                                                          assessmentCode,
                                                          questionListForNxtPage
                                                        ]);
                                                  }
                                                  else {
                                                    statusCode = await QnaService
                                                        .createAssessmentTeacherService(
                                                        assessment,userDetails);

                                                    if (statusCode.code == 200) {
                                                      assessmentCode = statusCode
                                                          .data
                                                          .toString()
                                                          .substring(
                                                          18,
                                                          statusCode.data
                                                              .toString()
                                                              .length -
                                                              1);
                                                    }
                                                    Navigator.of(context).pop();
                                                    Provider.of<NewQuestionProvider>(
                                                        context,
                                                        listen: false)
                                                        .reSetQuestionList();
                                                    Navigator.pushNamed(context,
                                                        '/teacherPublishedAssessment',
                                                        arguments: [
                                                          assessmentCode,
                                                          questionListForNxtPage
                                                        ]);
// Navigator.push(
//   context,
//   PageTransition(
//     type: PageTransitionType
//         .rightToLeft,
//     child: TeacherPublishedAssessment(
//         assessmentCode:
//             assessmentCode,
//         questionList:
//             questionListForNxtPage),
//   ),
// );
                                                  }
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .publish_now,
//'Publish Now',
                                                  style: TextStyle(
                                                      fontSize: height * 0.025,
                                                      fontFamily: "Inter",
                                                      color: const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),

                                          widget.assessmentType!='editActive'?
                                          const SizedBox(height: 0)
                                              :Center(
                                            child: SizedBox(
                                              width: width * 0.6,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    minimumSize:
                                                    const Size(280, 48),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(39),
                                                    ),
                                                    side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                    )),
                                                onPressed: () async {
                                                  if (val == 1) {
                                                    assessment.assessmentType =
                                                    'test';
                                                  } else {
                                                    assessment.assessmentType =
                                                    'practice';
                                                  }
                                                  assessment.assessmentStatus =
                                                  'active';
                                                  AssessmentSettings
                                                  assessmentSettings =
                                                  AssessmentSettings();
                                                  assessmentSettings
                                                      .allowedNumberOfTestRetries =
                                                  retriesController.text == ''
                                                      ? 0
                                                      : int.parse(
                                                      retriesController
                                                          .text);
                                                  assessmentSettings
                                                      .numberOfDaysAfterTestAvailableForPractice =
                                                  numOfDaysAfterTestController
                                                      .text ==
                                                      ''
                                                      ? 0
                                                      : int.parse(
                                                      numOfDaysAfterTestController
                                                          .text);
                                                  assessmentSettings
                                                      .allowGuestStudent =
                                                      allowedGuestStatus;
                                                  assessmentSettings
                                                      .showSolvedAnswerSheetInAdvisor =
                                                      showAnsAfterTest;
                                                  assessmentSettings
                                                      .showAnswerSheetDuringPractice =
                                                      showAnsDuringPractice;
                                                  assessmentSettings
                                                      .showAdvisorName =
                                                      showNameStatus;
                                                  assessmentSettings
                                                      .showAdvisorEmail =
                                                      showEmailStatus;
                                                  assessmentSettings.notAvailable =
                                                      activeStatus;
                                                  assessmentSettings
                                                      .avalabilityForPractice =
                                                      publicAccessStatus;
                                                  showNameStatus?assessmentSettings.advisorName=advisorName:assessmentSettings.advisorName=null;
                                                  showEmailStatus?assessmentSettings.advisorEmail=advisorEmail:assessmentSettings.advisorEmail=null;
                                                  assessment.assessmentSettings =
                                                      assessmentSettings;
                                                  startDate = DateTime(
                                                      startDate.year,
                                                      startDate.month,
                                                      startDate.day,
                                                      startTime.hour,
                                                      startTime.minute);
                                                  assessment.assessmentStartdate =
                                                      startDate
                                                          .microsecondsSinceEpoch;
                                                  endDate = DateTime(
                                                      endDate.year,
                                                      endDate.month,
                                                      endDate.day,
                                                      endTime.hour,
                                                      endTime.minute);
                                                  assessment.assessmentEnddate =
                                                      endDate
                                                          .microsecondsSinceEpoch;

                                                  assessment.assessmentDuration =
                                                      (hours * 60) + minutes;
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
                                                  ResponseEntity statusCode =
                                                  ResponseEntity();
                                                  String assessmentCode = '';
                                                  if (widget.assessmentType=='editActive') {
                                                    if(activeStatus){
                                                      assessment.assessmentStatus='inactive';

                                                    }
                                                    else{
                                                      assessment.assessmentStatus='active';
                                                    }

                                                    // activeStatus?
                                                    // statusCode = await QnaService
                                                    //     .makeInactiveAssessmentTeacherService(
                                                    //   assessment.assessmentSettings!,
                                                    //   assessment
                                                    //       .assessmentId!,
                                                    //   assessment.assessmentType!,
                                                    //   'inactive',userDetails,
                                                    // )
                                                    //     :
                                                    // statusCode = await QnaService
                                                    //     .editActiveAssessmentTeacherService(
                                                    //     assessment,
                                                    //     assessment.assessmentSettings!,
                                                    //     assessment
                                                    //         .assessmentId!,assessment.assessmentType!,'active',userDetails);
                                                    assessmentCode =
                                                    assessment.assessmentCode!;
                                                    Navigator.of(context).pop();
                                                    Provider.of<NewQuestionProvider>(
                                                        context,
                                                        listen: false)
                                                        .reSetQuestionList();
                                                    Navigator.pushNamed(context,
                                                        '/teacherPublishedAssessment',
                                                        arguments: [
                                                          assessmentCode,
                                                          questionListForNxtPage
                                                        ]);
                                                  }
                                                  else {
                                                    statusCode = await QnaService
                                                        .createAssessmentTeacherService(
                                                        assessment,userDetails);

                                                    if (statusCode.code == 200) {
                                                      assessmentCode = statusCode
                                                          .data
                                                          .toString()
                                                          .substring(
                                                          18,
                                                          statusCode.data
                                                              .toString()
                                                              .length -
                                                              1);
                                                    }
                                                    Navigator.of(context).pop();
                                                    Provider.of<NewQuestionProvider>(
                                                        context,
                                                        listen: false)
                                                        .reSetQuestionList();
                                                    Navigator.pushNamed(context,
                                                        '/teacherPublishedAssessment',
                                                        arguments: [
                                                          assessmentCode,
                                                          questionListForNxtPage
                                                        ]);
                                                    // Navigator.push(
                                                    //   context,
                                                    //   PageTransition(
                                                    //     type: PageTransitionType
                                                    //         .rightToLeft,
                                                    //     child: TeacherPublishedAssessment(
                                                    //         assessmentCode:
                                                    //             assessmentCode,
                                                    //         questionList:
                                                    //             questionListForNxtPage),
                                                    //   ),
                                                    // );
                                                  }
                                                },
                                                child: Text(
                                                  'Save changes',
                                                  //'Publish Now',
                                                  style: TextStyle(
                                                      fontSize: height * 0.025,
                                                      fontFamily: "Inter",
                                                      color: const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          }
        });
  }

  _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = TimeOfDay.now();
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.input);
    setState(() {
      selectedTime = timeOfDay;
    });
  }
}
