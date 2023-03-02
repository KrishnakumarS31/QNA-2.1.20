import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_create_assessment.dart';
import 'package:qna_test/pages/teacher_assessment_searched.dart';
import 'package:qna_test/pages/teacher_active_assessment.dart';
import 'package:qna_test/pages/teacher_inactive_assessment.dart';
import 'package:qna_test/pages/teacher_recent_assessment.dart';
import '../Components/end_drawer_menu_teacher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/create_assessment_provider.dart';import 'package:shared_preferences/shared_preferences.dart';
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
  CreateAssessmentModel assessment=CreateAssessmentModel(questions: []);
  final PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

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
                        "Legend",
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
                          "  Active",
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
                          "  In progress",
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
                          "  Inactive",
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
                          "  Practice",
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
            "MY ASSESSMENTS",
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
                      "Search",
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
                          "Only My Assessments",
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
                  "Library of Assessments",
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
                        text: "DISCLAIMER:",
                        style: TextStyle(
                            fontSize: height * 0.015,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: "Inter"),
                      ),
                      TextSpan(
                        text:
                            "\t ITNEducation is not responsible for the content and accuracy of the Questions & Answer available in the Library.",
                        style: TextStyle(
                            fontSize: height * 0.015,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(153, 153, 153, 1),
                            fontFamily: "Inter"),
                      ),
                    ])),
                SizedBox(height: height * 0.02),
                Text(
                  "Tests",
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
                  "Tap to Review/Edit/Delete",
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
                CardInfo(
                    height: height,
                    width: width,
                    status: 'In progress',
                    setLocale: widget.setLocale),
                SizedBox(
                  height: height * 0.02,
                ),
                CardInfo(
                    height: height,
                    width: width,
                    status: 'Active',
                    setLocale: widget.setLocale),
                SizedBox(
                  height: height * 0.02,
                ),
                CardInfo(
                    height: height,
                    width: width,
                    status: 'Inactive',
                    setLocale: widget.setLocale),
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
                    Text(
                      "View More",
                      style: TextStyle(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
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
                                                'Assessment Title',
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
                                                'Subject, Class and Other details',
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
                                                          'SUBJECT',
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
                                                  hintText: 'Type Subject Here',
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
                                                    return 'Enter Subject';
                                                  } else {
                                                    return null;
                                                  }
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
                                                          'CLASS',
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
                                                  hintText: 'Type Here',
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
                                                    return 'Enter Class';
                                                  } else {
                                                    return null;
                                                  }
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
                                                  labelText: 'TOPIC (Optional)',
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
                                                  hintText: 'Type Topic Here',
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
                                                      'SUB TOPIC (Optional)',
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
                                                      'Type Sub Topic Here',
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
                                                  assessment.topic=topicController.text;
                                                  assessment.subTopic=subTopicController.text;
                                                  assessment.subject=subjectController.text;
                                                  assessment.createAssessmentModelClass=classController.text;
                                                  assessment.userId=loginData?.getInt('userId');
                                                  List<Question> quesList=[];
                                                  Question ques=Question();
                                                  ques.questionId=6;
                                                  ques.questionMarks=10;
                                                  quesList.add(ques);
                                                  ques.questionId=7;
                                                  ques.questionMarks=10;
                                                  quesList.add(ques);
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
                                                'Save & Continue',
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
                            'Prepare New Assessment',
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
      required this.setLocale})
      : super(key: key);

  final double height;
  final double width;
  final String status;
  final void Function(Locale locale) setLocale;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (status == 'In progress') {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TeacherRecentAssessment(setLocale: setLocale),
              ),
            );
          } else if (status == 'Active') {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TeacherActiveAssessment(setLocale: setLocale),
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
                          "Maths ",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          " | Class IX",
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
                      color: status == 'In progress'
                          ? const Color.fromRGBO(255, 166, 0, 1)
                          : status == 'Active'
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
                      "Assessment ID: ",
                      style: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      " 0123456789",
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
                          "Institute Test ID: ",
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
