import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/Teacher/response_entity.dart';
import 'package:qna_test/Pages/teacher_create_assessment.dart';
import 'package:qna_test/pages/teacher_assessment_searched.dart';
import 'package:qna_test/pages/teacher_active_assessment.dart';
import 'package:qna_test/pages/teacher_inactive_assessment.dart';
import 'package:qna_test/pages/teacher_recent_assessment.dart';
import '../Components/end_drawer_menu_teacher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../Entity/Teacher/get_assessment_model.dart';
import '../Entity/Teacher/question_entity.dart' as Questions;
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/create_assessment_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Providers/edit_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class TeacherAssessmentLanding extends StatefulWidget {
  const TeacherAssessmentLanding({
    Key? key,
    required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

  @override
  TeacherAssessmentLandingState createState() =>
      TeacherAssessmentLandingState();
}

class TeacherAssessmentLandingState extends State<TeacherAssessmentLanding> {
  bool agree = false;
  TextEditingController subjectController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController subTopicController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  CreateAssessmentModel assessment=CreateAssessmentModel(questions: [],removeQuestions: [],addQuestion: []);
  final PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  List<GetAssessmentModel> allAssessment =[];
  List<GetAssessmentModel> assessments=[];
  bool loading=true;
  ScrollController scrollController =ScrollController();
  int pageLimit =1;



  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((_) {
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
              height: MediaQuery.of(context).copyWith().size.height * 0.245,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).copyWith().size.width * 0.10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.026,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).copyWith().size.width *
                              0.055),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            size: MediaQuery.of(context).copyWith().size.width *
                                0.07,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.legend,
                        //"Legend",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyLarge
                            ?.merge(TextStyle(
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height *
                                    0.02)),
                      ),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).copyWith().size.width * 0.052,
                    ),
                    SizedBox(
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.019,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          color: const Color.fromRGBO(60, 176, 0, 1),
                          size: MediaQuery.of(context).copyWith().size.height *
                              0.02,
                        ),
                        Text(
                          AppLocalizations.of(context)!.active,
                          //"  Active",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.016)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.18,
                        ),
                        Icon(
                          Icons.circle,
                          color: const Color.fromRGBO(255, 166, 0, 1),
                          size: MediaQuery.of(context).copyWith().size.height *
                              0.02,
                        ),
                        Text(
                          AppLocalizations.of(context)!.in_progress,
                          //"  In progress",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.016)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.019,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          color: const Color.fromRGBO(136, 136, 136, 1),
                          size: MediaQuery.of(context).copyWith().size.height *
                              0.02,
                        ),
                        Text(
                          AppLocalizations.of(context)!.in_active,
                          //"  Inactive",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.016)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.16,
                        ),
                        Icon(
                          Icons.circle,
                          color: const Color.fromRGBO(42, 36, 186, 1),
                          size: MediaQuery.of(context).copyWith().size.height *
                              0.02,
                        ),
                        Text(
                          AppLocalizations.of(context)!.practice,
                          //"  Practice",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.016)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
    getData();
  }

  getData()async{
    ResponseEntity response =await QnaService.getAllAssessment(5,pageLimit);
    allAssessment=List<GetAssessmentModel>.from(response.data.map((x) => GetAssessmentModel.fromJson(x)));
    setState(() {
      assessments.addAll(allAssessment);
      loading = false;
      pageLimit++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController teacherQuestionBankSearchController =
        TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      endDrawer: EndDrawerMenuTeacher(setLocale: widget.setLocale),
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
        title:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            AppLocalizations.of(context)!.my_assessments,
            //"MY ASSESSMENTS",
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
                      AppLocalizations.of(context)!.search,
                      //"Search",
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
                          activeColor: const Color.fromRGBO(82, 165, 160, 1),
                          fillColor: MaterialStateProperty.resolveWith<Color>(
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
                              if (agree) {}
                            });
                          },
                        ),
                        Text(
                          AppLocalizations.of(context)!.only_my_assessments,
                          //"Only My Assessments",
                          style: TextStyle(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  AppLocalizations.of(context)!.lib_of_assessments,
                  //"Library of Assessments",
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
                    hintText:
                    AppLocalizations.of(context)!.sub_hint_text,
                    //"Maths, 10th, 2022, CBSE, Science",
                    suffixIcon: Column(children: [
                      Container(
                          height: height * 0.073,
                          width: width * 0.13,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Color.fromRGBO(82, 165, 160, 1),
                          ),
                          child: IconButton(
                            iconSize: height * 0.04,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: TeacherAssessmentSearched(
                                      setLocale: widget.setLocale),
                                ),
                              );
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
                SizedBox(height: height * 0.04),
                RichText(
                    textAlign: TextAlign.center,
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
                        AppLocalizations.of(context)!.disclaimer_text_qn_prepare,
                        //"\t ITNEducation is not responsible for the content and accuracy of the Questions & Answer available in the Library.",
                        style: TextStyle(
                            fontSize: height * 0.015,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(153, 153, 153, 1),
                            fontFamily: "Inter"),
                      ),
                    ])),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.tests,
                  //"Tests",
                  style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
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
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.35,
                  child: ListView.builder(
                    itemCount: assessments.length,
                    itemBuilder: (context,index) =>
                      Column(
                        children: [
                          CardInfo(
                              height: height,
                              width: width,
                              status: 'Active',
                              setLocale: widget.setLocale,
                          assessment: assessments[index],),
                    SizedBox(
                        height: height * 0.02,
                      ),
                        ],
                      ),
                   ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(right: width * 0.05),
                      child: const Divider(),
                    )),
                    GestureDetector(
                      onTap: (){
                        getData();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.view_more,
                        //"View More",
                        style: TextStyle(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right)
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: SizedBox(
                    width: width * 0.888,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                      onPressed: () {
                        assessment=Provider.of<CreateAssessmentProvider>(context, listen: false).getAssessment;
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(17))),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    height: height * 0.7,
                                    width: width * 0.88,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black38, width: 1),
                                      borderRadius: BorderRadius.circular(17),
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
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                AppLocalizations.of(context)!.assessment_title,
                                                //'Assessment Title',
                                                style: TextStyle(
                                                    fontSize: height * 0.02,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                AppLocalizations.of(context)!.sub_class_others,
                                                // 'Subject, Class and Other details',
                                                style: TextStyle(
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.05,
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: TextFormField(
                                                controller: subjectController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  label: SizedBox(
                                                    width: width * 0.18,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(context)!.sub_caps,
                                                          //'SUBJECT',
                                                          style: TextStyle(
                                                              fontSize: height *
                                                                  0.015,
                                                              fontFamily:
                                                                  "Inter",
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  51,
                                                                  51,
                                                                  51,
                                                                  1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          '\t*',
                                                          style: TextStyle(
                                                              fontSize: height *
                                                                  0.015,
                                                              fontFamily:
                                                                  "Inter",
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  labelStyle: TextStyle(
                                                      color:
                                                          const Color.fromRGBO(
                                                              51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: height * 0.015),
                                                  hintStyle: TextStyle(
                                                      color: const Color
                                                              .fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                  hintText: AppLocalizations.of(context)!.sub_hint,
                                                  //'Type Subject Here',
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocalizations.of(context)!.enter_subject;
                                                      //'Enter Subject';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (value) {
                                                  formKey.currentState!.validate();
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: TextFormField(
                                                controller: classController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  label: SizedBox(
                                                    width: width * 0.15,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(context)!.class_caps,
                                                          // 'CLASS',
                                                          style: TextStyle(
                                                              fontSize: height *
                                                                  0.015,
                                                              fontFamily:
                                                                  "Inter",
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  51,
                                                                  51,
                                                                  51,
                                                                  1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          '\t*',
                                                          style: TextStyle(
                                                              fontSize: height *
                                                                  0.015,
                                                              fontFamily:
                                                                  "Inter",
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  labelStyle: TextStyle(
                                                      color:
                                                          const Color.fromRGBO(
                                                              51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: height * 0.015),
                                                  hintStyle: TextStyle(
                                                      color: const Color
                                                              .fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                  hintText:
                                                  AppLocalizations.of(context)!.type_here,
                                                  //'Type Here',
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocalizations.of(context)!.enter_class;
                                                      //'Enter Class';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (value) {
                                                  formKey.currentState!.validate();
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: TextFormField(
                                                controller: topicController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  labelText: AppLocalizations.of(context)!.topic_optional,
                                                  //'TOPIC (Optional)',
                                                  labelStyle: TextStyle(
                                                      color:
                                                          const Color.fromRGBO(
                                                              51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: height * 0.015),
                                                  hintStyle: TextStyle(
                                                      color: const Color
                                                              .fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                  hintText: AppLocalizations.of(context)!.topic_hint,
                                                  //'Type Topic Here',
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: TextFormField(
                                                controller: subTopicController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  labelText:
                                                  AppLocalizations.of(context)!.sub_topic_optional,
                                                  // 'SUB TOPIC (Optional)',
                                                  labelStyle: TextStyle(
                                                      color:
                                                          const Color.fromRGBO(
                                                              51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: height * 0.015),
                                                  hintStyle: TextStyle(
                                                      color: const Color
                                                              .fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                  hintText:
                                                  AppLocalizations.of(context)!.sub_topic_hint,
                                                  //'Type Sub Topic Here',
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            ElevatedButton(
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
                                              ),
                                              onPressed: () async {
                                                bool valid = formKey
                                                    .currentState!
                                                    .validate();
                                                if (valid) {
                                                  SharedPreferences loginData=await SharedPreferences.getInstance();
                                                  Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
                                                  Provider.of<CreateAssessmentProvider>(context, listen: false).resetAssessment();
                                                  assessment.topic=topicController.text;
                                                  assessment.subTopic=subTopicController.text;
                                                  assessment.subject=subjectController.text;
                                                  assessment.createAssessmentModelClass=classController.text;
                                                  assessment.questions=[];
                                                  assessment.userId=loginData?.getInt('userId');
                                                  Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(assessment);
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child:
                                                          TeacherCreateAssessment(
                                                              setLocale: widget
                                                                  .setLocale),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!.save_continue,
                                                //'Save & Continue',
                                                style: TextStyle(
                                                    fontSize: height * 0.025,
                                                    fontFamily: "Inter",
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    fontWeight:
                                                        FontWeight.w600),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.prepare_new_assessment,
                            //'Prepare New Assessment',
                            style: TextStyle(
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontWeight: FontWeight.w600),
                          ),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            )),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  const CardInfo(
      {Key? key,
      required this.height,
      required this.width,
      required this.status,
      required this.setLocale,
      required this.assessment})
      : super(key: key);

  final double height;
  final double width;
  final String status;
  final void Function(Locale locale) setLocale;
  final GetAssessmentModel assessment;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          Provider.of<EditAssessmentProvider>(context, listen: false).updateAssessment(assessment);
          print(assessment.toString());
          if (assessment.assessmentStatus == 'inprogress') {
            CreateAssessmentModel editAssessment =CreateAssessmentModel(questions: [],removeQuestions: []);
            editAssessment.assessmentId=assessment.assessmentId;
            editAssessment.assessmentType=assessment.assessmentType;
            editAssessment.assessmentStatus=assessment.assessmentStatus;
            editAssessment.subject=assessment.subject;
            editAssessment.createAssessmentModelClass=assessment.getAssessmentModelClass;
            assessment.topic==null?0:editAssessment.topic=assessment.topic;
            assessment.subTopic==null?0:editAssessment.subTopic=assessment.subTopic;
            assessment.totalScore==null?0:editAssessment.totalScore=assessment.totalScore;
            assessment.questions!.isEmpty?0:editAssessment.totalQuestions=assessment.questions!.length;
            assessment.assessmentDuration==null?'':editAssessment.totalScore=assessment.totalScore;
            if(assessment.questions!.isEmpty){

            }
            else{
              for(int i =0;i<assessment.questions!.length;i++){
                Question question=Question();
                question.questionMarks=assessment.questions![i].questionMark;
                question.questionId=assessment.questions![i].questionId;
                editAssessment.questions?.add(question);
                Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(assessment.questions![i]);
              }
            }

            Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(editAssessment);
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TeacherRecentAssessment(setLocale: setLocale,finalAssessment: editAssessment,),
              ),
            );
          }
          else if (assessment.assessmentStatus == 'active') {
            SharedPreferences loginData = await SharedPreferences.getInstance();
            CreateAssessmentModel editAssessment =CreateAssessmentModel(questions: [],removeQuestions: [],addQuestion: []);
            editAssessment.userId=loginData.getInt('userId');
            editAssessment.subject=assessment.subject;
            editAssessment.assessmentType=assessment.assessmentType??'Not Mentioned';
            editAssessment.createAssessmentModelClass=assessment.getAssessmentModelClass;
            assessment.topic==null?0:editAssessment.topic=assessment.topic;
            assessment.subTopic==null?0:editAssessment.subTopic=assessment.subTopic;
            assessment.totalScore==null?0:editAssessment.totalScore=assessment.totalScore;
            assessment.questions!.isEmpty?0:editAssessment.totalQuestions=assessment.questions!.length;
            assessment.assessmentDuration==null?'':editAssessment.totalScore=assessment.totalScore;
            if(assessment.questions!.isEmpty){

            }
            else{
              for(int i =0;i<assessment.questions!.length;i++){
                Questions.Question question=Questions.Question();
                question=assessment.questions![i];
                editAssessment.addQuestion?.add(question);
                Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(assessment.questions![i]);
              }
            }

            Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(editAssessment);
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TeacherActiveAssessment(setLocale: setLocale,assessment: assessment,),
              ),
            );
          } else {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TeacherInactiveAssessment(setLocale: setLocale),
              ),
            );
          }
        },
        child: Container(
          height: height * 0.1087,
          width: width * 0.888,
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
                    EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          assessment.subject!,
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          " | ${assessment.getAssessmentModelClass}",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.circle_rounded,
                      color: assessment.assessmentStatus == 'inprogress'
                          ? const Color.fromRGBO(255, 166, 0, 1)
                          : assessment.assessmentStatus == 'active'
                              ? const Color.fromRGBO(60, 176, 0, 1)
                              : const Color.fromRGBO(136, 136, 136, 1),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.assessment_id_caps,
                      //"Assessment ID: ",
                      style: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      " ${assessment.assessmentCode}",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.institute_test_id,
                          // "Institute Test ID: ",
                          style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          " ABC903857928",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "10/1/2023",
                      style: TextStyle(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
