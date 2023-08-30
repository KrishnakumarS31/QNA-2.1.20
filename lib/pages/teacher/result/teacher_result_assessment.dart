import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Entity/user_details.dart';
import 'package:qna_test/pages/teacher/result/teacher_result_submitted.dart';
import 'package:qna_test/pages/teacher/result/teacher_result_total.dart';
import 'package:qna_test/pages/teacher/result/teacher_result_inprogress.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../Components/custom_card.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import '../../../EntityModel/get_result_model.dart';
import '../../../Components/today_date.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class TeacherResultAssessment extends StatefulWidget {
  TeacherResultAssessment({
    Key? key,
    required this.result,
    this.userId,
    required this.userDetails
    // this.inProgressResults,
    // this.submittedResults,
  }) : super(key: key);
  GetResultModel result;
  final int? userId;
  UserDetails userDetails;
  // List<AssessmentResults>? inProgressResults;
  // List<AssessmentResults>? submittedResults;

  @override
  TeacherResultAssessmentState createState() => TeacherResultAssessmentState();
}

class TeacherResultAssessmentState extends State<TeacherResultAssessment> {
  IconData showIcon = Icons.arrow_circle_down_outlined;
  int totalMarks =0;
  @override
  void initState() {
    super.initState();

  }


  changeIcon(IconData pramIcon) {
    if (pramIcon == Icons.arrow_circle_down_outlined) {
      setState(() {
        showIcon = Icons.arrow_circle_up_outlined;
      });
    } else {
      setState(() {
        showIcon = Icons.arrow_circle_down_outlined;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int? assessmentStartDate = widget.result.assessmentStartDate;
    int? assessmentEndDate = widget.result.assessmentEndDate;
    int? assessmentDuration = widget.result.assessmentDuration;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 960) {
            return Center(
                child: SizedBox(
                    child:  WillPopScope(
                        onWillPop: () async => false,
                        child: Scaffold(
                            endDrawer: const EndDrawerMenuTeacher(),
                            resizeToAvoidBottomInset: false,
                            backgroundColor: Colors.white,
                            appBar: AppBar(
                              iconTheme: IconThemeData(color: const Color.fromRGBO(28, 78, 80, 1),size: height * 0.05),
                              leading: IconButton(
                                icon: const Icon(
                                  Icons.chevron_left,
                                  size: 40.0,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              toolbarHeight: height * 0.100,
                              elevation: 0,
                              centerTitle: true,
                              title: Text(
                                AppLocalizations.of(context)!.assessment_result,
                                //'RESULTS',
                                style: TextStyle(
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontSize: height * 0.0225,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              flexibleSpace: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            body: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: height * 0.005, left: width * 0.2,right: width * 0.2),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                                        child: CustomCard(
                                          height: height,
                                          width: width,
                                          result: widget.result,
                                          isShowTotal: true,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.018,
                                      ),
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          showIcon == Icons.arrow_circle_down_outlined
                                              ?
                                          Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color.fromRGBO(153, 153, 153, 0.25),),
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(5)
                                                  )),
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      AppLocalizations.of(context)!.assessment_details,
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontSize: height * 0.022,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      showIcon,
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                      size: height * 0.04,
                                                    ),
                                                    onPressed: () {
                                                      changeIcon(showIcon);
                                                    },
                                                  ),
                                                ],
                                              ))
                                              :
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      233, 233, 233, 1),
                                                ),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: Column(
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: const Color.fromRGBO(153, 153, 153, 0.25),),
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(5)
                                                        )),
                                                    child:Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            AppLocalizations.of(context)!.assessment_details,
                                                            style: TextStyle(
                                                                color: const Color.fromRGBO(102, 102, 102, 1),
                                                                fontSize: height * 0.022,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w500),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            showIcon,
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 1),
                                                            size: height * 0.04,
                                                          ),
                                                          onPressed: () {
                                                            changeIcon(showIcon);
                                                          },
                                                        ),
                                                      ],
                                                    )),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.time_limit,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            // fontSize: widget.height * 0.013,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        assessmentDuration != null
                                                            ? convertDuration(
                                                            assessmentDuration)
                                                            : "0",
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            // fontSize: widget.height * 0.013,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.start_date_time,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            // fontSize: widget.height * 0.013,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        assessmentStartDate != null
                                                            ? '${convertDate(
                                                            assessmentStartDate)}, ${convertTime(
                                                            assessmentStartDate)} IST'
                                                            : " ",
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            // fontSize: widget.height * 0.013,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.end_date_time,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            // fontSize: widget.height * 0.013,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        assessmentEndDate != null
                                                            ? '${convertDate(
                                                            assessmentEndDate)}, ${convertTime(
                                                            assessmentEndDate)} IST'
                                                            : " ",
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            // fontSize: widget.height * 0.013,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Divider(),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${AppLocalizations.of(context)!.category}: ",
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        " ${toBeginningOfSentenceCase(widget.result.assessmentType)}",
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            // fontSize: widget.height * 0.013,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.number_of_attempts,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            // fontSize: widget.height * 0.013,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        widget.result.totalAttempts != null ? "${widget.result.totalAttempts} " : "0",
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            // fontSize: widget.height * 0.013,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.guest_students,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        widget.result.assessmentSettings!.allowGuestStudent == true
                                                            ? AppLocalizations.of(
                                                            context)!.allowed
                                                        //"Allowed"
                                                            : AppLocalizations.of(
                                                            context)!.not_allowed,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.answer_in_practice,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        widget.result.assessmentSettings!.showAnswerSheetDuringPractice == true
                                                            ? AppLocalizations.of(
                                                            context)!.viewable
                                                        //"Allowed"
                                                            : AppLocalizations.of(
                                                            context)!.not_viewable,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding: const EdgeInsets.all(8.0),
                                                //   child: Row(
                                                //     children: [
                                                //       Text(
                                                //         AppLocalizations.of(context)!.published_looq,
                                                //         style: const TextStyle(
                                                //             color: Color.fromRGBO(102, 102, 102, 1),
                                                //             // fontSize: widget.height * 0.013,
                                                //             fontFamily: "Inter",
                                                //             fontWeight: FontWeight.w600),
                                                //       ),
                                                //       const Text(
                                                //         "-",
                                                //         style: TextStyle(
                                                //             color: Color.fromRGBO(102, 102, 102, 1),
                                                //             // fontSize: widget.height * 0.013,
                                                //             fontFamily: "Inter",
                                                //             fontWeight: FontWeight.w400),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.advisor_name,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            // fontSize: widget.height * 0.013,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        widget.result.assessmentSettings!.advisorName ?? " - ",
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            // fontSize: widget.height * 0.013,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.advisor_email,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        widget.result.assessmentSettings!.advisorEmail ?? " - ",
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding: const EdgeInsets.all(8.0),
                                                //   child: Row(
                                                //     children: [
                                                //       Text(
                                                //         AppLocalizations.of(context)!.whatsapp_link,
                                                //         style: const TextStyle(
                                                //             color: Color.fromRGBO(102, 102, 102, 1),
                                                //             fontFamily: "Inter",
                                                //             fontWeight: FontWeight.w600),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Row(children: <Widget>[
                                        const Expanded(
                                            child: Divider(
                                              color: Color.fromRGBO(233, 233, 233, 1),
                                              thickness: 2,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .participation_statistics,
                                            //'Participation statistics',
                                            style: TextStyle(
                                                fontSize: height * 0.0187,
                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        const Expanded(
                                            child: Divider(
                                              color: Color.fromRGBO(233, 233, 233, 1),
                                              thickness: 2,
                                            )),
                                      ]),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.rightToLeft,
                                                      child: TeacherResultTotal(
                                                        result: widget.result,
                                                        totalAttempts: widget.result.totalAttempts ?? 0,
                                                        userId: widget.userId,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                        const Color.fromRGBO(
                                                            233, 233, 233, 1),
                                                      ),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(20))),
                                                  height: height * 0.1875,
                                                  width: width * 0.1277,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(
                                                        widget.result.totalAttempts !=
                                                            null ? "${widget.result
                                                            .totalAttempts} " : "0",
                                                        style: TextStyle(
                                                            fontSize: height * 0.0287,
                                                            color: const Color.fromRGBO(
                                                                0, 167, 204, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w700),
                                                      ),

                                                      Text(
                                                        AppLocalizations.of(context)!
                                                            .total_small,
                                                        //'Total',
                                                        style: TextStyle(
                                                            fontSize: height * 0.015,
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                      const Icon(
                                                        Icons.arrow_circle_right_outlined,
                                                        color: Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                          MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.rightToLeft,
                                                      child: TeacherResultSubmitted(
                                                          result: widget.result,
                                                          userDetails:widget.userDetails),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                        const Color.fromRGBO(
                                                            233, 233, 233, 1),
                                                      ),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(20))),
                                                  height: height * 0.1875,
                                                  width: width * 0.1277,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(widget.result
                                                          .totalCompletedAttempts != null
                                                          ? "${widget.result
                                                          .totalCompletedAttempts} "
                                                          : "0",
                                                        style: TextStyle(
                                                            fontSize: height * 0.0287,
                                                            color: const Color.fromRGBO(
                                                                82, 165, 160, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(context)!
                                                            .submitted_small,
                                                        //'Submitted',
                                                        style: TextStyle(
                                                            fontSize: height * 0.015,
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                      const Icon(
                                                        Icons.arrow_circle_right_outlined,
                                                        color: Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                          MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.rightToLeft,
                                                      child: TeacherResultInProgress(
                                                          result: widget.result),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                        const Color.fromRGBO(
                                                            233, 233, 233, 1),
                                                      ),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(20))),
                                                  height: height * 0.1875,
                                                  width: width * 0.1277,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(
                                                        widget.result
                                                            .totalInprogressAttempts !=
                                                            null
                                                            ? '${widget.result
                                                            .totalInprogressAttempts}'
                                                            : "0",
                                                        style: TextStyle(
                                                            fontSize: height * 0.0287,
                                                            color: const Color.fromRGBO(
                                                                255, 153, 0, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(context)!
                                                            .in_progress,
                                                        //'In Progress',
                                                        style: TextStyle(
                                                            fontSize: height * 0.015,
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 1),
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                      const Icon(
                                                        Icons.arrow_circle_right_outlined,
                                                        color: Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.03,
                                      )
                                    ]),
                              ),
                            )))));
          }
          else
          {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    endDrawer: const EndDrawerMenuTeacher(),
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: const Color.fromRGBO(28, 78, 80, 1),size: height * 0.05),
                      leading: IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 40.0,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      toolbarHeight: height * 0.100,
                      elevation: 0,
                      centerTitle: true,
                      title: Text(
                        AppLocalizations.of(context)!.assessment_result,
                        //'RESULTS',
                        style: TextStyle(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                                child: CustomCard(
                                  height: height,
                                  width: width,
                                  //subject: results[index].subject,
                                  result: widget.result,
                                  isShowTotal: true,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.018,
                              ),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  showIcon == Icons.arrow_circle_down_outlined
                                      ?
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromRGBO(153, 153, 153, 0.25),),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)
                                          )),
                                      // height: height * 0.31,
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              AppLocalizations.of(context)!.assessment_details,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                                  fontSize: height * 0.022,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              showIcon,
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              size: height * 0.04,
                                            ),
                                            onPressed: () {
                                              changeIcon(showIcon);
                                            },
                                          ),
                                        ],
                                      ))
                                      :
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              233, 233, 233, 1),
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: const Color.fromRGBO(153, 153, 153, 0.25),),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(5)
                                                )),
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    AppLocalizations.of(context)!.assessment_details,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontSize: height * 0.022,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    showIcon,
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    size: height * 0.04,
                                                  ),
                                                  onPressed: () {
                                                    changeIcon(showIcon);
                                                  },
                                                ),
                                              ],
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.time_limit,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    // fontSize: widget.height * 0.013,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                assessmentDuration != null
                                                    ? convertDuration(
                                                    assessmentDuration)
                                                    : "0",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    // fontSize: widget.height * 0.013,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.start_date_time,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                assessmentStartDate != null
                                                    ? '${convertDate(
                                                    assessmentStartDate)}, ${convertTime(
                                                    assessmentStartDate)} IST'
                                                    : " ",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.end_date_time,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                assessmentEndDate != null
                                                    ? '${convertDate(
                                                    assessmentEndDate)}, ${convertTime(
                                                    assessmentEndDate)} IST'
                                                    : " ",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${AppLocalizations.of(context)!.category}: ",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                " ${toBeginningOfSentenceCase(widget.result.assessmentType)}",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.number_of_attempts,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                widget.result.totalAttempts != null ? "${widget.result.totalAttempts} " : "0",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    // fontSize: widget.height * 0.013,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.guest_students,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                widget.result.assessmentSettings!.allowGuestStudent == true
                                                    ? AppLocalizations.of(
                                                    context)!.allowed
                                                //"Allowed"
                                                    : AppLocalizations.of(
                                                    context)!.not_allowed,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    // fontSize: widget.height * 0.013,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.answer_in_practice,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                widget.result.assessmentSettings!.showAnswerSheetDuringPractice == true
                                                    ? AppLocalizations.of(
                                                    context)!.viewable
                                                //"Allowed"
                                                    : AppLocalizations.of(
                                                    context)!.not_viewable,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    // fontSize: widget.height * 0.013,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(8.0),
                                        //   child: Row(
                                        //     children: [
                                        //       Text(
                                        //         AppLocalizations.of(context)!.published_looq,
                                        //         style: const TextStyle(
                                        //             color: Color.fromRGBO(102, 102, 102, 1),
                                        //             // fontSize: widget.height * 0.013,
                                        //             fontFamily: "Inter",
                                        //             fontWeight: FontWeight.w600),
                                        //       ),
                                        //       const Text(
                                        //         "-",
                                        //         style: TextStyle(
                                        //             color: Color.fromRGBO(102, 102, 102, 1),
                                        //             // fontSize: widget.height * 0.013,
                                        //             fontFamily: "Inter",
                                        //             fontWeight: FontWeight.w400),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.advisor_name,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                widget.result.assessmentSettings!.advisorName ?? " - ",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.advisor_email,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                widget.result.assessmentSettings!.advisorEmail ?? " - ",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.whatsapp_link,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              // Text(
                                              //   widget.result.url ?? "" ,
                                              //   style: const TextStyle(
                                              //       color: Color.fromRGBO(102, 102, 102, 1),
                                              //       // fontSize: widget.height * 0.013,
                                              //       fontFamily: "Inter",
                                              //       fontWeight: FontWeight.w400),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(children: <Widget>[
                                const Expanded(
                                    child: Divider(
                                      color: Color.fromRGBO(233, 233, 233, 1),
                                      thickness: 2,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .participation_statistics,
                                    //'Participation statistics',
                                    style: TextStyle(
                                        fontSize: height * 0.0187,
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                const Expanded(
                                    child: Divider(
                                      color: Color.fromRGBO(233, 233, 233, 1),
                                      thickness: 2,
                                    )),
                              ]),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: TeacherResultTotal(
                                                  result: widget.result,
                                                  totalAttempts: widget.result.totalAttempts ?? 0,
                                                  userId: widget.userId),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                const Color.fromRGBO(
                                                    233, 233, 233, 1),
                                              ),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(20))),
                                          height: height * 0.1875,
                                          width: width * 0.277,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                widget.result.totalAttempts !=
                                                    null ? "${widget.result
                                                    .totalAttempts} " : "0",
                                                style: TextStyle(
                                                    fontSize: height * 0.0287,
                                                    color: const Color.fromRGBO(
                                                        0, 167, 204, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700),
                                              ),

                                              Text(
                                                AppLocalizations.of(context)!
                                                    .total_small,
                                                //  AppLocalizations.of(context)!.total_small,
                                                //'Total',
                                                style: TextStyle(
                                                    fontSize: height * 0.015,
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const Icon(
                                                Icons.arrow_circle_right_outlined,
                                                color: Color.fromRGBO(
                                                    82, 165, 160, 1),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                  MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: TeacherResultSubmitted(
                                                  result: widget.result,
                                                  userDetails:widget.userDetails),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                const Color.fromRGBO(
                                                    233, 233, 233, 1),
                                              ),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(20))),
                                          height: height * 0.1875,
                                          width: width * 0.277,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(widget.result
                                                  .totalCompletedAttempts != null
                                                  ? "${widget.result
                                                  .totalCompletedAttempts} "
                                                  : "0",
                                                style: TextStyle(
                                                    fontSize: height * 0.0287,
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .submitted_small,
                                                //'Submitted',
                                                style: TextStyle(
                                                    fontSize: height * 0.015,
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const Icon(
                                                Icons.arrow_circle_right_outlined,
                                                color: Color.fromRGBO(
                                                    82, 165, 160, 1),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                  MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: TeacherResultInProgress(
                                                  result: widget.result),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                const Color.fromRGBO(
                                                    233, 233, 233, 1),
                                              ),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(20))),
                                          height: height * 0.1875,
                                          width: width * 0.277,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                widget.result
                                                    .totalInprogressAttempts !=
                                                    null
                                                    ? '${widget.result
                                                    .totalInprogressAttempts}'
                                                    : "0",
                                                style: TextStyle(
                                                    fontSize: height * 0.0287,
                                                    color: const Color.fromRGBO(
                                                        255, 153, 0, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .in_progress,
                                                //'In Progress',
                                                style: TextStyle(
                                                    fontSize: height * 0.015,
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const Icon(
                                                Icons.arrow_circle_right_outlined,
                                                color: Color.fromRGBO(
                                                    82, 165, 160, 1),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              )
                            ]),
                      ),
                    )));
          }
        });}}
