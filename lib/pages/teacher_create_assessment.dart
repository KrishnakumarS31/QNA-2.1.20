import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_prepare_qnBank.dart';
import 'package:qna_test/pages/teacher_assessment_question_bank.dart';
import 'package:qna_test/pages/teacher_prepare_ques_for_assessment.dart';
import 'package:qna_test/pages/teacher_published_assessment.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../EntityModel/login_entity.dart';
import '../Providers/create_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/qna_service.dart';
class TeacherCreateAssessment extends StatefulWidget {
  const TeacherCreateAssessment({
    Key? key,
    required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

  @override
  TeacherCreateAssessmentState createState() => TeacherCreateAssessmentState();
}

class TeacherCreateAssessmentState extends State<TeacherCreateAssessment> {
  bool agree = false;
  bool? assessment = true;
  CreateAssessmentModel assessmentVal=CreateAssessmentModel(questions: []);
  TextEditingController subjectController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController subTopicController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  //Provider.of<QuestionPrepareProviderFinal>(context, listen: false).getAllQuestion;
  @override
  void initState() {
    super.initState();
    assessmentVal=Provider.of<CreateAssessmentProvider>(context, listen: false).getAssessment;
    subjectController.text=assessmentVal.subject!;
    classController.text=assessmentVal.createAssessmentModelClass!;
    topicController.text=assessmentVal.topic!;
    subTopicController.text=assessmentVal.subTopic!;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController TeacherCreateAssessmentSearchController =
        TextEditingController();
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
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
            "PREPARE",
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: height * 0.0225,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "ASSESSMENTS",
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
                Container(
                  height: height * 0.108,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color.fromRGBO(82, 165, 160, 0.07),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.03, left: width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${assessmentVal.subject}',
                                  style: TextStyle(
                                      fontSize: height * 0.017,
                                      fontFamily: "Inter",
                                      color:
                                          const Color.fromRGBO(28, 78, 80, 1),
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '  |  ${assessmentVal.createAssessmentModelClass}',
                                  style: TextStyle(
                                      fontSize: height * 0.015,
                                      fontFamily: "Inter",
                                      color:
                                          const Color.fromRGBO(28, 78, 80, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
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
                                                          assessmentVal.topic=topicController.text;
                                                          assessmentVal.subTopic=subTopicController.text;
                                                          assessmentVal.subject=subjectController.text;
                                                          assessmentVal.createAssessmentModelClass=classController.text;
                                                          assessmentVal.userId=loginData?.getInt('userId');
                                                          Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(assessmentVal);
                                                          Navigator.of(context).pop();
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
                                children: [
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontSize: height * 0.017,
                                        fontFamily: "Inter",
                                        color:
                                            const Color.fromRGBO(28, 78, 80, 1),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  const Icon(
                                    Icons.edit_outlined,
                                    color: Color.fromRGBO(28, 78, 80, 1),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Topic: ${assessmentVal.topic}',
                          style: TextStyle(
                              fontSize: height * 0.015,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontWeight: FontWeight.w400),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sub Topic: ${assessmentVal.subTopic}',
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '14/1/2023',
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Search Question",
                  style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Library Of My Questions",
                      style: TextStyle(
                        color: const Color.fromRGBO(153, 153, 153, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                TextField(
                  controller: TeacherCreateAssessmentSearchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 0.3),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: height * 0.016),
                    hintText: "Maths, 10th, 2022",
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
                                  child: TeacherAssessmentQuestionBank(
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
                SizedBox(height: height * 0.08),
                Container(
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset("assets/images/create_assessment.png"),
                      ),
                      SizedBox(height: height * 0.03),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Search from my question bank",
                          style: TextStyle(
                              fontSize: height * 0.015,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(153, 153, 153, 1),
                              fontFamily: "Inter"),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.08),
                Center(
                  child: SizedBox(
                    width: width * 0.888,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Color.fromRGBO(82, 165, 160, 1),
                        ),
                        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                      onPressed: () {

                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: TeacherPrepareQuesForAssessment(
                                assessment: true, setLocale: widget.setLocale),
                          ),
                        );
                      },
                      child: Text(
                        'Create New Question',
                        style: TextStyle(
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Center(
                  child: SizedBox(
                    width: width * 0.888,
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
                      onPressed: () async {
                        assessmentVal.assessmentStatus="inprogress";
                        assessmentVal.assessmentType="practice";
                        print(assessmentVal.toString());
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                    color: Color.fromRGBO(48, 145, 139, 1),
                                  ));
                            });
                        LoginModel statusCode = await QnaService.createAssessmentTeacherService(assessmentVal);
                        Navigator.of(context).pop();
                        if (statusCode.code == 200) {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: TeacherPublishedAssessment(
                                  setLocale: widget.setLocale),
                            ),
                          );
                        }
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: TeacherPublishedAssessment(
                                setLocale: widget.setLocale),
                          ),
                        );
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
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
      required this.status})
      : super(key: key);

  final double height;
  final double width;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {},
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
