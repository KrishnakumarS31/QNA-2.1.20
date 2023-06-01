import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher_assessment_question_preview.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/question_entity.dart' as questions;
import '../Entity/Teacher/response_entity.dart';
import '../Entity/user_details.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Providers/create_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qna_test/DataSource/http_url.dart';

class TeacherAssessmentSummary extends StatefulWidget {
  const TeacherAssessmentSummary({
    Key? key,required this.assessmentType
  }) : super(key: key);

  final String assessmentType;
  @override
  TeacherAssessmentSummaryState createState() =>
      TeacherAssessmentSummaryState();
}

class TeacherAssessmentSummaryState extends State<TeacherAssessmentSummary> {
  bool additionalDetails = true;
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  List<questions.Question> questionList = [];
  CreateAssessmentModel assessment = CreateAssessmentModel(questions: []);
  int totalQues = 0;
  int totalMark = 0;
  TextEditingController subjectController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController subTopicController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  UserDetails userDetails=UserDetails();
  showAdditionalDetails() {
    setState(() {
      !additionalDetails;
    });
  }

  showAlert(BuildContext context, double height) {
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
        //'Yes',
        AppLocalizations.of(context)!.yes,
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/teacherAssessmentSettingPublish',arguments: widget.assessmentType);
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
            AppLocalizations.of(context)!.login,
            //'Continue',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        AppLocalizations.of(context)!.do_you_want_continue,
        //'Do you want to still continue?',
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
      onPressed: () {
        Navigator.pushNamed(context, '/teacherAssessmentSettingPublish');
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
            AppLocalizations.of(context)!.marks_not_filled,
            //'Marks not filled',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        AppLocalizations.of(context)!.do_you_want_continue,
        //'Do you want to still continue?',
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
    super.initState();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    getData();
  }

  getData() {
    setState(() {

      questionList =
          Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
              .getAllQuestion;
      assessment = Provider.of<CreateAssessmentProvider>(context, listen: false)
          .getAssessment;
      totalQues = assessment.questions!.length;
      for (int i = 0; i < assessment.questions!.length; i++) {
        totalMark = totalMark + assessment.questions![i].questionMarks!;
      }
      subjectController.text=assessment.subject!;
      classController.text=assessment.createAssessmentModelClass!;
      topicController.text=assessment.topic!;
      subTopicController.text=assessment.subTopic!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // if(constraints.maxWidth > 900) {
          //   return WillPopScope(
          //       onWillPop: () async => false,
          //       child: Scaffold(
          //         resizeToAvoidBottomInset: true,
          //         backgroundColor: Colors.white,
          //         endDrawer: const EndDrawerMenuTeacher(),
          //         appBar: AppBar(
          //           leading: IconButton(
          //             icon: const Icon(
          //               Icons.chevron_left,
          //               size: 40.0,
          //               color: Colors.white,
          //             ),
          //             onPressed: () {
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //           toolbarHeight: height * 0.100,
          //           centerTitle: true,
          //           title: Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text(
          //                   AppLocalizations.of(context)!.selected_qns,
          //                   // "SELECTED QUESTIONS",
          //                   style: TextStyle(
          //                     color: const Color.fromRGBO(255, 255, 255, 1),
          //                     fontSize: height * 0.0225,
          //                     fontFamily: "Inter",
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 ),
          //                 Text(
          //                   AppLocalizations.of(context)!.for_assessments,
          //                   //"FOR ASSESSMENTS",
          //                   style: TextStyle(
          //                     color: const Color.fromRGBO(255, 255, 255, 1),
          //                     fontSize: height * 0.0225,
          //                     fontFamily: "Inter",
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 ),
          //               ]),
          //           flexibleSpace: Container(
          //             decoration: const BoxDecoration(
          //                 gradient: LinearGradient(
          //                     end: Alignment.bottomCenter,
          //                     begin: Alignment.topCenter,
          //                     colors: [
          //                       Color.fromRGBO(0, 106, 100, 1),
          //                       Color.fromRGBO(82, 165, 160, 1),
          //                     ])),
          //           ),
          //         ),
          //         body: Padding(
          //             padding: EdgeInsets.only(
          //                 top: height * 0.023,
          //                 left: height * 0.023,
          //                 right: height * 0.023),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   height: height * 0.108,
          //                   decoration: const BoxDecoration(
          //                     borderRadius: BorderRadius.all(Radius.circular(15)),
          //                     color: Color.fromRGBO(82, 165, 160, 0.07),
          //                   ),
          //                   child: Padding(
          //                     padding: EdgeInsets.only(
          //                         right: width * 0.03, left: width * 0.03),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                       children: [
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                           children: [
          //                             Row(
          //                               children: [
          //                                 Text(
          //                                   assessment.subject!,
          //                                   style: TextStyle(
          //                                       fontSize: height * 0.017,
          //                                       fontFamily: "Inter",
          //                                       color:
          //                                       const Color.fromRGBO(28, 78, 80, 1),
          //                                       fontWeight: FontWeight.w600),
          //                                 ),
          //                                 Text(
          //                                   '  |  ${assessment.createAssessmentModelClass}',
          //                                   style: TextStyle(
          //                                       fontSize: height * 0.015,
          //                                       fontFamily: "Inter",
          //                                       color:
          //                                       const Color.fromRGBO(28, 78, 80, 1),
          //                                       fontWeight: FontWeight.w400),
          //                                 ),
          //                               ],
          //                             ),
          //                             MouseRegion(
          //                                 cursor: SystemMouseCursors.click,
          //                                 child: GestureDetector(
          //                                   onTap: () {
          //                                     showDialog(
          //                                         context: context,
          //                                         builder: (BuildContext context) {
          //                                           return Dialog(
          //                                             shape: const RoundedRectangleBorder(
          //                                                 borderRadius: BorderRadius.all(
          //                                                     Radius.circular(17))),
          //                                             child: SingleChildScrollView(
          //                                               scrollDirection: Axis.vertical,
          //                                               child: Container(
          //                                                 height: height * 0.7,
          //                                                 width: width * 0.88,
          //                                                 decoration: BoxDecoration(
          //                                                   border: Border.all(
          //                                                       color: Colors.black38,
          //                                                       width: 1),
          //                                                   borderRadius:
          //                                                   BorderRadius.circular(17),
          //                                                 ),
          //                                                 child: Padding(
          //                                                   padding: EdgeInsets.only(
          //                                                       left: width * 0.02,
          //                                                       right: width * 0.02,
          //                                                       top: height * 0.02,
          //                                                       bottom: height * 0.02),
          //                                                   child: Form(
          //                                                     key: formKey,
          //                                                     child: Column(
          //                                                       mainAxisAlignment:
          //                                                       MainAxisAlignment
          //                                                           .start,
          //                                                       children: [
          //                                                         Align(
          //                                                           alignment: Alignment
          //                                                               .centerLeft,
          //                                                           child: Text(
          //                                                             AppLocalizations.of(
          //                                                                 context)!
          //                                                                 .assessment_title,
          //                                                             //'Assessment Title',
          //                                                             style: TextStyle(
          //                                                                 fontSize:
          //                                                                 height *
          //                                                                     0.02,
          //                                                                 fontFamily:
          //                                                                 "Inter",
          //                                                                 color: const Color
          //                                                                     .fromRGBO(
          //                                                                     82,
          //                                                                     165,
          //                                                                     160,
          //                                                                     1),
          //                                                                 fontWeight:
          //                                                                 FontWeight
          //                                                                     .w700),
          //                                                           ),
          //                                                         ),
          //                                                         Align(
          //                                                           alignment: Alignment
          //                                                               .centerLeft,
          //                                                           child: Text(
          //                                                             AppLocalizations.of(
          //                                                                 context)!
          //                                                                 .sub_class_others,
          //                                                             // 'Subject, Class and Other details',
          //                                                             style: TextStyle(
          //                                                                 fontSize:
          //                                                                 height *
          //                                                                     0.015,
          //                                                                 fontFamily:
          //                                                                 "Inter",
          //                                                                 color: const Color
          //                                                                     .fromRGBO(
          //                                                                     153,
          //                                                                     153,
          //                                                                     153,
          //                                                                     1),
          //                                                                 fontWeight:
          //                                                                 FontWeight
          //                                                                     .w400),
          //                                                           ),
          //                                                         ),
          //                                                         SizedBox(
          //                                                           height: height * 0.05,
          //                                                         ),
          //                                                         Align(
          //                                                           alignment:
          //                                                           Alignment.topLeft,
          //                                                           child: TextFormField(
          //                                                             controller:
          //                                                             subjectController,
          //                                                             keyboardType:
          //                                                             TextInputType
          //                                                                 .text,
          //                                                             decoration:
          //                                                             InputDecoration(
          //                                                               floatingLabelBehavior:
          //                                                               FloatingLabelBehavior
          //                                                                   .always,
          //                                                               label: SizedBox(
          //                                                                 width:
          //                                                                 constraints.maxWidth > 700
          //                                                                     ? width * 0.04
          //                                                                     : width * 0.185,
          //                                                                 child: Row(
          //                                                                   children: [
          //                                                                     Text(
          //                                                                       AppLocalizations.of(
          //                                                                           context)!
          //                                                                           .sub_caps,
          //                                                                       //'SUBJECT',
          //                                                                       style: TextStyle(
          //                                                                           fontSize: height *
          //                                                                               0.015,
          //                                                                           fontFamily:
          //                                                                           "Inter",
          //                                                                           color: const Color.fromRGBO(
          //                                                                               51,
          //                                                                               51,
          //                                                                               51,
          //                                                                               1),
          //                                                                           fontWeight:
          //                                                                           FontWeight.w600),
          //                                                                     ),
          //                                                                     Text(
          //                                                                       '\t*',
          //                                                                       style: TextStyle(
          //                                                                           fontSize: height *
          //                                                                               0.015,
          //                                                                           fontFamily:
          //                                                                           "Inter",
          //                                                                           color: Colors
          //                                                                               .red,
          //                                                                           fontWeight:
          //                                                                           FontWeight.w600),
          //                                                                     ),
          //                                                                   ],
          //                                                                 ),
          //                                                               ),
          //                                                               labelStyle: TextStyle(
          //                                                                   color: const Color
          //                                                                       .fromRGBO(
          //                                                                       51,
          //                                                                       51,
          //                                                                       51,
          //                                                                       1),
          //                                                                   fontFamily:
          //                                                                   'Inter',
          //                                                                   fontWeight:
          //                                                                   FontWeight
          //                                                                       .w600,
          //                                                                   fontSize:
          //                                                                   height *
          //                                                                       0.015),
          //                                                               hintStyle: TextStyle(
          //                                                                   color:
          //                                                                   const Color
          //                                                                       .fromRGBO(
          //                                                                       102,
          //                                                                       102,
          //                                                                       102,
          //                                                                       0.3),
          //                                                                   fontFamily:
          //                                                                   'Inter',
          //                                                                   fontWeight:
          //                                                                   FontWeight
          //                                                                       .w400,
          //                                                                   fontSize:
          //                                                                   height *
          //                                                                       0.02),
          //                                                               hintText:
          //                                                               AppLocalizations.of(
          //                                                                   context)!
          //                                                                   .sub_hint,
          //                                                               //'Type Subject Here',
          //                                                               focusedBorder: OutlineInputBorder(
          //                                                                   borderSide: const BorderSide(
          //                                                                       color: Color.fromRGBO(
          //                                                                           82,
          //                                                                           165,
          //                                                                           160,
          //                                                                           1)),
          //                                                                   borderRadius:
          //                                                                   BorderRadius
          //                                                                       .circular(
          //                                                                       15)),
          //                                                               border: OutlineInputBorder(
          //                                                                   borderRadius:
          //                                                                   BorderRadius
          //                                                                       .circular(
          //                                                                       15)),
          //                                                             ),
          //                                                             validator: (value) {
          //                                                               if (value!
          //                                                                   .isEmpty) {
          //                                                                 return AppLocalizations.of(
          //                                                                     context)!
          //                                                                     .enter_subject;
          //                                                                 //'Enter Subject';
          //                                                               } else {
          //                                                                 return null;
          //                                                               }
          //                                                             },
          //                                                             onChanged: (value) {
          //                                                               formKey
          //                                                                   .currentState!
          //                                                                   .validate();
          //                                                             },
          //                                                           ),
          //                                                         ),
          //                                                         SizedBox(
          //                                                           height: height * 0.02,
          //                                                         ),
          //                                                         Align(
          //                                                           alignment:
          //                                                           Alignment.topLeft,
          //                                                           child: TextFormField(
          //                                                             controller:
          //                                                             classController,
          //                                                             keyboardType:
          //                                                             TextInputType
          //                                                                 .text,
          //                                                             decoration:
          //                                                             InputDecoration(
          //                                                               floatingLabelBehavior:
          //                                                               FloatingLabelBehavior
          //                                                                   .always,
          //                                                               label: SizedBox(
          //                                                                 width: constraints.maxWidth > 700
          //                                                                     ? width * 0.06
          //                                                                     : width * 0.28,
          //                                                                 child: Row(
          //                                                                   children: [
          //                                                                     Text(
          //                                                                       AppLocalizations.of(
          //                                                                           context)!
          //                                                                           .class_caps,
          //                                                                       // 'CLASS',
          //                                                                       style: TextStyle(
          //                                                                           fontSize: height *
          //                                                                               0.015,
          //                                                                           fontFamily:
          //                                                                           "Inter",
          //                                                                           color: const Color.fromRGBO(
          //                                                                               51,
          //                                                                               51,
          //                                                                               51,
          //                                                                               1),
          //                                                                           fontWeight:
          //                                                                           FontWeight.w600),
          //                                                                     ),
          //                                                                     Text(
          //                                                                       '\t*',
          //                                                                       style: TextStyle(
          //                                                                           fontSize: height *
          //                                                                               0.015,
          //                                                                           fontFamily:
          //                                                                           "Inter",
          //                                                                           color: Colors
          //                                                                               .red,
          //                                                                           fontWeight:
          //                                                                           FontWeight.w600),
          //                                                                     ),
          //                                                                   ],
          //                                                                 ),
          //                                                               ),
          //                                                               labelStyle: TextStyle(
          //                                                                   color: const Color
          //                                                                       .fromRGBO(
          //                                                                       51,
          //                                                                       51,
          //                                                                       51,
          //                                                                       1),
          //                                                                   fontFamily:
          //                                                                   'Inter',
          //                                                                   fontWeight:
          //                                                                   FontWeight
          //                                                                       .w600,
          //                                                                   fontSize:
          //                                                                   height *
          //                                                                       0.015),
          //                                                               hintStyle: TextStyle(
          //                                                                   color:
          //                                                                   const Color
          //                                                                       .fromRGBO(
          //                                                                       102,
          //                                                                       102,
          //                                                                       102,
          //                                                                       0.3),
          //                                                                   fontFamily:
          //                                                                   'Inter',
          //                                                                   fontWeight:
          //                                                                   FontWeight
          //                                                                       .w400,
          //                                                                   fontSize:
          //                                                                   height *
          //                                                                       0.02),
          //                                                               hintText:
          //                                                               AppLocalizations.of(
          //                                                                   context)!
          //                                                                   .type_here,
          //                                                               //'Type Here',
          //                                                               focusedBorder: OutlineInputBorder(
          //                                                                   borderSide: const BorderSide(
          //                                                                       color: Color.fromRGBO(
          //                                                                           82,
          //                                                                           165,
          //                                                                           160,
          //                                                                           1)),
          //                                                                   borderRadius:
          //                                                                   BorderRadius
          //                                                                       .circular(
          //                                                                       15)),
          //                                                               border: OutlineInputBorder(
          //                                                                   borderRadius:
          //                                                                   BorderRadius
          //                                                                       .circular(
          //                                                                       15)),
          //                                                             ),
          //                                                             onChanged: (value) {
          //                                                               formKey
          //                                                                   .currentState!
          //                                                                   .validate();
          //                                                             },
          //                                                             validator: (value) {
          //                                                               if (value!
          //                                                                   .isEmpty) {
          //                                                                 return AppLocalizations.of(
          //                                                                     context)!
          //                                                                     .enter_class;
          //                                                                 //'Enter Class';
          //                                                               } else {
          //                                                                 return null;
          //                                                               }
          //                                                             },
          //                                                           ),
          //                                                         ),
          //                                                         SizedBox(
          //                                                           height: height * 0.02,
          //                                                         ),
          //                                                         Align(
          //                                                           alignment:
          //                                                           Alignment.topLeft,
          //                                                           child: TextFormField(
          //                                                             controller:
          //                                                             topicController,
          //                                                             keyboardType:
          //                                                             TextInputType
          //                                                                 .text,
          //                                                             decoration:
          //                                                             InputDecoration(
          //                                                               floatingLabelBehavior:
          //                                                               FloatingLabelBehavior
          //                                                                   .always,
          //                                                               labelText: AppLocalizations
          //                                                                   .of(context)!
          //                                                                   .topic_optional,
          //                                                               //'TOPIC (Optional)',
          //                                                               labelStyle: TextStyle(
          //                                                                   color: const Color
          //                                                                       .fromRGBO(
          //                                                                       51,
          //                                                                       51,
          //                                                                       51,
          //                                                                       1),
          //                                                                   fontFamily:
          //                                                                   'Inter',
          //                                                                   fontWeight:
          //                                                                   FontWeight
          //                                                                       .w600,
          //                                                                   fontSize:
          //                                                                   height *
          //                                                                       0.015),
          //                                                               hintStyle: TextStyle(
          //                                                                   color:
          //                                                                   const Color
          //                                                                       .fromRGBO(
          //                                                                       102,
          //                                                                       102,
          //                                                                       102,
          //                                                                       0.3),
          //                                                                   fontFamily:
          //                                                                   'Inter',
          //                                                                   fontWeight:
          //                                                                   FontWeight
          //                                                                       .w400,
          //                                                                   fontSize:
          //                                                                   height *
          //                                                                       0.02),
          //                                                               hintText:
          //                                                               AppLocalizations.of(
          //                                                                   context)!
          //                                                                   .topic_hint,
          //                                                               //'Type Topic Here',
          //                                                               focusedBorder: OutlineInputBorder(
          //                                                                   borderSide: const BorderSide(
          //                                                                       color: Color.fromRGBO(
          //                                                                           82,
          //                                                                           165,
          //                                                                           160,
          //                                                                           1)),
          //                                                                   borderRadius:
          //                                                                   BorderRadius
          //                                                                       .circular(
          //                                                                       15)),
          //                                                               border: OutlineInputBorder(
          //                                                                   borderRadius:
          //                                                                   BorderRadius
          //                                                                       .circular(
          //                                                                       15)),
          //                                                             ),
          //                                                           ),
          //                                                         ),
          //                                                         SizedBox(
          //                                                           height: height * 0.02,
          //                                                         ),
          //                                                         Align(
          //                                                           alignment:
          //                                                           Alignment.topLeft,
          //                                                           child: TextFormField(
          //                                                             controller:
          //                                                             subTopicController,
          //                                                             keyboardType:
          //                                                             TextInputType
          //                                                                 .text,
          //                                                             decoration:
          //                                                             InputDecoration(
          //                                                               floatingLabelBehavior:
          //                                                               FloatingLabelBehavior
          //                                                                   .always,
          //                                                               labelText: AppLocalizations
          //                                                                   .of(context)!
          //                                                                   .sub_topic_optional,
          //                                                               // 'Semester(Section) (Optional)',
          //                                                               labelStyle: TextStyle(
          //                                                                   color: const Color
          //                                                                       .fromRGBO(
          //                                                                       51,
          //                                                                       51,
          //                                                                       51,
          //                                                                       1),
          //                                                                   fontFamily:
          //                                                                   'Inter',
          //                                                                   fontWeight:
          //                                                                   FontWeight
          //                                                                       .w600,
          //                                                                   fontSize:
          //                                                                   height *
          //                                                                       0.015),
          //                                                               hintStyle: TextStyle(
          //                                                                   color:
          //                                                                   const Color
          //                                                                       .fromRGBO(
          //                                                                       102,
          //                                                                       102,
          //                                                                       102,
          //                                                                       0.3),
          //                                                                   fontFamily:
          //                                                                   'Inter',
          //                                                                   fontWeight:
          //                                                                   FontWeight
          //                                                                       .w400,
          //                                                                   fontSize:
          //                                                                   height *
          //                                                                       0.02),
          //                                                               hintText: AppLocalizations
          //                                                                   .of(context)!
          //                                                                   .sub_topic_hint,
          //                                                               //'Type Semester(Section) Here',
          //                                                               focusedBorder: OutlineInputBorder(
          //                                                                   borderSide: const BorderSide(
          //                                                                       color: Color.fromRGBO(
          //                                                                           82,
          //                                                                           165,
          //                                                                           160,
          //                                                                           1)),
          //                                                                   borderRadius:
          //                                                                   BorderRadius
          //                                                                       .circular(
          //                                                                       15)),
          //                                                               border: OutlineInputBorder(
          //                                                                   borderRadius:
          //                                                                   BorderRadius
          //                                                                       .circular(
          //                                                                       15)),
          //                                                             ),
          //                                                           ),
          //                                                         ),
          //                                                         SizedBox(
          //                                                           height: height * 0.02,
          //                                                         ),
          //                                                         ElevatedButton(
          //                                                           style: ElevatedButton
          //                                                               .styleFrom(
          //                                                             backgroundColor:
          //                                                             const Color
          //                                                                 .fromRGBO(
          //                                                                 82,
          //                                                                 165,
          //                                                                 160,
          //                                                                 1),
          //                                                             minimumSize:
          //                                                             const Size(
          //                                                                 280, 48),
          //                                                             shape:
          //                                                             RoundedRectangleBorder(
          //                                                               borderRadius:
          //                                                               BorderRadius
          //                                                                   .circular(
          //                                                                   39),
          //                                                             ),
          //                                                           ),
          //                                                           onPressed: () async {
          //                                                             bool valid = formKey
          //                                                                 .currentState!
          //                                                                 .validate();
          //                                                             if (valid) {
          //                                                               SharedPreferences
          //                                                               loginData =
          //                                                               await SharedPreferences
          //                                                                   .getInstance();
          //                                                               assessment
          //                                                                   .topic =
          //                                                                   topicController
          //                                                                       .text;
          //                                                               assessment
          //                                                                   .subTopic =
          //                                                                   subTopicController
          //                                                                       .text;
          //                                                               assessment
          //                                                                   .subject =
          //                                                                   subjectController
          //                                                                       .text;
          //                                                               assessment
          //                                                                   .createAssessmentModelClass =
          //                                                                   classController
          //                                                                       .text;
          //                                                               assessment
          //                                                                   .userId =
          //                                                                   loginData.getInt(
          //                                                                       'userId');
          //                                                               Provider.of<CreateAssessmentProvider>(
          //                                                                   context,
          //                                                                   listen:
          //                                                                   false)
          //                                                                   .updateAssessment(
          //                                                                   assessment);
          //                                                               setState(() {
          //
          //                                                               });
          //                                                               Navigator.pop(context);
          //                                                             }
          //                                                           },
          //                                                           child: Text(
          //                                                             AppLocalizations.of(
          //                                                                 context)!
          //                                                                 .save_continue,
          //                                                             //'Save & Continue',
          //                                                             style: TextStyle(
          //                                                                 fontSize:
          //                                                                 height *
          //                                                                     0.025,
          //                                                                 fontFamily:
          //                                                                 "Inter",
          //                                                                 color: const Color
          //                                                                     .fromRGBO(
          //                                                                     255,
          //                                                                     255,
          //                                                                     255,
          //                                                                     1),
          //                                                                 fontWeight:
          //                                                                 FontWeight
          //                                                                     .w600),
          //                                                           ),
          //                                                         ),
          //
          //                                                       ],
          //                                                     ),
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                           );
          //                                         });
          //                                   },
          //                                   child: Row(
          //                                     children: [
          //                                       Text(
          //                                         AppLocalizations.of(context)!.edit_button,
          //                                         //'Edit',
          //                                         style: TextStyle(
          //                                             fontSize: height * 0.017,
          //                                             fontFamily: "Inter",
          //                                             color:
          //                                             const Color.fromRGBO(28, 78, 80, 1),
          //                                             fontWeight: FontWeight.w400),
          //                                       ),
          //                                       SizedBox(
          //                                         width: width * 0.01,
          //                                       ),
          //                                       const Icon(
          //                                         Icons.edit_outlined,
          //                                         color: Color.fromRGBO(28, 78, 80, 1),
          //                                       )
          //                                     ],
          //                                   ),
          //                                 )),
          //                           ],
          //                         ),
          //                         Text(
          //                           "${AppLocalizations.of(context)!.topic_small} ${assessment.topic}",
          //                           //'Topic: ${assessment.topic}',
          //                           style: TextStyle(
          //                               fontSize: height * 0.015,
          //                               fontFamily: "Inter",
          //                               color: const Color.fromRGBO(102, 102, 102, 1),
          //                               fontWeight: FontWeight.w400),
          //                         ),
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                           children: [
          //                             Text(
          //                               "${AppLocalizations.of(context)!.sub_topic} ${assessment.topic}",
          //                               //'Semester(Section): ${assessment.subTopic}',
          //                               style: TextStyle(
          //                                   fontSize: height * 0.015,
          //                                   fontFamily: "Inter",
          //                                   color:
          //                                   const Color.fromRGBO(102, 102, 102, 1),
          //                                   fontWeight: FontWeight.w400),
          //                             ),
          //                             Text(
          //                               '14/1/2023',
          //                               style: TextStyle(
          //                                   fontSize: height * 0.015,
          //                                   fontFamily: "Inter",
          //                                   color:
          //                                   const Color.fromRGBO(102, 102, 102, 1),
          //                                   fontWeight: FontWeight.w400),
          //                             ),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: height * 0.02,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Row(
          //                       children: [
          //                         Text(
          //                           AppLocalizations.of(context)!.total_ques,
          //                           //'Total Questions: ',
          //                           style: TextStyle(
          //                               fontSize: height * 0.017,
          //                               fontFamily: "Inter",
          //                               color: const Color.fromRGBO(0, 0, 0, 1),
          //                               fontWeight: FontWeight.w400),
          //                         ),
          //                         Text(
          //                           '$totalQues',
          //                           style: TextStyle(
          //                               fontSize: height * 0.017,
          //                               fontFamily: "Inter",
          //                               color: const Color.fromRGBO(82, 165, 160, 1),
          //                               fontWeight: FontWeight.w700),
          //                         ),
          //                       ],
          //                     ),
          //                     Row(
          //                       children: [
          //                         Text(
          //                           AppLocalizations.of(context)!.total_marks,
          //                           // 'Total Marks: ',
          //                           style: TextStyle(
          //                               fontSize: height * 0.017,
          //                               fontFamily: "Inter",
          //                               color: const Color.fromRGBO(0, 0, 0, 1),
          //                               fontWeight: FontWeight.w400),
          //                         ),
          //                         Text(
          //                           '$totalMark',
          //                           style: TextStyle(
          //                               fontSize: height * 0.017,
          //                               fontFamily: "Inter",
          //                               color: const Color.fromRGBO(82, 165, 160, 1),
          //                               fontWeight: FontWeight.w700),
          //                         ),
          //                       ],
          //                     )
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: height * 0.02,
          //                 ),
          //                 Stack(
          //                   clipBehavior: Clip.none,
          //                   children: [
          //                     SizedBox(
          //                       height: height * 0.48,
          //                       width: width * 0.9,
          //                       child: SingleChildScrollView(
          //                         scrollDirection: Axis.vertical,
          //                         child: Column(
          //                           mainAxisSize: MainAxisSize.min,
          //                           children: [
          //                             for (int i = 0;
          //                             i < assessment.questions!.length;
          //                             i++)
          //                               QuestionWidget(
          //                                 height: height,
          //                                 question: questionList[i],
          //                                 index: i,
          //                                 assessment: assessment,
          //                                 assessmentType: widget.assessmentType,
          //                               ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     Positioned(
          //                         top: height * 0.4,
          //                         left: width * 0.78,
          //                         child: FloatingActionButton(
          //                           onPressed: () {
          //                             Navigator.pushNamed(context, '/teacherAssessmentQuestionBank',arguments: [null,'',widget.assessmentType]);
          //                           },
          //                           backgroundColor:
          //                           const Color.fromRGBO(82, 165, 160, 1),
          //                           child: const Icon(Icons.add),
          //                         ))
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: height * 0.01,
          //                 ),
          //                 Center(
          //                   child: SizedBox(
          //                     width: width * 0.888,
          //                     child: ElevatedButton(
          //                       style: ElevatedButton.styleFrom(
          //                         side: const BorderSide(
          //                           color: Color.fromRGBO(82, 165, 160, 1),
          //                         ),
          //                         backgroundColor:
          //                         const Color.fromRGBO(255, 255, 255, 1),
          //                         minimumSize: const Size(280, 48),
          //                         shape: RoundedRectangleBorder(
          //                           borderRadius: BorderRadius.circular(39),
          //                         ),
          //                       ),
          //                       onPressed: () async {
          //                         assessment = Provider.of<CreateAssessmentProvider>(
          //                             context,
          //                             listen: false)
          //                             .getAssessment;
          //                         DateTime startDate=DateTime.now();
          //                         startDate = DateTime(
          //                             startDate.year,
          //                             startDate.month,
          //                             startDate.day,
          //                             startDate.hour,
          //                             startDate.minute);
          //                         assessment.assessmentStartdate =
          //                             startDate
          //                                 .microsecondsSinceEpoch;
          //                         ResponseEntity statusCode = ResponseEntity();
          //                         statusCode =
          //                         await QnaService.editAssessmentTeacherService(
          //                             assessment, assessment.assessmentId!,userDetails);
          //                         if (statusCode.code == 200) {
          //                           Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));
          //
          //                         }
          //                       },
          //                       child: Text(
          //                         AppLocalizations.of(context)!.save_assessments,
          //                         //'Save Assessment',
          //                         style: TextStyle(
          //                             fontSize: height * 0.025,
          //                             fontFamily: "Inter",
          //                             color: const Color.fromRGBO(82, 165, 160, 1),
          //                             fontWeight: FontWeight.w600),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: height * 0.01,
          //                 ),
          //                 Center(
          //                   child: SizedBox(
          //                     width: width * 0.888,
          //                     child: ElevatedButton(
          //                       style: ElevatedButton.styleFrom(
          //                           backgroundColor:
          //                           const Color.fromRGBO(82, 165, 160, 1),
          //                           minimumSize: const Size(280, 48),
          //                           shape: RoundedRectangleBorder(
          //                             borderRadius: BorderRadius.circular(39),
          //                           ),
          //                           side: const BorderSide(
          //                             color: Color.fromRGBO(82, 165, 160, 1),
          //                           )),
          //                       onPressed: () {
          //                         if(assessment.questions!.isEmpty){
          //                           Navigator.push(
          //                             context,
          //                             PageTransition(
          //                               type: PageTransitionType.rightToLeft,
          //                               child: CustomDialog(
          //                                 title: AppLocalizations.of(context)!.alert_popup,
          //                                 //'Wrong password',
          //                                 content:
          //                                 "Question list is empty",
          //                                 //'please enter the correct password',
          //                                 button: AppLocalizations.of(context)!.retry,
          //                               ),
          //                             ),
          //                           );
          //                         }
          //                         else{
          //                           bool pros = true;
          //                           for (int i = 0;
          //                           i < assessment.questions!.length;
          //                           i++) {
          //                             if (questionList[i].questionType == "MCQ" &&
          //                                 questionList[i].questionMark == 0) {
          //                               pros = false;
          //                             }
          //                           }
          //                           pros
          //                               ? Navigator.pushNamed(
          //                               context, '/teacherAssessmentSettingPublish',
          //                               arguments: widget.assessmentType)
          //                               : showAlert(context, height);
          //                         }
          //                       },
          //                       child: Text(
          //                         AppLocalizations.of(context)!.login,
          //                         //'Continue',
          //                         style: TextStyle(
          //                             fontSize: height * 0.025,
          //                             fontFamily: "Inter",
          //                             color: const Color.fromRGBO(255, 255, 255, 1),
          //                             fontWeight: FontWeight.w600),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             )),
          //       ));
          // }
          if(constraints.maxWidth > 500) {
            return Center(
              child: WillPopScope(
                  onWillPop: () async => false,
                  child: Container(
                    width: webWidth,
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
                                AppLocalizations.of(context)!.selected_qns,
                                // "SELECTED QUESTIONS",
                                style: TextStyle(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: height * 0.0225,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.for_assessments,
                                //"FOR ASSESSMENTS",
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
                                      right: webWidth * 0.03, left: webWidth * 0.03),
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
                                                assessment.subject!,
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
                                                              width: webWidth * 0.88,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors.black38,
                                                                    width: 1),
                                                                borderRadius:
                                                                BorderRadius.circular(17),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: webWidth * 0.02,
                                                                    right: webWidth * 0.02,
                                                                    top: height * 0.02,
                                                                    bottom: height * 0.02),
                                                                child: Form(
                                                                  key: formKey,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
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
                                                                              height *
                                                                                  0.02,
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
                                                                              fontSize:
                                                                              height *
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
                                                                              webWidth * 0.04,
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    AppLocalizations.of(
                                                                                        context)!
                                                                                        .sub_caps,
                                                                                    //'SUBJECT',
                                                                                    style: TextStyle(
                                                                                        fontSize: height *
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
                                                                                        fontSize: height *
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
                                                                                    0.02),
                                                                            hintText:
                                                                            AppLocalizations.of(
                                                                                context)!
                                                                                .sub_hint,
                                                                            //'Type Subject Here',
                                                                            focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                    color: Color.fromRGBO(
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
                                                                              return AppLocalizations.of(
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
                                                                              width: constraints.maxWidth > 700
                                                                                  ? width * 0.06
                                                                                  : width * 0.28,
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    AppLocalizations.of(
                                                                                        context)!
                                                                                        .class_caps,
                                                                                    // 'CLASS',
                                                                                    style: TextStyle(
                                                                                        fontSize: height *
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
                                                                                        fontSize: height *
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
                                                                                    0.02),
                                                                            hintText:
                                                                            AppLocalizations.of(
                                                                                context)!
                                                                                .type_here,
                                                                            //'Type Here',
                                                                            focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                    color: Color.fromRGBO(
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
                                                                              return AppLocalizations.of(
                                                                                  context)!
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
                                                                                    0.02),
                                                                            hintText:
                                                                            AppLocalizations.of(
                                                                                context)!
                                                                                .topic_hint,
                                                                            //'Type Topic Here',
                                                                            focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                    color: Color.fromRGBO(
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
                                                                            // 'Semester(Section) (Optional)',
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
                                                                                    0.02),
                                                                            hintText: AppLocalizations
                                                                                .of(context)!
                                                                                .sub_topic_hint,
                                                                            //'Type Semester(Section) Here',
                                                                            focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                    color: Color.fromRGBO(
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
                                                                            assessment
                                                                                .topic =
                                                                                topicController
                                                                                    .text;
                                                                            assessment
                                                                                .subTopic =
                                                                                subTopicController
                                                                                    .text;
                                                                            assessment
                                                                                .subject =
                                                                                subjectController
                                                                                    .text;
                                                                            assessment
                                                                                .createAssessmentModelClass =
                                                                                classController
                                                                                    .text;
                                                                            assessment
                                                                                .userId =
                                                                                loginData.getInt(
                                                                                    'userId');
                                                                            Provider.of<CreateAssessmentProvider>(
                                                                                context,
                                                                                listen:
                                                                                false)
                                                                                .updateAssessment(
                                                                                assessment);
                                                                            setState(() {

                                                                            });
                                                                            Navigator.pop(context);
                                                                          }
                                                                        },
                                                                        child: Text(
                                                                          AppLocalizations.of(
                                                                              context)!
                                                                              .save_continue,
                                                                          //'Save & Continue',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                              height *
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
                                                      AppLocalizations.of(context)!.edit_button,
                                                      //'Edit',
                                                      style: TextStyle(
                                                          fontSize: height * 0.017,
                                                          fontFamily: "Inter",
                                                          color:
                                                          const Color.fromRGBO(28, 78, 80, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      width: webWidth * 0.01,
                                                    ),
                                                    const Icon(
                                                      Icons.edit_outlined,
                                                      color: Color.fromRGBO(28, 78, 80, 1),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                      Text(
                                        "${AppLocalizations.of(context)!.topic_small} ${assessment.topic}",
                                        //'Topic: ${assessment.topic}',
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
                                            "${AppLocalizations.of(context)!.sub_topic} ${assessment.topic}",
                                            //'Semester(Section): ${assessment.subTopic}',
                                            style: TextStyle(
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(102, 102, 102, 1),
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            '14/1/2023',
                                            style: TextStyle(
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(102, 102, 102, 1),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.total_ques,
                                        //'Total Questions: ',
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
                                        AppLocalizations.of(context)!.total_marks,
                                        // 'Total Marks: ',
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
                                    width: webWidth * 0.9,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          for (int i = 0;
                                          i < assessment.questions!.length;
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
                                      left: webWidth * 0.78,
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/teacherAssessmentQuestionBank',arguments: [null,'',widget.assessmentType]);
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
                                  width: webWidth * 0.888,
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
                                      assessment = Provider.of<CreateAssessmentProvider>(
                                          context,
                                          listen: false)
                                          .getAssessment;
                                      DateTime startDate=DateTime.now();
                                      startDate = DateTime(
                                          startDate.year,
                                          startDate.month,
                                          startDate.day,
                                          startDate.hour,
                                          startDate.minute);
                                      assessment.assessmentStartdate =
                                          startDate
                                              .microsecondsSinceEpoch;
                                      ResponseEntity statusCode = ResponseEntity();
                                      statusCode =
                                      await QnaService.editAssessmentTeacherService(
                                          assessment, assessment.assessmentId!,userDetails);
                                      if (statusCode.code == 200) {
                                        Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));

                                      }
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.save_assessments,
                                      //'Save Assessment',
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
                                  width: webWidth * 0.888,
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
                                      if(assessment.questions!.isEmpty){
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            child: CustomDialog(
                                              title: AppLocalizations.of(context)!.alert_popup,
                                              //'Wrong password',
                                              content:
                                              "Question list is empty",
                                              //'please enter the correct password',
                                              button: AppLocalizations.of(context)!.retry,
                                            ),
                                          ),
                                        );
                                      }
                                      else{
                                        bool pros = true;
                                        for (int i = 0;
                                        i < assessment.questions!.length;
                                        i++) {
                                          if (questionList[i].questionType == "MCQ" &&
                                              questionList[i].questionMark == 0) {
                                            pros = false;
                                          }
                                        }
                                        pros
                                            ? Navigator.pushNamed(
                                            context, '/teacherAssessmentSettingPublish',
                                            arguments: widget.assessmentType)
                                            : showAlert(context, height);
                                      }
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.login,
                                      //'Continue',
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
                  )),
            );
          }
          else {
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
                            AppLocalizations.of(context)!.selected_qns,
                            // "SELECTED QUESTIONS",
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize: height * 0.0225,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.for_assessments,
                            //"FOR ASSESSMENTS",
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
                                            assessment.subject!,
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
                                                                MainAxisAlignment
                                                                    .start,
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
                                                                          height *
                                                                              0.02,
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
                                                                          fontSize:
                                                                          height *
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
                                                                          constraints.maxWidth > 700
                                                                              ? width * 0.04
                                                                              : width * 0.185,
                                                                          child: Row(
                                                                            children: [
                                                                              Text(
                                                                                AppLocalizations.of(
                                                                                    context)!
                                                                                    .sub_caps,
                                                                                //'SUBJECT',
                                                                                style: TextStyle(
                                                                                    fontSize: height *
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
                                                                                    fontSize: height *
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
                                                                                0.02),
                                                                        hintText:
                                                                        AppLocalizations.of(
                                                                            context)!
                                                                            .sub_hint,
                                                                        //'Type Subject Here',
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                                color: Color.fromRGBO(
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
                                                                          return AppLocalizations.of(
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
                                                                          width: constraints.maxWidth > 700
                                                                              ? width * 0.06
                                                                              : width * 0.28,
                                                                          child: Row(
                                                                            children: [
                                                                              Text(
                                                                                AppLocalizations.of(
                                                                                    context)!
                                                                                    .class_caps,
                                                                                // 'CLASS',
                                                                                style: TextStyle(
                                                                                    fontSize: height *
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
                                                                                    fontSize: height *
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
                                                                                0.02),
                                                                        hintText:
                                                                        AppLocalizations.of(
                                                                            context)!
                                                                            .type_here,
                                                                        //'Type Here',
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                                color: Color.fromRGBO(
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
                                                                          return AppLocalizations.of(
                                                                              context)!
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
                                                                                0.02),
                                                                        hintText:
                                                                        AppLocalizations.of(
                                                                            context)!
                                                                            .topic_hint,
                                                                        //'Type Topic Here',
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                                color: Color.fromRGBO(
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
                                                                        // 'Semester(Section) (Optional)',
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
                                                                                0.02),
                                                                        hintText: AppLocalizations
                                                                            .of(context)!
                                                                            .sub_topic_hint,
                                                                        //'Type Semester(Section) Here',
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(
                                                                                color: Color.fromRGBO(
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
                                                                        assessment
                                                                            .topic =
                                                                            topicController
                                                                                .text;
                                                                        assessment
                                                                            .subTopic =
                                                                            subTopicController
                                                                                .text;
                                                                        assessment
                                                                            .subject =
                                                                            subjectController
                                                                                .text;
                                                                        assessment
                                                                            .createAssessmentModelClass =
                                                                            classController
                                                                                .text;
                                                                        assessment
                                                                            .userId =
                                                                            loginData.getInt(
                                                                                'userId');
                                                                        Provider.of<CreateAssessmentProvider>(
                                                                            context,
                                                                            listen:
                                                                            false)
                                                                            .updateAssessment(
                                                                            assessment);
                                                                        setState(() {

                                                                        });
                                                                        Navigator.pop(context);
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      AppLocalizations.of(
                                                                          context)!
                                                                          .save_continue,
                                                                      //'Save & Continue',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          height *
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
                                                  AppLocalizations.of(context)!.edit_button,
                                                  //'Edit',
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
                                          )),
                                    ],
                                  ),
                                  Text(
                                    "${AppLocalizations.of(context)!.topic_small} ${assessment.topic}",
                                    //'Topic: ${assessment.topic}',
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
                                        "${AppLocalizations.of(context)!.sub_topic} ${assessment.topic}",
                                        //'Semester(Section): ${assessment.subTopic}',
                                        style: TextStyle(
                                            fontSize: height * 0.015,
                                            fontFamily: "Inter",
                                            color:
                                            const Color.fromRGBO(102, 102, 102, 1),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        '14/1/2023',
                                        style: TextStyle(
                                            fontSize: height * 0.015,
                                            fontFamily: "Inter",
                                            color:
                                            const Color.fromRGBO(102, 102, 102, 1),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.total_ques,
                                    //'Total Questions: ',
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
                                    AppLocalizations.of(context)!.total_marks,
                                    // 'Total Marks: ',
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
                                      i < assessment.questions!.length;
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
                                      Navigator.pushNamed(context, '/teacherAssessmentQuestionBank',arguments: [null,'',widget.assessmentType]);
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
                                  assessment = Provider.of<CreateAssessmentProvider>(
                                      context,
                                      listen: false)
                                      .getAssessment;
                                  DateTime startDate=DateTime.now();
                                  startDate = DateTime(
                                      startDate.year,
                                      startDate.month,
                                      startDate.day,
                                      startDate.hour,
                                      startDate.minute);
                                  assessment.assessmentStartdate =
                                      startDate
                                          .microsecondsSinceEpoch;
                                  ResponseEntity statusCode = ResponseEntity();
                                  statusCode =
                                  await QnaService.editAssessmentTeacherService(
                                      assessment, assessment.assessmentId!,userDetails);
                                  if (statusCode.code == 200) {
                                    Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));

                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.save_assessments,
                                  //'Save Assessment',
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
                                  if(assessment.questions!.isEmpty){
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: CustomDialog(
                                          title: AppLocalizations.of(context)!.alert_popup,
                                          //'Wrong password',
                                          content:
                                          "Question list is empty",
                                          //'please enter the correct password',
                                          button: AppLocalizations.of(context)!.retry,
                                        ),
                                      ),
                                    );
                                  }
                                  else{
                                    bool pros = true;
                                    for (int i = 0;
                                    i < assessment.questions!.length;
                                    i++) {
                                      if (questionList[i].questionType == "MCQ" &&
                                          questionList[i].questionMark == 0) {
                                        pros = false;
                                      }
                                    }
                                    pros
                                        ? Navigator.pushNamed(
                                        context, '/teacherAssessmentSettingPublish',
                                        arguments: widget.assessmentType)
                                        : showAlert(context, height);
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.login,
                                  //'Continue',
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
   });
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
  final questions.Question question;
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
        AppLocalizations.of(context)!.no,
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
      child: Text(
        AppLocalizations.of(context)!.yes,
        //'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
            .removeQuestion(widget.question.questionId);
        Provider.of<CreateAssessmentProvider>(context, listen: false)
            .removeQuestion(widget.question.questionId);
        Navigator.pushNamedAndRemoveUntil(context, '/teacherAssessmentSummary', ModalRoute.withName('/teacherRecentAssessment'),arguments: widget.assessmentType);
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
        AppLocalizations.of(context)!.sure_to_remove_qn,
        //'Are you sure you want to remove this Question?',
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
                              AppLocalizations.of(context)!.remove,
                              //' Remove',
                              style: TextStyle(
                                  fontSize: widget.height * 0.017,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      showQuestionPreview(context);
                      setState(() {});
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
                        AppLocalizations.of(context)!.marks_small,
                        // 'Marks: ',
                        style: TextStyle(
                            fontSize: widget.height * 0.017,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${widget.assessment.questions![widget.index].questionMarks}',
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
    );
  }

  showQuestionPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TeacherAssessmentQuestionPreview(
          assessment: widget.assessment,
          question: widget.question,
          index: widget.index,
          pageName: 'TeacherAssessmentSummary',
          assessmentType: widget.assessmentType,
        );
      },
    );
  }
}
