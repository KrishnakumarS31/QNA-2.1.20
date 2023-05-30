import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_result_submitted.dart';
import 'package:qna_test/Pages/teacher_result_total.dart';
import 'package:qna_test/pages/teacher_result_inprogress.dart';
import '../Components/custom_card1.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Components/today_date.dart';
import '../EntityModel/get_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class TeacherResultAssessment extends StatefulWidget {
  TeacherResultAssessment({
    Key? key,
    required this.result,
    this.userId,
    this.advisorName,
    this.inProgressResults,
    this.submittedResults
  }) : super(key: key);
  GetResultModel result;
  final int? userId;
  final String? advisorName;
  List<AssessmentResults>? inProgressResults;
  List<AssessmentResults>? submittedResults;

  @override
  TeacherResultAssessmentState createState() => TeacherResultAssessmentState();
}

class TeacherResultAssessmentState extends State<TeacherResultAssessment> {
  IconData showIcon = Icons.expand_circle_down_outlined;
  int totalMarks =0;
  @override
  void initState() {
    super.initState();

  }


  changeIcon(IconData pramIcon) {
    if (pramIcon == Icons.expand_circle_down_outlined) {
      setState(() {
        showIcon = Icons.arrow_circle_up_outlined;
      });
    } else {
      setState(() {
        showIcon = Icons.expand_circle_down_outlined;
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
    var d = DateTime.fromMicrosecondsSinceEpoch(
        widget.result.assessmentStartDate!);
    var end = DateTime.fromMicrosecondsSinceEpoch(
        widget.result.assessmentEndDate!);
    DateTime now = DateTime.now();
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 400) {
        return
          Center(
            child: SizedBox(
            width: 400,
            child:  WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                endDrawer: const EndDrawerMenuTeacher(),
                resizeToAvoidBottomInset: false,
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
                          AppLocalizations.of(context)!.results_caps,
                          //'RESULTS',
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // Text(
                        //   widget.result.assessmentCode!,
                        //   style: TextStyle(
                        //     color: const Color.fromRGBO(255, 255, 255, 1),
                        //     fontSize: height * 0.0225,
                        //     fontFamily: "Inter",
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.result.assessmentCode!,
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                AppLocalizations.of(context)!.internal_ass_id,
                                //'Internal Assessment ID',
                                style: TextStyle(
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: height * 0.018,
                          // ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              showIcon == Icons.expand_circle_down_outlined
                                  ? CustomCard1(
                                height: height,
                                width: 400,
                                resultIndex: widget.result,
                              )
                                  :
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          233, 233, 233, 1),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                height: height * 0.71,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        "${AppLocalizations.of(context)!
                                            .sub_small} - ${widget.result
                                            .subject}",
                                        //"${AppLocalizations.of(context)!.sub_small} - ${widget.result.subject}",
//'Subject - ${widget.result.subject}',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                28, 78, 80, 1),
                                            fontSize: height * 0.0187,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color:
                                            end.isBefore(now)
                                                ? const Color.fromRGBO(
                                                66, 194, 0, 1)
                                                : d.isAfter(now)
                                                ? const Color.fromRGBO(
                                                179, 179, 179, 1)
                                                : const Color.fromRGBO(
                                                255, 157, 77, 1),
                                            size: height * 0.03,
                                          ),
                                          Text(
                                            assessmentStartDate != null
                                                ? convertDate(
                                                assessmentStartDate)
                                                : " ",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: width * 0.02,
                                          left: width * 0.02),
                                      child: const Divider(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.03,
                                          bottom: height * 0.015,
                                          top: height * 0.002),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .advisor,
                                              // AppLocalizations.of(context)!.advisor,
                                              //'Advisor',
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      28, 78, 80, 1),
                                                  fontSize: height * 0.0185,
                                                  fontFamily: "Inter",
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: width * 0.01,
                                            ),
                                            Text(
                                              widget.advisorName!,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontSize: height * 0.0175,
                                                  fontFamily: "Inter",
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.03,
                                          bottom: height * 0.005),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${AppLocalizations.of(context)!
                                              .title} - ${widget.result.topic}",
                                          //"${AppLocalizations.of(context)!.title} - ${widget.result.topic}",
                                          //'Title - ${widget.result.topic}',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              fontSize: height * 0.0175,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.03,
                                          bottom: height * 0.005),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${AppLocalizations.of(context)!
                                              .sub_topic_optional} - ${widget
                                              .result.subTopic}',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              fontSize: height * 0.0175,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.03,
                                          bottom: height * 0.004),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${AppLocalizations.of(context)!
                                              .degree_small} - ${widget.result
                                              .studentClass}",
                                          // "${AppLocalizations.of(context)!.degree_small} - ${widget.result.studentClass}",
                                          //'Class ${widget.result.studentClass}',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.0175,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          // height: height * 0.103,
                                          // width: width * 0.31,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                widget.result.assessmentType ??
                                                    "",
                                                style: TextStyle(
                                                    color:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontSize: height * 0.02,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .category,
                                                //AppLocalizations.of(context)!.category,
                                                //'Category',
                                                style: TextStyle(
                                                    color:
                                                    const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          // height: height * 0.103,
                                          // width: width * 0.306,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                widget.result.totalQuestions !=
                                                    null
                                                    ? widget.result
                                                    .totalQuestions.toString()
                                                    : "0",
                                                style: TextStyle(
                                                    color:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontSize: height * 0.02,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .total_small,
                                                // AppLocalizations.of(context)!.total_small,
                                                //'Total',
                                                style: TextStyle(
                                                    color:
                                                    const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .qn_button,
                                                //AppLocalizations.of(context)!.qn_button,
                                                //'Questions',
                                                style: TextStyle(
                                                    color:
                                                    const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                widget.result.totalScore != null
                                                    ? widget.result.totalScore
                                                    .toString()
                                                    : "0",
                                                style: TextStyle(
                                                    color:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontSize: height * 0.02,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .total_small,
                                                // AppLocalizations.of(context)!.total_small,
                                                //'Total',
                                                style: TextStyle(
                                                    color:
                                                    const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .marks,
                                                //'Marks',
                                                style: TextStyle(
                                                    color:
                                                    const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(left: width * 0.03),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .schedule_small,
                                          //'Schedule',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                              fontSize: height * 0.017,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.03,
                                          top: height * 0.007),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .test_time_permitted,
                                              //AppLocalizations.of(context)!.test_time_permitted,
                                              //'Test max. Time permitted: ',
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight:
                                                  FontWeight.w400),
                                            ),
                                            Text(
                                              assessmentDuration != null
                                                  ? convertDuration(
                                                  assessmentDuration)
                                                  : "0",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.03,
                                          top: height * 0.007),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .test_opening_time,
                                              //    AppLocalizations.of(context)!.test_opening_time,
                                              //'Test Opening Date & Time:',
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight:
                                                  FontWeight.w400),
                                            ),
                                            Text(
                                              assessmentStartDate != null
                                                  ? '${convertDate(
                                                  assessmentStartDate)}, ${convertTime(
                                                  assessmentStartDate)} IST'
                                                  : " ",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.03,
                                          top: height * 0.007),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .test_closing_time,
                                              //    AppLocalizations.of(context)!.test_closing_time,
                                              //'Test Closing Date & Time:',
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight:
                                                  FontWeight.w400),
                                            ),
                                            Text(
                                              assessmentEndDate != null
                                                  ? '${convertDate(
                                                  assessmentEndDate)}, ${convertTime(
                                                  assessmentEndDate)} IST'
                                                  : " ",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.03,
                                          bottom: height * 0.015,
                                          top: height * 0.002),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .guest,
                                              //'Guest',
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      28, 78, 80, 1),
                                                  fontSize: height * 0.0185,
                                                  fontFamily: "Inter",
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: width * 0.01,
                                            ),
                                            Text(
                                              widget.result
                                                  .guestStudentAllowed ==
                                                  true
                                                  ? AppLocalizations.of(
                                                  context)!.allowed
                                              //"Allowed"
                                                  : AppLocalizations.of(
                                                  context)!.not_allowed,
                                              //"Not Allowed",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontSize: height * 0.0175,
                                                  fontFamily: "Inter",
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       left: width * 0.03,
                                    //       bottom: height * 0.015,
                                    //       top: height * 0.002),
                                    //   child: Align(
                                    //     alignment: Alignment.centerLeft,
                                    //     child: Row(
                                    //       children: [
                                    //         Text(
                                    //           'URL: ',
                                    //           style: TextStyle(
                                    //               color: const Color.fromRGBO(
                                    //                   102, 102, 102, 1),
                                    //               fontSize: height * 0.015,
                                    //               fontFamily: "Inter",
                                    //               fontWeight:
                                    //               FontWeight.w400),
                                    //         ),
                                    //         SizedBox(
                                    //           width: width * 0.21,
                                    //         ),
                                    //         Container(
                                    //           height: height * 0.037,
                                    //           width: width * 0.52,
                                    //           alignment: Alignment.center,
                                    //           child: Text(
                                    //             widget.result.url!,
                                    //             style: TextStyle(
                                    //                 color:
                                    //                 const Color.fromRGBO(
                                    //                     82, 165, 160, 1),
                                    //                 fontSize: height * 0.0175,
                                    //                 fontFamily: "Inter",
                                    //                 fontWeight:
                                    //                 FontWeight.w500),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       left: width * 0.03,
                                    //       bottom: height * 0.015,
                                    //       top: height * 0.002),
                                    //   child: Align(
                                    //     alignment: Alignment.centerLeft,
                                    //     child: Row(
                                    //       children: [
                                    //         Text(
                                    //           'Android APP:',
                                    //           style: TextStyle(
                                    //               color: const Color.fromRGBO(
                                    //                   102, 102, 102, 1),
                                    //               fontSize: height * 0.015,
                                    //               fontFamily: "Inter",
                                    //               fontWeight:
                                    //               FontWeight.w400),
                                    //         ),
                                    //         SizedBox(
                                    //           width: width * 0.1,
                                    //         ),
                                    //         Container(
                                    //           height: height * 0.037,
                                    //           width: width * 0.52,
                                    //           alignment: Alignment.center,
                                    //           child: Text(
                                    //             widget.result.androidUrl!,
                                    //             style: TextStyle(
                                    //                 color:
                                    //                 const Color.fromRGBO(
                                    //                     82, 165, 160, 1),
                                    //                 fontSize: height * 0.0175,
                                    //                 fontFamily: "Inter",
                                    //                 fontWeight:
                                    //                 FontWeight.w500),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       left: width * 0.03,
                                    //       bottom: height * 0.015,
                                    //       top: height * 0.002),
                                    //   child: Align(
                                    //     alignment: Alignment.centerLeft,
                                    //     child: Row(
                                    //       children: [
                                    //         Text(
                                    //           'IOS APP:',
                                    //           style: TextStyle(
                                    //               color: const Color.fromRGBO(
                                    //                   102, 102, 102, 1),
                                    //               fontSize: height * 0.015,
                                    //               fontFamily: "Inter",
                                    //               fontWeight:
                                    //               FontWeight.w400),
                                    //         ),
                                    //         SizedBox(
                                    //           width: width * 0.17,
                                    //         ),
                                    //         Container(
                                    //           height: height * 0.037,
                                    //           width: width * 0.52,
                                    //           alignment: Alignment.center,
                                    //           child: Text(
                                    //             widget.result.iosUrl!,
                                    //             style: TextStyle(
                                    //                 color:
                                    //                 const Color.fromRGBO(
                                    //                     82, 165, 160, 1),
                                    //                 fontSize: height * 0.0175,
                                    //                 fontFamily: "Inter",
                                    //                 fontWeight:
                                    //                 FontWeight.w500),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: showIcon ==
                                    Icons.expand_circle_down_outlined
                                    ? height * 0.158
                                    : height * 0.661,
                                right: width * 0.07,
                                child: IconButton(
                                  icon: Icon(
                                    showIcon,
                                    color: const Color.fromRGBO(
                                        82, 165, 160, 1),
                                    size: height * 0.03,
                                  ),
                                  onPressed: () {
                                    changeIcon(showIcon);
                                  },
                                ),
                              )
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
                                    fontWeight: FontWeight.w700),
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
                          Center(
                          child: SizedBox(
                          width: 400,
          child:
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
                                              userId: widget.userId,
                                              advisorName: widget.advisorName),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                            const Color.fromRGBO(
                                                233, 233, 233, 1),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      // height: height * 0.1675,
                                      // width: width * 0.277,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      0, 167, 204, 1),
                                                  Color.fromRGBO(
                                                      57, 191, 200, 1),
                                                ],
                                              ),
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(50),
                                                bottomRight: Radius.circular(
                                                    50),
                                              ),
                                            ),
                                            height: height * 0.07,
                                            width: width * 0.277,
                                            child: Text(
                                              widget.result.totalAttempts !=
                                                  null ? "${widget.result
                                                  .totalAttempts} " : "0",
                                              style: TextStyle(
                                                  fontSize: height * 0.0187,
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
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
                                          SizedBox(
                                            height: height * 0.01,
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
                                              submittedArray: widget
                                                  .submittedResults,
                                              result: widget.result,
                                              advisorName: widget.advisorName),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                            const Color.fromRGBO(
                                                233, 233, 233, 1),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      // height: height * 0.1675,
                                      // width: width * 0.277,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  Color.fromRGBO(
                                                      0, 218, 205, 1),
                                                ],
                                              ),
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(50),
                                                bottomRight: Radius.circular(
                                                    50),
                                              ),
                                            ),
                                            height: height * 0.07,
                                            width: width * 0.277,
                                            child: Text(widget.result
                                                .totalCompletedAttempts != null
                                                ? "${widget.result
                                                .totalCompletedAttempts} "
                                                : "0",
                                              style: TextStyle(
                                                  fontSize: height * 0.0187,
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
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
                                          SizedBox(
                                            height: height * 0.01,
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
                                              inProgressArray: widget
                                                  .inProgressResults,
                                              result: widget.result,
                                              advisorName: widget.advisorName),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                            const Color.fromRGBO(
                                                233, 233, 233, 1),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      // height: height * 0.1675,
                                      // width: width * 0.277,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      255, 153, 0, 1),
                                                  Color.fromRGBO(
                                                      255, 199, 0, 1),
                                                ],
                                              ),
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(50),
                                                bottomRight: Radius.circular(
                                                    50),
                                              ),
                                            ),
                                            height: height * 0.07,
                                            width: width * 0.277,
                                            child: Text(
                                              widget.result
                                                  .totalInprogressAttempts !=
                                                  null
                                                  ? '${widget.result
                                                  .totalInprogressAttempts}'
                                                  : "0",
                                              style: TextStyle(
                                                  fontSize: height * 0.0187,
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
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
                                          SizedBox(
                                            height: height * 0.01,
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
                          ))),
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
                            AppLocalizations.of(context)!.results_caps,
                            //'RESULTS',
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize: height * 0.0175,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          // Text(
                          //   widget.result.assessmentCode!,
                          //   style: TextStyle(
                          //     color: const Color.fromRGBO(255, 255, 255, 1),
                          //     fontSize: height * 0.0225,
                          //     fontFamily: "Inter",
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.result.assessmentCode!,
                                style: TextStyle(
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontSize: height * 0.025,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  AppLocalizations.of(context)!.internal_ass_id,
                                  //'Internal Assessment ID',
                                  style: TextStyle(
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1),
                                      fontSize: height * 0.015,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.018,
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                showIcon == Icons.expand_circle_down_outlined
                                    ? CustomCard1(
                                  height: height,
                                  width: width,
                                  resultIndex: widget.result,
                                )
                                    :
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            233, 233, 233, 1),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  height: height * 0.71,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          "${AppLocalizations.of(context)!
                                              .sub_small} - ${widget.result
                                              .subject}",
                                          //"${AppLocalizations.of(context)!.sub_small} - ${widget.result.subject}",
//'Subject - ${widget.result.subject}',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                              fontSize: height * 0.0187,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700),
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color:
                                              end.isBefore(now)
                                                  ? const Color.fromRGBO(
                                                  66, 194, 0, 1)
                                                  : d.isAfter(now)
                                                  ? const Color.fromRGBO(
                                                  179, 179, 179, 1)
                                                  : const Color.fromRGBO(
                                                  255, 157, 77, 1),
                                              size: height * 0.03,
                                            ),
                                            Text(
                                              assessmentStartDate != null
                                                  ? convertDate(
                                                  assessmentStartDate)
                                                  : " ",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: width * 0.02,
                                            left: width * 0.02),
                                        child: const Divider(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.03,
                                            bottom: height * 0.015,
                                            top: height * 0.002),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .advisor,
                                                // AppLocalizations.of(context)!.advisor,
                                                //'Advisor',
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        28, 78, 80, 1),
                                                    fontSize: height * 0.0185,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                              SizedBox(
                                                width: width * 0.01,
                                              ),
                                              Text(
                                                widget.advisorName!,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontSize: height * 0.0175,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.03,
                                            bottom: height * 0.005),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${AppLocalizations.of(context)!
                                                .title} - ${widget.result.topic}",
                                            //"${AppLocalizations.of(context)!.title} - ${widget.result.topic}",
                                            //'Title - ${widget.result.topic}',
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.03,
                                            bottom: height * 0.005),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${AppLocalizations.of(context)!
                                                .sub_topic_optional} - ${widget
                                                .result.subTopic}',
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.03,
                                            bottom: height * 0.004),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${AppLocalizations.of(context)!
                                                .degree_small} - ${widget.result
                                                .studentClass}",
                                            // "${AppLocalizations.of(context)!.degree_small} - ${widget.result.studentClass}",
                                            //'Class ${widget.result.studentClass}',
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.103,
                                            width: width * 0.31,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget.result.assessmentType ??
                                                      "",
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                      fontSize: height * 0.02,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                      FontWeight.w700),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .category,
                                                  //AppLocalizations.of(context)!.category,
                                                  //'Category',
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                      fontSize: height * 0.015,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: height * 0.103,
                                            width: width * 0.306,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                    width: 1.0,
                                                    color: Color.fromRGBO(
                                                        232, 232, 232, 1)),
                                                right: BorderSide(
                                                    width: 1.0,
                                                    color: Color.fromRGBO(
                                                        232, 232, 232, 1)),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget.result.totalQuestions !=
                                                      null
                                                      ? widget.result
                                                      .totalQuestions.toString()
                                                      : "0",
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                      fontSize: height * 0.02,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                      FontWeight.w700),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .total_small,
                                                  // AppLocalizations.of(context)!.total_small,
                                                  //'Total',
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                      fontSize: height * 0.015,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .qn_button,
                                                  //AppLocalizations.of(context)!.qn_button,
                                                  //'Questions',
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                      fontSize: height * 0.015,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.103,
                                            width: width * 0.265,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget.result.totalScore != null
                                                      ? widget.result.totalScore
                                                      .toString()
                                                      : "0",
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                      fontSize: height * 0.02,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                      FontWeight.w700),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .total_small,
                                                  // AppLocalizations.of(context)!.total_small,
                                                  //'Total',
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                      fontSize: height * 0.015,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .marks,
                                                  //'Marks',
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                      fontSize: height * 0.015,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const Divider(),
                                      Padding(
                                        padding:
                                        EdgeInsets.only(left: width * 0.03),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .schedule_small,
                                            //'Schedule',
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontSize: height * 0.017,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.03,
                                            top: height * 0.007),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .test_time_permitted,
                                                //AppLocalizations.of(context)!.test_time_permitted,
                                                //'Test max. Time permitted: ',
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                              Text(
                                                assessmentDuration != null
                                                    ? convertDuration(
                                                    assessmentDuration)
                                                    : "0",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.03,
                                            top: height * 0.007),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .test_opening_time,
                                                //    AppLocalizations.of(context)!.test_opening_time,
                                                //'Test Opening Date & Time:',
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                              Text(
                                                assessmentStartDate != null
                                                    ? '${convertDate(
                                                    assessmentStartDate)}, ${convertTime(
                                                    assessmentStartDate)} IST'
                                                    : " ",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.03,
                                            top: height * 0.007),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .test_closing_time,
                                                //    AppLocalizations.of(context)!.test_closing_time,
                                                //'Test Closing Date & Time:',
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                              Text(
                                                assessmentEndDate != null
                                                    ? '${convertDate(
                                                    assessmentEndDate)}, ${convertTime(
                                                    assessmentEndDate)} IST'
                                                    : " ",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.03,
                                            bottom: height * 0.015,
                                            top: height * 0.002),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .guest,
                                                //'Guest',
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        28, 78, 80, 1),
                                                    fontSize: height * 0.0185,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                              SizedBox(
                                                width: width * 0.01,
                                              ),
                                              Text(
                                                widget.result
                                                    .guestStudentAllowed ==
                                                    true
                                                    ? AppLocalizations.of(
                                                    context)!.allowed
                                                //"Allowed"
                                                    : AppLocalizations.of(
                                                    context)!.not_allowed,
                                                //"Not Allowed",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontSize: height * 0.0175,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(
                                      //       left: width * 0.03,
                                      //       bottom: height * 0.015,
                                      //       top: height * 0.002),
                                      //   child: Align(
                                      //     alignment: Alignment.centerLeft,
                                      //     child: Row(
                                      //       children: [
                                      //         Text(
                                      //           'URL: ',
                                      //           style: TextStyle(
                                      //               color: const Color.fromRGBO(
                                      //                   102, 102, 102, 1),
                                      //               fontSize: height * 0.015,
                                      //               fontFamily: "Inter",
                                      //               fontWeight:
                                      //               FontWeight.w400),
                                      //         ),
                                      //         SizedBox(
                                      //           width: width * 0.21,
                                      //         ),
                                      //         Container(
                                      //           height: height * 0.037,
                                      //           width: width * 0.52,
                                      //           alignment: Alignment.center,
                                      //           child: Text(
                                      //             widget.result.url!,
                                      //             style: TextStyle(
                                      //                 color:
                                      //                 const Color.fromRGBO(
                                      //                     82, 165, 160, 1),
                                      //                 fontSize: height * 0.0175,
                                      //                 fontFamily: "Inter",
                                      //                 fontWeight:
                                      //                 FontWeight.w500),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(
                                      //       left: width * 0.03,
                                      //       bottom: height * 0.015,
                                      //       top: height * 0.002),
                                      //   child: Align(
                                      //     alignment: Alignment.centerLeft,
                                      //     child: Row(
                                      //       children: [
                                      //         Text(
                                      //           'Android APP:',
                                      //           style: TextStyle(
                                      //               color: const Color.fromRGBO(
                                      //                   102, 102, 102, 1),
                                      //               fontSize: height * 0.015,
                                      //               fontFamily: "Inter",
                                      //               fontWeight:
                                      //               FontWeight.w400),
                                      //         ),
                                      //         SizedBox(
                                      //           width: width * 0.1,
                                      //         ),
                                      //         Container(
                                      //           height: height * 0.037,
                                      //           width: width * 0.52,
                                      //           alignment: Alignment.center,
                                      //           child: Text(
                                      //             widget.result.androidUrl!,
                                      //             style: TextStyle(
                                      //                 color:
                                      //                 const Color.fromRGBO(
                                      //                     82, 165, 160, 1),
                                      //                 fontSize: height * 0.0175,
                                      //                 fontFamily: "Inter",
                                      //                 fontWeight:
                                      //                 FontWeight.w500),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(
                                      //       left: width * 0.03,
                                      //       bottom: height * 0.015,
                                      //       top: height * 0.002),
                                      //   child: Align(
                                      //     alignment: Alignment.centerLeft,
                                      //     child: Row(
                                      //       children: [
                                      //         Text(
                                      //           'IOS APP:',
                                      //           style: TextStyle(
                                      //               color: const Color.fromRGBO(
                                      //                   102, 102, 102, 1),
                                      //               fontSize: height * 0.015,
                                      //               fontFamily: "Inter",
                                      //               fontWeight:
                                      //               FontWeight.w400),
                                      //         ),
                                      //         SizedBox(
                                      //           width: width * 0.17,
                                      //         ),
                                      //         Container(
                                      //           height: height * 0.037,
                                      //           width: width * 0.52,
                                      //           alignment: Alignment.center,
                                      //           child: Text(
                                      //             widget.result.iosUrl!,
                                      //             style: TextStyle(
                                      //                 color:
                                      //                 const Color.fromRGBO(
                                      //                     82, 165, 160, 1),
                                      //                 fontSize: height * 0.0175,
                                      //                 fontFamily: "Inter",
                                      //                 fontWeight:
                                      //                 FontWeight.w500),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: showIcon ==
                                      Icons.expand_circle_down_outlined
                                      ? height * 0.158
                                      : height * 0.661,
                                  right: width * 0.07,
                                  child: IconButton(
                                    icon: Icon(
                                      showIcon,
                                      color: const Color.fromRGBO(
                                          82, 165, 160, 1),
                                      size: height * 0.03,
                                    ),
                                    onPressed: () {
                                      changeIcon(showIcon);
                                    },
                                  ),
                                )
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
                                      fontWeight: FontWeight.w700),
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
                                                userId: widget.userId,
                                                advisorName: widget.advisorName),
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
                                        height: height * 0.1675,
                                        width: width * 0.277,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        0, 167, 204, 1),
                                                    Color.fromRGBO(
                                                        57, 191, 200, 1),
                                                  ],
                                                ),
                                                color: Colors.black,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(50),
                                                  bottomRight: Radius.circular(
                                                      50),
                                                ),
                                              ),
                                              height: height * 0.07,
                                              width: width * 0.277,
                                              child: Text(
                                                widget.result.totalAttempts !=
                                                    null ? "${widget.result
                                                    .totalAttempts} " : "0",
                                                style: TextStyle(
                                                    fontSize: height * 0.0187,
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
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
                                            SizedBox(
                                              height: height * 0.01,
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
                                                submittedArray: widget
                                                    .submittedResults,
                                                result: widget.result,
                                                advisorName: widget.advisorName),
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
                                        height: height * 0.1675,
                                        width: width * 0.277,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    Color.fromRGBO(
                                                        0, 218, 205, 1),
                                                  ],
                                                ),
                                                color: Colors.black,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(50),
                                                  bottomRight: Radius.circular(
                                                      50),
                                                ),
                                              ),
                                              height: height * 0.07,
                                              width: width * 0.277,
                                              child: Text(widget.result
                                                  .totalCompletedAttempts != null
                                                  ? "${widget.result
                                                  .totalCompletedAttempts} "
                                                  : "0",
                                                style: TextStyle(
                                                    fontSize: height * 0.0187,
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
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
                                            SizedBox(
                                              height: height * 0.01,
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
                                                inProgressArray: widget
                                                    .inProgressResults,
                                                result: widget.result,
                                                advisorName: widget.advisorName),
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
                                        height: height * 0.1675,
                                        width: width * 0.277,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        255, 153, 0, 1),
                                                    Color.fromRGBO(
                                                        255, 199, 0, 1),
                                                  ],
                                                ),
                                                color: Colors.black,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(50),
                                                  bottomRight: Radius.circular(
                                                      50),
                                                ),
                                              ),
                                              height: height * 0.07,
                                              width: width * 0.277,
                                              child: Text(
                                                widget.result
                                                    .totalInprogressAttempts !=
                                                    null
                                                    ? '${widget.result
                                                    .totalInprogressAttempts}'
                                                    : "0",
                                                style: TextStyle(
                                                    fontSize: height * 0.0187,
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
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
                                            SizedBox(
                                              height: height * 0.01,
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
