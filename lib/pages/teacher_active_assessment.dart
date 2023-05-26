import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/get_assessment_model.dart';
import '../Entity/Teacher/question_entity.dart' as Question;
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/create_assessment_provider.dart';
import '../Providers/edit_assessment_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TeacherActiveAssessment extends StatefulWidget {
  TeacherActiveAssessment(
      {Key? key, required this.assessment,
      required this.assessmentType})
      : super(key: key);

  final GetAssessmentModel assessment;
  String assessmentType;

  @override
  TeacherActiveAssessmentState createState() => TeacherActiveAssessmentState();
}

class TeacherActiveAssessmentState extends State<TeacherActiveAssessment> {
  bool additionalDetails = true;
  bool questionShirnk = true;
  GetAssessmentModel assessment = GetAssessmentModel();
  var startDate;
  var endDate;
  CreateAssessmentModel finalAssessment = CreateAssessmentModel(questions: []);
  int mark = 0;

  showAdditionalDetails() {
    setState(() {
      additionalDetails = !additionalDetails;
    });
  }

  showQuestionDetails() {
    setState(() {
      questionShirnk = !questionShirnk;
    });
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  getData() {
    assessment = Provider.of<EditAssessmentProvider>(context, listen: false)
        .getAssessment;
    finalAssessment =
        Provider.of<CreateAssessmentProvider>(context, listen: false)
            .getAssessment;
    finalAssessment.removeQuestions = [];
    for (int i = 0; i < finalAssessment.questions!.length; i++) {
      mark = mark + assessment.questions![i].questionMark!;
    }
    setState(() {
      mark =
          finalAssessment.totalScore == null ? 0 : finalAssessment.totalScore!;
      startDate = DateTime.fromMicrosecondsSinceEpoch(
          finalAssessment.assessmentStartdate == null
              ? 0
              : finalAssessment.assessmentStartdate!);
      endDate = DateTime.fromMicrosecondsSinceEpoch(
          finalAssessment.assessmentEnddate == null
              ? 0
              : finalAssessment.assessmentEnddate!);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // if(constraints.maxWidth > 900)
        // {
        //   print("INSIDE WEB");
        //   print(constraints.maxWidth);
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
        //                   AppLocalizations.of(context)!.active,
        //                   //"ACTIVE",
        //                   style: TextStyle(
        //                     color: const Color.fromRGBO(255, 255, 255, 1),
        //                     fontSize: height * 0.0225,
        //                     fontFamily: "Inter",
        //                     fontWeight: FontWeight.w400,
        //                   ),
        //                 ),
        //                 Text(
        //                   AppLocalizations.of(context)!.assessment_caps,
        //                   // "ASSESSMENTS",
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
        //                   Color.fromRGBO(0, 106, 100, 1),
        //                   Color.fromRGBO(82, 165, 160, 1),
        //                 ])),
        //           ),
        //         ),
        //         body: SingleChildScrollView(
        //           scrollDirection: Axis.vertical,
        //           child: Padding(
        //               padding: EdgeInsets.only(
        //                   top: height * 0.023,
        //                   left: height * 0.023,
        //                   right: height * 0.023),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   SizedBox(
        //                     height: height * 0.01,
        //                   ),
        //                   SizedBox(
        //                     height: height * 0.03,
        //                   ),
        //                   Center(
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                         borderRadius:
        //                             const BorderRadius.all(Radius.circular(8.0)),
        //                         border: Border.all(
        //                           color: const Color.fromRGBO(217, 217, 217, 1),
        //                         ),
        //                         color: Colors.white,
        //                       ),
        //                       height: height * 0.1675,
        //                       width: width * 0.888,
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Container(
        //                             height: height * 0.037,
        //                             decoration: const BoxDecoration(
        //                               borderRadius: BorderRadius.only(
        //                                   topLeft: Radius.circular(8.0),
        //                                   topRight: Radius.circular(8.0)),
        //                               color: Color.fromRGBO(82, 165, 160, 1),
        //                             ),
        //                             child: Padding(
        //                               padding: EdgeInsets.only(left: width * 0.02),
        //                               child: Row(
        //                                 children: [
        //                                   Text(
        //                                     assessment.subject!,
        //                                     style: TextStyle(
        //                                       color: const Color.fromRGBO(
        //                                           255, 255, 255, 1),
        //                                       fontSize: height * 0.02,
        //                                       fontFamily: "Inter",
        //                                       fontWeight: FontWeight.w700,
        //                                     ),
        //                                   ),
        //                                   Text(
        //                                     "  |  ${assessment.getAssessmentModelClass!}",
        //                                     style: TextStyle(
        //                                       color: const Color.fromRGBO(
        //                                           255, 255, 255, 1),
        //                                       fontSize: height * 0.015,
        //                                       fontFamily: "Inter",
        //                                       fontWeight: FontWeight.w400,
        //                                     ),
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ),
        //                           Row(
        //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               Padding(
        //                                 padding: EdgeInsets.only(right: width * 0.02),
        //                                 child: const Icon(
        //                                   Icons.circle,
        //                                   color: Colors.white,
        //                                 ),
        //                               ),
        //                               Text(
        //                                 "${assessment.topic!} - ${assessment.subTopic!}",
        //                                 style: TextStyle(
        //                                   color:
        //                                       const Color.fromRGBO(102, 102, 102, 1),
        //                                   fontSize: height * 0.015,
        //                                   fontFamily: "Inter",
        //                                   fontWeight: FontWeight.w400,
        //                                 ),
        //                               ),
        //                               Padding(
        //                                 padding: EdgeInsets.only(right: width * 0.02),
        //                                 child: const Icon(
        //                                   Icons.circle,
        //                                   color: Color.fromRGBO(60, 176, 0, 1),
        //                                 ),
        //                               )
        //                             ],
        //                           ),
        //                           Row(
        //                             children: [
        //                               Container(
        //                                 decoration: const BoxDecoration(
        //                                   border: Border(
        //                                     right: BorderSide(
        //                                       color: Color.fromRGBO(204, 204, 204, 1),
        //                                     ),
        //                                   ),
        //                                   color: Colors.white,
        //                                 ),
        //                                 width: width * 0.44,
        //                                 height: height * 0.0875,
        //                                 child: Column(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.spaceEvenly,
        //                                   children: [
        //                                     Text(
        //                                       "$mark",
        //                                       style: TextStyle(
        //                                         color: const Color.fromRGBO(
        //                                             28, 78, 80, 1),
        //                                         fontSize: height * 0.03,
        //                                         fontFamily: "Inter",
        //                                         fontWeight: FontWeight.w700,
        //                                       ),
        //                                     ),
        //                                     Text(
        //                                         AppLocalizations.of(context)!
        //                                             .marks,
        //                                       //"Marks",
        //                                       style: TextStyle(
        //                                         color: const Color.fromRGBO(
        //                                             102, 102, 102, 1),
        //                                         fontSize: height * 0.015,
        //                                         fontFamily: "Inter",
        //                                         fontWeight: FontWeight.w400,
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ),
        //                               SizedBox(
        //                                 width: width * 0.44,
        //                                 height: height * 0.0875,
        //                                 child: Column(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.spaceEvenly,
        //                                   children: [
        //                                     Text(
        //                                       "${assessment.questions!.length}",
        //                                       style: TextStyle(
        //                                         color: const Color.fromRGBO(
        //                                             28, 78, 80, 1),
        //                                         fontSize: height * 0.03,
        //                                         fontFamily: "Inter",
        //                                         fontWeight: FontWeight.w700,
        //                                       ),
        //                                     ),
        //                                     Text(
        //                                       AppLocalizations.of(context)!.qn_button,
        //                                       //"Questions",
        //                                       style: TextStyle(
        //                                         color: const Color.fromRGBO(
        //                                             102, 102, 102, 1),
        //                                         fontSize: height * 0.015,
        //                                         fontFamily: "Inter",
        //                                         fontWeight: FontWeight.w400,
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               )
        //                             ],
        //                           )
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: height * 0.025,
        //                   ),
        //                   Row(
        //                     children: [
        //                       SizedBox(
        //                         width: width * 0.4,
        //                         child: Text(
        //                           AppLocalizations.of(context)!.assessment_id_caps,
        //                           //"Assessment ID:",
        //                           style: TextStyle(
        //                             color: const Color.fromRGBO(102, 102, 102, 1),
        //                             fontSize: height * 0.02,
        //                             fontFamily: "Inter",
        //                             fontWeight: FontWeight.w600,
        //                           ),
        //                         ),
        //                       ),
        //                       Text(
        //                         assessment.assessmentCode!,
        //                         style: TextStyle(
        //                           color: const Color.fromRGBO(82, 165, 160, 1),
        //                           fontSize: height * 0.0175,
        //                           fontFamily: "Inter",
        //                           fontWeight: FontWeight.w700,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     height: height * 0.01,
        //                   ),
        //                   Row(
        //                     children: [
        //                       SizedBox(
        //                         width: width * 0.4,
        //                         child: Text(
        //                           AppLocalizations.of(context)!
        //                               .institute_test_id,
        //                           //"Institute Test ID:",
        //                           style: TextStyle(
        //                             color: const Color.fromRGBO(102, 102, 102, 1),
        //                             fontSize: height * 0.02,
        //                             fontFamily: "Inter",
        //                             fontWeight: FontWeight.w600,
        //                           ),
        //                         ),
        //                       ),
        //                       Text(
        //                         "-----------",
        //                         style: TextStyle(
        //                           color: const Color.fromRGBO(82, 165, 160, 1),
        //                           fontSize: height * 0.0175,
        //                           fontFamily: "Inter",
        //                           fontWeight: FontWeight.w700,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     height: height * 0.01,
        //                   ),
        //                   const Divider(),
        //                   SizedBox(
        //                     height: height * 0.01,
        //                   ),
        //                   Row(
        //                     children: [
        //                       SizedBox(
        //                         width: width * 0.4,
        //                         child: Text(
        //                           AppLocalizations.of(context)!.time_permitted,
        //                           //"Time Permitted:",
        //                           style: TextStyle(
        //                             color: const Color.fromRGBO(102, 102, 102, 1),
        //                             fontSize: height * 0.02,
        //                             fontFamily: "Inter",
        //                             fontWeight: FontWeight.w600,
        //                           ),
        //                         ),
        //                       ),
        //                       Text(
        //                         assessment.assessmentDuration == null
        //                             ? "00 ${AppLocalizations.of(context)!.minutes}"
        //                             : "${assessment.assessmentDuration} ${AppLocalizations.of(context)!.minutes}",
        //                         style: TextStyle(
        //                           color: const Color.fromRGBO(82, 165, 160, 1),
        //                           fontSize: height * 0.0175,
        //                           fontFamily: "Inter",
        //                           fontWeight: FontWeight.w700,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     height: height * 0.01,
        //                   ),
        //                   Row(
        //                     children: [
        //                       SizedBox(
        //                         width: width * 0.4,
        //                         child: Text(
        //                           AppLocalizations.of(context)!.start_date_time,
        //                           //"Start Date & Time:",
        //                           style: TextStyle(
        //                             color: const Color.fromRGBO(102, 102, 102, 1),
        //                             fontSize: height * 0.02,
        //                             fontFamily: "Inter",
        //                             fontWeight: FontWeight.w600,
        //                           ),
        //                         ),
        //                       ),
        //                       finalAssessment.assessmentStartdate == null
        //                           ? Text(
        //                               "----------------------",
        //                               style: TextStyle(
        //                                 color: const Color.fromRGBO(82, 165, 160, 1),
        //                                 fontSize: height * 0.0175,
        //                                 fontFamily: "Inter",
        //                                 fontWeight: FontWeight.w700,
        //                               ),
        //                             )
        //                           : Text(
        //                               "${startDate.toString().substring(0, startDate.toString().length - 13)}      ${startDate.toString().substring(11, startDate.toString().length - 7)}",
        //                               style: TextStyle(
        //                                 color: const Color.fromRGBO(82, 165, 160, 1),
        //                                 fontSize: height * 0.0175,
        //                                 fontFamily: "Inter",
        //                                 fontWeight: FontWeight.w700,
        //                               ),
        //                             ),
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     height: height * 0.01,
        //                   ),
        //                   Row(
        //                     children: [
        //                       SizedBox(
        //                         width: width * 0.4,
        //                         child: Text(
        //                           AppLocalizations.of(context)!.end_date_time,
        //                           //"End Date & Time:",
        //                           style: TextStyle(
        //                             color: const Color.fromRGBO(102, 102, 102, 1),
        //                             fontSize: height * 0.02,
        //                             fontFamily: "Inter",
        //                             fontWeight: FontWeight.w600,
        //                           ),
        //                         ),
        //                       ),
        //                       finalAssessment.assessmentEnddate == null
        //                           ? Text(
        //                               "----------------------",
        //                               style: TextStyle(
        //                                 color: const Color.fromRGBO(82, 165, 160, 1),
        //                                 fontSize: height * 0.0175,
        //                                 fontFamily: "Inter",
        //                                 fontWeight: FontWeight.w700,
        //                               ),
        //                             )
        //                           : Text(
        //                               "${endDate.toString().substring(0, endDate.toString().length - 13)}      ${endDate.toString().substring(11, endDate.toString().length - 7)}",
        //                               style: TextStyle(
        //                                 color: const Color.fromRGBO(82, 165, 160, 1),
        //                                 fontSize: height * 0.0175,
        //                                 fontFamily: "Inter",
        //                                 fontWeight: FontWeight.w700,
        //                               ),
        //                             ),
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     height: height * 0.01,
        //                   ),
        //                   const Divider(),
        //                   SizedBox(
        //                     height: height * 0.01,
        //                   ),
        //                   additionalDetails
        //                       ? Container(
        //                           height: height * 0.05,
        //                           decoration: const BoxDecoration(
        //                             borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(8.0),
        //                                 topRight: Radius.circular(8.0)),
        //                             color: Color.fromRGBO(82, 165, 160, 1),
        //                           ),
        //                           child: Padding(
        //                             padding: EdgeInsets.only(left: width * 0.02),
        //                             child: Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 Text(
        //                                   AppLocalizations.of(context)!.time_permitted,
        //                                   //"Additional Details",
        //                                   style: TextStyle(
        //                                     color: const Color.fromRGBO(
        //                                         255, 255, 255, 1),
        //                                     fontSize: height * 0.02,
        //                                     fontFamily: "Inter",
        //                                     fontWeight: FontWeight.w700,
        //                                   ),
        //                                 ),
        //                                 Padding(
        //                                   padding:
        //                                       EdgeInsets.only(right: width * 0.02),
        //                                   child: IconButton(
        //                                     icon: const Icon(
        //                                       Icons.arrow_circle_up_outlined,
        //                                       color: Color.fromRGBO(255, 255, 255, 1),
        //                                     ),
        //                                     onPressed: () {
        //                                       showAdditionalDetails();
        //                                     },
        //                                   ),
        //                                 )
        //                               ],
        //                             ),
        //                           ),
        //                         )
        //                       : Container(
        //                           height: height * 0.05,
        //                           decoration: const BoxDecoration(
        //                             borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(8.0),
        //                                 topRight: Radius.circular(8.0)),
        //                             color: Color.fromRGBO(82, 165, 160, 1),
        //                           ),
        //                           child: Padding(
        //                             padding: EdgeInsets.only(left: width * 0.02),
        //                             child: Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 Text(
        //                                   AppLocalizations.of(context)!.additional_details,
        //                                   //"Additional Details",
        //                                   style: TextStyle(
        //                                     color: const Color.fromRGBO(
        //                                         255, 255, 255, 1),
        //                                     fontSize: height * 0.02,
        //                                     fontFamily: "Inter",
        //                                     fontWeight: FontWeight.w700,
        //                                   ),
        //                                 ),
        //                                 Padding(
        //                                   padding:
        //                                       EdgeInsets.only(right: width * 0.02),
        //                                   child: IconButton(
        //                                     icon: const Icon(
        //                                       Icons.arrow_circle_down_outlined,
        //                                       color: Color.fromRGBO(255, 255, 255, 1),
        //                                     ),
        //                                     onPressed: () {
        //                                       showAdditionalDetails();
        //                                     },
        //                                   ),
        //                                 )
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                   SizedBox(
        //                     height: height * 0.02,
        //                   ),
        //                   additionalDetails
        //                       ? Column(
        //                           children: [
        //                             Row(
        //                               children: [
        //                                 SizedBox(
        //                                   width: width * 0.4,
        //                                   child: Text(
        //                                     AppLocalizations.of(context)!.category,
        //                                     //"Category",
        //                                     style: TextStyle(
        //                                       color: const Color.fromRGBO(
        //                                           102, 102, 102, 1),
        //                                       fontSize: height * 0.02,
        //                                       fontFamily: "Inter",
        //                                       fontWeight: FontWeight.w600,
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 Text(
        //                                   "${finalAssessment.assessmentType}",
        //                                   style: TextStyle(
        //                                     color:
        //                                         const Color.fromRGBO(82, 165, 160, 1),
        //                                     fontSize: height * 0.0175,
        //                                     fontFamily: "Inter",
        //                                     fontWeight: FontWeight.w700,
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: height * 0.01,
        //                             ),
        //                             Row(
        //                               children: [
        //                                 SizedBox(
        //                                   width: width * 0.4,
        //                                   child: Text(
        //                                     AppLocalizations.of(context)!.no_of_retries_allowed,
        //                                     //"Number of Retries allowed",
        //                                     style: TextStyle(
        //                                       color: const Color.fromRGBO(
        //                                           102, 102, 102, 1),
        //                                       fontSize: height * 0.02,
        //                                       fontFamily: "Inter",
        //                                       fontWeight: FontWeight.w600,
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 Text(
        //                                   //"Allowed "
        //                                       "${AppLocalizations.of(context)!.allowed} (${finalAssessment.assessmentSettings?.allowedNumberOfTestRetries ?? "0"} Times)",
        //                                   style: TextStyle(
        //                                     color:
        //                                         const Color.fromRGBO(82, 165, 160, 1),
        //                                     fontSize: height * 0.0175,
        //                                     fontFamily: "Inter",
        //                                     fontWeight: FontWeight.w700,
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: height * 0.01,
        //                             ),
        //                             Row(
        //                               children: [
        //                                 SizedBox(
        //                                   width: width * 0.4,
        //                                   child: Text(
        //                                     AppLocalizations.of(context)!.allow_guest_Students,
        //                                     //"Allow Guest students",
        //                                     style: TextStyle(
        //                                       color: const Color.fromRGBO(
        //                                           102, 102, 102, 1),
        //                                       fontSize: height * 0.02,
        //                                       fontFamily: "Inter",
        //                                       fontWeight: FontWeight.w600,
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 Text(
        //                                   finalAssessment.assessmentSettings
        //                                               ?.allowGuestStudent ==
        //                                           null
        //                                       ? AppLocalizations.of(context)!.not_allowed
        //                                   //"Not Allowed"
        //                                       : finalAssessment.assessmentSettings!
        //                                               .allowGuestStudent!
        //                                           ? AppLocalizations.of(context)!.allowed
        //                                   //"Allowed"
        //                                           :  AppLocalizations.of(context)!.not_allowed,
        //                                  // "Not Allowed",
        //                                   style: TextStyle(
        //                                     color:
        //                                         const Color.fromRGBO(82, 165, 160, 1),
        //                                     fontSize: height * 0.0175,
        //                                     fontFamily: "Inter",
        //                                     fontWeight: FontWeight.w700,
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: height * 0.01,
        //                             ),
        //                             Row(
        //                               children: [
        //                                 SizedBox(
        //                                   width: width * 0.4,
        //                                   child: Text(
        //                                       AppLocalizations.of(context)!.show_answersheet_after_test,
        //                                     //"Show answer Sheet after test",
        //                                     style: TextStyle(
        //                                       color: const Color.fromRGBO(
        //                                           102, 102, 102, 1),
        //                                       fontSize: height * 0.02,
        //                                       fontFamily: "Inter",
        //                                       fontWeight: FontWeight.w600,
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 Text(
        //                                   finalAssessment.assessmentSettings
        //                                               ?.showSolvedAnswerSheetInAdvisor ==
        //                                           null
        //                                       ? AppLocalizations.of(context)!.not_viewable
        //                                         //"Not Viewable"
        //                                       : finalAssessment.assessmentSettings!
        //                                               .showSolvedAnswerSheetInAdvisor!
        //                                           ? AppLocalizations.of(context)!.viewable
        //                                           //"Viewable"
        //                                           : AppLocalizations.of(context)!.not_viewable,
        //                                             // "Not Viewable",
        //                                   style: TextStyle(
        //                                     color:
        //                                         const Color.fromRGBO(82, 165, 160, 1),
        //                                     fontSize: height * 0.0175,
        //                                     fontFamily: "Inter",
        //                                     fontWeight: FontWeight.w700,
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: height * 0.01,
        //                             ),
        //                             Row(
        //                               children: [
        //                                 SizedBox(
        //                                   width: width * 0.4,
        //                                   child: Text(
        //                                   AppLocalizations.of(context)!.show_my_advisor_name,
        //                                   //"Show my name in Advisor",
        //                                     style: TextStyle(
        //                                       color: const Color.fromRGBO(
        //                                           102, 102, 102, 1),
        //                                       fontSize: height * 0.02,
        //                                       fontFamily: "Inter",
        //                                       fontWeight: FontWeight.w600,
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 Text(
        //                                   assessment.assessmentSettings!
        //                                               .showAdvisorName ==
        //                                           false
        //                                       ? AppLocalizations.of(context)!.no
        //                                     //"No"
        //                                       : assessment.assessmentSettings!
        //                                               .showAdvisorName!
        //                                           ? assessment.assessmentSettings!.advisorName??''
        //                                             //"Yes"
        //                                           :  AppLocalizations.of(context)!.no,
        //                                             //"No",
        //                                   style: TextStyle(
        //                                     color:
        //                                         const Color.fromRGBO(82, 165, 160, 1),
        //                                     fontSize: height * 0.0175,
        //                                     fontFamily: "Inter",
        //                                     fontWeight: FontWeight.w700,
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: height * 0.01,
        //                             ),
        //                             Row(
        //                               children: [
        //                                 SizedBox(
        //                                   width: width * 0.4,
        //                                   child: Text(
        //                                   AppLocalizations.of(context)!.show_my_email,
        //                                   //"Show my Email in Advisor",
        //                                     style: TextStyle(
        //                                       color: const Color.fromRGBO(
        //                                           102, 102, 102, 1),
        //                                       fontSize: height * 0.02,
        //                                       fontFamily: "Inter",
        //                                       fontWeight: FontWeight.w600,
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 Text(
        //                                   assessment.assessmentSettings
        //                                               ?.showAdvisorEmail ==
        //                                           false
        //                                       ? AppLocalizations.of(context)!.no
        //                                         //"No"
        //                                       : assessment.assessmentSettings!
        //                                               .showAdvisorEmail!
        //                                           ?  assessment.assessmentSettings!.advisorEmail??''
        //                                           : AppLocalizations.of(context)!.no,
        //                                             //"No",
        //                                   style: TextStyle(
        //                                     color:
        //                                         const Color.fromRGBO(82, 165, 160, 1),
        //                                     fontSize: height * 0.0175,
        //                                     fontFamily: "Inter",
        //                                     fontWeight: FontWeight.w700,
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: height * 0.01,
        //                             ),
        //                             Row(
        //                               children: [
        //                                 SizedBox(
        //                                   width: width * 0.4,
        //                                   child: Column(
        //                                       crossAxisAlignment:
        //                                           CrossAxisAlignment.start,
        //                                       children: [
        //                                         Text(
        //                                               AppLocalizations.of(context)!.in_active,
        //                                              //"Inactive",
        //                                           style: TextStyle(
        //                                             color: const Color.fromRGBO(
        //                                                 51, 51, 51, 1),
        //                                             fontSize: height * 0.015,
        //                                             fontFamily: "Inter",
        //                                             fontWeight: FontWeight.w700,
        //                                           ),
        //                                         ),
        //                                         Text(
        //                                           AppLocalizations.of(context)!.not_available_for_student,
        //                                           //"Not available for student",
        //                                           style: TextStyle(
        //                                             color: const Color.fromRGBO(
        //                                                 153, 153, 153, 0.8),
        //                                             fontSize: height * 0.015,
        //                                             fontFamily: "Inter",
        //                                             fontWeight: FontWeight.w700,
        //                                           ),
        //                                         ),
        //                                       ]),
        //                                 ),
        //                                 Text(
        //                                   assessment.assessmentSettings
        //                                               ?.notAvailable ==
        //                                           false
        //                                       ? AppLocalizations.of(context)!.no
        //                                         //"No"
        //                                       : AppLocalizations.of(context)!.yes,
        //                                         //"Yes",
        //                                   style: TextStyle(
        //                                     color:
        //                                         const Color.fromRGBO(82, 165, 160, 1),
        //                                     fontSize: height * 0.0175,
        //                                     fontFamily: "Inter",
        //                                     fontWeight: FontWeight.w700,
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: height * 0.01,
        //                             ),
        //                             Row(children: [
        //                               SizedBox(
        //                                 width: width * 0.4,
        //                                 child: Column(
        //                                     crossAxisAlignment:
        //                                         CrossAxisAlignment.start,
        //                                     children: [
        //                                       Text(
        //                                       AppLocalizations.of(context)!.allow_public_access,
        //                                       //"Allow  Public access ",
        //                                         style: TextStyle(
        //                                           color: const Color.fromRGBO(
        //                                               51, 51, 51, 1),
        //                                           fontSize: height * 0.015,
        //                                           fontFamily: "Inter",
        //                                           fontWeight: FontWeight.w700,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         AppLocalizations.of(context)!.available_to_public,
        //                                         //"Available to public for practice",
        //                                         style: TextStyle(
        //                                           color: const Color.fromRGBO(
        //                                               153, 153, 153, 0.8),
        //                                           fontSize: height * 0.015,
        //                                           fontFamily: "Inter",
        //                                           fontWeight: FontWeight.w700,
        //                                         ),
        //                                       ),
        //                                     ]),
        //                               ),
        //                               Text(
        //                                 finalAssessment.assessmentSettings
        //                                             ?.avalabilityForPractice ==
        //                                         null
        //                                     ? AppLocalizations.of(context)!.no
        //                                         //"No"
        //                                     : finalAssessment.assessmentSettings!
        //                                             .avalabilityForPractice!
        //                                         ? AppLocalizations.of(context)!.yes
        //                                               //"Yes"
        //                                         : AppLocalizations.of(context)!.no,
        //                                           //"No",
        //                                 style: TextStyle(
        //                                   color:
        //                                       const Color.fromRGBO(82, 165, 160, 1),
        //                                   fontSize: height * 0.0175,
        //                                   fontFamily: "Inter",
        //                                   fontWeight: FontWeight.w700,
        //                                 ),
        //                               ),
        //                             ])
        //                           ],
        //                         )
        //                       : const SizedBox(
        //                           height: 0,
        //                         ),
        //                   SizedBox(
        //                     height: height * 0.03,
        //                   ),
        //                   questionShirnk
        //                       ? Container(
        //                           height: height * 0.05,
        //                           decoration: const BoxDecoration(
        //                             borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(8.0),
        //                                 topRight: Radius.circular(8.0)),
        //                             color: Color.fromRGBO(82, 165, 160, 1),
        //                           ),
        //                           child: Padding(
        //                             padding: EdgeInsets.only(left: width * 0.02),
        //                             child: Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 Text(
        //                                     AppLocalizations.of(context)!.qn_button,
        //                                   //"Questions",
        //                                   style: TextStyle(
        //                                     color: const Color.fromRGBO(
        //                                         255, 255, 255, 1),
        //                                     fontSize: height * 0.02,
        //                                     fontFamily: "Inter",
        //                                     fontWeight: FontWeight.w700,
        //                                   ),
        //                                 ),
        //                                 Padding(
        //                                   padding:
        //                                       EdgeInsets.only(right: width * 0.02),
        //                                   child: IconButton(
        //                                     onPressed: () {
        //                                       showQuestionDetails();
        //                                     },
        //                                     icon: const Icon(
        //                                       Icons.arrow_circle_up_outlined,
        //                                       color: Color.fromRGBO(255, 255, 255, 1),
        //                                     ),
        //                                   ),
        //                                 )
        //                               ],
        //                             ),
        //                           ),
        //                         )
        //                       : Container(
        //                           height: height * 0.05,
        //                           decoration: const BoxDecoration(
        //                             borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(8.0),
        //                                 topRight: Radius.circular(8.0)),
        //                             color: Color.fromRGBO(82, 165, 160, 1),
        //                           ),
        //                           child: Padding(
        //                             padding: EdgeInsets.only(left: width * 0.02),
        //                             child: Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 Text(
        //                                    AppLocalizations.of(context)!.qn_button,
        //                                   //"Questions",
        //                                   style: TextStyle(
        //                                     color: const Color.fromRGBO(
        //                                         255, 255, 255, 1),
        //                                     fontSize: height * 0.02,
        //                                     fontFamily: "Inter",
        //                                     fontWeight: FontWeight.w700,
        //                                   ),
        //                                 ),
        //                                 Padding(
        //                                   padding:
        //                                       EdgeInsets.only(right: width * 0.02),
        //                                   child: IconButton(
        //                                     onPressed: () {
        //                                       showQuestionDetails();
        //                                     },
        //                                     icon: const Icon(
        //                                       Icons.arrow_circle_down_outlined,
        //                                       color: Color.fromRGBO(255, 255, 255, 1),
        //                                     ),
        //                                   ),
        //                                 )
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                   questionShirnk
        //                       ? SizedBox(
        //                           height: height * 0.4,
        //                           child: ListView.builder(
        //                               padding: EdgeInsets.zero,
        //                               itemCount: assessment.questions!.length,
        //                               itemBuilder: (context, index) => QuestionWidget(
        //                                     height: height,
        //                                     question: assessment.questions![index],
        //                                   )),
        //                         )
        //                       : const SizedBox(
        //                           height: 0,
        //                         ),
        //                   SizedBox(
        //                     height: height * 0.02,
        //                   ),
        //                   Row(
        //                     children: [
        //                       const Expanded(child: Divider()),
        //                       MouseRegion(
        //                           cursor: SystemMouseCursors.click,
        //                           child: GestureDetector(
        //                         onTap: () {
        //                           showQuestionDetails();
        //                         },
        //                         child: Text(
        //                             AppLocalizations.of(context)!.view_all_qns,
        //                           //"  View All Questions  ",
        //                           style: TextStyle(
        //                             color: const Color.fromRGBO(28, 78, 80, 1),
        //                             fontSize: height * 0.02,
        //                             fontFamily: "Inter",
        //                             fontWeight: FontWeight.w700,
        //                           ),
        //                         ),
        //                       )),
        //                       // IconButton(
        //                       //   onPressed: () {
        //                       //     showQuestionDetails();
        //                       //   },
        //                       //   icon: const Icon(
        //                       //     Icons.keyboard_arrow_down_sharp,
        //                       //     color: Color.fromRGBO(28, 78, 80, 1),
        //                       //   ),
        //                       // ),
        //                       const Expanded(child: Divider()),
        //                     ],
        //                   ),
        //                   // WEB,Android App and IOS App
        //
        //                   // SizedBox(
        //                   //   height: height * 0.02,
        //                   // ),
        //                   // Row(
        //                   //   children: [
        //                   //     Container(
        //                   //       height: height * 0.08,
        //                   //       width: width * 0.28,
        //                   //       decoration: const BoxDecoration(
        //                   //         border: Border(
        //                   //           right: BorderSide(
        //                   //             width: 1,
        //                   //             color: Color.fromRGBO(232, 232, 232, 1),
        //                   //           ),
        //                   //         ),
        //                   //       ),
        //                   //       child: Center(
        //                   //         child: Text(
        //                   //           "WEB",
        //                   //           textAlign: TextAlign.center,
        //                   //           style: TextStyle(
        //                   //             decoration: TextDecoration.underline,
        //                   //             color: const Color.fromRGBO(153, 153, 153, 1),
        //                   //             fontSize: height * 0.015,
        //                   //             fontFamily: "Inter",
        //                   //             fontWeight: FontWeight.w400,
        //                   //           ),
        //                   //         ),
        //                   //       ),
        //                   //     ),
        //                   //     Expanded(
        //                   //       child: SizedBox(
        //                   //         height: height * 0.08,
        //                   //         width: width * 0.3,
        //                   //         child: Center(
        //                   //           child: Text(
        //                   //             "Android App",
        //                   //             textAlign: TextAlign.center,
        //                   //             style: TextStyle(
        //                   //               decoration: TextDecoration.underline,
        //                   //               color: const Color.fromRGBO(153, 153, 153, 1),
        //                   //               fontSize: height * 0.015,
        //                   //               fontFamily: "Inter",
        //                   //               fontWeight: FontWeight.w400,
        //                   //             ),
        //                   //           ),
        //                   //         ),
        //                   //       ),
        //                   //     ),
        //                   //     Container(
        //                   //       height: height * 0.08,
        //                   //       width: width * 0.28,
        //                   //       decoration: const BoxDecoration(
        //                   //         border: Border(
        //                   //           left: BorderSide(
        //                   //             width: 1,
        //                   //             color: Color.fromRGBO(232, 232, 232, 1),
        //                   //           ),
        //                   //         ),
        //                   //       ),
        //                   //       child: Center(
        //                   //         child: Text(
        //                   //           "IOS App",
        //                   //           textAlign: TextAlign.center,
        //                   //           style: TextStyle(
        //                   //             decoration: TextDecoration.underline,
        //                   //             color: const Color.fromRGBO(153, 153, 153, 1),
        //                   //             fontSize: height * 0.015,
        //                   //             fontFamily: "Inter",
        //                   //             fontWeight: FontWeight.w400,
        //                   //           ),
        //                   //         ),
        //                   //       ),
        //                   //     )
        //                   //   ],
        //                   // ),
        //                   SizedBox(
        //                     height: height * 0.03,
        //                   ),
        //                   widget.assessmentType=='myAssessment'?
        //                   Center(
        //                     child: SizedBox(
        //                       width: width * 0.888,
        //                       child: ElevatedButton(
        //                         style: ElevatedButton.styleFrom(
        //                             backgroundColor:
        //                             const Color.fromRGBO(255, 255, 255, 1),
        //                             minimumSize: const Size(280, 48),
        //                             shape: RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.circular(39),
        //                             ),
        //                             side: const BorderSide(
        //                               color: Color.fromRGBO(82, 165, 160, 1),
        //                             )),
        //                         onPressed: () {
        //                           // Provider.of<CreateAssessmentProvider>(context, listen: false)
        //                           //     .getAssessment;
        //                           Navigator.pushNamed(context, '/teacherAssessmentSettingPublish',arguments: 'editActive',);
        //                         },
        //                         child: Text(
        //                           'Edit',
        //                           style: TextStyle(
        //                               fontSize: height * 0.025,
        //                               fontFamily: "Inter",
        //                               color: const Color.fromRGBO(82, 165, 160, 1),
        //                               fontWeight: FontWeight.w600),
        //                         ),
        //                       ),
        //                     ),
        //                   ):
        //                   const SizedBox(height: 0,),
        //                   SizedBox(
        //                     height: height * 0.03,
        //                   ),
        //
        //
        //                   Center(
        //                     child: SizedBox(
        //                       width: width * 0.888,
        //                       child: ElevatedButton(
        //                         style: ElevatedButton.styleFrom(
        //                             backgroundColor:
        //                                 const Color.fromRGBO(82, 165, 160, 1),
        //                             minimumSize: const Size(280, 48),
        //                             shape: RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.circular(39),
        //                             ),
        //                             side: const BorderSide(
        //                               color: Color.fromRGBO(82, 165, 160, 1),
        //                             )),
        //                         //shape: StadiumBorder(),
        //                         onPressed: () {
        //                           Navigator.pushNamed(context, '/teacherClonedAssessment',arguments: 'clone',);
        //                           // Navigator.push(
        //                           //   context,
        //                           //   PageTransition(
        //                           //     type: PageTransitionType.rightToLeft,
        //                           //     child: TeacherClonedAssessment(
        //                           //         ),
        //                           //   ),
        //                           // );
        //                         },
        //                         child: Text(
        //                             AppLocalizations.of(context)!.clone_qn,
        //                             //'Clone',
        //                           style: TextStyle(
        //                               fontSize: height * 0.025,
        //                               fontFamily: "Inter",
        //                               color: const Color.fromRGBO(255, 255, 255, 1),
        //                               fontWeight: FontWeight.w600),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: height * 0.03,
        //                   ),
        //                 ],
        //               )),
        //         ),
        //       ));
        // }
        if(constraints.maxWidth > 500)
        {
          print("INSIDE TABLET");
          print(constraints.maxWidth);
          return

            Center(
              child: WillPopScope(
                onWillPop: () async => false,
                child: SizedBox(
                  width: 400.0,
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
                              AppLocalizations.of(context)!.active,
                              //"ACTIVE",
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontSize: height * 0.0225,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.assessment_caps,
                              // "ASSESSMENTS",
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
                              SizedBox(
                                height: height * 0.01,
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(8.0)),
                                    border: Border.all(
                                      color: const Color.fromRGBO(217, 217, 217, 1),
                                    ),
                                    color: Colors.white,
                                  ),
                                  height: height * 0.1675,
                                  width: width * 0.888,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: height * 0.037,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0)),
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: width * 0.02),
                                          child: Row(
                                            children: [
                                              Text(
                                                assessment.subject!,
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "  |  ${assessment.getAssessmentModelClass!}",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: width * 0.02),
                                            child: const Icon(
                                              Icons.circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "${assessment.topic!} - ${assessment.subTopic!}",
                                            style: TextStyle(
                                              color:
                                                  const Color.fromRGBO(102, 102, 102, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: width * 0.02),
                                            child: const Icon(
                                              Icons.circle,
                                              color: Color.fromRGBO(60, 176, 0, 1),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  color: Color.fromRGBO(204, 204, 204, 1),
                                                ),
                                              ),
                                              color: Colors.white,
                                            ),
                                            width: width * 0.44,
                                            height: height * 0.0875,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "$mark",
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        28, 78, 80, 1),
                                                    fontSize: height * 0.03,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                    AppLocalizations.of(context)!
                                                        .marks,
                                                  //"Marks",
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.44,
                                            height: height * 0.0875,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "${assessment.questions!.length}",
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        28, 78, 80, 1),
                                                    fontSize: height * 0.03,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!.qn_button,
                                                  //"Questions",
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.025,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context)!.assessment_id_caps,
                                      //"Assessment ID:",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    assessment.assessmentCode!,
                                    style: TextStyle(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontSize: height * 0.0175,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .institute_test_id,
                                      //"Institute Test ID:",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "-----------",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontSize: height * 0.0175,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              const Divider(),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context)!.time_permitted,
                                      //"Time Permitted:",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    assessment.assessmentDuration == null
                                        ? "00 ${AppLocalizations.of(context)!.minutes}"
                                        : "${assessment.assessmentDuration} ${AppLocalizations.of(context)!.minutes}",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontSize: height * 0.0175,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context)!.start_date_time,
                                      //"Start Date & Time:",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  finalAssessment.assessmentStartdate == null
                                      ? Text(
                                          "----------------------",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      : Text(
                                          "${startDate.toString().substring(0, startDate.toString().length - 13)}      ${startDate.toString().substring(11, startDate.toString().length - 7)}",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context)!.end_date_time,
                                      //"End Date & Time:",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  finalAssessment.assessmentEnddate == null
                                      ? Text(
                                          "----------------------",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      : Text(
                                          "${endDate.toString().substring(0, endDate.toString().length - 13)}      ${endDate.toString().substring(11, endDate.toString().length - 7)}",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              const Divider(),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              additionalDetails
                                  ? Container(
                                      height: height * 0.05,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: width * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!.time_permitted,
                                              //"Additional Details",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontSize: height * 0.02,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: width * 0.02),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_circle_up_outlined,
                                                  color: Color.fromRGBO(255, 255, 255, 1),
                                                ),
                                                onPressed: () {
                                                  showAdditionalDetails();
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: height * 0.05,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: width * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!.additional_details,
                                              //"Additional Details",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontSize: height * 0.02,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: width * 0.02),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_circle_down_outlined,
                                                  color: Color.fromRGBO(255, 255, 255, 1),
                                                ),
                                                onPressed: () {
                                                  showAdditionalDetails();
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              additionalDetails
                                  ? Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.4,
                                              child: Text(
                                                AppLocalizations.of(context)!.category,
                                                //"Category",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "${finalAssessment.assessmentType}",
                                              style: TextStyle(
                                                color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.4,
                                              child: Text(
                                                AppLocalizations.of(context)!.no_of_retries_allowed,
                                                //"Number of Retries allowed",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              //"Allowed "
                                                  "${AppLocalizations.of(context)!.allowed} (${finalAssessment.assessmentSettings?.allowedNumberOfTestRetries ?? "0"} Times)",
                                              style: TextStyle(
                                                color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.4,
                                              child: Text(
                                                AppLocalizations.of(context)!.allow_guest_Students,
                                                //"Allow Guest students",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              finalAssessment.assessmentSettings
                                                          ?.allowGuestStudent ==
                                                      null
                                                  ? AppLocalizations.of(context)!.not_allowed
                                              //"Not Allowed"
                                                  : finalAssessment.assessmentSettings!
                                                          .allowGuestStudent!
                                                      ? AppLocalizations.of(context)!.allowed
                                              //"Allowed"
                                                      :  AppLocalizations.of(context)!.not_allowed,
                                             // "Not Allowed",
                                              style: TextStyle(
                                                color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.4,
                                              child: Text(
                                                  AppLocalizations.of(context)!.show_answersheet_after_test,
                                                //"Show answer Sheet after test",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              finalAssessment.assessmentSettings
                                                          ?.showSolvedAnswerSheetInAdvisor ==
                                                      null
                                                  ? AppLocalizations.of(context)!.not_viewable
                                                    //"Not Viewable"
                                                  : finalAssessment.assessmentSettings!
                                                          .showSolvedAnswerSheetInAdvisor!
                                                      ? AppLocalizations.of(context)!.viewable
                                                      //"Viewable"
                                                      : AppLocalizations.of(context)!.not_viewable,
                                                        // "Not Viewable",
                                              style: TextStyle(
                                                color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.4,
                                              child: Text(
                                              AppLocalizations.of(context)!.show_my_advisor_name,
                                              //"Show my name in Advisor",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              assessment.assessmentSettings!
                                                          .showAdvisorName ==
                                                      false
                                                  ? AppLocalizations.of(context)!.no
                                                //"No"
                                                  : assessment.assessmentSettings!
                                                          .showAdvisorName!
                                                      ? assessment.assessmentSettings!.advisorName??''
                                                        //"Yes"
                                                      :  AppLocalizations.of(context)!.no,
                                                        //"No",
                                              style: TextStyle(
                                                color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.4,
                                              child: Text(
                                              AppLocalizations.of(context)!.show_my_email,
                                              //"Show my Email in Advisor",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              assessment.assessmentSettings
                                                          ?.showAdvisorEmail ==
                                                      false
                                                  ? AppLocalizations.of(context)!.no
                                                    //"No"
                                                  : assessment.assessmentSettings!
                                                          .showAdvisorEmail!
                                                      ?  assessment.assessmentSettings!.advisorEmail??''
                                                      : AppLocalizations.of(context)!.no,
                                                        //"No",
                                              style: TextStyle(
                                                color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.4,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                          AppLocalizations.of(context)!.in_active,
                                                         //"Inactive",
                                                      style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            51, 51, 51, 1),
                                                        fontSize: height * 0.015,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(context)!.not_available_for_student,
                                                      //"Not available for student",
                                                      style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            153, 153, 153, 0.8),
                                                        fontSize: height * 0.015,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                            Text(
                                              assessment.assessmentSettings
                                                          ?.notAvailable ==
                                                      false
                                                  ? AppLocalizations.of(context)!.no
                                                    //"No"
                                                  : AppLocalizations.of(context)!.yes,
                                                    //"Yes",
                                              style: TextStyle(
                                                color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Row(children: [
                                          SizedBox(
                                            width: width * 0.4,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                  AppLocalizations.of(context)!.allow_public_access,
                                                  //"Allow  Public access ",
                                                    style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          51, 51, 51, 1),
                                                      fontSize: height * 0.015,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(context)!.available_to_public,
                                                    //"Available to public for practice",
                                                    style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          153, 153, 153, 0.8),
                                                      fontSize: height * 0.015,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                          Text(
                                            finalAssessment.assessmentSettings
                                                        ?.avalabilityForPractice ==
                                                    null
                                                ? AppLocalizations.of(context)!.no
                                                    //"No"
                                                : finalAssessment.assessmentSettings!
                                                        .avalabilityForPractice!
                                                    ? AppLocalizations.of(context)!.yes
                                                          //"Yes"
                                                    : AppLocalizations.of(context)!.no,
                                                      //"No",
                                            style: TextStyle(
                                              color:
                                                  const Color.fromRGBO(82, 165, 160, 1),
                                              fontSize: height * 0.0175,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ])
                                      ],
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              questionShirnk
                                  ? Container(
                                      height: height * 0.05,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: width * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                AppLocalizations.of(context)!.qn_button,
                                              //"Questions",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontSize: height * 0.02,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: width * 0.02),
                                              child: IconButton(
                                                onPressed: () {
                                                  showQuestionDetails();
                                                },
                                                icon: const Icon(
                                                  Icons.arrow_circle_up_outlined,
                                                  color: Color.fromRGBO(255, 255, 255, 1),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: height * 0.05,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: width * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                               AppLocalizations.of(context)!.qn_button,
                                              //"Questions",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontSize: height * 0.02,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: width * 0.02),
                                              child: IconButton(
                                                onPressed: () {
                                                  showQuestionDetails();
                                                },
                                                icon: const Icon(
                                                  Icons.arrow_circle_down_outlined,
                                                  color: Color.fromRGBO(255, 255, 255, 1),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                              questionShirnk
                                  ? SizedBox(
                                      height: height * 0.4,
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: assessment.questions!.length,
                                          itemBuilder: (context, index) => QuestionWidget(
                                                height: height,
                                                question: assessment.questions![index],
                                              )),
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                children: [
                                  const Expanded(child: Divider()),
                                  MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                    onTap: () {
                                      showQuestionDetails();
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.view_all_qns,
                                      //"  View All Questions  ",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     showQuestionDetails();
                                  //   },
                                  //   icon: const Icon(
                                  //     Icons.keyboard_arrow_down_sharp,
                                  //     color: Color.fromRGBO(28, 78, 80, 1),
                                  //   ),
                                  // ),
                                  const Expanded(child: Divider()),
                                ],
                              ),
                              // WEB,Android App and IOS App

                              // SizedBox(
                              //   height: height * 0.02,
                              // ),
                              // Row(
                              //   children: [
                              //     Container(
                              //       height: height * 0.08,
                              //       width: width * 0.28,
                              //       decoration: const BoxDecoration(
                              //         border: Border(
                              //           right: BorderSide(
                              //             width: 1,
                              //             color: Color.fromRGBO(232, 232, 232, 1),
                              //           ),
                              //         ),
                              //       ),
                              //       child: Center(
                              //         child: Text(
                              //           "WEB",
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(
                              //             decoration: TextDecoration.underline,
                              //             color: const Color.fromRGBO(153, 153, 153, 1),
                              //             fontSize: height * 0.015,
                              //             fontFamily: "Inter",
                              //             fontWeight: FontWeight.w400,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: SizedBox(
                              //         height: height * 0.08,
                              //         width: width * 0.3,
                              //         child: Center(
                              //           child: Text(
                              //             "Android App",
                              //             textAlign: TextAlign.center,
                              //             style: TextStyle(
                              //               decoration: TextDecoration.underline,
                              //               color: const Color.fromRGBO(153, 153, 153, 1),
                              //               fontSize: height * 0.015,
                              //               fontFamily: "Inter",
                              //               fontWeight: FontWeight.w400,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Container(
                              //       height: height * 0.08,
                              //       width: width * 0.28,
                              //       decoration: const BoxDecoration(
                              //         border: Border(
                              //           left: BorderSide(
                              //             width: 1,
                              //             color: Color.fromRGBO(232, 232, 232, 1),
                              //           ),
                              //         ),
                              //       ),
                              //       child: Center(
                              //         child: Text(
                              //           "IOS App",
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(
                              //             decoration: TextDecoration.underline,
                              //             color: const Color.fromRGBO(153, 153, 153, 1),
                              //             fontSize: height * 0.015,
                              //             fontFamily: "Inter",
                              //             fontWeight: FontWeight.w400,
                              //           ),
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              widget.assessmentType=='myAssessment'?
                              Center(
                                child: SizedBox(
                                  width: width * 0.888,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                        minimumSize: const Size(280, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(39),
                                        ),
                                        side: const BorderSide(
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                        )),
                                    onPressed: () {
                                      // Provider.of<CreateAssessmentProvider>(context, listen: false)
                                      //     .getAssessment;
                                      Navigator.pushNamed(context, '/teacherAssessmentSettingPublish',arguments: 'editActive',);
                                    },
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontSize: height * 0.025,
                                          fontFamily: "Inter",
                                          color: const Color.fromRGBO(82, 165, 160, 1),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ):
                              const SizedBox(height: 0,),
                              SizedBox(
                                height: height * 0.03,
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
                                    //shape: StadiumBorder(),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/teacherClonedAssessment',arguments: 'clone',);
                                      // Navigator.push(
                                      //   context,
                                      //   PageTransition(
                                      //     type: PageTransitionType.rightToLeft,
                                      //     child: TeacherClonedAssessment(
                                      //         ),
                                      //   ),
                                      // );
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.clone_qn,
                                        //'Clone',
                                      style: TextStyle(
                                          fontSize: height * 0.025,
                                          fontFamily: "Inter",
                                          color: const Color.fromRGBO(255, 255, 255, 1),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                            ],
                          )),
                    ),
                  ),
                )),
            );
        }
        else {
          print("INSIDE MOBILE");
          print(constraints.maxWidth);
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
                          AppLocalizations.of(context)!.active,
                          //"ACTIVE",
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: height * 0.0225,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.assessment_caps,
                          // "ASSESSMENTS",
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
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8.0)),
                                border: Border.all(
                                  color: const Color.fromRGBO(217, 217, 217, 1),
                                ),
                                color: Colors.white,
                              ),
                              height: height * 0.1675,
                              width: width * 0.888,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: height * 0.037,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0)),
                                      color: Color.fromRGBO(82, 165, 160, 1),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: width * 0.02),
                                      child: Row(
                                        children: [
                                          Text(
                                            assessment.subject!,
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontSize: height * 0.02,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "  |  ${assessment.getAssessmentModelClass!}",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: width * 0.02),
                                        child: const Icon(
                                          Icons.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${assessment.topic!} - ${assessment.subTopic!}",
                                        style: TextStyle(
                                          color:
                                              const Color.fromRGBO(102, 102, 102, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: width * 0.02),
                                        child: const Icon(
                                          Icons.circle,
                                          color: Color.fromRGBO(60, 176, 0, 1),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                              color: Color.fromRGBO(204, 204, 204, 1),
                                            ),
                                          ),
                                          color: Colors.white,
                                        ),
                                        width: width * 0.44,
                                        height: height * 0.0875,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "$mark",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontSize: height * 0.03,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .marks,
                                              //"Marks",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.44,
                                        height: height * 0.0875,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "${assessment.questions!.length}",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontSize: height * 0.03,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.qn_button,
                                              //"Questions",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.4,
                                child: Text(
                                  AppLocalizations.of(context)!.assessment_id_caps,
                                  //"Assessment ID:",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                assessment.assessmentCode!,
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.4,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .institute_test_id,
                                  //"Institute Test ID:",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "-----------",
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          const Divider(),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.4,
                                child: Text(
                                  AppLocalizations.of(context)!.time_permitted,
                                  //"Time Permitted:",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                assessment.assessmentDuration == null
                                    ? "00 ${AppLocalizations.of(context)!.minutes}"
                                    : "${assessment.assessmentDuration} ${AppLocalizations.of(context)!.minutes}",
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.4,
                                child: Text(
                                  AppLocalizations.of(context)!.start_date_time,
                                  //"Start Date & Time:",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              finalAssessment.assessmentStartdate == null
                                  ? Text(
                                      "----------------------",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontSize: height * 0.0175,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : Text(
                                      "${startDate.toString().substring(0, startDate.toString().length - 13)}      ${startDate.toString().substring(11, startDate.toString().length - 7)}",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontSize: height * 0.0175,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.4,
                                child: Text(
                                  AppLocalizations.of(context)!.end_date_time,
                                  //"End Date & Time:",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              finalAssessment.assessmentEnddate == null
                                  ? Text(
                                      "----------------------",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontSize: height * 0.0175,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : Text(
                                      "${endDate.toString().substring(0, endDate.toString().length - 13)}      ${endDate.toString().substring(11, endDate.toString().length - 7)}",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontSize: height * 0.0175,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          const Divider(),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          additionalDetails
                              ? Container(
                                  height: height * 0.05,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0)),
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: width * 0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.time_permitted,
                                          //"Additional Details",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(right: width * 0.02),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.arrow_circle_up_outlined,
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                            ),
                                            onPressed: () {
                                              showAdditionalDetails();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: height * 0.05,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0)),
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: width * 0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.additional_details,
                                          //"Additional Details",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(right: width * 0.02),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.arrow_circle_down_outlined,
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                            ),
                                            onPressed: () {
                                              showAdditionalDetails();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          additionalDetails
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Text(
                                            AppLocalizations.of(context)!.category,
                                            //"Category",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.02,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${finalAssessment.assessmentType}",
                                          style: TextStyle(
                                            color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Text(
                                            AppLocalizations.of(context)!.no_of_retries_allowed,
                                            //"Number of Retries allowed",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.02,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          //"Allowed "
                                              "${AppLocalizations.of(context)!.allowed} (${finalAssessment.assessmentSettings?.allowedNumberOfTestRetries ?? "0"} Times)",
                                          style: TextStyle(
                                            color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Text(
                                            AppLocalizations.of(context)!.allow_guest_Students,
                                            //"Allow Guest students",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.02,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          finalAssessment.assessmentSettings
                                                      ?.allowGuestStudent ==
                                                  null
                                              ? AppLocalizations.of(context)!.not_allowed
                                          //"Not Allowed"
                                              : finalAssessment.assessmentSettings!
                                                      .allowGuestStudent!
                                                  ? AppLocalizations.of(context)!.allowed
                                          //"Allowed"
                                                  :  AppLocalizations.of(context)!.not_allowed,
                                         // "Not Allowed",
                                          style: TextStyle(
                                            color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Text(
                                              AppLocalizations.of(context)!.show_answersheet_after_test,
                                            //"Show answer Sheet after test",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.02,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          finalAssessment.assessmentSettings
                                                      ?.showSolvedAnswerSheetInAdvisor ==
                                                  null
                                              ? AppLocalizations.of(context)!.not_viewable
                                                //"Not Viewable"
                                              : finalAssessment.assessmentSettings!
                                                      .showSolvedAnswerSheetInAdvisor!
                                                  ? AppLocalizations.of(context)!.viewable
                                                  //"Viewable"
                                                  : AppLocalizations.of(context)!.not_viewable,
                                                    // "Not Viewable",
                                          style: TextStyle(
                                            color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Text(
                                          AppLocalizations.of(context)!.show_my_advisor_name,
                                          //"Show my name in Advisor",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.02,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          assessment.assessmentSettings!
                                                      .showAdvisorName ==
                                                  false
                                              ? AppLocalizations.of(context)!.no
                                            //"No"
                                              : assessment.assessmentSettings!
                                                      .showAdvisorName!
                                                  ? assessment.assessmentSettings!.advisorName??''
                                                    //"Yes"
                                                  :  AppLocalizations.of(context)!.no,
                                                    //"No",
                                          style: TextStyle(
                                            color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Text(
                                          AppLocalizations.of(context)!.show_my_email,
                                          //"Show my Email in Advisor",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.02,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          assessment.assessmentSettings
                                                      ?.showAdvisorEmail ==
                                                  false
                                              ? AppLocalizations.of(context)!.no
                                                //"No"
                                              : assessment.assessmentSettings!
                                                      .showAdvisorEmail!
                                                  ?  assessment.assessmentSettings!.advisorEmail??''
                                                  : AppLocalizations.of(context)!.no,
                                                    //"No",
                                          style: TextStyle(
                                            color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                      AppLocalizations.of(context)!.in_active,
                                                     //"Inactive",
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        51, 51, 51, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!.not_available_for_student,
                                                  //"Not available for student",
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        153, 153, 153, 0.8),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        Text(
                                          assessment.assessmentSettings
                                                      ?.notAvailable ==
                                                  false
                                              ? AppLocalizations.of(context)!.no
                                                //"No"
                                              : AppLocalizations.of(context)!.yes,
                                                //"Yes",
                                          style: TextStyle(
                                            color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Row(children: [
                                      SizedBox(
                                        width: width * 0.4,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                              AppLocalizations.of(context)!.allow_public_access,
                                              //"Allow  Public access ",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!.available_to_public,
                                                //"Available to public for practice",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      153, 153, 153, 0.8),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      Text(
                                        finalAssessment.assessmentSettings
                                                    ?.avalabilityForPractice ==
                                                null
                                            ? AppLocalizations.of(context)!.no
                                                //"No"
                                            : finalAssessment.assessmentSettings!
                                                    .avalabilityForPractice!
                                                ? AppLocalizations.of(context)!.yes
                                                      //"Yes"
                                                : AppLocalizations.of(context)!.no,
                                                  //"No",
                                        style: TextStyle(
                                          color:
                                              const Color.fromRGBO(82, 165, 160, 1),
                                          fontSize: height * 0.0175,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ])
                                  ],
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          questionShirnk
                              ? Container(
                                  height: height * 0.05,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0)),
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: width * 0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!.qn_button,
                                          //"Questions",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(right: width * 0.02),
                                          child: IconButton(
                                            onPressed: () {
                                              showQuestionDetails();
                                            },
                                            icon: const Icon(
                                              Icons.arrow_circle_up_outlined,
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: height * 0.05,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0)),
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: width * 0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                           AppLocalizations.of(context)!.qn_button,
                                          //"Questions",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(right: width * 0.02),
                                          child: IconButton(
                                            onPressed: () {
                                              showQuestionDetails();
                                            },
                                            icon: const Icon(
                                              Icons.arrow_circle_down_outlined,
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                          questionShirnk
                              ? SizedBox(
                                  height: height * 0.4,
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: assessment.questions!.length,
                                      itemBuilder: (context, index) => QuestionWidget(
                                            height: height,
                                            question: assessment.questions![index],
                                          )),
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                onTap: () {
                                  showQuestionDetails();
                                },
                                child: Text(
                                    AppLocalizations.of(context)!.view_all_qns,
                                  //"  View All Questions  ",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )),
                              // IconButton(
                              //   onPressed: () {
                              //     showQuestionDetails();
                              //   },
                              //   icon: const Icon(
                              //     Icons.keyboard_arrow_down_sharp,
                              //     color: Color.fromRGBO(28, 78, 80, 1),
                              //   ),
                              // ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          // WEB,Android App and IOS App

                          // SizedBox(
                          //   height: height * 0.02,
                          // ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       height: height * 0.08,
                          //       width: width * 0.28,
                          //       decoration: const BoxDecoration(
                          //         border: Border(
                          //           right: BorderSide(
                          //             width: 1,
                          //             color: Color.fromRGBO(232, 232, 232, 1),
                          //           ),
                          //         ),
                          //       ),
                          //       child: Center(
                          //         child: Text(
                          //           "WEB",
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(
                          //             decoration: TextDecoration.underline,
                          //             color: const Color.fromRGBO(153, 153, 153, 1),
                          //             fontSize: height * 0.015,
                          //             fontFamily: "Inter",
                          //             fontWeight: FontWeight.w400,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: SizedBox(
                          //         height: height * 0.08,
                          //         width: width * 0.3,
                          //         child: Center(
                          //           child: Text(
                          //             "Android App",
                          //             textAlign: TextAlign.center,
                          //             style: TextStyle(
                          //               decoration: TextDecoration.underline,
                          //               color: const Color.fromRGBO(153, 153, 153, 1),
                          //               fontSize: height * 0.015,
                          //               fontFamily: "Inter",
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     Container(
                          //       height: height * 0.08,
                          //       width: width * 0.28,
                          //       decoration: const BoxDecoration(
                          //         border: Border(
                          //           left: BorderSide(
                          //             width: 1,
                          //             color: Color.fromRGBO(232, 232, 232, 1),
                          //           ),
                          //         ),
                          //       ),
                          //       child: Center(
                          //         child: Text(
                          //           "IOS App",
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(
                          //             decoration: TextDecoration.underline,
                          //             color: const Color.fromRGBO(153, 153, 153, 1),
                          //             fontSize: height * 0.015,
                          //             fontFamily: "Inter",
                          //             fontWeight: FontWeight.w400,
                          //           ),
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          widget.assessmentType=='myAssessment'?
                          Center(
                            child: SizedBox(
                              width: width * 0.888,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    const Color.fromRGBO(255, 255, 255, 1),
                                    minimumSize: const Size(280, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(39),
                                    ),
                                    side: const BorderSide(
                                      color: Color.fromRGBO(82, 165, 160, 1),
                                    )),
                                onPressed: () {
                                  // Provider.of<CreateAssessmentProvider>(context, listen: false)
                                  //     .getAssessment;
                                  Navigator.pushNamed(context, '/teacherAssessmentSettingPublish',arguments: 'editActive',);
                                },
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                      fontSize: height * 0.025,
                                      fontFamily: "Inter",
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ):
                          const SizedBox(height: 0,),
                          SizedBox(
                            height: height * 0.03,
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
                                //shape: StadiumBorder(),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/teacherClonedAssessment',arguments: 'clone',);
                                  // Navigator.push(
                                  //   context,
                                  //   PageTransition(
                                  //     type: PageTransitionType.rightToLeft,
                                  //     child: TeacherClonedAssessment(
                                  //         ),
                                  //   ),
                                  // );
                                },
                                child: Text(
                                    AppLocalizations.of(context)!.clone_qn,
                                    //'Clone',
                                  style: TextStyle(
                                      fontSize: height * 0.025,
                                      fontFamily: "Inter",
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                        ],
                      )),
                ),
              ));
        }
      },);
    // return WillPopScope(
    //     onWillPop: () async => false,
    //     child: Scaffold(
    //       resizeToAvoidBottomInset: true,
    //       backgroundColor: Colors.white,
    //       endDrawer: const EndDrawerMenuTeacher(),
    //       appBar: AppBar(
    //         leading: IconButton(
    //           icon: const Icon(
    //             Icons.chevron_left,
    //             size: 40.0,
    //             color: Colors.white,
    //           ),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //         toolbarHeight: height * 0.100,
    //         centerTitle: true,
    //         title: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Text(
    //                 AppLocalizations.of(context)!.active,
    //                 //"ACTIVE",
    //                 style: TextStyle(
    //                   color: const Color.fromRGBO(255, 255, 255, 1),
    //                   fontSize: height * 0.0225,
    //                   fontFamily: "Inter",
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //               ),
    //               Text(
    //                 AppLocalizations.of(context)!.assessment_caps,
    //                 // "ASSESSMENTS",
    //                 style: TextStyle(
    //                   color: const Color.fromRGBO(255, 255, 255, 1),
    //                   fontSize: height * 0.0225,
    //                   fontFamily: "Inter",
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //               ),
    //             ]),
    //         flexibleSpace: Container(
    //           decoration: const BoxDecoration(
    //               gradient: LinearGradient(
    //                   end: Alignment.bottomCenter,
    //                   begin: Alignment.topCenter,
    //                   colors: [
    //                 Color.fromRGBO(0, 106, 100, 1),
    //                 Color.fromRGBO(82, 165, 160, 1),
    //               ])),
    //         ),
    //       ),
    //       body: SingleChildScrollView(
    //         scrollDirection: Axis.vertical,
    //         child: Padding(
    //             padding: EdgeInsets.only(
    //                 top: height * 0.023,
    //                 left: height * 0.023,
    //                 right: height * 0.023),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 SizedBox(
    //                   height: height * 0.01,
    //                 ),
    //                 SizedBox(
    //                   height: height * 0.03,
    //                 ),
    //                 Center(
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       borderRadius:
    //                           const BorderRadius.all(Radius.circular(8.0)),
    //                       border: Border.all(
    //                         color: const Color.fromRGBO(217, 217, 217, 1),
    //                       ),
    //                       color: Colors.white,
    //                     ),
    //                     height: height * 0.1675,
    //                     width: width * 0.888,
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Container(
    //                           height: height * 0.037,
    //                           decoration: const BoxDecoration(
    //                             borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(8.0),
    //                                 topRight: Radius.circular(8.0)),
    //                             color: Color.fromRGBO(82, 165, 160, 1),
    //                           ),
    //                           child: Padding(
    //                             padding: EdgeInsets.only(left: width * 0.02),
    //                             child: Row(
    //                               children: [
    //                                 Text(
    //                                   assessment.subject!,
    //                                   style: TextStyle(
    //                                     color: const Color.fromRGBO(
    //                                         255, 255, 255, 1),
    //                                     fontSize: height * 0.02,
    //                                     fontFamily: "Inter",
    //                                     fontWeight: FontWeight.w700,
    //                                   ),
    //                                 ),
    //                                 Text(
    //                                   "  |  ${assessment.getAssessmentModelClass!}",
    //                                   style: TextStyle(
    //                                     color: const Color.fromRGBO(
    //                                         255, 255, 255, 1),
    //                                     fontSize: height * 0.015,
    //                                     fontFamily: "Inter",
    //                                     fontWeight: FontWeight.w400,
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Padding(
    //                               padding: EdgeInsets.only(right: width * 0.02),
    //                               child: const Icon(
    //                                 Icons.circle,
    //                                 color: Colors.white,
    //                               ),
    //                             ),
    //                             Text(
    //                               "${assessment.topic!} - ${assessment.subTopic!}",
    //                               style: TextStyle(
    //                                 color:
    //                                     const Color.fromRGBO(102, 102, 102, 1),
    //                                 fontSize: height * 0.015,
    //                                 fontFamily: "Inter",
    //                                 fontWeight: FontWeight.w400,
    //                               ),
    //                             ),
    //                             Padding(
    //                               padding: EdgeInsets.only(right: width * 0.02),
    //                               child: const Icon(
    //                                 Icons.circle,
    //                                 color: Color.fromRGBO(60, 176, 0, 1),
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                         Row(
    //                           children: [
    //                             Container(
    //                               decoration: const BoxDecoration(
    //                                 border: Border(
    //                                   right: BorderSide(
    //                                     color: Color.fromRGBO(204, 204, 204, 1),
    //                                   ),
    //                                 ),
    //                                 color: Colors.white,
    //                               ),
    //                               width: width * 0.44,
    //                               height: height * 0.0875,
    //                               child: Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceEvenly,
    //                                 children: [
    //                                   Text(
    //                                     "$mark",
    //                                     style: TextStyle(
    //                                       color: const Color.fromRGBO(
    //                                           28, 78, 80, 1),
    //                                       fontSize: height * 0.03,
    //                                       fontFamily: "Inter",
    //                                       fontWeight: FontWeight.w700,
    //                                     ),
    //                                   ),
    //                                   Text(
    //                                       AppLocalizations.of(context)!
    //                                           .marks,
    //                                     //"Marks",
    //                                     style: TextStyle(
    //                                       color: const Color.fromRGBO(
    //                                           102, 102, 102, 1),
    //                                       fontSize: height * 0.015,
    //                                       fontFamily: "Inter",
    //                                       fontWeight: FontWeight.w400,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               width: width * 0.44,
    //                               height: height * 0.0875,
    //                               child: Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceEvenly,
    //                                 children: [
    //                                   Text(
    //                                     "${assessment.questions!.length}",
    //                                     style: TextStyle(
    //                                       color: const Color.fromRGBO(
    //                                           28, 78, 80, 1),
    //                                       fontSize: height * 0.03,
    //                                       fontFamily: "Inter",
    //                                       fontWeight: FontWeight.w700,
    //                                     ),
    //                                   ),
    //                                   Text(
    //                                     AppLocalizations.of(context)!.qn_button,
    //                                     //"Questions",
    //                                     style: TextStyle(
    //                                       color: const Color.fromRGBO(
    //                                           102, 102, 102, 1),
    //                                       fontSize: height * 0.015,
    //                                       fontFamily: "Inter",
    //                                       fontWeight: FontWeight.w400,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             )
    //                           ],
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: height * 0.025,
    //                 ),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       width: width * 0.4,
    //                       child: Text(
    //                         AppLocalizations.of(context)!.assessment_id_caps,
    //                         //"Assessment ID:",
    //                         style: TextStyle(
    //                           color: const Color.fromRGBO(102, 102, 102, 1),
    //                           fontSize: height * 0.02,
    //                           fontFamily: "Inter",
    //                           fontWeight: FontWeight.w600,
    //                         ),
    //                       ),
    //                     ),
    //                     Text(
    //                       assessment.assessmentCode!,
    //                       style: TextStyle(
    //                         color: const Color.fromRGBO(82, 165, 160, 1),
    //                         fontSize: height * 0.0175,
    //                         fontFamily: "Inter",
    //                         fontWeight: FontWeight.w700,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: height * 0.01,
    //                 ),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       width: width * 0.4,
    //                       child: Text(
    //                         AppLocalizations.of(context)!
    //                             .institute_test_id,
    //                         //"Institute Test ID:",
    //                         style: TextStyle(
    //                           color: const Color.fromRGBO(102, 102, 102, 1),
    //                           fontSize: height * 0.02,
    //                           fontFamily: "Inter",
    //                           fontWeight: FontWeight.w600,
    //                         ),
    //                       ),
    //                     ),
    //                     Text(
    //                       "-----------",
    //                       style: TextStyle(
    //                         color: const Color.fromRGBO(82, 165, 160, 1),
    //                         fontSize: height * 0.0175,
    //                         fontFamily: "Inter",
    //                         fontWeight: FontWeight.w700,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: height * 0.01,
    //                 ),
    //                 const Divider(),
    //                 SizedBox(
    //                   height: height * 0.01,
    //                 ),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       width: width * 0.4,
    //                       child: Text(
    //                         AppLocalizations.of(context)!.time_permitted,
    //                         //"Time Permitted:",
    //                         style: TextStyle(
    //                           color: const Color.fromRGBO(102, 102, 102, 1),
    //                           fontSize: height * 0.02,
    //                           fontFamily: "Inter",
    //                           fontWeight: FontWeight.w600,
    //                         ),
    //                       ),
    //                     ),
    //                     Text(
    //                       assessment.assessmentDuration == null
    //                           ? "00 ${AppLocalizations.of(context)!.minutes}"
    //                           : "${assessment.assessmentDuration} ${AppLocalizations.of(context)!.minutes}",
    //                       style: TextStyle(
    //                         color: const Color.fromRGBO(82, 165, 160, 1),
    //                         fontSize: height * 0.0175,
    //                         fontFamily: "Inter",
    //                         fontWeight: FontWeight.w700,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: height * 0.01,
    //                 ),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       width: width * 0.4,
    //                       child: Text(
    //                         AppLocalizations.of(context)!.start_date_time,
    //                         //"Start Date & Time:",
    //                         style: TextStyle(
    //                           color: const Color.fromRGBO(102, 102, 102, 1),
    //                           fontSize: height * 0.02,
    //                           fontFamily: "Inter",
    //                           fontWeight: FontWeight.w600,
    //                         ),
    //                       ),
    //                     ),
    //                     finalAssessment.assessmentStartdate == null
    //                         ? Text(
    //                             "----------------------",
    //                             style: TextStyle(
    //                               color: const Color.fromRGBO(82, 165, 160, 1),
    //                               fontSize: height * 0.0175,
    //                               fontFamily: "Inter",
    //                               fontWeight: FontWeight.w700,
    //                             ),
    //                           )
    //                         : Text(
    //                             "${startDate.toString().substring(0, startDate.toString().length - 13)}      ${startDate.toString().substring(11, startDate.toString().length - 7)}",
    //                             style: TextStyle(
    //                               color: const Color.fromRGBO(82, 165, 160, 1),
    //                               fontSize: height * 0.0175,
    //                               fontFamily: "Inter",
    //                               fontWeight: FontWeight.w700,
    //                             ),
    //                           ),
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: height * 0.01,
    //                 ),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       width: width * 0.4,
    //                       child: Text(
    //                         AppLocalizations.of(context)!.end_date_time,
    //                         //"End Date & Time:",
    //                         style: TextStyle(
    //                           color: const Color.fromRGBO(102, 102, 102, 1),
    //                           fontSize: height * 0.02,
    //                           fontFamily: "Inter",
    //                           fontWeight: FontWeight.w600,
    //                         ),
    //                       ),
    //                     ),
    //                     finalAssessment.assessmentEnddate == null
    //                         ? Text(
    //                             "----------------------",
    //                             style: TextStyle(
    //                               color: const Color.fromRGBO(82, 165, 160, 1),
    //                               fontSize: height * 0.0175,
    //                               fontFamily: "Inter",
    //                               fontWeight: FontWeight.w700,
    //                             ),
    //                           )
    //                         : Text(
    //                             "${endDate.toString().substring(0, endDate.toString().length - 13)}      ${endDate.toString().substring(11, endDate.toString().length - 7)}",
    //                             style: TextStyle(
    //                               color: const Color.fromRGBO(82, 165, 160, 1),
    //                               fontSize: height * 0.0175,
    //                               fontFamily: "Inter",
    //                               fontWeight: FontWeight.w700,
    //                             ),
    //                           ),
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: height * 0.01,
    //                 ),
    //                 const Divider(),
    //                 SizedBox(
    //                   height: height * 0.01,
    //                 ),
    //                 additionalDetails
    //                     ? Container(
    //                         height: height * 0.05,
    //                         decoration: const BoxDecoration(
    //                           borderRadius: BorderRadius.only(
    //                               topLeft: Radius.circular(8.0),
    //                               topRight: Radius.circular(8.0)),
    //                           color: Color.fromRGBO(82, 165, 160, 1),
    //                         ),
    //                         child: Padding(
    //                           padding: EdgeInsets.only(left: width * 0.02),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text(
    //                                 AppLocalizations.of(context)!.time_permitted,
    //                                 //"Additional Details",
    //                                 style: TextStyle(
    //                                   color: const Color.fromRGBO(
    //                                       255, 255, 255, 1),
    //                                   fontSize: height * 0.02,
    //                                   fontFamily: "Inter",
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               ),
    //                               Padding(
    //                                 padding:
    //                                     EdgeInsets.only(right: width * 0.02),
    //                                 child: IconButton(
    //                                   icon: const Icon(
    //                                     Icons.arrow_circle_up_outlined,
    //                                     color: Color.fromRGBO(255, 255, 255, 1),
    //                                   ),
    //                                   onPressed: () {
    //                                     showAdditionalDetails();
    //                                   },
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       )
    //                     : Container(
    //                         height: height * 0.05,
    //                         decoration: const BoxDecoration(
    //                           borderRadius: BorderRadius.only(
    //                               topLeft: Radius.circular(8.0),
    //                               topRight: Radius.circular(8.0)),
    //                           color: Color.fromRGBO(82, 165, 160, 1),
    //                         ),
    //                         child: Padding(
    //                           padding: EdgeInsets.only(left: width * 0.02),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text(
    //                                 AppLocalizations.of(context)!.additional_details,
    //                                 //"Additional Details",
    //                                 style: TextStyle(
    //                                   color: const Color.fromRGBO(
    //                                       255, 255, 255, 1),
    //                                   fontSize: height * 0.02,
    //                                   fontFamily: "Inter",
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               ),
    //                               Padding(
    //                                 padding:
    //                                     EdgeInsets.only(right: width * 0.02),
    //                                 child: IconButton(
    //                                   icon: const Icon(
    //                                     Icons.arrow_circle_down_outlined,
    //                                     color: Color.fromRGBO(255, 255, 255, 1),
    //                                   ),
    //                                   onPressed: () {
    //                                     showAdditionalDetails();
    //                                   },
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                 SizedBox(
    //                   height: height * 0.02,
    //                 ),
    //                 additionalDetails
    //                     ? Column(
    //                         children: [
    //                           Row(
    //                             children: [
    //                               SizedBox(
    //                                 width: width * 0.4,
    //                                 child: Text(
    //                                   AppLocalizations.of(context)!.category,
    //                                   //"Category",
    //                                   style: TextStyle(
    //                                     color: const Color.fromRGBO(
    //                                         102, 102, 102, 1),
    //                                     fontSize: height * 0.02,
    //                                     fontFamily: "Inter",
    //                                     fontWeight: FontWeight.w600,
    //                                   ),
    //                                 ),
    //                               ),
    //                               Text(
    //                                 "${finalAssessment.assessmentType}",
    //                                 style: TextStyle(
    //                                   color:
    //                                       const Color.fromRGBO(82, 165, 160, 1),
    //                                   fontSize: height * 0.0175,
    //                                   fontFamily: "Inter",
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: height * 0.01,
    //                           ),
    //                           Row(
    //                             children: [
    //                               SizedBox(
    //                                 width: width * 0.4,
    //                                 child: Text(
    //                                   AppLocalizations.of(context)!.no_of_retries_allowed,
    //                                   //"Number of Retries allowed",
    //                                   style: TextStyle(
    //                                     color: const Color.fromRGBO(
    //                                         102, 102, 102, 1),
    //                                     fontSize: height * 0.02,
    //                                     fontFamily: "Inter",
    //                                     fontWeight: FontWeight.w600,
    //                                   ),
    //                                 ),
    //                               ),
    //                               Text(
    //                                 //"Allowed "
    //                                     "${AppLocalizations.of(context)!.allowed} (${finalAssessment.assessmentSettings?.allowedNumberOfTestRetries ?? "0"} Times)",
    //                                 style: TextStyle(
    //                                   color:
    //                                       const Color.fromRGBO(82, 165, 160, 1),
    //                                   fontSize: height * 0.0175,
    //                                   fontFamily: "Inter",
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: height * 0.01,
    //                           ),
    //                           Row(
    //                             children: [
    //                               SizedBox(
    //                                 width: width * 0.4,
    //                                 child: Text(
    //                                   AppLocalizations.of(context)!.allow_guest_Students,
    //                                   //"Allow Guest students",
    //                                   style: TextStyle(
    //                                     color: const Color.fromRGBO(
    //                                         102, 102, 102, 1),
    //                                     fontSize: height * 0.02,
    //                                     fontFamily: "Inter",
    //                                     fontWeight: FontWeight.w600,
    //                                   ),
    //                                 ),
    //                               ),
    //                               Text(
    //                                 finalAssessment.assessmentSettings
    //                                             ?.allowGuestStudent ==
    //                                         null
    //                                     ? AppLocalizations.of(context)!.not_allowed
    //                                 //"Not Allowed"
    //                                     : finalAssessment.assessmentSettings!
    //                                             .allowGuestStudent!
    //                                         ? AppLocalizations.of(context)!.allowed
    //                                 //"Allowed"
    //                                         :  AppLocalizations.of(context)!.not_allowed,
    //                                // "Not Allowed",
    //                                 style: TextStyle(
    //                                   color:
    //                                       const Color.fromRGBO(82, 165, 160, 1),
    //                                   fontSize: height * 0.0175,
    //                                   fontFamily: "Inter",
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: height * 0.01,
    //                           ),
    //                           Row(
    //                             children: [
    //                               SizedBox(
    //                                 width: width * 0.4,
    //                                 child: Text(
    //                                     AppLocalizations.of(context)!.show_answersheet_after_test,
    //                                   //"Show answer Sheet after test",
    //                                   style: TextStyle(
    //                                     color: const Color.fromRGBO(
    //                                         102, 102, 102, 1),
    //                                     fontSize: height * 0.02,
    //                                     fontFamily: "Inter",
    //                                     fontWeight: FontWeight.w600,
    //                                   ),
    //                                 ),
    //                               ),
    //                               Text(
    //                                 finalAssessment.assessmentSettings
    //                                             ?.showSolvedAnswerSheetInAdvisor ==
    //                                         null
    //                                     ? AppLocalizations.of(context)!.not_viewable
    //                                       //"Not Viewable"
    //                                     : finalAssessment.assessmentSettings!
    //                                             .showSolvedAnswerSheetInAdvisor!
    //                                         ? AppLocalizations.of(context)!.viewable
    //                                         //"Viewable"
    //                                         : AppLocalizations.of(context)!.not_viewable,
    //                                           // "Not Viewable",
    //                                 style: TextStyle(
    //                                   color:
    //                                       const Color.fromRGBO(82, 165, 160, 1),
    //                                   fontSize: height * 0.0175,
    //                                   fontFamily: "Inter",
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: height * 0.01,
    //                           ),
    //                           Row(
    //                             children: [
    //                               SizedBox(
    //                                 width: width * 0.4,
    //                                 child: Text(
    //                                 AppLocalizations.of(context)!.show_my_advisor_name,
    //                                 //"Show my name in Advisor",
    //                                   style: TextStyle(
    //                                     color: const Color.fromRGBO(
    //                                         102, 102, 102, 1),
    //                                     fontSize: height * 0.02,
    //                                     fontFamily: "Inter",
    //                                     fontWeight: FontWeight.w600,
    //                                   ),
    //                                 ),
    //                               ),
    //                               Text(
    //                                 assessment.assessmentSettings!
    //                                             .showAdvisorName ==
    //                                         false
    //                                     ? AppLocalizations.of(context)!.no
    //                                   //"No"
    //                                     : assessment.assessmentSettings!
    //                                             .showAdvisorName!
    //                                         ? assessment.assessmentSettings!.advisorName??''
    //                                           //"Yes"
    //                                         :  AppLocalizations.of(context)!.no,
    //                                           //"No",
    //                                 style: TextStyle(
    //                                   color:
    //                                       const Color.fromRGBO(82, 165, 160, 1),
    //                                   fontSize: height * 0.0175,
    //                                   fontFamily: "Inter",
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: height * 0.01,
    //                           ),
    //                           Row(
    //                             children: [
    //                               SizedBox(
    //                                 width: width * 0.4,
    //                                 child: Text(
    //                                 AppLocalizations.of(context)!.show_my_email,
    //                                 //"Show my Email in Advisor",
    //                                   style: TextStyle(
    //                                     color: const Color.fromRGBO(
    //                                         102, 102, 102, 1),
    //                                     fontSize: height * 0.02,
    //                                     fontFamily: "Inter",
    //                                     fontWeight: FontWeight.w600,
    //                                   ),
    //                                 ),
    //                               ),
    //                               Text(
    //                                 assessment.assessmentSettings
    //                                             ?.showAdvisorEmail ==
    //                                         false
    //                                     ? AppLocalizations.of(context)!.no
    //                                       //"No"
    //                                     : assessment.assessmentSettings!
    //                                             .showAdvisorEmail!
    //                                         ?  assessment.assessmentSettings!.advisorEmail??''
    //                                         : AppLocalizations.of(context)!.no,
    //                                           //"No",
    //                                 style: TextStyle(
    //                                   color:
    //                                       const Color.fromRGBO(82, 165, 160, 1),
    //                                   fontSize: height * 0.0175,
    //                                   fontFamily: "Inter",
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: height * 0.01,
    //                           ),
    //                           Row(
    //                             children: [
    //                               SizedBox(
    //                                 width: width * 0.4,
    //                                 child: Column(
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       Text(
    //                                             AppLocalizations.of(context)!.in_active,
    //                                            //"Inactive",
    //                                         style: TextStyle(
    //                                           color: const Color.fromRGBO(
    //                                               51, 51, 51, 1),
    //                                           fontSize: height * 0.015,
    //                                           fontFamily: "Inter",
    //                                           fontWeight: FontWeight.w700,
    //                                         ),
    //                                       ),
    //                                       Text(
    //                                         AppLocalizations.of(context)!.not_available_for_student,
    //                                         //"Not available for student",
    //                                         style: TextStyle(
    //                                           color: const Color.fromRGBO(
    //                                               153, 153, 153, 0.8),
    //                                           fontSize: height * 0.015,
    //                                           fontFamily: "Inter",
    //                                           fontWeight: FontWeight.w700,
    //                                         ),
    //                                       ),
    //                                     ]),
    //                               ),
    //                               Text(
    //                                 assessment.assessmentSettings
    //                                             ?.notAvailable ==
    //                                         false
    //                                     ? AppLocalizations.of(context)!.no
    //                                       //"No"
    //                                     : AppLocalizations.of(context)!.yes,
    //                                       //"Yes",
    //                                 style: TextStyle(
    //                                   color:
    //                                       const Color.fromRGBO(82, 165, 160, 1),
    //                                   fontSize: height * 0.0175,
    //                                   fontFamily: "Inter",
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: height * 0.01,
    //                           ),
    //                           Row(children: [
    //                             SizedBox(
    //                               width: width * 0.4,
    //                               child: Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     Text(
    //                                     AppLocalizations.of(context)!.allow_public_access,
    //                                     //"Allow  Public access ",
    //                                       style: TextStyle(
    //                                         color: const Color.fromRGBO(
    //                                             51, 51, 51, 1),
    //                                         fontSize: height * 0.015,
    //                                         fontFamily: "Inter",
    //                                         fontWeight: FontWeight.w700,
    //                                       ),
    //                                     ),
    //                                     Text(
    //                                       AppLocalizations.of(context)!.available_to_public,
    //                                       //"Available to public for practice",
    //                                       style: TextStyle(
    //                                         color: const Color.fromRGBO(
    //                                             153, 153, 153, 0.8),
    //                                         fontSize: height * 0.015,
    //                                         fontFamily: "Inter",
    //                                         fontWeight: FontWeight.w700,
    //                                       ),
    //                                     ),
    //                                   ]),
    //                             ),
    //                             Text(
    //                               finalAssessment.assessmentSettings
    //                                           ?.avalabilityForPractice ==
    //                                       null
    //                                   ? AppLocalizations.of(context)!.no
    //                                       //"No"
    //                                   : finalAssessment.assessmentSettings!
    //                                           .avalabilityForPractice!
    //                                       ? AppLocalizations.of(context)!.yes
    //                                             //"Yes"
    //                                       : AppLocalizations.of(context)!.no,
    //                                         //"No",
    //                               style: TextStyle(
    //                                 color:
    //                                     const Color.fromRGBO(82, 165, 160, 1),
    //                                 fontSize: height * 0.0175,
    //                                 fontFamily: "Inter",
    //                                 fontWeight: FontWeight.w700,
    //                               ),
    //                             ),
    //                           ])
    //                         ],
    //                       )
    //                     : const SizedBox(
    //                         height: 0,
    //                       ),
    //                 SizedBox(
    //                   height: height * 0.03,
    //                 ),
    //                 questionShirnk
    //                     ? Container(
    //                         height: height * 0.05,
    //                         decoration: const BoxDecoration(
    //                           borderRadius: BorderRadius.only(
    //                               topLeft: Radius.circular(8.0),
    //                               topRight: Radius.circular(8.0)),
    //                           color: Color.fromRGBO(82, 165, 160, 1),
    //                         ),
    //                         child: Padding(
    //                           padding: EdgeInsets.only(left: width * 0.02),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text(
    //                                   AppLocalizations.of(context)!.qn_button,
    //                                 //"Questions",
    //                                 style: TextStyle(
    //                                   color: const Color.fromRGBO(
    //                                       255, 255, 255, 1),
    //                                   fontSize: height * 0.02,
    //                                   fontFamily: "Inter",
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               ),
    //                               Padding(
    //                                 padding:
    //                                     EdgeInsets.only(right: width * 0.02),
    //                                 child: IconButton(
    //                                   onPressed: () {
    //                                     showQuestionDetails();
    //                                   },
    //                                   icon: const Icon(
    //                                     Icons.arrow_circle_up_outlined,
    //                                     color: Color.fromRGBO(255, 255, 255, 1),
    //                                   ),
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       )
    //                     : Container(
    //                         height: height * 0.05,
    //                         decoration: const BoxDecoration(
    //                           borderRadius: BorderRadius.only(
    //                               topLeft: Radius.circular(8.0),
    //                               topRight: Radius.circular(8.0)),
    //                           color: Color.fromRGBO(82, 165, 160, 1),
    //                         ),
    //                         child: Padding(
    //                           padding: EdgeInsets.only(left: width * 0.02),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text(
    //                                  AppLocalizations.of(context)!.qn_button,
    //                                 //"Questions",
    //                                 style: TextStyle(
    //                                   color: const Color.fromRGBO(
    //                                       255, 255, 255, 1),
    //                                   fontSize: height * 0.02,
    //                                   fontFamily: "Inter",
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               ),
    //                               Padding(
    //                                 padding:
    //                                     EdgeInsets.only(right: width * 0.02),
    //                                 child: IconButton(
    //                                   onPressed: () {
    //                                     showQuestionDetails();
    //                                   },
    //                                   icon: const Icon(
    //                                     Icons.arrow_circle_down_outlined,
    //                                     color: Color.fromRGBO(255, 255, 255, 1),
    //                                   ),
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                 questionShirnk
    //                     ? SizedBox(
    //                         height: height * 0.4,
    //                         child: ListView.builder(
    //                             padding: EdgeInsets.zero,
    //                             itemCount: assessment.questions!.length,
    //                             itemBuilder: (context, index) => QuestionWidget(
    //                                   height: height,
    //                                   question: assessment.questions![index],
    //                                 )),
    //                       )
    //                     : const SizedBox(
    //                         height: 0,
    //                       ),
    //                 SizedBox(
    //                   height: height * 0.02,
    //                 ),
    //                 Row(
    //                   children: [
    //                     const Expanded(child: Divider()),
    //                     MouseRegion(
    //                         cursor: SystemMouseCursors.click,
    //                         child: GestureDetector(
    //                       onTap: () {
    //                         showQuestionDetails();
    //                       },
    //                       child: Text(
    //                           AppLocalizations.of(context)!.view_all_qns,
    //                         //"  View All Questions  ",
    //                         style: TextStyle(
    //                           color: const Color.fromRGBO(28, 78, 80, 1),
    //                           fontSize: height * 0.02,
    //                           fontFamily: "Inter",
    //                           fontWeight: FontWeight.w700,
    //                         ),
    //                       ),
    //                     )),
    //                     // IconButton(
    //                     //   onPressed: () {
    //                     //     showQuestionDetails();
    //                     //   },
    //                     //   icon: const Icon(
    //                     //     Icons.keyboard_arrow_down_sharp,
    //                     //     color: Color.fromRGBO(28, 78, 80, 1),
    //                     //   ),
    //                     // ),
    //                     const Expanded(child: Divider()),
    //                   ],
    //                 ),
    //                 // WEB,Android App and IOS App
    //
    //                 // SizedBox(
    //                 //   height: height * 0.02,
    //                 // ),
    //                 // Row(
    //                 //   children: [
    //                 //     Container(
    //                 //       height: height * 0.08,
    //                 //       width: width * 0.28,
    //                 //       decoration: const BoxDecoration(
    //                 //         border: Border(
    //                 //           right: BorderSide(
    //                 //             width: 1,
    //                 //             color: Color.fromRGBO(232, 232, 232, 1),
    //                 //           ),
    //                 //         ),
    //                 //       ),
    //                 //       child: Center(
    //                 //         child: Text(
    //                 //           "WEB",
    //                 //           textAlign: TextAlign.center,
    //                 //           style: TextStyle(
    //                 //             decoration: TextDecoration.underline,
    //                 //             color: const Color.fromRGBO(153, 153, 153, 1),
    //                 //             fontSize: height * 0.015,
    //                 //             fontFamily: "Inter",
    //                 //             fontWeight: FontWeight.w400,
    //                 //           ),
    //                 //         ),
    //                 //       ),
    //                 //     ),
    //                 //     Expanded(
    //                 //       child: SizedBox(
    //                 //         height: height * 0.08,
    //                 //         width: width * 0.3,
    //                 //         child: Center(
    //                 //           child: Text(
    //                 //             "Android App",
    //                 //             textAlign: TextAlign.center,
    //                 //             style: TextStyle(
    //                 //               decoration: TextDecoration.underline,
    //                 //               color: const Color.fromRGBO(153, 153, 153, 1),
    //                 //               fontSize: height * 0.015,
    //                 //               fontFamily: "Inter",
    //                 //               fontWeight: FontWeight.w400,
    //                 //             ),
    //                 //           ),
    //                 //         ),
    //                 //       ),
    //                 //     ),
    //                 //     Container(
    //                 //       height: height * 0.08,
    //                 //       width: width * 0.28,
    //                 //       decoration: const BoxDecoration(
    //                 //         border: Border(
    //                 //           left: BorderSide(
    //                 //             width: 1,
    //                 //             color: Color.fromRGBO(232, 232, 232, 1),
    //                 //           ),
    //                 //         ),
    //                 //       ),
    //                 //       child: Center(
    //                 //         child: Text(
    //                 //           "IOS App",
    //                 //           textAlign: TextAlign.center,
    //                 //           style: TextStyle(
    //                 //             decoration: TextDecoration.underline,
    //                 //             color: const Color.fromRGBO(153, 153, 153, 1),
    //                 //             fontSize: height * 0.015,
    //                 //             fontFamily: "Inter",
    //                 //             fontWeight: FontWeight.w400,
    //                 //           ),
    //                 //         ),
    //                 //       ),
    //                 //     )
    //                 //   ],
    //                 // ),
    //                 SizedBox(
    //                   height: height * 0.03,
    //                 ),
    //                 widget.assessmentType=='myAssessment'?
    //                 Center(
    //                   child: SizedBox(
    //                     width: width * 0.888,
    //                     child: ElevatedButton(
    //                       style: ElevatedButton.styleFrom(
    //                           backgroundColor:
    //                           const Color.fromRGBO(255, 255, 255, 1),
    //                           minimumSize: const Size(280, 48),
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(39),
    //                           ),
    //                           side: const BorderSide(
    //                             color: Color.fromRGBO(82, 165, 160, 1),
    //                           )),
    //                       onPressed: () {
    //                         // Provider.of<CreateAssessmentProvider>(context, listen: false)
    //                         //     .getAssessment;
    //                         Navigator.pushNamed(context, '/teacherAssessmentSettingPublish',arguments: 'editActive',);
    //                       },
    //                       child: Text(
    //                         'Edit',
    //                         style: TextStyle(
    //                             fontSize: height * 0.025,
    //                             fontFamily: "Inter",
    //                             color: const Color.fromRGBO(82, 165, 160, 1),
    //                             fontWeight: FontWeight.w600),
    //                       ),
    //                     ),
    //                   ),
    //                 ):
    //                 const SizedBox(height: 0,),
    //                 SizedBox(
    //                   height: height * 0.03,
    //                 ),
    //
    //
    //                 Center(
    //                   child: SizedBox(
    //                     width: width * 0.888,
    //                     child: ElevatedButton(
    //                       style: ElevatedButton.styleFrom(
    //                           backgroundColor:
    //                               const Color.fromRGBO(82, 165, 160, 1),
    //                           minimumSize: const Size(280, 48),
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(39),
    //                           ),
    //                           side: const BorderSide(
    //                             color: Color.fromRGBO(82, 165, 160, 1),
    //                           )),
    //                       //shape: StadiumBorder(),
    //                       onPressed: () {
    //                         Navigator.pushNamed(context, '/teacherClonedAssessment',arguments: 'clone',);
    //                         // Navigator.push(
    //                         //   context,
    //                         //   PageTransition(
    //                         //     type: PageTransitionType.rightToLeft,
    //                         //     child: TeacherClonedAssessment(
    //                         //         ),
    //                         //   ),
    //                         // );
    //                       },
    //                       child: Text(
    //                           AppLocalizations.of(context)!.clone_qn,
    //                           //'Clone',
    //                         style: TextStyle(
    //                             fontSize: height * 0.025,
    //                             fontFamily: "Inter",
    //                             color: const Color.fromRGBO(255, 255, 255, 1),
    //                             fontWeight: FontWeight.w600),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: height * 0.03,
    //                 ),
    //               ],
    //             )),
    //       ),
    //     ));
  }
}

class QuestionWidget extends StatefulWidget {
  QuestionWidget({Key? key, required this.height, required this.question})
      : super(key: key);

  final double height;
  Question.Question question;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String ans = '';

  @override
  void initState() {
    if(widget.question.questionType=="MCQ")
    {
    for (int i = 0; i < widget.question.choices!.length; i++) {
      if (widget.question.choices![i].rightChoice!) {
        ans = '${widget.question.choices![i].choiceText}, $ans';
      }
    }
    ans = ans==''?'':ans.substring(0, ans.length - 2);
  }
    super.initState();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: widget.height * 0.01,
              ),
              Text(
                widget.question.questionType!,
                style: TextStyle(
                  color: const Color.fromRGBO(28, 78, 80, 1),
                  fontSize: widget.height * 0.015,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              Text(
                widget.question.question!,
                style: TextStyle(
                  color: const Color.fromRGBO(51, 51, 51, 1),
                  fontSize: widget.height * 0.015,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ans,
                    style: TextStyle(
                      color: const Color.fromRGBO(82, 165, 160, 1),
                      fontSize: widget.height * 0.015,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.marks} :",
                        // "Marks: ",
                        style: TextStyle(
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontSize: widget.height * 0.015,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${widget.question.questionMark}",
                        style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontSize: widget.height * 0.015,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
