import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/Teacher/question_entity.dart';
import 'package:qna_test/Providers/edit_assessment_provider.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/choice_entity.dart';
import '../Entity/Teacher/get_assessment_model.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Entity/user_details.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Providers/create_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DataSource/http_url.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'teacher/question/edit_global_question_popup.dart';
import 'teacher/question/edit_question_popup.dart';

class AssessmentLandingPage extends StatefulWidget {
  const AssessmentLandingPage({
    Key? key,
  }) : super(key: key);



  @override
  AssessmentLandingPageState createState() => AssessmentLandingPageState();
}

class AssessmentLandingPageState extends State<AssessmentLandingPage> {
  bool agree = true;
  int pageNumber = 1;

  String searchVal = '';
  TextEditingController teacherQuestionBankSearchController =
  TextEditingController();
  SharedPreferences? loginData;
  UserDetails userDetails=UserDetails();
  bool onlyMyAssessments = true;
  bool myQuestion =true;
  //-----------------------------------------------------
  final formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  List<GetAssessmentModel> assessmentList=[];
  String totalAssessments='';
  int assessmentStart=0;

  @override
  void initState() {
    super.initState();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    getInitData('');
  }

  getInitData(String search) async {
    ResponseEntity response =
    await QnaService.getAllAssessment(10, pageNumber, search,userDetails);
    List<GetAssessmentModel> assessments = [];
    if (response.code == 200) {
      assessments = response.data['assessments']==null?[]:List<GetAssessmentModel>.from(
          response.data['assessments'].map((x) => GetAssessmentModel.fromJson(x)));
      totalAssessments=response.data['total_count'].toString();
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
      assessmentList=[];
      assessmentList.addAll(assessments);
      pageNumber++;
      searchVal = search;
    });
    //Navigator.of(context).pop();
  }

  getData(String search) async {
    ResponseEntity response =
    await QnaService.getAllAssessment(10, pageNumber, search,userDetails);
    List<GetAssessmentModel> assessments = [];
    if (response.code == 200) {
      assessments = response.data['assessments']==null?[]:List<GetAssessmentModel>.from(
          response.data['assessments'].map((x) => GetAssessmentModel.fromJson(x)));
      totalAssessments=response.data['total_count'].toString();
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
      onlyMyAssessments=true;
      assessmentList.addAll(assessments);
      pageNumber++;
      searchVal = search;
    });
  }

  searchGlobalQuestion() async {
    List<GetAssessmentModel> assessments = [];
    ResponseEntity response =
    await QnaService.getSearchAssessment(10, pageNumber, teacherQuestionBankSearchController.text,userDetails);
    assessments = response.data['assessments']==null?[]:List<GetAssessmentModel>.from(
        response.data['assessments'].map((x) => GetAssessmentModel.fromJson(x)));
    totalAssessments=response.data['total_count'].toString();
    setState(() {
      myQuestion=false;
      assessmentList.addAll(assessments);
      pageNumber++;
      searchVal = teacherQuestionBankSearchController.text;
    });
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                    backgroundColor: Colors.white,
                    appBar: AppBar(
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
                              AppLocalizations.of(context)!.my_qns,
                              //"MY QUESTIONS",
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
                    endDrawer: const EndDrawerMenuTeacher(),
                    body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.023,
                              left: height * 0.023,
                              right: height * 0.023),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.search_lib,
                                    //"Search Library  (LOOQ)",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Checkbox(
                                        activeColor:
                                        const Color.fromRGBO(82, 165, 160, 1),
                                        fillColor:
                                        MaterialStateProperty.resolveWith<Color>(
                                                (states) {
                                              if (states.contains(MaterialState.selected)) {
                                                return const Color.fromRGBO(82, 165, 160, 1);
                                              }
                                              return const Color.fromRGBO(82, 165, 160, 1);
                                            }),
                                        value: agree,
                                        onChanged: (val) {
                                          setState(() {
                                            agree = val!;
                                            if (!agree) {
                                              setState(() {
                                                pageNumber = 1;
                                                // questionList = [];
                                                Navigator.pushNamed(
                                                  context,
                                                  '/teacherLooqQuestionBank',
                                                  arguments: teacherQuestionBankSearchController
                                                      .text,
                                                ).then((value) =>
                                                    teacherQuestionBankSearchController
                                                        .clear());
                                              });
                                            } else {
                                              getData('');
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.only_my_qns,
                                        //'Only My Questions',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(fontSize: webWidth * 0.03),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                AppLocalizations.of(context)!.lib_online_qn,
                                //"Library Of Online Questions",
                                style: TextStyle(
                                  color: const Color.fromRGBO(153, 153, 153, 1),
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              TextField(
                                controller: teacherQuestionBankSearchController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  hintStyle: TextStyle(
                                      color: const Color.fromRGBO(102, 102, 102, 0.3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * 0.016),
                                  hintText: "Maths, 10th, 2022, CBSE, Science",
                                  suffixIcon: Column(children: [
                                    Container(
                                        height: height * 0.073,
                                        width: webWidth * 0.13,
                                        decoration: const BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(8.0)),
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                        ),
                                        child: IconButton(
                                          iconSize: height * 0.04,
                                          color: const Color.fromRGBO(255, 255, 255, 1),
                                          onPressed: () {
                                            // questionList = [];
                                            pageNumber = 1;
                                            agree
                                                ? getData(
                                                teacherQuestionBankSearchController
                                                    .text)

                                                :searchGlobalQuestion();

                                          },
                                          icon: const Icon(Icons.search),
                                        )),
                                  ]),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(82, 165, 160, 1)),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                enabled: true,
                                onChanged: (value) {},
                              ),
                              SizedBox(height: height * 0.03),
                              Container(
                                alignment: Alignment.center,
                                child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:
                                        AppLocalizations.of(context)!.disclaimer_qn_prepare,
                                        //"DISCLAIMER:",
                                        style: TextStyle(
                                            fontSize: height * 0.015,
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontFamily: "Inter"),
                                      ),
                                      TextSpan(
                                        text:
                                        AppLocalizations.of(context)!.disclaimer_content,
                                        //"\t ITNEducation is not responsible for\n the content and accuracy of the Questions & Answer \n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t available in the Library.",
                                        style: TextStyle(
                                            fontSize: height * 0.015,
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromRGBO(153, 153, 153, 1),
                                            fontFamily: "Inter"),
                                      ),
                                    ])),
                              ),
                              SizedBox(height: height * 0.02),
                              const Divider(
                                thickness: 2,
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                AppLocalizations.of(context)!.my_qn_bank,
                                //"My Question Bank",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.02,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                AppLocalizations.of(context)!.tap_to_review,
                                //"Tap to Review/Edit/Delete",
                                style: TextStyle(
                                  color: const Color.fromRGBO(153, 153, 153, 1),
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              Column(children: [
                                // for (Question i in questionList)
                                //   QuestionPreview(
                                //     height: height,
                                //     width: webWidth,
                                //     question: i,
                                //   ),
                                SizedBox(height: height * 0.02),
                                MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        //getQuestionData();
                                      },
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!.view_more,
                                              //"View More",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color.fromRGBO(28, 78, 80, 1),
                                            ),
                                          ]),
                                    )),
                                SizedBox(height: height * 0.02),
                                Center(
                                  child: SizedBox(
                                    width: webWidth * 0.8,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                          minimumSize: const Size(280, 48),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(39),
                                          ),
                                          side: const BorderSide(
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                          )),
                                      onPressed: () {
                                        Provider.of<QuestionPrepareProviderFinal>(context,
                                            listen: false).reSetQuestionList();
                                        Navigator.pushNamed(context, '/teacherPrepareQnBank',arguments: [false,null]);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.prepare_new_qn,
                                            //'Prepare New Questions',
                                            style: const TextStyle(
                                                fontSize: webWidth * 0.06,
                                                fontFamily: "Inter",
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Icon(
                                            Icons.chevron_right,
                                            color: Color.fromRGBO(255, 255, 255, 1),
                                            size: webWidth * 0.06,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                              ]),
                            ],
                          )),
                    ),
                  )),
            ),
          );
        }
        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                appBar:
                AppBar(
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
                  toolbarHeight: height * 0.100,
                  centerTitle: true,
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          //AppLocalizations.of(context)!.my_qns,
                          "Assessments",
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
                // AppBar(
                //   leading: IconButton(
                //     icon: const Icon(
                //       Icons.chevron_left,
                //       size: 40.0,
                //       color: Colors.white,
                //     ),
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //   ),
                //   toolbarHeight: height * 0.100,
                //   centerTitle: true,
                //   title: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Text(
                //           AppLocalizations.of(context)!.my_qns,
                //           //"MY QUESTIONS",
                //           style: TextStyle(
                //             color: const Color.fromRGBO(255, 255, 255, 1),
                //             fontSize: height * 0.0225,
                //             fontFamily: "Inter",
                //             fontWeight: FontWeight.w400,
                //           ),
                //         ),
                //       ]),
                //   flexibleSpace: Container(
                //     decoration: const BoxDecoration(
                //         gradient: LinearGradient(
                //             end: Alignment.bottomCenter,
                //             begin: Alignment.topCenter,
                //             colors: [
                //               Color.fromRGBO(0, 106, 100, 1),
                //               Color.fromRGBO(82, 165, 160, 1),
                //             ])),
                //   ),
                // ),
                endDrawer: const EndDrawerMenuTeacher(),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.023,
                          left: height * 0.023,
                          right: height * 0.023),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            //AppLocalizations.of(context)!.lib_online_qn,
                            "Search",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.016,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: height * 0.005),
                          TextField(
                            onChanged: (t){
                              setState(() {
                                pageNumber=1;
                                assessmentList=[];
                              });
                            },
                            controller: teacherQuestionBankSearchController,
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
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      // borderRadius:
                                      // BorderRadius.all(Radius.circular(100)),
                                      color: Color.fromRGBO(153, 153, 153, 0.5),
                                    ),
                                    child: IconButton(
                                      iconSize: height * 0.025,
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      onPressed: () {
                                        onlyMyAssessments
                                            ? getData(
                                            teacherQuestionBankSearchController
                                                .text)
                                            :
                                        searchGlobalQuestion();
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
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.0),
                                          topRight: Radius.circular(25.0)),
                                    ),
                                    context: context,
                                    builder: (builder) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        height: height * 0.245,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.10,
                                              right: width * 0.10
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height:
                                                height * 0.026,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  //AppLocalizations.of(context)!.legend,
                                                  "Search Filters",
                                                  style: Theme
                                                      .of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge
                                                      ?.merge(TextStyle(
                                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: height *
                                                          0.02)),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                width * 0.052,
                                              ),
                                              SizedBox(
                                                height:

                                                height * 0.019,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    //AppLocalizations.of(context)!.lib_online_qn,
                                                    "Show only my questions",
                                                    style: TextStyle(
                                                      color: const Color.fromRGBO(102, 102, 102, 1),
                                                      fontSize: height * 0.02,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w400,
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
                                                    value: onlyMyAssessments,
                                                    borderRadius: 30.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        onlyMyAssessments =
                                                            val;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                MediaQuery
                                                    .of(context)
                                                    .copyWith()
                                                    .size
                                                    .height * 0.019,
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),

                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(39),
                                                    ),
                                                    side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                    )),
                                                onPressed: () {
                                                  setState(() {
                                                    pageNumber=1;
                                                    assessmentList=[];
                                                  });
                                                  onlyMyAssessments?
                                                  getData(teacherQuestionBankSearchController.text):
                                                  searchGlobalQuestion();
                                                  //Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "Apply",
                                                  style: TextStyle(
                                                      fontSize: height * 0.025,
                                                      fontFamily: "Inter",
                                                      color: const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    //AppLocalizations.of(context)!.lib_online_qn,
                                    "Filters",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontSize: height * 0.016,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    size: height * 0.014,
                                    color: const Color.fromRGBO(82, 165, 160, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            //AppLocalizations.of(context)!.my_qn_bank,
                            "Tap the Assessment to view ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: const Color.fromRGBO(153, 153, 153, 1),
                              fontSize: height * 0.016,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Container(
                            height: height * 0.55,
                            width: width * 0.9,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.07,
                                      width: width * 0.85,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Color.fromRGBO(82, 165, 160, 1),),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: height * 0.04,
                                            width: width * 0.16,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Color.fromRGBO(219, 35, 35, 1),),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: const Color.fromRGBO(219, 35, 35, 1),
                                                  size: MediaQuery
                                                      .of(context)
                                                      .copyWith()
                                                      .size
                                                      .height *
                                                      0.02,
                                                ),
                                                Text(
                                                  //AppLocalizations.of(context)!.active,
                                                  "  LIVE ",
                                                  style: Theme
                                                      .of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge
                                                      ?.merge(TextStyle(
                                                      color: const Color.fromRGBO(51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: MediaQuery
                                                          .of(context)
                                                          .copyWith()
                                                          .size
                                                          .height *
                                                          0.016)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: height * 0.04,
                                            width: width * 0.22,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
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
                                                Text(
                                                  //AppLocalizations.of(context)!.active,
                                                  "  Practice",
                                                  style: Theme
                                                      .of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge
                                                      ?.merge(TextStyle(
                                                      color: const Color.fromRGBO(51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: MediaQuery
                                                          .of(context)
                                                          .copyWith()
                                                          .size
                                                          .height *
                                                          0.016)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: height * 0.04,
                                            width: width * 0.14,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: const Color.fromRGBO(153, 153, 153, 1),
                                                  size: MediaQuery
                                                      .of(context)
                                                      .copyWith()
                                                      .size
                                                      .height *
                                                      0.02,
                                                ),
                                                Text(
                                                  //AppLocalizations.of(context)!.active,
                                                  "  Draft",
                                                  style: Theme
                                                      .of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge
                                                      ?.merge(TextStyle(
                                                      color: const Color.fromRGBO(51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: MediaQuery
                                                          .of(context)
                                                          .copyWith()
                                                          .size
                                                          .height *
                                                          0.016)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: height * 0.04,
                                            width: width * 0.22,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.circle_outlined,
                                                  color: Colors.black,
                                                  size: MediaQuery
                                                      .of(context)
                                                      .copyWith()
                                                      .size
                                                      .height *
                                                      0.02,
                                                ),
                                                Text(
                                                  //AppLocalizations.of(context)!.active,
                                                  "  Inactive",
                                                  style: Theme
                                                      .of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge
                                                      ?.merge(TextStyle(
                                                      color: const Color.fromRGBO(51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: MediaQuery
                                                          .of(context)
                                                          .copyWith()
                                                          .size
                                                          .height *
                                                          0.016)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  for (int i=assessmentStart;i<assessmentList.length;i++)
                                  AssessmentCard(height: height, width: width,assessment: assessmentList[i],globalAssessment: onlyMyAssessments,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Showing ${assessmentStart + 1} to ${assessmentStart+10 <assessmentList.length?assessmentStart+10:assessmentList.length} of $totalAssessments',
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
                                                onTap: (){
                                                  if(assessmentList.length>11){
                                                    setState(() {
                                                      pageNumber--;
                                                      assessmentStart=assessmentStart-10;
                                                      assessmentList.removeRange(assessmentList.length-10, assessmentList.length);
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
                                                      '${assessmentStart==0?1:((assessmentStart/10)+1).toInt()}',
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
                                                    assessmentStart=assessmentStart+10;
                                                  });
                                                  onlyMyAssessments?
                                                  getData(teacherQuestionBankSearchController.text)
                                                      :searchGlobalQuestion();
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

                          // Text(
                          //   AppLocalizations.of(context)!.my_qn_bank,
                          //   //"My Question Bank",
                          //   textAlign: TextAlign.left,
                          //   style: TextStyle(
                          //     color: const Color.fromRGBO(82, 165, 160, 1),
                          //     fontSize: height * 0.02,
                          //     fontFamily: "Inter",
                          //     fontWeight: FontWeight.w700,
                          //   ),
                          // ),
                          // SizedBox(height: height * 0.01),
                          // Text(
                          //   AppLocalizations.of(context)!.tap_to_review,
                          //   //"Tap to Review/Edit/Delete",
                          //   style: TextStyle(
                          //     color: const Color.fromRGBO(153, 153, 153, 1),
                          //     fontSize: height * 0.015,
                          //     fontFamily: "Inter",
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                          // SizedBox(height: height * 0.01),
                          Column(children: [
                            SizedBox(height: height * 0.02),
                            Center(
                              child: SizedBox(
                                width: width * 0.8,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Colors.white,
                                      minimumSize: const Size(280, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(39),
                                      ),
                                      side: const BorderSide(
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      )),
                                  onPressed: () {
                                    Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                    CreateAssessmentModel assess=CreateAssessmentModel(questions: []);
                                    Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(assess);
                                    Provider.of<EditAssessmentProvider>(context, listen: false).resetAssessment();
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
                                                      child: SingleChildScrollView(
                                                        scrollDirection: Axis.vertical,
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
                                                                'Assessment Details',
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

                                                                ),
                                                                  validator: (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return AppLocalizations
                                                                          .of(
                                                                          context)!
                                                                          .enter_subject;
                                                                      //'Enter Subject';
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
                                                                bool valid = formKey.currentState!.validate();
                                                                if (valid) {
                                                                  Provider.of<CreateAssessmentProvider>(context, listen: false).resetAssessment();
                                                                  CreateAssessmentModel assessment=CreateAssessmentModel(questions: []);
                                                                  assessment.subject=subjectController.text;
                                                                  assessment.topic=topicController.text;
                                                                  assessment.createAssessmentModelClass=degreeController.text;
                                                                  assessment.subTopic=semesterController.text;
                                                                  Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                                                  Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(assessment);
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      '/createNewAssessment',
                                                                  );
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
                                              ),
                                            );
                                          });
                                  },
                                  child: Text(
                                    //AppLocalizations.of(context)!.prepare_new_qn,
                                    'Create New Assessment',
                                    style: TextStyle(
                                        fontSize: height * 0.025,
                                        fontFamily: "Inter",
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                          ]),
                        ],
                      )),
                ),
              ));
        }
      },
    );
  }
}

class AssessmentCard extends StatefulWidget {
  const AssessmentCard({
    super.key,
    required this.height,
    required this.width,
    required this.assessment,
    required this.globalAssessment
  });

  final double height;
  final double width;
  final GetAssessmentModel assessment;
  final bool globalAssessment;

  @override
  State<AssessmentCard> createState() => _AssessmentCardState();
}

class _AssessmentCardState extends State<AssessmentCard> {
  String datetime='';

  @override
  void initState() {
    DateTime tsDate = DateTime.fromMicrosecondsSinceEpoch(widget.assessment.assessmentStartdate!);
    datetime = "${tsDate.day}/${tsDate.month}/${tsDate.year}";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Provider.of<CreateAssessmentProvider>(context, listen: false).resetAssessment();
          Provider.of<EditAssessmentProvider>(context, listen: false).resetAssessment();
          Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
          Provider.of<EditAssessmentProvider>(context, listen: false).updateAssessment(widget.assessment);
          if(!widget.globalAssessment){
            Navigator.pushNamed(context, '/cloneAssessmentLanding');
          }
          else if(widget.assessment.assessmentStatus=="active" && widget.assessment.assessmentType=='test'){
            Navigator.pushNamed(context, '/assessmentTest');
          }
          else if(widget.assessment.assessmentStatus=="inprogress"){
            Navigator.pushNamed(context, '/draftAssessmentLanding');
          }
          else if(widget.assessment.assessmentStatus=="inactive"){
            Navigator.pushNamed(context, '/inactiveAssessmentLanding');
          }
          else{
            Navigator.pushNamed(context, '/practiceAssessmentLanding');
          }
        },
        child: Container(
          height: widget.height * 0.15,
          width: widget.width * 0.888,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
          padding:
          EdgeInsets.only(left: widget.width * 0.02, right: widget.width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width:widget.width * 0.6,
                child: Text(
                  "${widget.assessment.subject!}  | ${widget.assessment.topic!}",
                  style: TextStyle(
                    color: const Color.fromRGBO(28, 78, 80, 1),
                    fontSize: widget.height * 0.0175,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              (widget.assessment.assessmentStatus=="active" && widget.assessment.assessmentType=='test')?
              Container(
                height: widget.height * 0.04,
                width: widget.width * 0.16,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(219, 35, 35, 1),),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.circle,
                      color: const Color.fromRGBO(219, 35, 35, 1),
                      size: MediaQuery
                          .of(context)
                          .copyWith()
                          .size
                          .height *
                          0.02,
                    ),
                    Text(
                      //AppLocalizations.of(context)!.active,
                      "  LIVE ",
                      style: Theme
                          .of(context)
                          .primaryTextTheme
                          .bodyLarge
                          ?.merge(TextStyle(
                          color: const Color.fromRGBO(51, 51, 51, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery
                              .of(context)
                              .copyWith()
                              .size
                              .height *
                              0.016)),
                    ),
                  ],
                ),
              ):
              widget.assessment.assessmentStatus=="inactive"?
              Icon(
                Icons.circle_outlined,
                color: Colors.black,
                size: MediaQuery
                    .of(context)
                    .copyWith()
                    .size
                    .height *
                    0.02,
              ):
              widget.assessment.assessmentStatus=="inprogress"?
              Icon(
                Icons.circle,
                color: const Color.fromRGBO(153, 153, 153, 1),
                size: MediaQuery
                    .of(context)
                    .copyWith()
                    .size
                    .height *
                    0.02,
              ):
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
              // Icon(
              //   Icons.circle_rounded,
              //   color: "active" == 'inprogress'
              //       ? const Color.fromRGBO(255, 166, 0, 1)
              //       : "active" == 'practice'
              //       ? const Color.fromRGBO(42, 36, 186, 1)
              //       : "active" == 'active' && "test" == 'test'
              //       ? const Color.fromRGBO(60, 176, 0, 1)
              //       : "active" == 'inactive' && "test" == 'test'
              //       ? const Color.fromRGBO(136, 136, 136, 1)
              //       : const Color.fromRGBO(136, 136, 136, 1),
              // )
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(left: widget.width * 0.02, right: widget.width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    widget.assessment.getAssessmentModelClass!,
                    style: TextStyle(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: widget.height * 0.0175,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    " | ${widget.assessment.subTopic ?? ''}",
                    style: TextStyle(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: widget.height * 0.0175,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: widget.width * 0.02, right: widget.width * 0.02),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.assessment_id_caps,
                      style: TextStyle(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontSize: widget.height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(widget.assessment.assessmentCode!,
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: widget.height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],),
                Text(
                  datetime,
                  style: TextStyle(
                    color: const Color.fromRGBO(28, 78, 80, 1),
                    fontSize: widget.height * 0.015,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),),
                                  ],
                                ),
                              ),
      ),
    );
  }
}
