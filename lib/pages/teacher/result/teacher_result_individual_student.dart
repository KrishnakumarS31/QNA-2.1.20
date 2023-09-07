import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../Components/custom_result_new_card.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import '../../../Entity/Teacher/response_entity.dart';
import '../../../EntityModel/get_result_details_model.dart';
import '../../../EntityModel/get_result_model.dart';
import '../../../Services/qna_service.dart';

class TeacherResultIndividualStudent extends StatefulWidget {
  TeacherResultIndividualStudent({
    Key? key,
    required this.result,
    required this.index,
    required this.status,
    this.results,
    this.advisorName,
  }) : super(key: key);
  final GetResultModel result;
  final int index;
  final String? advisorName;
  final String status;
  GetResultDetailsModel? results;

  @override
  TeacherResultIndividualStudentState createState() =>
      TeacherResultIndividualStudentState();
}

class TeacherResultIndividualStudentState
    extends State<TeacherResultIndividualStudent> {
  Uint8List? bytes;
  IconData showIcon = Icons.arrow_circle_down_outlined;
  List<dynamic>? allResults;
  List<QuestionsDetails> questions = [];
  bool loading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, (){getData();});
    super.initState();
  }

  Future<int> getData() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(48, 145, 139, 1),
              ));
        });
    ResponseEntity response =
    await QnaService.getQuestionDetailsService(widget.results!.assessmentResults![widget.index].attemptId);
    if(response.code == 200) {
      Navigator.pop(context);
      List<dynamic> resultsModelResponse=response.data!;
      List<QuestionsDetails>? qs = [];
      allResults = resultsModelResponse;
      for(int i=0;i<allResults!.length;i++)
      {
        QuestionsDetails questionDetails = QuestionsDetails.fromJson(allResults![i]);
        setState(() {
          qs.add(questionDetails);
        });
      }
      questions = qs;
    }
    else{
      return 400;
    }
    return response.code!;
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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth <= 960 && constraints.maxWidth >= 500) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  iconTheme: IconThemeData(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      size: height * 0.05),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: height * 0.06,
                      color: const Color.fromRGBO(28, 78, 80, 1),
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
                          //"Student Result",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                ),
                endDrawer: const EndDrawerMenuTeacher(),
                backgroundColor: Colors.white,
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
                              Text(
                                "${widget.results!.assessmentResults![widget.index]
                                        .firstName} ${widget
                                                  .results!
                                                  .assessmentResults![
                                                      widget.index]
                                                  .lastName}"
                                    ,
                                style: TextStyle(
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontSize: height * 0.025,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      iconSize: height * 0.04,
                                      icon: const Icon(
                                        Icons.mail_outline_outlined,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      onPressed: () async {}),
                                  SizedBox(width: width * 0.005),
                                  IconButton(
                                      iconSize: height * 0.04,
                                      icon: const Icon(
                                        Icons.print_rounded,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      onPressed: () {}),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.results!.assessmentResults![widget.index].rollNumber}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.result.degree}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.results!.assessmentResults![widget.index].organizationName}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const Divider(thickness: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Semester: ${widget.result.semester}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Subject: ${widget.result.subject}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Topic: ${widget.result.topic}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
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
                            assessmentResults:
                                widget.results!.assessmentResults,
                            results: widget.results!,
                            status: widget.status,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          const Divider(thickness: 2),
                          Column(
                            children: [
                              for (int i = 0; i < questions.length; i++)
                                Column(
                                  children: [
                                    MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: QuesAndAns(
                                            height: height,
                                            width: width,
                                            ques: questions[i],
                                            quesNum: i,
                                            marks: questions[i].marks ?? 0,
                                          ),
                                        )),
                                  ],
                                )
                            ],
                          ),
                        ]),
                  ),
                )));
      } else if (constraints.maxWidth > 960) {
        return Center(
          child: SizedBox(
            child: WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        size: height * 0.05),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: height * 0.06,
                        color: const Color.fromRGBO(28, 78, 80, 1),
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
                            //"Student Result",
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ),
                  endDrawer: const EndDrawerMenuTeacher(),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width * 0.6,
                          child: Column(
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${widget
                                                  .results!
                                                  .assessmentResults![
                                                      widget.index]
                                                  .firstName} ${widget
                                                  .results!
                                                  .assessmentResults![
                                                      widget.index]
                                                  .lastName}"
                                              ,
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                28, 78, 80, 1),
                                            fontSize: height * 0.025,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                iconSize: height * 0.04,
                                                icon: const Icon(
                                                  Icons.mail_outline_outlined,
                                                  color: Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                ),
                                                onPressed: () async {}),
                                            SizedBox(width: width * 0.005),
                                            IconButton(
                                                iconSize: height * 0.04,
                                                icon: const Icon(
                                                  Icons.print_rounded,
                                                  color: Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                ),
                                                onPressed: () {}),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.results!.assessmentResults![widget.index].rollNumber}",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.result.degree}",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.results!.assessmentResults![widget.index].organizationName}",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Semester: ${widget.result.semester}",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Subject: ${widget.result.subject}",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Topic: ${widget.result.topic}",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontSize: height * 0.015,
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
                                        width: width * 0.6,
                                        index: widget.index,
                                        assessmentResults:
                                            widget.results!.assessmentResults,
                                        results: widget.results!,
                                        status: widget.status),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    const Divider(thickness: 2),
                                    Column(
                                      children: [
                                        for (int i = 0;
                                            i < questions.length;
                                            i++)
                                          Column(
                                            children: [
                                              MouseRegion(
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: QuesAndAns(
                                                      height: height,
                                                      width: width,
                                                      ques: questions[i],
                                                      quesNum: i,
                                                      marks:
                                                          questions[i].marks ??
                                                              0,
                                                    ),
                                                  )),
                                            ],
                                          )
                                      ],
                                    ),
                                    // Column(
                                    //   children: [
                                    //     for(int i = 0; i <
                                    //         widget.result.assessmentResults![widget.index].questions!.length; i++)
                                    //       Column(
                                    //         children: [
                                    //           MouseRegion(
                                    //               cursor: SystemMouseCursors.click,
                                    //               child: GestureDetector(
                                    //                 onTap: () {},
                                    //                 child: QuesAndAns(
                                    //                   height: height,
                                    //                   width: width,
                                    //                   ques: widget.result.assessmentResults![widget.index].questions![i],
                                    //                   quesNum: i,
                                    //                   marks: widget.result.assessmentResults![widget.index].questions![i].marks!,
                                    //                 ),
                                    //               )),
                                    //           SizedBox(
                                    //             height: height * 0.0,
                                    //           ),
                                    //         ],
                                    //       )
                                    //   ],
                                    // ),
                                  ]),
                            ],
                          ),
                        )),
                  ),
                )),
          ),
        );
      } else {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  iconTheme: IconThemeData(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      size: height * 0.05),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: height * 0.06,
                      color: const Color.fromRGBO(28, 78, 80, 1),
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
                          //"Student Result",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                ),
                endDrawer: const EndDrawerMenuTeacher(),
                backgroundColor: Colors.white,
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
                              Text(
                                "${widget.results!.assessmentResults![widget.index]
                                        .firstName} ${widget.results!.assessmentResults![widget.index]
                                        .lastName}",
                                style: TextStyle(
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontSize: height * 0.025,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      iconSize: height * 0.04,
                                      icon: const Icon(
                                        Icons.mail_outline_outlined,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      onPressed: () async {}),
                                  SizedBox(width: width * 0.005),
                                  IconButton(
                                      iconSize: height * 0.04,
                                      icon: const Icon(
                                        Icons.print_rounded,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      onPressed: () {}),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.results!.assessmentResults![widget.index].rollNumber}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.result.degree}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.results!.assessmentResults![widget.index].organizationName}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const Divider(thickness: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Semester: ${widget.result.semester}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Subject: ${widget.result.subject}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Topic: ${widget.result.topic}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
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
                              assessmentResults:
                                  widget.results!.assessmentResults,
                              results: widget.results!,
                              status: widget.status),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          const Divider(thickness: 2),
                          Column(
                            children: [
                              for (int i = 0; i < questions.length; i++)
                                Column(
                                  children: [
                                    MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: QuesAndAns(
                                            height: height,
                                            width: width,
                                            ques: questions[i],
                                            quesNum: i,
                                            marks: questions[i].marks ?? 0,
                                          ),
                                        )),
                                  ],
                                )
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     for(int i = 0; i <
                          //         widget.result.assessmentResults![widget.index].questions!.length; i++)
                          //       Column(
                          //         children: [
                          //           MouseRegion(
                          //               cursor: SystemMouseCursors.click,
                          //               child: GestureDetector(
                          //                 onTap: () {},
                          //                 child: QuesAndAns(
                          //                   height: height,
                          //                   width: width,
                          //                   ques: widget.result.assessmentResults![widget.index].questions![i],
                          //                   quesNum: i,
                          //                   marks: widget.result.assessmentResults![widget.index].questions![i].marks!,
                          //                 ),
                          //               )),
                          //           SizedBox(
                          //             height: height * 0.0,
                          //           ),
                          //         ],
                          //       )
                          //   ],
                          // ),
                        ]),
                  ),
                )));
      }
    });
  }
}

class NumberList {
  String number;
  int index;

  NumberList({required this.number, required this.index});
}

class QuesAndAns extends StatefulWidget {
  const QuesAndAns(
      {Key? key,
      required this.height,
      required this.width,
      required this.ques,
      required this.quesNum,
      required this.marks})
      : super(key: key);

  final double height;
  final double width;
  final QuestionsDetails ques;
  final int quesNum;
  final int marks;

  @override
  State<QuesAndAns> createState() => _QuesAndAnsState();
}

class _QuesAndAnsState extends State<QuesAndAns> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth <= 960 && constraints.maxWidth >= 500) {
        return Column(children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: kElevationToShadow[1],
              ),
              width: widget.width * 0.7,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: widget.width * 0.02),
                          Text(
                            'Q${widget.quesNum + 1}',
                            style: TextStyle(
                                fontSize: widget.height * 0.014,
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: widget.width * 0.02),
                          Text(
                            '${widget.ques.questionType}',
                            style: TextStyle(
                                fontSize: widget.height * 0.014,
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: widget.width * 0.05),
                          Text(
                            widget.ques.status == "Incorrect"
                                ? 'Incorrectly Answered'
                                : widget.ques.selectedChoices == null
                                    ? "Not Answered"
                                    : "",
                            style: TextStyle(
                                fontSize: widget.height * 0.014,
                                color: const Color.fromRGBO(238, 71, 0, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),

                      widget.ques.questionType == "MCQ"
                          ? Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                color: Color.fromRGBO(28, 78, 80, 1),
                              ),
                              height: widget.height * 0.04,
                              width: widget.width * 0.1,
                              child: Text(
                                widget.ques.status == "Incorrect" ||
                                        widget.ques.marks == 0
                                    ? "\t\t\t\t0"
                                    : "\t\t+ ${widget.ques.marks}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: widget.height * 0.0237),
                              ))
                          : Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              height: widget.height * 0.04,
                              width: widget.width * 0.15,
                              child: Text(
                                "0",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: widget.height * 0.0237),
                              ))
                    ],
                  ),
                  SizedBox(
                    height: widget.height * 0.01,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(width: widget.width * 0.02),
                    Flexible(
                        child: Text(
                      widget.ques.question ?? " ",
                      style: TextStyle(
                          fontSize: widget.height * 0.014,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400),
                    )),
                  ]),
                  SizedBox(
                    height: widget.height * 0.01,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: widget.width * 0.02),
                      Text(
                        AppLocalizations.of(context)!.answered_small,
                        //'Answered:',
                        style: TextStyle(
                            fontSize: widget.height * 0.014,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                      widget.ques.questionType != "Descriptive"
                          ? Expanded(
                              child: Text(
                                widget.ques.selectedChoices == null ||
                                        widget.ques.selectedChoices!.isEmpty ||
                                        widget.ques.selectedChoices![0] == "" ||
                                        widget.ques.selectedChoices == []
                                    ? "Not Answered"
                                    : widget.ques.selectedChoices![0],
                                style: TextStyle(
                                    fontSize: widget.height * 0.014,
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          : Expanded(
                              child: Text(
                                widget.ques.descriptiveAnswers!.substring(
                                         1,
                                        widget.ques.descriptiveAnswers!.length -
                                             1).isEmpty?"Not answered":widget.ques.descriptiveAnswers!.substring(
                                         1,
                                        widget.ques.descriptiveAnswers!.length -
                                             1),
                                // widget.ques.selectedChoices == null ||
                                //         widget.ques.selectedChoices!.isEmpty ||
                                //         widget.ques.selectedChoices![0] == "" ||
                                //         widget.ques.selectedChoices == []
                                //     ? "Not answered"
                                //     : widget.ques.descriptiveAnswers!.substring(
                                //         1,
                                //         widget.ques.descriptiveAnswers!.length -
                                //             1),
                                style: TextStyle(
                                    fontSize: widget.height * 0.014,
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: widget.height * 0.015,
                  ),
                ],
              )),
          SizedBox(height: widget.height * 0.01)
        ]);
      } else if (constraints.maxWidth > 960) {
        return Container(
            child: Column(children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: kElevationToShadow[1],
              ),
              width: widget.width * 0.9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(width: widget.width * 0.02),
                      Row(
                        children: [
                          SizedBox(width: widget.width * 0.02),
                          Text(
                            'Q${widget.quesNum + 1}',
                            style: TextStyle(
                                fontSize: widget.height * 0.014,
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: widget.width * 0.02),
                          Text(
                            '${widget.ques.questionType}',
                            style: TextStyle(
                                fontSize: widget.height * 0.014,
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: widget.width * 0.03),
                          Text(
                            widget.ques.status == "Incorrect"
                                ? 'Incorrectly Answered'
                                : widget.ques.selectedChoices == null
                                    ? "Not Answered"
                                    : "",
                            style: TextStyle(
                                fontSize: widget.height * 0.014,
                                color: const Color.fromRGBO(238, 71, 0, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          widget.ques.questionType == "MCQ"
                              ? Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)),
                                    color: Color.fromRGBO(28, 78, 80, 1),
                                  ),
                                  height: widget.height * 0.04,
                                  width: widget.width * 0.1,
                                  child: Text(
                                    widget.ques.status == "Incorrect"
                                        ? "\t\t\t\t0"
                                        : "\t\t+ ${widget.ques.marks}",
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: widget.height * 0.0237),
                                  ))
                              : Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)),
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  height: widget.height * 0.04,
                                  width: widget.width * 0.15,
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: widget.height * 0.0237),
                                  )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: widget.height * 0.01,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(width: widget.width * 0.02),
                    Flexible(
                        child: Text(
                      widget.ques.question ?? " ",
                      style: TextStyle(
                          fontSize: widget.height * 0.014,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400),
                    )),
                  ]),
                  SizedBox(
                    height: widget.height * 0.01,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: widget.width * 0.02),
                      Text(
                        AppLocalizations.of(context)!.answered_small,
                        //'Answered:',
                        style: TextStyle(
                            fontSize: widget.height * 0.014,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                      widget.ques.questionType != "Descriptive"
                          ? Expanded(
                              child: Text(
                                widget.ques.selectedChoices == null ||
                                        widget.ques.selectedChoices!.isEmpty ||
                                        widget.ques.selectedChoices![0] == "" ||
                                        widget.ques.selectedChoices == []
                                    ? "Not Answered"
                                    : widget.ques.selectedChoices![0],
                                style: TextStyle(
                                    fontSize: widget.height * 0.014,
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          : Expanded(
                              child: Text(
                                widget.ques.descriptiveAnswers!.substring(
                                         1,
                                        widget.ques.descriptiveAnswers!.length -
                                             1).isEmpty?"Not answered":widget.ques.descriptiveAnswers!.substring(
                                         1,
                                        widget.ques.descriptiveAnswers!.length -
                                             1),
                                // widget.ques.selectedChoices == null ||
                                //         widget.ques.selectedChoices!.isEmpty ||
                                //         widget.ques.selectedChoices![0] == "" ||
                                //         widget.ques.selectedChoices == []
                                //     ? "Not answered"
                                //     : widget.ques.descriptiveAnswers!.substring(
                                //         1,
                                //         widget.ques.descriptiveAnswers!.length -
                                //             1),
                                style: TextStyle(
                                    fontSize: widget.height * 0.014,
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: widget.height * 0.015,
                  ),
                ],
              )),
          SizedBox(height: widget.height * 0.01)
        ]));
      } else {
        return Column(children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: kElevationToShadow[1],
              ),
              width: widget.width * 0.9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: widget.width * 0.05),
                          Text(
                            'Q${widget.quesNum + 1}',
                            style: TextStyle(
                                fontSize: widget.height * 0.014,
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: widget.width * 0.03),
                          Text(
                            '${widget.ques.questionType}',
                            style: TextStyle(
                                fontSize: widget.height * 0.014,
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: widget.width * 0.05),
                          Text(
                            widget.ques.status == "Incorrect"
                                ? 'Incorrectly Answered'
                                : widget.ques.selectedChoices == null
                                    ? "Not Answered"
                                    : "",
                            style: TextStyle(
                                fontSize: widget.height * 0.014,
                                color: const Color.fromRGBO(238, 71, 0, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),

                      widget.ques.questionType == "MCQ"
                          ? Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                color: Color.fromRGBO(28, 78, 80, 1),
                              ),
                              height: widget.height * 0.04,
                              width: widget.width * 0.2,
                              child: Text(
                                widget.ques.status == "Incorrect"
                                    ? "\t\t\t\t0"
                                    : "\t\t+ ${widget.ques.marks}",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: widget.height * 0.0237),
                              ))
                          : Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              height: widget.height * 0.04,
                              width: widget.width * 0.15,
                              child: Text(
                                "0",
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: widget.height * 0.0237),
                              ))
                    ],
                  ),
                  SizedBox(
                    height: widget.height * 0.01,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(width: widget.width * 0.02),
                    Flexible(
                        child: Text(
                      widget.ques.question ?? " ",
                      style: TextStyle(
                          fontSize: widget.height * 0.014,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400),
                    )),
                  ]),
                  SizedBox(
                    height: widget.height * 0.01,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: widget.width * 0.02),
                      Text(
                        AppLocalizations.of(context)!.answered_small,
                        //'Answered:',
                        style: TextStyle(
                            fontSize: widget.height * 0.014,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                      widget.ques.questionType != "Descriptive"
                          ? Expanded(
                              child: Text(
                                widget.ques.selectedChoices == null ||
                                        widget.ques.selectedChoices!.isEmpty ||
                                        widget.ques.selectedChoices![0] == "" ||
                                        widget.ques.selectedChoices == []
                                    ? "Not Answered"
                                    : widget.ques.selectedChoices![0],
                                style: TextStyle(
                                    fontSize: widget.height * 0.014,
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          : Expanded(
                              child: Text(
                                  widget.ques
                                        .descriptiveAnswers!.substring(
                                        1, widget.ques.descriptiveAnswers!.length - 1).isEmpty ? 'NotAnswered' :widget.ques
                                        .descriptiveAnswers!.substring(
                                        1, widget.ques.descriptiveAnswers!.length - 1),

                                // widget.ques.selectedChoices == null ||
                                //         widget.ques.selectedChoices!.isEmpty ||
                                //         widget.ques.selectedChoices![0] == "" ||
                                //         widget.ques.selectedChoices == []
                                //     ? "Not answered"
                                //     : widget.ques.descriptiveAnswers!.substring(
                                //         1,
                                //         widget.ques.descriptiveAnswers!.length -
                                //             1),
                                style: TextStyle(
                                    fontSize: widget.height * 0.014,
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: widget.height * 0.015,
                  ),
                ],
              )),
          SizedBox(height: widget.height * 0.01)
        ]);
      }
    });
  }
}
