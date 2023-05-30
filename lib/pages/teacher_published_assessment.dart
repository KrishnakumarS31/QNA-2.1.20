import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/create_assessment_provider.dart';
import '../Entity/Teacher/question_entity.dart' as questions;
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TeacherPublishedAssessment extends StatefulWidget {
  TeacherPublishedAssessment(
      {Key? key,
        required this.assessmentCode,
        this.questionList})
      : super(key: key);
  String assessmentCode;
  List<questions.Question>? questionList;

  @override
  TeacherPublishedAssessmentState createState() =>
      TeacherPublishedAssessmentState();
}

class TeacherPublishedAssessmentState
    extends State<TeacherPublishedAssessment> {
  bool additionalDetails = true;
  bool _visible = true;
  int mark = 0;
  int questionTotal = 0;
  var startDate;
  var endDate;
  CreateAssessmentModel assessmentVal =
  CreateAssessmentModel(questions: [], removeQuestions: []);
  bool questionShirnk = true;
  String advisorName='';
  String advisorEmail='';

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
    super.initState();
    getData();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _visible =
          false;
        });
      }
    });
  }

  getData() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    setState(() {
      assessmentVal =
          Provider.of<CreateAssessmentProvider>(context, listen: false)
              .getAssessment;
      questionTotal =
      widget.questionList == null ? 0 : widget.questionList!.length;
      if(widget.questionList==null){

      }else{
        for (int i = 0; i < widget.questionList!.length; i++) {
          mark = mark + widget.questionList![i].questionMark!;
        }
      }

      if(assessmentVal.assessmentStartdate == null){
        DateTime date1 = DateTime.now();
        date1 = DateTime(
            date1.year,
            date1.month,
            date1.day,
            date1.hour,
            date1.minute);
        startDate=DateTime.fromMicrosecondsSinceEpoch(date1.microsecondsSinceEpoch);
      }else{
        startDate = DateTime.fromMicrosecondsSinceEpoch(
            assessmentVal.assessmentStartdate!);
      }
      endDate = DateTime.fromMicrosecondsSinceEpoch(
          assessmentVal.assessmentEnddate == null
              ? 0
              : assessmentVal.assessmentEnddate!);
      advisorEmail=loginData.getString('email')!;
      advisorName=loginData.getString('firstName')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // if (constraints.maxWidth > 900) {  return WillPopScope(
          //     onWillPop: () async => false,
          //     child: Scaffold(
          //       resizeToAvoidBottomInset: true,
          //       backgroundColor: Colors.white,
          //       endDrawer: const EndDrawerMenuTeacher(),
          //       appBar: AppBar(
          //         automaticallyImplyLeading: false,
          //         toolbarHeight: height * 0.100,
          //         centerTitle: true,
          //         title: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Text(
          //                 AppLocalizations.of(context)!.published_caps,
          //                 //"PUBLISHED",
          //                 style: TextStyle(
          //                   color: const Color.fromRGBO(255, 255, 255, 1),
          //                   fontSize: height * 0.0225,
          //                   fontFamily: "Inter",
          //                   fontWeight: FontWeight.w400,
          //                 ),
          //               ),
          //               Text(
          //                 AppLocalizations.of(context)!.assessment_caps,
          //                 //"ASSESSMENT",
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
          //                     Color.fromRGBO(0, 106, 100, 1),
          //                     Color.fromRGBO(82, 165, 160, 1),
          //                   ])),
          //         ),
          //       ),
          //       body: SingleChildScrollView(
          //         scrollDirection: Axis.vertical,
          //         child: Padding(
          //             padding: EdgeInsets.only(
          //                 top: height * 0.023,
          //                 left: height * 0.023,
          //                 right: height * 0.023,
          //             bottom: height * 0.023),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Visibility(
          //                   visible: _visible,
          //                   child: Center(
          //                     child: Container(
          //                       height: height * 0.06,
          //                       width: width * 0.9,
          //                       decoration: const BoxDecoration(
          //                         borderRadius: BorderRadius.all(Radius.circular(8.0)),
          //                         color: Color.fromRGBO(28, 78, 80, 1),
          //                       ),
          //                       child: Center(
          //                         child: Text(
          //                           AppLocalizations.of(context)!.as_published,
          //                           //"Assessment Published Successfully",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(255, 255, 255, 1),
          //                             fontSize: height * 0.02,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w500,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: height * 0.01,
          //                 ),
          //                 Center(
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                       borderRadius:
          //                       const BorderRadius.all(Radius.circular(8.0)),
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
          //                                   "${assessmentVal.subject}",
          //                                   style: TextStyle(
          //                                     color: const Color.fromRGBO(
          //                                         255, 255, 255, 1),
          //                                     fontSize: height * 0.02,
          //                                     fontFamily: "Inter",
          //                                     fontWeight: FontWeight.w700,
          //                                   ),
          //                                 ),
          //                                 Text(
          //                                   "  |  ${assessmentVal.createAssessmentModelClass}",
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
          //                               padding: EdgeInsets.only(left: width * 0.02),
          //                               child: Text(
          //                                 "${assessmentVal.topic} - ${assessmentVal.subTopic}",
          //                                 style: TextStyle(
          //                                   color: const Color.fromRGBO(
          //                                       102, 102, 102, 1),
          //                                   fontSize: height * 0.015,
          //                                   fontFamily: "Inter",
          //                                   fontWeight: FontWeight.w400,
          //                                 ),
          //                               ),
          //                             ),
          //                             Padding(
          //                               padding: EdgeInsets.only(right: width * 0.02),
          //                               child: assessmentVal.assessmentStatus ==
          //                                   'active'
          //                                   ? const Icon(
          //                                 Icons.circle,
          //                                 color: Color.fromRGBO(60, 176, 0, 1),
          //                               )
          //                                   : assessmentVal.assessmentStatus ==
          //                                   'inprogress'
          //                                   ? const Icon(
          //                                 Icons.circle,
          //                                 color: Color.fromRGBO(
          //                                     255, 166, 0, 1),
          //                               )
          //                                   : const Icon(
          //                                 Icons.circle,
          //                                 color: Color.fromRGBO(
          //                                     136, 136, 136, 1),
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
          //                                 MainAxisAlignment.spaceEvenly,
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
          //                                     AppLocalizations.of(context)!.marks,
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
          //                                 MainAxisAlignment.spaceEvenly,
          //                                 children: [
          //                                   Text(
          //                                     "$questionTotal",
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
          //                       widget.assessmentCode,
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
          //                         AppLocalizations.of(context)!.institute_test_id,
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
          //                       assessmentVal.assessmentId != null
          //                           ? "${assessmentVal.assessmentId}"
          //                           : "-",
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
          //                       assessmentVal.assessmentDuration == null
          //                           ? "00 Minutes"
          //                           : "${assessmentVal.assessmentDuration} Minutes",
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
          //                         "${AppLocalizations.of(context)!.start_date_time} : ",
          //                         //"Start Date & Time:",
          //                         style: TextStyle(
          //                           color: const Color.fromRGBO(102, 102, 102, 1),
          //                           fontSize: height * 0.02,
          //                           fontFamily: "Inter",
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //                       ),
          //                     ),
          //                     assessmentVal.assessmentStartdate == null
          //                         ? Text(
          //                       "----------------------",
          //                       style: TextStyle(
          //                         color: const Color.fromRGBO(82, 165, 160, 1),
          //                         fontSize: height * 0.0175,
          //                         fontFamily: "Inter",
          //                         fontWeight: FontWeight.w700,
          //                       ),
          //                     )
          //                         : Text(
          //                       "${startDate.toString().substring(0, startDate.toString().length - 13)}      ${startDate.toString().substring(11, startDate.toString().length - 7)}",
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
          //                         "${AppLocalizations.of(context)!.end_date_time} : ",
          //                         //"End Date & Time:",
          //                         style: TextStyle(
          //                           color: const Color.fromRGBO(102, 102, 102, 1),
          //                           fontSize: height * 0.02,
          //                           fontFamily: "Inter",
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //                       ),
          //                     ),
          //                     assessmentVal.assessmentEnddate == null
          //                         ? Text(
          //                       "----------------------",
          //                       style: TextStyle(
          //                         color: const Color.fromRGBO(82, 165, 160, 1),
          //                         fontSize: height * 0.0175,
          //                         fontFamily: "Inter",
          //                         fontWeight: FontWeight.w700,
          //                       ),
          //                     )
          //                         : Text(
          //                       "${endDate.toString().substring(0, endDate.toString().length - 13)}      ${endDate.toString().substring(11, endDate.toString().length - 7)}",
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
          //                 additionalDetails
          //                     ? Container(
          //                   height: height * 0.05,
          //                   decoration: const BoxDecoration(
          //                     borderRadius: BorderRadius.only(
          //                         topLeft: Radius.circular(8.0),
          //                         topRight: Radius.circular(8.0)),
          //                     color: Color.fromRGBO(82, 165, 160, 1),
          //                   ),
          //                   child: Padding(
          //                     padding: EdgeInsets.only(left: width * 0.02),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           AppLocalizations.of(context)!.additional_details,
          //                           //"Additional Details",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(
          //                                 255, 255, 255, 1),
          //                             fontSize: height * 0.02,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                         Padding(
          //                           padding:
          //                           EdgeInsets.only(right: width * 0.02),
          //                           child: IconButton(
          //                             icon: const Icon(
          //                               Icons.arrow_circle_up_outlined,
          //                               color: Color.fromRGBO(255, 255, 255, 1),
          //                             ),
          //                             onPressed: () {
          //                               showAdditionalDetails();
          //                             },
          //                           ),
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 )
          //                     : Container(
          //                   height: height * 0.05,
          //                   decoration: const BoxDecoration(
          //                     borderRadius: BorderRadius.only(
          //                         topLeft: Radius.circular(8.0),
          //                         topRight: Radius.circular(8.0)),
          //                     color: Color.fromRGBO(82, 165, 160, 1),
          //                   ),
          //                   child: Padding(
          //                     padding: EdgeInsets.only(left: width * 0.02),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           AppLocalizations.of(context)!.additional_details,
          //                           // "Additional Details",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(
          //                                 255, 255, 255, 1),
          //                             fontSize: height * 0.02,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                         Padding(
          //                           padding:
          //                           EdgeInsets.only(right: width * 0.02),
          //                           child: IconButton(
          //                             icon: const Icon(
          //                               Icons.arrow_circle_down_outlined,
          //                               color: Color.fromRGBO(255, 255, 255, 1),
          //                             ),
          //                             onPressed: () {
          //                               showAdditionalDetails();
          //                             },
          //                           ),
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: height * 0.02,
          //                 ),
          //                 additionalDetails
          //                     ? Column(
          //                   children: [
          //                     Row(
          //                       children: [
          //                         SizedBox(
          //                           width: width * 0.4,
          //                           child: Text(
          //                             AppLocalizations.of(context)!.category,
          //                             //"Category",
          //                             style: TextStyle(
          //                               color: const Color.fromRGBO(102, 102, 102, 1),
          //                               fontSize: height * 0.02,
          //                               fontFamily: "Inter",
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                         ),
          //                         Text(
          //                           "${assessmentVal.assessmentType}",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(82, 165, 160, 1),
          //                             fontSize: height * 0.0175,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     SizedBox(
          //                       height: height * 0.01,
          //                     ),
          //                     Row(
          //                       children: [
          //                         SizedBox(
          //                           width: width * 0.4,
          //                           child: Text(
          //                             AppLocalizations.of(context)!.no_of_retries_allowed,
          //                             // "Number of Retries allowed",
          //                             style: TextStyle(
          //                               color: const Color.fromRGBO(102, 102, 102, 1),
          //                               fontSize: height * 0.02,
          //                               fontFamily: "Inter",
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                         ),
          //                         Text(
          //                           assessmentVal.assessmentSettings
          //                               ?.allowedNumberOfTestRetries ==
          //                               null
          //                               ? AppLocalizations.of(context)!.not_allowed
          //                           //"Not Allowed"
          //                               : "${AppLocalizations.of(context)!.allowed} (${assessmentVal.assessmentSettings!.allowedNumberOfTestRetries} Times)",
          //                           //"Allowed (${assessmentVal.assessmentSettings!.allowedNumberOfTestRetries} Times)",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(82, 165, 160, 1),
          //                             fontSize: height * 0.0175,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     SizedBox(
          //                       height: height * 0.01,
          //                     ),
          //                     Row(
          //                       children: [
          //                         SizedBox(
          //                           width: width * 0.4,
          //                           child: Text(
          //                             AppLocalizations.of(context)!.allow_guest_Students,
          //                             // "Allow Guest students",
          //                             style: TextStyle(
          //                               color: const Color.fromRGBO(102, 102, 102, 1),
          //                               fontSize: height * 0.02,
          //                               fontFamily: "Inter",
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                         ),
          //                         Text(
          //                           assessmentVal.assessmentSettings?.allowGuestStudent ==
          //                               null
          //                               ? AppLocalizations.of(context)!.not_allowed
          //                           //"Not Allowed"
          //                               : assessmentVal
          //                               .assessmentSettings!.allowGuestStudent!
          //                               ? AppLocalizations.of(context)!.allowed
          //                           //"Allowed"
          //                               : AppLocalizations.of(context)!.not_allowed,
          //                           //"Not Allowed",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(82, 165, 160, 1),
          //                             fontSize: height * 0.0175,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     SizedBox(
          //                       height: height * 0.01,
          //                     ),
          //                     Row(
          //                       children: [
          //                         SizedBox(
          //                           width: width * 0.4,
          //                           child: Text(
          //                             AppLocalizations.of(context)!.show_answersheet_after_test,
          //                             //"Show answer Sheet after test",
          //                             style: TextStyle(
          //                               color: const Color.fromRGBO(102, 102, 102, 1),
          //                               fontSize: height * 0.02,
          //                               fontFamily: "Inter",
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                         ),
          //                         Text(
          //                           assessmentVal.assessmentSettings
          //                               ?.showSolvedAnswerSheetInAdvisor ==
          //                               null
          //                               ? AppLocalizations.of(context)!.not_viewable
          //                           //"Not Viewable"
          //                               : assessmentVal.assessmentSettings!
          //                               .showSolvedAnswerSheetInAdvisor!
          //                               ? AppLocalizations.of(context)!.viewable
          //                           //"Viewable"
          //                               : AppLocalizations.of(context)!.not_viewable,
          //                           //"Not Viewable",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(82, 165, 160, 1),
          //                             fontSize: height * 0.0175,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     SizedBox(
          //                       height: height * 0.01,
          //                     ),
          //                     Row(
          //                       children: [
          //                         SizedBox(
          //                           width: width * 0.4,
          //                           child: Text(
          //                             AppLocalizations.of(context)!.show_my_advisor_name,
          //                             //"Show my name in Advisor",
          //                             style: TextStyle(
          //                               color: const Color.fromRGBO(102, 102, 102, 1),
          //                               fontSize: height * 0.02,
          //                               fontFamily: "Inter",
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                         ),
          //                         Text(
          //                           assessmentVal.assessmentSettings?.showAdvisorName ==
          //                               null
          //                               ? AppLocalizations.of(context)!.no
          //                           //"No"
          //                               : assessmentVal
          //                               .assessmentSettings!.showAdvisorName!
          //                               ? advisorName
          //                           //"Yes"
          //                               : AppLocalizations.of(context)!.no,
          //                           //"No",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(82, 165, 160, 1),
          //                             fontSize: height * 0.0175,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     SizedBox(
          //                       height: height * 0.01,
          //                     ),
          //                     Row(
          //                       children: [
          //                         SizedBox(
          //                           width: width * 0.4,
          //                           child: Text(
          //                             AppLocalizations.of(context)!.show_my_email,
          //                             //"Show my Email in Advisor",
          //                             style: TextStyle(
          //                               color: const Color.fromRGBO(102, 102, 102, 1),
          //                               fontSize: height * 0.02,
          //                               fontFamily: "Inter",
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                         ),
          //                         Text(
          //                           assessmentVal.assessmentSettings?.showAdvisorEmail ==
          //                               null
          //                               ? AppLocalizations.of(context)!.no
          //                           //"No"
          //                               : assessmentVal
          //                               .assessmentSettings!.showAdvisorEmail!
          //                               ? advisorEmail
          //                           //"Yes"
          //                               : AppLocalizations.of(context)!.no,
          //                           //"No",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(82, 165, 160, 1),
          //                             fontSize: height * 0.0175,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     SizedBox(
          //                       height: height * 0.01,
          //                     ),
          //                     Row(
          //                       children: [
          //                         SizedBox(
          //                           width: width * 0.4,
          //                           child: Column(
          //                               crossAxisAlignment: CrossAxisAlignment.start,
          //                               children: [
          //                                 Text(
          //                                   AppLocalizations.of(context)!.in_active,
          //                                   // "Inactive",
          //                                   style: TextStyle(
          //                                     color: const Color.fromRGBO(51, 51, 51, 1),
          //                                     fontSize: height * 0.015,
          //                                     fontFamily: "Inter",
          //                                     fontWeight: FontWeight.w700,
          //                                   ),
          //                                 ),
          //                                 Text(
          //                                   AppLocalizations.of(context)!.not_available_for_student,
          //                                   // "Not available for student",
          //                                   style: TextStyle(
          //                                     color: const Color.fromRGBO(
          //                                         153, 153, 153, 0.8),
          //                                     fontSize: height * 0.015,
          //                                     fontFamily: "Inter",
          //                                     fontWeight: FontWeight.w700,
          //                                   ),
          //                                 ),
          //                               ]),
          //                         ),
          //                         Text(
          //                           assessmentVal.assessmentSettings?.notAvailable == null
          //                               ? AppLocalizations.of(context)!.no
          //                           //"No"
          //                               : assessmentVal.assessmentSettings!.notAvailable!
          //                               ? AppLocalizations.of(context)!.yes
          //                           //"Yes"
          //                               : AppLocalizations.of(context)!.no,
          //                           //"No",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(82, 165, 160, 1),
          //                             fontSize: height * 0.0175,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     SizedBox(
          //                       height: height * 0.01,
          //                     ),
          //                     Row(
          //                       children: [
          //                         SizedBox(
          //                           width: width * 0.4,
          //                           child: Column(
          //                               crossAxisAlignment: CrossAxisAlignment.start,
          //                               children: [
          //                                 Text(
          //                                   AppLocalizations.of(context)!.allow_public_access,
          //                                   //"Allow  Public access ",
          //                                   style: TextStyle(
          //                                     color: const Color.fromRGBO(51, 51, 51, 1),
          //                                     fontSize: height * 0.015,
          //                                     fontFamily: "Inter",
          //                                     fontWeight: FontWeight.w700,
          //                                   ),
          //                                 ),
          //                                 Text(
          //                                   AppLocalizations.of(context)!.available_to_public,
          //                                   //"Available to public for practice",
          //                                   style: TextStyle(
          //                                     color: const Color.fromRGBO(
          //                                         153, 153, 153, 0.8),
          //                                     fontSize: height * 0.015,
          //                                     fontFamily: "Inter",
          //                                     fontWeight: FontWeight.w700,
          //                                   ),
          //                                 ),
          //                               ]),
          //                         ),
          //                         Text(
          //                           assessmentVal.assessmentSettings
          //                               ?.avalabilityForPractice ==
          //                               null
          //                               ?  AppLocalizations.of(context)!.no
          //                           //"No"
          //                               : assessmentVal.assessmentSettings!
          //                               .avalabilityForPractice!
          //                               ? AppLocalizations.of(context)!.yes
          //                           //"Yes"
          //                               : AppLocalizations.of(context)!.no,
          //                           //"No",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(82, 165, 160, 1),
          //                             fontSize: height * 0.0175,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ],
          //                 ):
          //                 SizedBox(
          //                   height: height * 0.015,
          //                 ),
          //                 SizedBox(
          //                   height: height * 0.015,
          //                 ),
          //                 questionShirnk
          //                     ? Container(
          //                   height: height * 0.05,
          //                   decoration: const BoxDecoration(
          //                     borderRadius: BorderRadius.only(
          //                         topLeft: Radius.circular(8.0),
          //                         topRight: Radius.circular(8.0)),
          //                     color: Color.fromRGBO(82, 165, 160, 1),
          //                   ),
          //                   child: Padding(
          //                     padding: EdgeInsets.only(left: width * 0.02),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           AppLocalizations.of(context)!.qn_button,
          //                           //"Questions",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(
          //                                 255, 255, 255, 1),
          //                             fontSize: height * 0.02,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                         Padding(
          //                           padding:
          //                           EdgeInsets.only(right: width * 0.02),
          //                           child: IconButton(
          //                             onPressed: () {
          //                               showQuestionDetails();
          //                             },
          //                             icon: const Icon(
          //                               Icons.arrow_circle_up_outlined,
          //                               color: Color.fromRGBO(255, 255, 255, 1),
          //                             ),
          //                           ),
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 )
          //                     : Container(
          //                   height: height * 0.05,
          //                   decoration: const BoxDecoration(
          //                     borderRadius: BorderRadius.only(
          //                         topLeft: Radius.circular(8.0),
          //                         topRight: Radius.circular(8.0)),
          //                     color: Color.fromRGBO(82, 165, 160, 1),
          //                   ),
          //                   child: Padding(
          //                     padding: EdgeInsets.only(left: width * 0.02),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           AppLocalizations.of(context)!.qn_button,
          //                           //"Questions",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(
          //                                 255, 255, 255, 1),
          //                             fontSize: height * 0.02,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                         Padding(
          //                           padding:
          //                           EdgeInsets.only(right: width * 0.02),
          //                           child: IconButton(
          //                             onPressed: () {
          //                               showQuestionDetails();
          //                             },
          //                             icon: const Icon(
          //                               Icons.arrow_circle_down_outlined,
          //                               color: Color.fromRGBO(255, 255, 255, 1),
          //                             ),
          //                           ),
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: height * 0.01,
          //                 ),
          //                 questionShirnk
          //                     ? SizedBox(
          //                   height: height * 0.4,
          //                   child: ListView.builder(
          //                       padding: EdgeInsets.zero,
          //                       itemCount: widget.questionList==null?0:widget.questionList!.length,
          //                       itemBuilder: (context, index) =>
          //                           QuestionWidget(
          //                             height: height,
          //                             question: widget.questionList![index],
          //                           )),
          //                 )
          //                     : const SizedBox(
          //                   height: 0,
          //                 ),
          //                 SizedBox(
          //                   height: height * 0.02,
          //                 ),
          //                 Row(
          //                   children: [
          //                     const Expanded(child: Divider()),
          //                     MouseRegion(
          //                       cursor: SystemMouseCursors.click,
          //                       child: GestureDetector(
          //                         onTap: () {
          //                           showQuestionDetails();
          //                         },
          //                         child: Text(
          //                           AppLocalizations.of(context)!.view_all_qns,
          //                           // "  View All Questions  ",
          //                           style: TextStyle(
          //                             color: const Color.fromRGBO(28, 78, 80, 1),
          //                             fontSize: height * 0.02,
          //                             fontFamily: "Inter",
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                     // MouseRegion(
          //                     //   cursor: SystemMouseCursors.click,
          //                     //   child: GestureDetector(
          //                     //     onTap: () {
          //                     //       showQuestionDetails();
          //                     //     },
          //                     //     child: const Icon(
          //                     //       Icons.keyboard_arrow_down_sharp,
          //                     //       color: Color.fromRGBO(28, 78, 80, 1),
          //                     //     ),
          //                     //   ),
          //                     // ),
          //                     const Expanded(child: Divider()),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: height * 0.02,
          //                 ),
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
          //                 // SizedBox(
          //                 //   height: height * 0.03,
          //                 // ),
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
          //                         Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));
          //
          //
          //                       },
          //                       child: Text(
          //                         AppLocalizations.of(context)!.back_to_as,
          //                         // 'Back to My Assessment',
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
          //     ));}
          if(constraints.maxWidth > 400) {  return Center(
            child: WillPopScope(
                onWillPop: () async => false,
                child: Container(
                  width: 400.0,
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.white,
                    endDrawer: const EndDrawerMenuTeacher(),
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.published_caps,
                              //"PUBLISHED",
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontSize: height * 0.0225,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.assessment_caps,
                              //"ASSESSMENT",
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontSize: height * 0.0225,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        width:400.0,
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
                              Visibility(
                                visible: _visible,
                                child: Center(
                                  child: Container(
                                    height: height * 0.06,
                                    width: 400.0 * 0.9,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      color: Color.fromRGBO(28, 78, 80, 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.as_published,
                                        //"Assessment Published Successfully",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(255, 255, 255, 1),
                                          fontSize: height * 0.02,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
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
                                  width: 400.0 * 0.888,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 400.0,
                                        height: height * 0.037,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0)),
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 400.0 * 0.02),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${assessmentVal.subject}",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "  |  ${assessmentVal.createAssessmentModelClass}",
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
                                            padding: EdgeInsets.only(left: 400.0 * 0.02),
                                            child: Text(
                                              "${assessmentVal.topic} - ${assessmentVal.subTopic}",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 400.0 * 0.02),
                                            child: assessmentVal.assessmentStatus ==
                                                'active'
                                                ? const Icon(
                                              Icons.circle,
                                              color: Color.fromRGBO(60, 176, 0, 1),
                                            )
                                                : assessmentVal.assessmentStatus ==
                                                'inprogress'
                                                ? const Icon(
                                              Icons.circle,
                                              color: Color.fromRGBO(
                                                  255, 166, 0, 1),
                                            )
                                                : const Icon(
                                              Icons.circle,
                                              color: Color.fromRGBO(
                                                  136, 136, 136, 1),
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
                                            width: 400.0 * 0.44,
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
                                                  AppLocalizations.of(context)!.marks,
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
                                            width: 400.0 * 0.44,
                                            height: height * 0.0875,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "$questionTotal",
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
                                    width: 400.0 * 0.4,
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
                                    widget.assessmentCode,
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
                                    width: 400.0 * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context)!.institute_test_id,
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
                                    assessmentVal.assessmentId != null
                                        ? "${assessmentVal.assessmentId}"
                                        : "-",
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
                                    width: 400.0 * 0.4,
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
                                    assessmentVal.assessmentDuration == null
                                        ? "00 Minutes"
                                        : "${assessmentVal.assessmentDuration} Minutes",
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
                                    width: 400.0 * 0.4,
                                    child: Text(
                                      "${AppLocalizations.of(context)!.start_date_time} : ",
                                      //"Start Date & Time:",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  assessmentVal.assessmentStartdate == null
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
                                    width: 400.0 * 0.4,
                                    child: Text(
                                      "${AppLocalizations.of(context)!.end_date_time} : ",
                                      //"End Date & Time:",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  assessmentVal.assessmentEnddate == null
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
                                  padding: EdgeInsets.only(left: 400.0 * 0.02),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.additional_details,
                                        // "Additional Details",
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
                                        width: 400.0 * 0.4,
                                        child: Text(
                                          AppLocalizations.of(context)!.category,
                                          //"Category",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(102, 102, 102, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${assessmentVal.assessmentType}",
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
                                        width: 400.0 * 0.4,
                                        child: Text(
                                          AppLocalizations.of(context)!.no_of_retries_allowed,
                                          // "Number of Retries allowed",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(102, 102, 102, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        assessmentVal.assessmentSettings
                                            ?.allowedNumberOfTestRetries ==
                                            null
                                            ? AppLocalizations.of(context)!.not_allowed
                                        //"Not Allowed"
                                            : "${AppLocalizations.of(context)!.allowed} (${assessmentVal.assessmentSettings!.allowedNumberOfTestRetries} Times)",
                                        //"Allowed (${assessmentVal.assessmentSettings!.allowedNumberOfTestRetries} Times)",
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
                                        width: 400.0 * 0.4,
                                        child: Text(
                                          AppLocalizations.of(context)!.allow_guest_Students,
                                          // "Allow Guest students",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(102, 102, 102, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        assessmentVal.assessmentSettings?.allowGuestStudent ==
                                            null
                                            ? AppLocalizations.of(context)!.not_allowed
                                        //"Not Allowed"
                                            : assessmentVal
                                            .assessmentSettings!.allowGuestStudent!
                                            ? AppLocalizations.of(context)!.allowed
                                        //"Allowed"
                                            : AppLocalizations.of(context)!.not_allowed,
                                        //"Not Allowed",
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
                                        width: 400.0 * 0.4,
                                        child: Text(
                                          AppLocalizations.of(context)!.show_answersheet_after_test,
                                          //"Show answer Sheet after test",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(102, 102, 102, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        assessmentVal.assessmentSettings
                                            ?.showSolvedAnswerSheetInAdvisor ==
                                            null
                                            ? AppLocalizations.of(context)!.not_viewable
                                        //"Not Viewable"
                                            : assessmentVal.assessmentSettings!
                                            .showSolvedAnswerSheetInAdvisor!
                                            ? AppLocalizations.of(context)!.viewable
                                        //"Viewable"
                                            : AppLocalizations.of(context)!.not_viewable,
                                        //"Not Viewable",
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
                                        width: 400.0 * 0.4,
                                        child: Text(
                                          AppLocalizations.of(context)!.show_my_advisor_name,
                                          //"Show my name in Advisor",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(102, 102, 102, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        assessmentVal.assessmentSettings?.showAdvisorName ==
                                            null
                                            ? AppLocalizations.of(context)!.no
                                        //"No"
                                            : assessmentVal
                                            .assessmentSettings!.showAdvisorName!
                                            ? advisorName
                                        //"Yes"
                                            : AppLocalizations.of(context)!.no,
                                        //"No",
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
                                        width: 400.0 * 0.4,
                                        child: Text(
                                          AppLocalizations.of(context)!.show_my_email,
                                          //"Show my Email in Advisor",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(102, 102, 102, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        assessmentVal.assessmentSettings?.showAdvisorEmail ==
                                            null
                                            ? AppLocalizations.of(context)!.no
                                        //"No"
                                            : assessmentVal
                                            .assessmentSettings!.showAdvisorEmail!
                                            ? advisorEmail
                                        //"Yes"
                                            : AppLocalizations.of(context)!.no,
                                        //"No",
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
                                        width: 400.0 * 0.4,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.in_active,
                                                // "Inactive",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!.not_available_for_student,
                                                // "Not available for student",
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
                                        assessmentVal.assessmentSettings?.notAvailable == null
                                            ? AppLocalizations.of(context)!.no
                                        //"No"
                                            : assessmentVal.assessmentSettings!.notAvailable!
                                            ? AppLocalizations.of(context)!.yes
                                        //"Yes"
                                            : AppLocalizations.of(context)!.no,
                                        //"No",
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
                                        width: 400.0 * 0.4,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.allow_public_access,
                                                //"Allow  Public access ",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(51, 51, 51, 1),
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
                                        assessmentVal.assessmentSettings
                                            ?.avalabilityForPractice ==
                                            null
                                            ?  AppLocalizations.of(context)!.no
                                        //"No"
                                            : assessmentVal.assessmentSettings!
                                            .avalabilityForPractice!
                                            ? AppLocalizations.of(context)!.yes
                                        //"Yes"
                                            : AppLocalizations.of(context)!.no,
                                        //"No",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(82, 165, 160, 1),
                                          fontSize: height * 0.0175,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ):
                              SizedBox(
                                height: height * 0.015,
                              ),
                              SizedBox(
                                height: height * 0.015,
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
                                  padding: EdgeInsets.only(left: 400.0 * 0.02),
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
                                        EdgeInsets.only(right: 400.0 * 0.02),
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
                                  padding: EdgeInsets.only(left: 400.0 * 0.02),
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
                                        EdgeInsets.only(right: 400.0 * 0.02),
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
                              SizedBox(
                                height: height * 0.01,
                              ),
                              questionShirnk
                                  ? SizedBox(
                                height: height * 0.4,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: widget.questionList==null?0:widget.questionList!.length,
                                    itemBuilder: (context, index) =>
                                        QuestionWidget(
                                          height: height,
                                          question: widget.questionList![index],
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
                                        // "  View All Questions  ",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontSize: height * 0.02,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // MouseRegion(
                                  //   cursor: SystemMouseCursors.click,
                                  //   child: GestureDetector(
                                  //     onTap: () {
                                  //       showQuestionDetails();
                                  //     },
                                  //     child: const Icon(
                                  //       Icons.keyboard_arrow_down_sharp,
                                  //       color: Color.fromRGBO(28, 78, 80, 1),
                                  //     ),
                                  //   ),
                                  // ),
                                  const Expanded(child: Divider()),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
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
                              // SizedBox(
                              //   height: height * 0.03,
                              // ),
                              Center(
                                child: SizedBox(
                                  width: 400.0 * 0.888,
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
                                      Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));


                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.back_to_as,
                                      // 'Back to My Assessment',
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
          );}
          else {  return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                endDrawer: const EndDrawerMenuTeacher(),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: height * 0.100,
                  centerTitle: true,
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.published_caps,
                          //"PUBLISHED",
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: height * 0.0225,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.assessment_caps,
                          //"ASSESSMENT",
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
                          Visibility(
                            visible: _visible,
                            child: Center(
                              child: Container(
                                height: height * 0.06,
                                width: width * 0.9,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  color: Color.fromRGBO(28, 78, 80, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.as_published,
                                    //"Assessment Published Successfully",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
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
                                            "${assessmentVal.subject}",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontSize: height * 0.02,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "  |  ${assessmentVal.createAssessmentModelClass}",
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
                                        padding: EdgeInsets.only(left: width * 0.02),
                                        child: Text(
                                          "${assessmentVal.topic} - ${assessmentVal.subTopic}",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontSize: height * 0.015,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: width * 0.02),
                                        child: assessmentVal.assessmentStatus ==
                                            'active'
                                            ? const Icon(
                                          Icons.circle,
                                          color: Color.fromRGBO(60, 176, 0, 1),
                                        )
                                            : assessmentVal.assessmentStatus ==
                                            'inprogress'
                                            ? const Icon(
                                          Icons.circle,
                                          color: Color.fromRGBO(
                                              255, 166, 0, 1),
                                        )
                                            : const Icon(
                                          Icons.circle,
                                          color: Color.fromRGBO(
                                              136, 136, 136, 1),
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
                                              AppLocalizations.of(context)!.marks,
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
                                              "$questionTotal",
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
                                widget.assessmentCode,
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
                                  AppLocalizations.of(context)!.institute_test_id,
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
                                assessmentVal.assessmentId != null
                                    ? "${assessmentVal.assessmentId}"
                                    : "-",
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
                                assessmentVal.assessmentDuration == null
                                    ? "00 Minutes"
                                    : "${assessmentVal.assessmentDuration} Minutes",
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
                                  "${AppLocalizations.of(context)!.start_date_time} : ",
                                  //"Start Date & Time:",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              assessmentVal.assessmentStartdate == null
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
                                  "${AppLocalizations.of(context)!.end_date_time} : ",
                                  //"End Date & Time:",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              assessmentVal.assessmentEnddate == null
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
                                    // "Additional Details",
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
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${assessmentVal.assessmentType}",
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
                                      AppLocalizations.of(context)!.no_of_retries_allowed,
                                      // "Number of Retries allowed",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    assessmentVal.assessmentSettings
                                        ?.allowedNumberOfTestRetries ==
                                        null
                                        ? AppLocalizations.of(context)!.not_allowed
                                    //"Not Allowed"
                                        : "${AppLocalizations.of(context)!.allowed} (${assessmentVal.assessmentSettings!.allowedNumberOfTestRetries} Times)",
                                    //"Allowed (${assessmentVal.assessmentSettings!.allowedNumberOfTestRetries} Times)",
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
                                      AppLocalizations.of(context)!.allow_guest_Students,
                                      // "Allow Guest students",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    assessmentVal.assessmentSettings?.allowGuestStudent ==
                                        null
                                        ? AppLocalizations.of(context)!.not_allowed
                                    //"Not Allowed"
                                        : assessmentVal
                                        .assessmentSettings!.allowGuestStudent!
                                        ? AppLocalizations.of(context)!.allowed
                                    //"Allowed"
                                        : AppLocalizations.of(context)!.not_allowed,
                                    //"Not Allowed",
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
                                      AppLocalizations.of(context)!.show_answersheet_after_test,
                                      //"Show answer Sheet after test",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    assessmentVal.assessmentSettings
                                        ?.showSolvedAnswerSheetInAdvisor ==
                                        null
                                        ? AppLocalizations.of(context)!.not_viewable
                                    //"Not Viewable"
                                        : assessmentVal.assessmentSettings!
                                        .showSolvedAnswerSheetInAdvisor!
                                        ? AppLocalizations.of(context)!.viewable
                                    //"Viewable"
                                        : AppLocalizations.of(context)!.not_viewable,
                                    //"Not Viewable",
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
                                      AppLocalizations.of(context)!.show_my_advisor_name,
                                      //"Show my name in Advisor",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    assessmentVal.assessmentSettings?.showAdvisorName ==
                                        null
                                        ? AppLocalizations.of(context)!.no
                                    //"No"
                                        : assessmentVal
                                        .assessmentSettings!.showAdvisorName!
                                        ? advisorName
                                    //"Yes"
                                        : AppLocalizations.of(context)!.no,
                                    //"No",
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
                                      AppLocalizations.of(context)!.show_my_email,
                                      //"Show my Email in Advisor",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    assessmentVal.assessmentSettings?.showAdvisorEmail ==
                                        null
                                        ? AppLocalizations.of(context)!.no
                                    //"No"
                                        : assessmentVal
                                        .assessmentSettings!.showAdvisorEmail!
                                        ? advisorEmail
                                    //"Yes"
                                        : AppLocalizations.of(context)!.no,
                                    //"No",
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
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.in_active,
                                            // "Inactive",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(51, 51, 51, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!.not_available_for_student,
                                            // "Not available for student",
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
                                    assessmentVal.assessmentSettings?.notAvailable == null
                                        ? AppLocalizations.of(context)!.no
                                    //"No"
                                        : assessmentVal.assessmentSettings!.notAvailable!
                                        ? AppLocalizations.of(context)!.yes
                                    //"Yes"
                                        : AppLocalizations.of(context)!.no,
                                    //"No",
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
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.allow_public_access,
                                            //"Allow  Public access ",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(51, 51, 51, 1),
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
                                    assessmentVal.assessmentSettings
                                        ?.avalabilityForPractice ==
                                        null
                                        ?  AppLocalizations.of(context)!.no
                                    //"No"
                                        : assessmentVal.assessmentSettings!
                                        .avalabilityForPractice!
                                        ? AppLocalizations.of(context)!.yes
                                    //"Yes"
                                        : AppLocalizations.of(context)!.no,
                                    //"No",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontSize: height * 0.0175,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ):
                          SizedBox(
                            height: height * 0.015,
                          ),
                          SizedBox(
                            height: height * 0.015,
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
                          SizedBox(
                            height: height * 0.01,
                          ),
                          questionShirnk
                              ? SizedBox(
                            height: height * 0.4,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: widget.questionList==null?0:widget.questionList!.length,
                                itemBuilder: (context, index) =>
                                    QuestionWidget(
                                      height: height,
                                      question: widget.questionList![index],
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
                                    // "  View All Questions  ",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              // MouseRegion(
                              //   cursor: SystemMouseCursors.click,
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       showQuestionDetails();
                              //     },
                              //     child: const Icon(
                              //       Icons.keyboard_arrow_down_sharp,
                              //       color: Color.fromRGBO(28, 78, 80, 1),
                              //     ),
                              //   ),
                              // ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
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
                          // SizedBox(
                          //   height: height * 0.03,
                          // ),
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
                                  Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));


                                },
                                child: Text(
                                  AppLocalizations.of(context)!.back_to_as,
                                  // 'Back to My Assessment',
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
              ));}
        },
    );

  }
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key, required this.height, required this.question})
      : super(key: key);

  final double height;
  final questions.Question question;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String correctAns = '';

  @override
  void initState() {

    if(widget.question.questionType=='MCQ') {
      for (int i = 0; i < widget.question.choices!.length; i++) {
        if (widget.question.choices![i].rightChoice!) {
          correctAns = '${widget.question.choices![i].choiceText!},$correctAns';
        }
      }
      correctAns = correctAns.substring(0, correctAns.length - 1);
    }
    else{
      correctAns='';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              correctAns,
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
                  AppLocalizations.of(context)!.marks_small,
                  // 'Marks : ',
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
    );
  }
}
