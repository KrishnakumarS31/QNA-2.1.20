import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Components/custom_result_total_card.dart';
import 'package:qna_test/Pages/teacher_result_individual_student.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Components/today_date.dart';
import '../EntityModel/get_result_model.dart';
import '../Components/custom_card1.dart';

class TeacherResultTotal extends StatefulWidget {
  const TeacherResultTotal({
    Key? key,
    required this.result,
    this.userId,
    this.advisorName,
  }) : super(key: key);
  final GetResultModel result;
  final int? userId;
  final String? advisorName;

  @override
  TeacherResultTotalState createState() => TeacherResultTotalState();
}

class TeacherResultTotalState extends State<TeacherResultTotal> {
  IconData showIcon = Icons.expand_circle_down_outlined;

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

    int? assessmentStartDate = widget.result.assessmentStartDate;
    int? assessmentEndDate = widget.result.assessmentEndDate;
    int? assessmentDuration = widget.result.assessmentDuration;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            endDrawer: const EndDrawerMenuTeacher(),
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
                      'RESULTS',
                      style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "TOTAL",
                      style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: height * 0.0225,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          // Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.drafts_outlined,
                          //       color: Color.fromRGBO(82, 165, 160, 1),
                          //     ),
                          //     SizedBox(
                          //       width: width * 0.03,
                          //     ),
                          //     const Icon(
                          //       Icons.print_outlined,
                          //       color: Color.fromRGBO(82, 165, 160, 1),
                          //     )
                          //   ],
                          // )
                        ],
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
                              : Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(
                                      233, 233, 233, 1),
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            height: height * 0.6912,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    'Subject - ${widget.result.subject}',
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
                                        color: const Color.fromRGBO(
                                            255, 157, 77, 1),
                                        size: width * 0.05,
                                      ),
                                      Text(
                                        (widget.result.assessmentResults != null && widget.result.assessmentResults?.isEmpty == false )? "${convertDate(widget.result.assessmentResults![0].attemptEndDate)} hrs" : " ",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 0.7),
                                            fontSize: height * 0.0125,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w400),
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
                                          'Advisor',
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
                                      'Title - ${widget.result.topic}',
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
                                      'Sub Topic ${widget.result.subTopic}',
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
                                      'Class ${widget.result.studentClass}',
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
                                        //crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.result.assessmentType!,
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
                                            'Category',
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
                                        //crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${widget.result.totalQuestions!}",
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
                                            'Total',
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
                                            'Questions',
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
                                            "${widget.result.totalScore!}",
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
                                            'Total',
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
                                            'Marks',
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
                                      'Schedule',
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
                                          'Test max. Time permitted: ',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        Text(
                                          assessmentDuration != null ? '${convertTime(assessmentDuration)} hrs' : "",
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
                                          'Test Opening Date & Time:',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        Text( assessmentStartDate != null ? '${convertDate(assessmentStartDate)}, ${convertTime(assessmentStartDate)} IST': " ",
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
                                          'Test Closing Date & Time:',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        Text(
                                          assessmentEndDate != null ? '${convertDate(assessmentEndDate)}, ${convertTime(assessmentEndDate)} + " IST"': " ",
                                          //"$closingDate, $closingTime IST",
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
                                          'Guest',
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
                                              ? "Allowed"
                                              : "Not Allowed",
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
                                //         // Container(
                                //         //   height: height * 0.037,
                                //         //   width: width * 0.52,
                                //         //   alignment: Alignment.center,
                                //         //   child: Text(
                                //         //     widget.result.url!,
                                //         //     style: TextStyle(
                                //         //         color:
                                //         //         const Color.fromRGBO(
                                //         //             82, 165, 160, 1),
                                //         //         fontSize: height * 0.0175,
                                //         //         fontFamily: "Inter",
                                //         //         fontWeight:
                                //         //         FontWeight.w500),
                                //         //   ),
                                //         // ),
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
                            top: showIcon == Icons.expand_circle_down_outlined
                                ? height * 0.158
                                : height * 0.661,
                            right: width * 0.07,
                            child: IconButton(
                              icon: Icon(
                                showIcon,
                                color: const Color.fromRGBO(82, 165, 160, 1),
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(

                          widget.result.assessmentResults!.length != null
                              ?
                          'Total Participants List ('
                              '${widget.result.assessmentResults!.length})'
                              :
                          'Total Participants List(0)'
                          ,
                          style: TextStyle(
                              fontSize: height * 0.0187,
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.004,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tap on respective student for details',
                          style: TextStyle(
                              fontSize: height * 0.0125,
                              color: const Color.fromRGBO(148, 148, 148, 1),
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.result.assessmentResults!.length,
                            itemBuilder: (context, index) =>
                                Column(
                                  children: [
                                    MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.rightToLeft,
                                                child: TeacherResultIndividualStudent(
                                                  result: widget.result,
                                                  comingFrom: "total",
                                                  index: index,
                                                ),
                                              ),
                                            );
                                          },
                                          child: ResultTotalCard(
                                              height: height,
                                              width: width,
                                              results: widget.result,
                                              index: index),
                                        )),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                  ],
                                ),
                          )),
                      SizedBox(
                        height: height * 0.03,
                      )
                    ]),
              ),
            )));
  }
}
