import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../Components/custom_result_new_card.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../EntityModel/get_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TeacherResultIndividualStudent extends StatefulWidget {
  const TeacherResultIndividualStudent({
    Key? key,
    required this.result,
    required this.index,
    required this.comingFrom,
    this.advisorName,
  }) : super(key: key);
  final GetResultModel result;
  final int index;
  final String? advisorName;
  final String? comingFrom;

  @override
  TeacherResultIndividualStudentState createState() =>
      TeacherResultIndividualStudentState();
}

class TeacherResultIndividualStudentState
    extends State<TeacherResultIndividualStudent> {
  Uint8List? bytes;
  IconData showIcon = Icons.expand_circle_down_outlined;
  late List<AssessmentResults> totalResults;

  @override
  void initState() {
    super.initState();
    if(widget.comingFrom == "submit")
    {
      totalResults = widget.result.assessmentResults!.where((o) => o.attemptType == "Completed").toList();
    }
    else if(widget.comingFrom == "inProgress")
    {
      totalResults = widget.result.assessmentResults!.where((o) => o.attemptType == "InProgress").toList();
    }
    else {
      totalResults = widget.result.assessmentResults!;
    }

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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints)
    {
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
                          AppLocalizations.of(context)!.results_report_caps,
                          //'RESULTS REPORT',
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.studentCaps,
                          //"STUDENT",
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
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: height * 0.005, top: height * 0.005),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " ${widget.result.assessmentId!}",
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
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Color.fromRGBO(82, 165, 160, 1),
                              ),
                              Text(
                                widget
                                    .result.assessmentResults![widget.index]
                                    .organizationName == null ? "" : widget
                                    .result.assessmentResults![widget.index]
                                    .organizationName!,
                                style: TextStyle(
                                    fontSize: height * 0.017,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          ResultCardNew(
                              height: height,
                              width: 400,
                              index: widget.index,
                              assessmentResults: totalResults,
                              results: widget.result),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            "*** ${AppLocalizations.of(context)!
                                .incorrectly_answered} ***",
                            // "*** Incorrect Answered ***",
                            style: TextStyle(
                                color: const Color.fromRGBO(238, 100, 0, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: height * 0.02),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.mcq,
                              //"MCQ",
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Column(
                            children: [
                              for(int i = 0; i <
                                  totalResults[widget.index].questions!
                                      .length; i++)
                                Column(
                                  children: [
                                    totalResults[widget.index]
                                        .questions![i]
                                        .questionType! ==
                                        "MCQ"
                                        ?
                                    (totalResults[widget.index]
                                        .questions![i].status == "Incorrect") ?
                                    MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: QuesAndAns(
                                            height: height,
                                            ques: totalResults[widget.index]
                                                .questions![i],
                                            quesNum: i,
                                            // ans: widget
                                            //     .result
                                            //     .assessmentResults![0]
                                            //     .questions,
                                          ),
                                        ))
                                        : const SizedBox() : const SizedBox(),
                                    SizedBox(
                                      height: height * 0.0,
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.survey,
                              //"Survey",
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Column(
                            children: [
                              for(int i = 0; i <
                                  totalResults[widget.index].questions!
                                      .length; i++)
                                Column(
                                  children: [
                                    totalResults[widget.index]
                                        .questions![i]
                                        .questionType! ==
                                        "Survey"
                                        ? MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: QuesAndAns(
                                            height: height,
                                            ques: totalResults[widget.index]
                                                .questions![i],
                                            quesNum: i,
                                            // ans: widget
                                            //     .result
                                            //     .assessmentResults![0]
                                            //     .questions,
                                          ),
                                        ))
                                        : const SizedBox(),
                                    SizedBox(
                                      height: height * 0.0,
                                    ),
                                  ],
                                )
                            ],
                          ),


                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(),
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.descriptive,
                              //"Descriptive",
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Column(
                            children: [
                              for(int i = 0; i <
                                  totalResults[widget.index].questions!
                                      .length; i++)
                                Column(
                                  children: [
                                    totalResults[widget.index]
                                        .questions![i]
                                        .questionType! ==
                                        "Descripitive"
                                        ? MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: QuesAndAns(
                                            height: height,
                                            ques: totalResults[widget.index]
                                                .questions![i],
                                            quesNum: i,
                                            // ans: widget
                                            //     .result
                                            //     .assessmentResults![0]
                                            //     .questions,
                                          ),
                                        ))
                                        : const SizedBox(),
                                    SizedBox(
                                      height: height * 0.0,
                                    ),
                                  ],
                                )
                            ],
                          ),
                          // Container(
                          //   height: height * 0.3,
                          //   child: ListView.builder(
                          //     scrollDirection: Axis.vertical,
                          //     shrinkWrap: true,
                          //     itemCount:
                          //     totalResults[widget.index].questions!.length,
                          //     itemBuilder: (context, index) =>
                          //         Column(
                          //       children: [
                          //         totalResults[widget.index]
                          //             .questions![index]
                          //             .questionType! ==
                          //             "Descripitive"
                          //             ? MouseRegion(
                          //             cursor: SystemMouseCursors.click,
                          //             child: GestureDetector(
                          //               onTap: () {},
                          //               child: QuesAndAns(
                          //                 height: height,
                          //                 ques: totalResults[widget.index]
                          //                     .questions![index],
                          //                 quesNum: index,
                          //                 // ans: widget
                          //                 //     .result
                          //                 //     .assessmentResults![0]
                          //                 //     .questions,
                          //               ),
                          //             ))
                          //             : const SizedBox(),
                          //         SizedBox(
                          //           height: height * 0.02,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                        ]),
                  ),
                )))));
      }
      else {
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
                          AppLocalizations.of(context)!.results_report_caps,
                          //'RESULTS REPORT',
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.studentCaps,
                          //"STUDENT",
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
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: height * 0.005, top: height * 0.005),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " ${widget.result.assessmentId!}",
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
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Color.fromRGBO(82, 165, 160, 1),
                              ),
                              Text(
                                widget
                                    .result.assessmentResults![widget.index]
                                    .organizationName == null ? "" : widget
                                    .result.assessmentResults![widget.index]
                                    .organizationName!,
                                style: TextStyle(
                                    fontSize: height * 0.017,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          ResultCardNew(
                              height: height,
                              width: width,
                              index: widget.index,
                              assessmentResults: totalResults,
                              results: widget.result),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            "*** ${AppLocalizations.of(context)!
                                .incorrectly_answered} ***",
                            // "*** Incorrect Answered ***",
                            style: TextStyle(
                                color: const Color.fromRGBO(238, 100, 0, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: height * 0.02),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.mcq,
                              //"MCQ",
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Column(
                            children: [
                              for(int i = 0; i <
                                  totalResults[widget.index].questions!
                                      .length; i++)
                                Column(
                                  children: [
                                    totalResults[widget.index]
                                        .questions![i]
                                        .questionType! ==
                                        "MCQ"
                                        ?
                                    (totalResults[widget.index]
                                        .questions![i].status == "Incorrect") ?
                                    MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: QuesAndAns(
                                            height: height,
                                            ques: totalResults[widget.index]
                                                .questions![i],
                                            quesNum: i,
                                            // ans: widget
                                            //     .result
                                            //     .assessmentResults![0]
                                            //     .questions,
                                          ),
                                        ))
                                        : const SizedBox() : const SizedBox(),
                                    SizedBox(
                                      height: height * 0.0,
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.survey,
                              //"Survey",
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Column(
                            children: [
                              for(int i = 0; i <
                                  totalResults[widget.index].questions!
                                      .length; i++)
                                Column(
                                  children: [
                                    totalResults[widget.index]
                                        .questions![i]
                                        .questionType! ==
                                        "Survey"
                                        ? MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: QuesAndAns(
                                            height: height,
                                            ques: totalResults[widget.index]
                                                .questions![i],
                                            quesNum: i,
                                            // ans: widget
                                            //     .result
                                            //     .assessmentResults![0]
                                            //     .questions,
                                          ),
                                        ))
                                        : const SizedBox(),
                                    SizedBox(
                                      height: height * 0.0,
                                    ),
                                  ],
                                )
                            ],
                          ),


                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(),
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.descriptive,
                              //"Descriptive",
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Column(
                            children: [
                              for(int i = 0; i <
                                  totalResults[widget.index].questions!
                                      .length; i++)
                                Column(
                                  children: [
                                    totalResults[widget.index]
                                        .questions![i]
                                        .questionType! ==
                                        "Descripitive"
                                        ? MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: QuesAndAns(
                                            height: height,
                                            ques: totalResults[widget.index]
                                                .questions![i],
                                            quesNum: i,
                                            // ans: widget
                                            //     .result
                                            //     .assessmentResults![0]
                                            //     .questions,
                                          ),
                                        ))
                                        : const SizedBox(),
                                    SizedBox(
                                      height: height * 0.0,
                                    ),
                                  ],
                                )
                            ],
                          ),
                          // Container(
                          //   height: height * 0.3,
                          //   child: ListView.builder(
                          //     scrollDirection: Axis.vertical,
                          //     shrinkWrap: true,
                          //     itemCount:
                          //     totalResults[widget.index].questions!.length,
                          //     itemBuilder: (context, index) =>
                          //         Column(
                          //       children: [
                          //         totalResults[widget.index]
                          //             .questions![index]
                          //             .questionType! ==
                          //             "Descripitive"
                          //             ? MouseRegion(
                          //             cursor: SystemMouseCursors.click,
                          //             child: GestureDetector(
                          //               onTap: () {},
                          //               child: QuesAndAns(
                          //                 height: height,
                          //                 ques: totalResults[widget.index]
                          //                     .questions![index],
                          //                 quesNum: index,
                          //                 // ans: widget
                          //                 //     .result
                          //                 //     .assessmentResults![0]
                          //                 //     .questions,
                          //               ),
                          //             ))
                          //             : const SizedBox(),
                          //         SizedBox(
                          //           height: height * 0.02,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                        ]),
                  ),
                )));
      }
    }
    );}}

class NumberList {
  String number;
  int index;

  NumberList({required this.number, required this.index});
}

class QuesAndAns extends StatefulWidget {
  const QuesAndAns(
      {Key? key, required this.height, required this.ques,required this.quesNum})
      : super(key: key);

  final double height;
  final Questions ques;
  final int quesNum;

  @override
  State<QuesAndAns> createState() => _QuesAndAnsState();
}

class _QuesAndAnsState extends State<QuesAndAns> {

  @override
  void initState()
  {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 400) {
        return
          Center(
            child: SizedBox(
            width: 400,
            child:
            Column(
          children: [
            SizedBox(
              height: widget.height * 0.015,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    'Q',
                    style: TextStyle(
                        fontSize: widget.height * 0.014,
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${widget.quesNum + 1}',
                    style: TextStyle(
                        fontSize: widget.height * 0.014,
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: widget.height * 0.005,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.ques.question ?? " ",
                      style: TextStyle(
                          fontSize: widget.height * 0.014,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: widget.height * 0.01,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.answered_small,
                    //'Answered:',
                    style: TextStyle(
                        fontSize: widget.height * 0.014,
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400),
                  ),
                  widget.ques.questionType != "Descripitive" ?
                  Expanded(
                    child: Text(
                      widget.ques.selectedChoices == null ? " " : widget.ques
                          .selectedChoices![0],
                      style: TextStyle(
                          fontSize: widget.height * 0.014,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400),
                    ),
                  ) :
                  Expanded(
                    child: Text(
                      widget.ques.descriptiveAnswers == null ? " " : widget.ques
                          .descriptiveAnswers!.substring(
                          1, widget.ques.descriptiveAnswers!.length - 1),
                      style: TextStyle(
                          fontSize: widget.height * 0.014,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400),
                    ),
                  ),

                ],
              ),
            ),
          ],
        )));
      }
      else
        {
          return Column(
            children: [
              SizedBox(
                height: widget.height * 0.015,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Q',
                      style: TextStyle(
                          fontSize: widget.height * 0.014,
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${widget.quesNum + 1}',
                      style: TextStyle(
                          fontSize: widget.height * 0.014,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: widget.height* 0.005,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.ques.question ?? " ",
                        style: TextStyle(
                            fontSize: widget.height * 0.014,
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.answered_small,
                      //'Answered:',
                      style: TextStyle(
                          fontSize: widget.height * 0.014,
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400),
                    ),
                    widget.ques.questionType != "Descripitive" ?
                    Expanded(
                      child: Text(widget.ques.selectedChoices == null ? " " : widget.ques.selectedChoices![0],
                        style: TextStyle(
                            fontSize: widget.height * 0.014,
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                    ):
                    Expanded(
                      child: Text(widget.ques.descriptiveAnswers == null ? " " : widget.ques.descriptiveAnswers!.substring(1,widget.ques.descriptiveAnswers!.length-1),
                        style: TextStyle(
                            fontSize: widget.height * 0.014,
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          );
        }
    }
    );}
}