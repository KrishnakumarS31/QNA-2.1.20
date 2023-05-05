import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/question_entity.dart' as Question;
import '../Entity/Teacher/response_entity.dart';

//import '../Entity/Teacher/result_entity.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/create_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherSelectedQuestionAssessment extends StatefulWidget {
  const TeacherSelectedQuestionAssessment(
      {Key? key, this.questions,required this.assessmentType})
      : super(key: key);

  final List<Question.Question>? questions;
  final String assessmentType;

  @override
  TeacherSelectedQuestionAssessmentState createState() =>
      TeacherSelectedQuestionAssessmentState();
}

class TeacherSelectedQuestionAssessmentState
    extends State<TeacherSelectedQuestionAssessment> {
  bool additionalDetails = true;
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  List<Question.Question> questionList = [];
  CreateAssessmentModel assessment = CreateAssessmentModel(questions: []);
  int totalQues = 0;
  int totalMark = 0;
  TextEditingController subjectController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController subTopicController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showAdditionalDetails() {
    setState(() {
      !additionalDetails;
    });
  }

  showAlertDialog(BuildContext context, double height) {
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
        'No',
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
        'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        //Provider.of<QuestionsForAssessmentSettingsPublishedProvider>(context, listen: false).addQuestion(widget.questions! as QuestionEntityForAssessmentSettingsPublished);
        Navigator.pushNamed(context, '/teacherAssessmentSettingPublish',arguments: widget.assessmentType);
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.rightToLeft,
        //     child: TeacherAssessmentSettingPublish(),
        //   ),
        // );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.error,
            color: const Color.fromRGBO(238, 71, 0, 1),
            size: height * 0.05,
          ),
          Text(
            'Marks not filled',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        'Do you want to still continue?',
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

  @override
  void initState() {
    getData();
    subjectController.text = assessment.subject!;
    classController.text = assessment.createAssessmentModelClass!;
    topicController.text = assessment.topic!;
    subTopicController.text = assessment.subTopic!;
    super.initState();
  }

  getData() {
      questionList.addAll(
          Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
              .getAllQuestion);
      assessment = Provider.of<CreateAssessmentProvider>(context, listen: false)
          .getAssessment;
      totalQues = questionList.length;
      for (int i = 0; i < questionList.length; i++) {
        totalMark = totalMark + questionList[i].questionMark!;
      }

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          endDrawer: const EndDrawerMenuTeacher(),
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
                    "SELECTED QUESTIONS",
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: height * 0.0225,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "FOR ASSESSMENT",
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
          body: Padding(
              padding: EdgeInsets.only(
                  top: height * 0.023,
                  left: height * 0.023,
                  right: height * 0.023),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                                    '${assessment.subject}',
                                    style: TextStyle(
                                        fontSize: height * 0.017,
                                        fontFamily: "Inter",
                                        color:
                                            const Color.fromRGBO(28, 78, 80, 1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '  |  ${assessment.createAssessmentModelClass}',
                                    style: TextStyle(
                                        fontSize: height * 0.015,
                                        fontFamily: "Inter",
                                        color:
                                            const Color.fromRGBO(28, 78, 80, 1),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                onTap: () {
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
                                              height: height * 0.7,
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
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .assessment_title,
                                                          //'Assessment Title',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  height * 0.02,
                                                              fontFamily:
                                                                  "Inter",
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  82,
                                                                  165,
                                                                  160,
                                                                  1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .sub_class_others,
                                                          // 'Subject, Class and Other details',
                                                          style: TextStyle(
                                                              fontSize: height *
                                                                  0.015,
                                                              fontFamily:
                                                                  "Inter",
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.05,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: TextFormField(
                                                          controller:
                                                              subjectController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            label: SizedBox(
                                                              width:
                                                                  width * 0.18,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .sub_caps,
                                                                    //'SUBJECT',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            height *
                                                                                0.015,
                                                                        fontFamily:
                                                                            "Inter",
                                                                        color: const Color.fromRGBO(
                                                                            51,
                                                                            51,
                                                                            51,
                                                                            1),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  Text(
                                                                    '\t*',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            height *
                                                                                0.015,
                                                                        fontFamily:
                                                                            "Inter",
                                                                        color: Colors
                                                                            .red,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            labelStyle: TextStyle(
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    51,
                                                                    51,
                                                                    51,
                                                                    1),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    height *
                                                                        0.015),
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
                                                                        0.02),
                                                            hintText:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .sub_hint,
                                                            //'Type Subject Here',
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                          ),
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return AppLocalizations
                                                                      .of(context)!
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
                                                      SizedBox(
                                                        height: height * 0.02,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: TextFormField(
                                                          controller:
                                                              classController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            label: SizedBox(
                                                              width:
                                                                  width * 0.15,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .class_caps,
                                                                    // 'CLASS',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            height *
                                                                                0.015,
                                                                        fontFamily:
                                                                            "Inter",
                                                                        color: const Color.fromRGBO(
                                                                            51,
                                                                            51,
                                                                            51,
                                                                            1),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  Text(
                                                                    '\t*',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            height *
                                                                                0.015,
                                                                        fontFamily:
                                                                            "Inter",
                                                                        color: Colors
                                                                            .red,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            labelStyle: TextStyle(
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    51,
                                                                    51,
                                                                    51,
                                                                    1),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    height *
                                                                        0.015),
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
                                                                        0.02),
                                                            hintText:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .type_here,
                                                            //'Type Here',
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                          ),
                                                          onChanged: (value) {
                                                            formKey
                                                                .currentState!
                                                                .validate();
                                                          },
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return AppLocalizations
                                                                      .of(context)!
                                                                  .enter_class;
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
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: TextFormField(
                                                          controller:
                                                              topicController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            labelText: AppLocalizations
                                                                    .of(context)!
                                                                .topic_optional,
                                                            //'TOPIC (Optional)',
                                                            labelStyle: TextStyle(
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    51,
                                                                    51,
                                                                    51,
                                                                    1),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    height *
                                                                        0.015),
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
                                                                        0.02),
                                                            hintText:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .topic_hint,
                                                            //'Type Topic Here',
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.02,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: TextFormField(
                                                          controller:
                                                              subTopicController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            labelText: AppLocalizations
                                                                    .of(context)!
                                                                .sub_topic_optional,
                                                            // 'SUB TOPIC (Optional)',
                                                            labelStyle: TextStyle(
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    51,
                                                                    51,
                                                                    51,
                                                                    1),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    height *
                                                                        0.015),
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
                                                                        0.02),
                                                            hintText: AppLocalizations
                                                                    .of(context)!
                                                                .sub_topic_hint,
                                                            //'Type Sub Topic Here',
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.02,
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  82,
                                                                  165,
                                                                  160,
                                                                  1),
                                                          minimumSize:
                                                              const Size(
                                                                  280, 48),
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
                                                            SharedPreferences
                                                                loginData =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            // Provider.of<QuestionPrepareProviderFinal>(
                                                            //         context,
                                                            //         listen:
                                                            //             false)
                                                            //     .reSetQuestionList();
                                                            assessment.topic =
                                                                topicController
                                                                    .text;
                                                            assessment
                                                                    .subTopic =
                                                                subTopicController
                                                                    .text;
                                                            assessment.subject =
                                                                subjectController
                                                                    .text;
                                                            assessment
                                                                    .createAssessmentModelClass =
                                                                classController
                                                                    .text;
                                                            assessment.userId =
                                                                loginData.getInt(
                                                                    'userId');
                                                            Provider.of<CreateAssessmentProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .updateAssessment(
                                                                    assessment);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .save_continue,
                                                          //'Save & Continue',
                                                          style: TextStyle(
                                                              fontSize: height *
                                                                  0.025,
                                                              fontFamily:
                                                                  "Inter",
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  1),
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
                                child: Row(
                                  children: [
                                    Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontSize: height * 0.017,
                                          fontFamily: "Inter",
                                          color: const Color.fromRGBO(
                                              28, 78, 80, 1),
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
                              )), ],
                          ),
                          Text(
                            'Topic: ${assessment.topic}',
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
                                'Sub Topic: ${assessment.subTopic}',
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontWeight: FontWeight.w400),
                              ),
                              // Text(
                              //   '${assessment.assessmentStartdate}',
                              //   style: TextStyle(
                              //       fontSize: height * 0.015,
                              //       fontFamily: "Inter",
                              //       color:
                              //           const Color.fromRGBO(102, 102, 102, 1),
                              //       fontWeight: FontWeight.w400),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total Questions: ',
                            style: TextStyle(
                                fontSize: height * 0.017,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '$totalQues',
                            style: TextStyle(
                                fontSize: height * 0.017,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Total Marks: ',
                            style: TextStyle(
                                fontSize: height * 0.017,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '$totalMark',
                            style: TextStyle(
                                fontSize: height * 0.017,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: height * 0.48,
                        width: width * 0.9,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 0;
                                  i < questionList.length;
                                  i++)
                                QuestionWidget(
                                  height: height,
                                  question: questionList[i],
                                  index: i,
                                  assessment: assessment,
                                  assessmentType: widget.assessmentType,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: height * 0.4,
                          left: width * 0.78,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/teacherAssessmentQuestionBank',arguments: [null,null,widget.assessmentType]);
                              // Navigator.push(
                              //   context,
                              //   PageTransition(
                              //     type: PageTransitionType.rightToLeft,
                              //     child: TeacherAssessmentQuestionBank(
                              //         ),
                              //   ),
                              // );
                            },
                            backgroundColor:
                                const Color.fromRGBO(82, 165, 160, 1),
                            child: const Icon(Icons.add),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: SizedBox(
                      width: width * 0.888,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            color: Color.fromRGBO(82, 165, 160, 1),
                          ),
                          backgroundColor:
                              const Color.fromRGBO(255, 255, 255, 1),
                          minimumSize: const Size(280, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(39),
                          ),
                        ),
                        onPressed: () async {
                          ResponseEntity statusCode = ResponseEntity();
                          if (assessment.assessmentId != null) {
                            assessment.assessmentStatus = 'inprogress';
                            statusCode =
                                await QnaService.editAssessmentTeacherService(
                                    assessment, assessment.assessmentId!);
                          } else {
                            assessment.assessmentStatus = 'inprogress';
                            assessment.assessmentType = 'practice';
                            assessment.removeQuestions = null;
                            statusCode =
                                await QnaService.createAssessmentTeacherService(
                                    assessment);
                          }
                          Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));


                        },
                        child: Text(
                          'Save Assessment',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
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
                        onPressed: () {
                          bool markZero = true;
                          for (int i = 0; i < questionList.length; i++) {
                            if(questionList[i].questionMark != 0){
                              markZero = false;
                            }
                            else{
                              markZero = true;
                            }
                          }
                          if(markZero){
                            showAlertDialog(context, height);
                          }else{
                            Navigator.pushNamed(context, '/teacherAssessmentSettingPublish',arguments: widget.assessmentType);
                          }

                        },
                        child: Text(
                          'Continue',
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
        ));
  }
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget(
      {Key? key,
      required this.height,
      required this.question,
      required this.index,
      required this.assessment,
        required this.assessmentType
      })
      : super(key: key);

  final double height;
  final Question.Question question;
  final int index;
  final CreateAssessmentModel assessment;
  final String assessmentType;


  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
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
        'No',
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
        'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
            .removeQuestion(widget.question.questionId);

        if(widget.question.questionId<1){

          Provider.of<CreateAssessmentProvider>(context, listen: false)
              .removeQuestionInAddQuestion(widget.question.questionId);

        }
        else{
          Provider.of<CreateAssessmentProvider>(context, listen: false)
              .removeQuestion(widget.question.questionId);
          }
        Navigator.of(context).pop();
        setState(() {});
        List<Question.Question> quesListArg=Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
            .getAllQuestion;

        //Navigator.pushNamed(context, '/teacherSelectedQuestionAssessment',arguments: quesListArg);
        print("---------------------------------------------TeacherSelectedQuestionAssessment");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => TeacherSelectedQuestionAssessment(
                  questions: quesListArg,
                  assessmentType: widget.assessmentType,
                    )),
                (route) => route.isFirst);
      },
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
            'Confirm',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to remove this Question?',
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

  String ans = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      for (int i = 0; i < widget.question.choices!.length; i++) {
        if (widget.question.choices![i].rightChoice!) {
          ans = '${widget.question.choices![i].choiceText}, $ans';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
          onTap: () {
            // showAlertDialog(
            //   context,
            //   widget.height,
            // );
            Navigator.pushNamed(
                context,
                '/teacherAssessmentQuestionPreview',
                arguments: [widget.assessment,widget.question, widget.index,'',widget.assessmentType]
            );
          },
          child: Container(
            color: const Color.fromRGBO(82, 165, 160, 0.08),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: widget.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Q${widget.index + 1}',
                            style: TextStyle(
                                fontSize: widget.height * 0.017,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '  ${widget.question.questionType}',
                            style: TextStyle(
                                fontSize: widget.height * 0.017,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(51, 51, 51, 1),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                        onTap: () {
                          showAlertDialog(
                            context,
                            widget.height,
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.close,
                              color: Color.fromRGBO(51, 51, 51, 1),
                            ),
                            Text(
                              ' Remove',
                              style: TextStyle(
                                  fontSize: widget.height * 0.017,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                      )],
                  ),
                  SizedBox(
                    height: widget.height * 0.01,
                  ),
                  MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          '/teacherAssessmentQuestionPreview',
                          arguments: [widget.assessment,widget.question, widget.index,'',widget.assessmentType]
                      );
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.rightToLeft,
                      //     child: TeacherAssessmentQuestionPreview(
                      //       assessment: widget.assessment,
                      //       question: widget.question,
                      //       index: widget.index,
                      //     ),
                      //   ),
                      // );
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${widget.question.question}',
                        style: TextStyle(
                            fontSize: widget.height * 0.015,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(51, 51, 51, 1),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )),
                  SizedBox(
                    height: widget.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ans,
                          style: TextStyle(
                              fontSize: widget.height * 0.017,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Marks: ',
                            style: TextStyle(
                                fontSize: widget.height * 0.017,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.question.questionMark}',
                            style: TextStyle(
                                fontSize: widget.height * 0.017,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: widget.height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
