import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Entity/Teacher/get_assessment_header.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Entity/user_details.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/post_assessment_model.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Providers/question_num_provider.dart';
import 'package:provider/provider.dart';
import '../Entity/question_paper_model.dart';
import 'package:intl/intl.dart';
import '../Services/qna_service.dart';
import '../DataSource/http_url.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class StudentReviseQuest extends StatefulWidget {
  const StudentReviseQuest({Key? key,
    required this.questions, required this.userName, required this.assessmentID,
    required this.startTime, required this.assessmentCode,required this.submit,
    this.userId,required this.isMember,required this.assessmentHeaders
  }) : super(key: key);
  final QuestionPaperModel questions;
  final String userName;
  final int startTime;
  final String assessmentID;
  final int assessmentCode;
  final bool submit;
  final int? userId;
  final bool isMember;
  final GetAssessmentHeaderModel assessmentHeaders;



  @override
  StudentReviseQuestState createState() => StudentReviseQuestState();
}

class StudentReviseQuestState extends State<StudentReviseQuest> {
  late QuestionPaperModel values;
  List<List<dynamic>> options = [];
  PostAssessmentModel assessment = PostAssessmentModel(assessmentResults: []);
  UserDetails userDetails=UserDetails();
  StreamSubscription? connection;
  bool isOffline = false;


  getData(){
    submit();
  }

  @override
  void initState() {

    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none){
        setState(() {
          isOffline = true;
        });
      }
    else {
        setState(() {
          isOffline = false;
        });
    }
    });
    super.initState();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    values = widget.questions;
    for (int j = 1; j <= Provider
        .of<Questions>(context, listen: false)
        .totalQuestion
        .length; j++) {
      List<dynamic> selectedAns = Provider
          .of<Questions>(context, listen: false)
          .totalQuestion['$j'][0];
      List<dynamic> selectedAnswers = [];
      for (int t = 0; t < selectedAns.length; t++) {
        if (widget.questions.data!.questions![j - 1].questionType == 'MCQ') {
          selectedAnswers.add(
              widget.questions.data!.questions![j - 1].choices![t].choiceText);
        }
        else {
          String temp = '';
          temp = Provider
              .of<Questions>(context, listen: false)
              .totalQuestion['$j'][0].toString().substring(1, Provider
              .of<Questions>(context, listen: false)
              .totalQuestion['$j'][0]
              .toString()
              .length - 1);
          selectedAnswers.add(temp);
        }
      }
      options.add(selectedAnswers);
    }
    if(widget.submit == true){
      getData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    connection?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;
    double localWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > webWidth) {
          return Center(
              child: SizedBox(
              width: webWidth,
              child: WillPopScope(
              onWillPop: () async => false, child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(children: [
                    Column(
                        children: [
                          Container(
                            height: localHeight * 0.25,
                            width: webWidth * 1,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(0, 106, 100, 1),
                                  Color.fromRGBO(82, 165, 160, 1),
                                ],
                              ),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.elliptical(
                                      webWidth * 2.0,
                                      localHeight * 0.6)
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: localHeight * 0.060),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                      children: [
                                        IconButton(
                                          tooltip: AppLocalizations.of(context)!
                                              .revise,
                                          icon: const Icon(
                                            Icons.chevron_left,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            context.read<QuestionNumProvider>()
                                                .skipQuestionNum(1);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  context.read<QuestionNumProvider>()
                                                      .skipQuestionNum(1);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)!.revise,
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    fontSize: localHeight * 0.018,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ))]),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:
                                  SizedBox(
                                    child: Column(children: [
                                      Text(
                                        AppLocalizations.of(context)!.review,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: localHeight * 0.020,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .answer_sheet,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: localHeight * 0.020,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: localHeight * 0.03,
                                      ),
                                      Text(
                                        widget.assessmentID,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: localHeight * 0.016,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                                SizedBox(height: localHeight * 0.025),
                              ],
                            ),
                          ),
                          SizedBox(height: localHeight * 0.030),
                          Text(widget.userName,
                            style: const TextStyle(
                              color: Color.fromRGBO(82, 165, 160, 1),
                              fontSize: 18.0,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),),
                          SizedBox(height: localHeight * 0.030),
                          Column(
                              children: [
                                for (int index = 1; index <= context
                                    .watch<Questions>()
                                    .totalQuestion
                                    .length; index++)
                                  MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: webWidth,
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.all(5),
                                            child:
                                            ListTile(
                                              tileColor:
                                              Provider
                                                  .of<Questions>(
                                                  context, listen: false)
                                                  .totalQuestion['$index'][1] ==
                                                  const Color(0xff52a5a0)
                                                  ? const Color.fromRGBO(
                                                  82, 165, 160, 0.03)
                                                  : const Color.fromRGBO(
                                                  250, 250, 250, 1),
                                              title: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(children: [
                                                      Text("${AppLocalizations.of(
                                                          context)!.ques}$index",
                                                          style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  82, 165, 160, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight
                                                                  .w700,
                                                              fontSize: localHeight *
                                                                  0.012)),
                                                      SizedBox(width: localHeight *
                                                          0.010),
                                                      Text(
                                                        "(${values.data!
                                                            .questions![index - 1]
                                                            .questionMarks} ${AppLocalizations
                                                            .of(context)!.marks})",
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                179, 179, 179, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: localHeight *
                                                                0.012),
                                                      ),
                                                      SizedBox(width: localHeight *
                                                          0.010),
                                                      Provider
                                                          .of<Questions>(
                                                          context, listen: false)
                                                          .totalQuestion["$index"][2] ==
                                                          true
                                                          ? Stack(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .mode_comment_outlined,
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  255, 153, 0, 1),
                                                              size: localHeight *
                                                                  0.025),
                                                          Positioned(
                                                              left: MediaQuery
                                                                  .of(context)
                                                                  .copyWith()
                                                                  .size
                                                                  .width * 0.008,
                                                              top: MediaQuery
                                                                  .of(context)
                                                                  .copyWith()
                                                                  .size
                                                                  .height * 0.004,
                                                              child: Icon(
                                                                Icons.question_mark,
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    255, 153, 0, 1),
                                                                size: MediaQuery
                                                                    .of(context)
                                                                    .copyWith()
                                                                    .size
                                                                    .height *
                                                                    0.016,))
                                                        ],
                                                      )
                                                          : SizedBox(
                                                          width: localHeight *
                                                              0.010),
                                                    ]),
                                                    SizedBox(height: localHeight *
                                                        0.010),
                                                    Text(values.data!
                                                        .questions![index - 1]
                                                        .question!,
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromRGBO(
                                                              51, 51, 51, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          fontSize: localHeight *
                                                              0.013),
                                                    ),
                                                    SizedBox(height: localHeight *
                                                        0.015),
                                                  ]),
                                              subtitle:
                                              Column(
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.topLeft,
                                                      child:
                                                      Text(
                                                          Provider
                                                              .of<Questions>(
                                                              context,
                                                              listen: false)
                                                              .totalQuestion['$index'][1] ==
                                                              const Color(
                                                                  0xffdb2323)
                                                              ? AppLocalizations.of(
                                                              context)!.not_answered
                                                              : Provider
                                                              .of<Questions>(
                                                              context,
                                                              listen: false)
                                                              .totalQuestion['$index'][0]
                                                              .toString()
                                                              .substring(1, Provider
                                                              .of<Questions>(
                                                              context,
                                                              listen: false)
                                                              .totalQuestion['$index'][0]
                                                              .toString()
                                                              .length - 1),
                                                          style:
                                                          Provider
                                                              .of<Questions>(
                                                              context,
                                                              listen: false)
                                                              .totalQuestion['$index'][1] ==
                                                              const Color(
                                                                  0xffdb2323)
                                                              ?
                                                          TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  238, 71, 0, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: localHeight *
                                                                  0.014)
                                                              : TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  82, 165, 160, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: localHeight *
                                                                  0.014)
                                                      ),
                                                    ),
                                                    const Divider(
                                                      thickness: 2,
                                                    ),
                                                  ]),
                                            )
                                        ),
                                      ))
                              ]),
                          Column(
                            children: [
                              Align(alignment: Alignment.center,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(
                                          82, 165, 160, 1),
                                      minimumSize: const Size(280, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(39),
                                      ),
                                    ),
                                    child: Text(
                                        AppLocalizations.of(context)!.submit,
                                        style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600
                                        )
                                    ),
                                    onPressed: () {
                                      var result = Connectivity().checkConnectivity();
                                      if(result == ConnectivityResult.none){
                                        showDialogBox();
                                      }
                                      else {
                                        _showMyDialog();
                                      }
                                    }
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: localHeight * 0.030),
                        ])
                  ]))))));
        }
        else {
          return WillPopScope(
              onWillPop: () async => false, child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(children: [
                    Column(
                        children: [
                          Container(
                            height: localHeight * 0.25,
                            width: localWidth  * 1,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(0, 106, 100, 1),
                                  Color.fromRGBO(82, 165, 160, 1),
                                ],
                              ),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.elliptical(5, localHeight * 0.6)
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: localHeight * 0.060),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                      children: [
                                        IconButton(
                                          tooltip: AppLocalizations.of(context)!
                                              .revise,
                                          icon: const Icon(
                                            Icons.chevron_left,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            context.read<QuestionNumProvider>()
                                                .skipQuestionNum(1);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  context.read<QuestionNumProvider>()
                                                      .skipQuestionNum(1);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)!.revise,
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    fontSize: localHeight * 0.018,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ))]),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:
                                  SizedBox(
                                    child: Column(children: [
                                      Text(
                                        AppLocalizations.of(context)!.review,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: localHeight * 0.020,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .answer_sheet,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: localHeight * 0.020,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: localHeight * 0.03,
                                      ),
                                      Text(
                                        widget.assessmentID,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: localHeight * 0.016,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                                SizedBox(height: localHeight * 0.025),
                              ],
                            ),
                          ),
                          SizedBox(height: localHeight * 0.030),
                          Text(widget.userName,
                            style: const TextStyle(
                              color: Color.fromRGBO(82, 165, 160, 1),
                              fontSize: 18.0,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),),
                          SizedBox(height: localHeight * 0.030),
                          Column(
                              children: [
                                for (int index = 1; index <= context
                                    .watch<Questions>()
                                    .totalQuestion
                                    .length; index++)
                                  MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.all(5),
                                            child:
                                            ListTile(
                                              tileColor:
                                              Provider
                                                  .of<Questions>(
                                                  context, listen: false)
                                                  .totalQuestion['$index'][1] ==
                                                  const Color(0xff52a5a0)
                                                  ? const Color.fromRGBO(
                                                  82, 165, 160, 0.03)
                                                  : const Color.fromRGBO(
                                                  250, 250, 250, 1),
                                              title: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(children: [
                                                      Text("${AppLocalizations.of(
                                                          context)!.ques}$index",
                                                          style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  82, 165, 160, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight
                                                                  .w700,
                                                              fontSize: localHeight *
                                                                  0.012)),
                                                      SizedBox(width: localHeight *
                                                          0.010),
                                                      Text(
                                                        "(${values.data!
                                                            .questions![index - 1]
                                                            .questionMarks} ${AppLocalizations
                                                            .of(context)!.marks})",
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                179, 179, 179, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: localHeight *
                                                                0.012),
                                                      ),
                                                      SizedBox(width: localHeight *
                                                          0.010),
                                                      Provider
                                                          .of<Questions>(
                                                          context, listen: false)
                                                          .totalQuestion["$index"][2] ==
                                                          true
                                                          ? Stack(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .mode_comment_outlined,
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  255, 153, 0, 1),
                                                              size: localHeight *
                                                                  0.025),
                                                          Positioned(
                                                              left: MediaQuery
                                                                  .of(context)
                                                                  .copyWith()
                                                                  .size
                                                                  .width * 0.008,
                                                              top: MediaQuery
                                                                  .of(context)
                                                                  .copyWith()
                                                                  .size
                                                                  .height * 0.004,
                                                              child: Icon(
                                                                Icons.question_mark,
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    255, 153, 0, 1),
                                                                size: MediaQuery
                                                                    .of(context)
                                                                    .copyWith()
                                                                    .size
                                                                    .height *
                                                                    0.016,))
                                                        ],
                                                      )
                                                          : SizedBox(
                                                          width: localHeight *
                                                              0.010),
                                                    ]),
                                                    SizedBox(height: localHeight *
                                                        0.010),
                                                    Text(values.data!
                                                        .questions![index - 1]
                                                        .question!,
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromRGBO(
                                                              51, 51, 51, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          fontSize: localHeight *
                                                              0.013),
                                                    ),
                                                    SizedBox(height: localHeight *
                                                        0.015),
                                                  ]),
                                              subtitle:
                                              Column(
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.topLeft,
                                                      child:
                                                      Text(
                                                          Provider
                                                              .of<Questions>(
                                                              context,
                                                              listen: false)
                                                              .totalQuestion['$index'][1] ==
                                                              const Color(
                                                                  0xffdb2323)
                                                              ? AppLocalizations.of(
                                                              context)!.not_answered
                                                              : Provider
                                                              .of<Questions>(
                                                              context,
                                                              listen: false)
                                                              .totalQuestion['$index'][0]
                                                              .toString()
                                                              .substring(1, Provider
                                                              .of<Questions>(
                                                              context,
                                                              listen: false)
                                                              .totalQuestion['$index'][0]
                                                              .toString()
                                                              .length - 1),
                                                          style:
                                                          Provider
                                                              .of<Questions>(
                                                              context,
                                                              listen: false)
                                                              .totalQuestion['$index'][1] ==
                                                              const Color(
                                                                  0xffdb2323)
                                                              ?
                                                          TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  238, 71, 0, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: localHeight *
                                                                  0.014)
                                                              : TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  82, 165, 160, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: localHeight *
                                                                  0.014)
                                                      ),
                                                    ),
                                                    const Divider(
                                                      thickness: 2,
                                                    ),
                                                  ]),
                                            )
                                        ),
                                      ))
                              ]),
                          Column(
                            children: [
                              Align(alignment: Alignment.center,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(
                                          82, 165, 160, 1),
                                      minimumSize: const Size(280, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(39),
                                      ),
                                    ),
                                    child: Text(
                                        AppLocalizations.of(context)!.submit,
                                        style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600
                                        )
                                    ),
                                    onPressed: () {
                                      var result = Connectivity().checkConnectivity();
                                      if(result == ConnectivityResult.none){
                                        showDialogBox();
                                      }
                                      else {
                                        _showMyDialog();
                                      }
                                    }
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: localHeight * 0.030),
                        ])
                  ]))));
        }
      },
    );
  }

  Future<void> _showMyDialog() async {
    double localHeight = MediaQuery.of(context).size.height;

    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return AlertDialog(
                insetPadding: const EdgeInsets.only(
                    left: 25, right: 25),
                title: Row(
                    children: [
                  const SizedBox(width: 90),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(82, 165, 160, 1),
                    ),
                    height: localHeight * 0.1,
                    width: 40,
                    child: const Icon(
                      Icons.info_outline_rounded,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    AppLocalizations.of(context)!.confirm,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: localHeight * 0.024,
                        color: const Color.fromRGBO(
                            0, 106, 100, 1),
                        fontWeight: FontWeight.w700),
                  ),
                ]),
                content:
                Text(AppLocalizations.of(context)!.sure_to_submit),
                actions: <Widget>[
                  ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                        minimumSize: const Size(90, 30),
                      ),
                      child: Text(AppLocalizations.of(context)!.yes,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: localHeight * 0.018,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                          )
                      ),
                      onPressed: () async {
                        var result = await Connectivity().checkConnectivity();
                        Provider.of<Questions>(context, listen: false).updateAssessmentSubmit(true);
                        String message = '';
                        int ansCorrect = 0;
                        int totalMark = 0;
                        int? givenMark = 0;

                        assessment.assessmentId = widget.assessmentCode;
                        assessment.assessmentCode = widget.assessmentID;
                        assessment.userId = widget.userId;
                        assessment.statusId = 2;
                        assessment.attemptStartdate = widget.startTime;
                        assessment.attemptEnddate = DateTime
                            .now()
                            .microsecondsSinceEpoch;
                        var d1 = DateTime.fromMicrosecondsSinceEpoch(
                            widget.startTime);
                        var d2 = DateTime.fromMicrosecondsSinceEpoch(DateTime
                            .now()
                            .microsecondsSinceEpoch);
                        int difference = d2
                            .difference(d1)
                            .inMinutes;
                        assessment.attemptDuration = difference;
                        var endTimeTaken = (d2.difference(d1).toString());
                        for (int j = 1; j <= Provider.of<Questions>(context, listen: false)
                            .totalQuestion.length; j++)
                        {
                          List<int> selectedAnsId = [];
                          AssessmentResult quesResult = AssessmentResult();
                          quesResult.questionId =
                              values.data!.questions![j - 1].questionId;
                          quesResult.questionTypeId =
                              values.data!.questions![j - 1].questionTypeId;
                          quesResult.marks = 0;
                          List<dynamic> correctAns = [];
                          if (values.data!.questions![j - 1].questionType ==
                              "Descriptive") {
                            quesResult.marks = 0;
                            quesResult.statusId = 8;
                            quesResult.descriptiveText = Provider
                                .of<Questions>(context, listen: false)
                                .totalQuestion['$j'][0].toString();
                          }
                          else if (values.data!.questions![j - 1].questionType ==
                              "Survey")
                          {
                            quesResult.statusId = 8;
                            List<dynamic> selectedAns = Provider
                                .of<Questions>(context, listen: false)
                                .totalQuestion['$j'][0];
                            selectedAns.sort();
                            List<int> key = [];
                            List<String> value = [];
                            for (int s = 0; s <
                                values.data!.questions![j - 1].choices!.length; s++) {
                              key.add(values.data!.questions![j - 1].choices![s]
                                  .choiceId!);
                              value.add(values.data!.questions![j - 1].choices![s]
                                  .choiceText!);
                            }
                            for (int f = 0; f < selectedAns.length; f++) {
                              selectedAnsId.add(key[value.indexOf(selectedAns[f])]);
                            }
                            quesResult.selectedQuestionChoice = selectedAnsId;
                            quesResult.marks = 0;
                          }
                          else {
                            for (int i = 0; i < values.data!.questions![j - 1].choices!.length; i++) {
                              if (values.data!.questions![j - 1].choices![i]
                                  .rightChoice!) {
                                correctAns.add(values.data!.questions![j - 1]
                                    .choices![i].choiceText);
                              }
                            }
                            correctAns.sort();
                            List<dynamic> selectedAns = Provider
                                .of<Questions>(context, listen: false)
                                .totalQuestion['$j'][0];
                            selectedAns.sort();
                            if(selectedAns.isEmpty){
                              quesResult.statusId = 5;
                            }

                            List<int> key = [];
                            List<String> value = [];
                            for (int s = 0; s <
                                values.data!.questions![j - 1].choices!.length; s++) {
                              key.add(values.data!.questions![j - 1].choices![s]
                                  .choiceId!);
                              value.add(values.data!.questions![j - 1].choices![s]
                                  .choiceText!);
                            }
                            for (int f = 0; f < selectedAns.length; f++) {
                              selectedAnsId.add(key[value.indexOf(selectedAns[f])]);
                            }
                            quesResult.selectedQuestionChoice = selectedAnsId;

                            if (listEquals(correctAns, selectedAns)) {
                              quesResult.statusId = 6;
                              quesResult.marks =
                                  values.data!.questions![j - 1].questionMarks;
                              totalMark = totalMark +
                                  values.data!.questions![j - 1].questionMarks!;
                              ansCorrect++;
                              givenMark = values.data!.totalScore;
                            }
                            else{
                              quesResult.statusId = 7;
                            }
                          }
                          assessment.assessmentResults.add(quesResult);
                        }
                        totalMark == 0 ? totalMark = assessment.attemptScore ?? 0 : totalMark = totalMark;
                        givenMark = values.data!.totalScore ?? 0;
                        double f=0;
                        givenMark==0?f=0:
                        f = 100/givenMark;
                        double g = totalMark * f;
                        int percent =g.round();
                        assessment.attemptPercentage = percent;
                        assessment.attemptScore=totalMark;

                        if (percent == 100) {
                          assessment.assessmentScoreId =
                              values.data!.assessmentScoreMessage![0]
                                  .assessmentScoreId;
                          message = values.data!.assessmentScoreMessage![0]
                              .assessmentScoreStatus;
                        }

                        else {
                          assessment.assessmentScoreId =
                              values.data!.assessmentScoreMessage![1]
                                  .assessmentScoreId;
                          message = values.data!.assessmentScoreMessage![1]
                              .assessmentScoreStatus;
                        }
                        final DateTime now = DateTime.now();
                        final DateFormat formatter = DateFormat('dd-MM-yyyy');
                        final DateFormat timeFormatter = DateFormat('hh:mm a');
                        final String formatted = formatter.format(now);
                        final String time = timeFormatter.format(now);
                        if(result == ConnectivityResult.none){
                          showDialogBox();
                        }
                        else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color.fromRGBO(
                                          48, 145, 139, 1),
                                    ));
                              });
                          LoginModel loginResponse = await QnaService
                              .postAssessmentService(assessment, values,userDetails);
                          Navigator.of(context).pop();
                          if (loginResponse.code == 200){
                            Navigator.pushNamed(
                                context,
                                '/studentResultPage',
                                arguments: [
                                  totalMark,
                                  formatted,
                                  time,
                                  values,
                                  widget.assessmentID,
                                  widget.userName,
                                  message,
                                  endTimeTaken,
                                  givenMark,
                                  widget.isMember,
                                  widget.assessmentHeaders
                                ]);
                          }
                          else {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: CustomDialog(
                                  title: 'Answer not Submitted',
                                  content: 'please enter the',
                                  button: AppLocalizations.of(context)!
                                      .retry,
                                ),
                              ),
                            );
                          }
                        }}
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      minimumSize: const Size(90, 30),
                      side: const BorderSide(
                        width: 1.5,
                        color: Color.fromRGBO(82, 165, 160, 1),
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.no,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: localHeight * 0.018,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontWeight: FontWeight.w500
                        )
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: localHeight * 0.030),
                ],
              );
            },
          );
        }
    );}

  Future<void> submit() async {
    String message = '';
    int ansCorrect = 0;
    int totalMark = 0;
    int? givenMark = 0;
    assessment.assessmentId = widget.assessmentCode;
    assessment.assessmentCode = widget.assessmentID;
    assessment.statusId = 2;
    assessment.attemptStartdate = widget.startTime;
    assessment.attemptEnddate = DateTime
        .now()
        .microsecondsSinceEpoch;
    var d1 = DateTime.fromMicrosecondsSinceEpoch(
        widget.startTime);
    var d2 = DateTime.fromMicrosecondsSinceEpoch(DateTime
        .now()
        .microsecondsSinceEpoch);
    int difference = d2
        .difference(d1)
        .inMinutes;
    assessment.attemptDuration = difference == 0 ? 1 : difference;
    var endTimeTaken = (d2.difference(d1).toString());
    for (int j = 1; j <= Provider
        .of<Questions>(context, listen: false)
        .totalQuestion
        .length; j++) {
      List<int> selectedAnsId = [];
      AssessmentResult quesResult = AssessmentResult();
      quesResult.questionId =
          values.data!.questions![j - 1].questionId;
      quesResult.statusId = 6;
      quesResult.questionTypeId =
          values.data!.questions![j - 1].questionTypeId;
      quesResult.marks = 0;
      List<dynamic> correctAns = [];
      if (values.data!.questions![j - 1].questionType ==
          "Descriptive") {
        quesResult.statusId = 8;
        quesResult.marks = 0;
        quesResult.descriptiveText = Provider
            .of<Questions>(context, listen: false)
            .totalQuestion['$j'][0].toString();
      }
      else if (values.data!.questions![j - 1].questionType ==
          "Survey") {
        quesResult.statusId = 8;
        List<dynamic> selectedAns = Provider
            .of<Questions>(context, listen: false)
            .totalQuestion['$j'][0];
        selectedAns.sort();
        List<int> key = [];
        List<String> value = [];
        for (int s = 0; s <
            values.data!.questions![j - 1].choices!.length; s++) {
          key.add(values.data!.questions![j - 1].choices![s]
              .choiceId!);
          value.add(values.data!.questions![j - 1].choices![s]
              .choiceText!);
        }
        for (int f = 0; f < selectedAns.length; f++) {
          selectedAnsId.add(key[value.indexOf(selectedAns[f])]);
        }
        quesResult.selectedQuestionChoice = selectedAnsId;
        quesResult.marks = 0;
      }
      else {
        for (int i = 0; i <
            values.data!.questions![j - 1].choices!.length; i++) {
          if (values.data!.questions![j - 1].choices![i]
              .rightChoice!) {
            correctAns.add(values.data!.questions![j - 1]
                .choices![i].choiceText);
          }
        }
        correctAns.sort();
        List<dynamic> selectedAns = Provider
            .of<Questions>(context, listen: false)
            .totalQuestion['$j'][0];
        selectedAns.sort();
        if(selectedAns.isEmpty){
          quesResult.statusId = 5;
        }
        List<int> key = [];
        List<String> value = [];
        for (int s = 0; s <
            values.data!.questions![j - 1].choices!.length; s++) {
          key.add(values.data!.questions![j - 1].choices![s]
              .choiceId!);
          value.add(values.data!.questions![j - 1].choices![s]
              .choiceText!);
        }
        for (int f = 0; f < selectedAns.length; f++) {
          selectedAnsId.add(key[value.indexOf(selectedAns[f])]);
        }
        quesResult.selectedQuestionChoice = selectedAnsId;

        if (listEquals(correctAns, selectedAns)) {
          quesResult.statusId = 6;
          quesResult.marks =
              values.data!.questions![j - 1].questionMarks;
          totalMark = totalMark +
              values.data!.questions![j - 1].questionMarks!;
          ansCorrect++;
          givenMark = values.data!.totalScore;
        }
        else{
          quesResult.statusId = 7;
        }
      }

      assessment.assessmentResults.add(quesResult);
    }
    assessment.attemptScore = totalMark;
    values.data!.totalScore = givenMark;
    int percent=0;
    if(ansCorrect==0 || totalMark==0){
      percent=0;
    }

    else{
      double f = 100/givenMark!;
      double g = totalMark * f;
      percent = g.round();
    }
    assessment.attemptPercentage = percent;
    assessment.attemptScore=totalMark;
    if (percent == 100) {
      assessment.assessmentScoreId =
          values.data!.assessmentScoreMessage![0]
              .assessmentScoreId;
      message = values.data!.assessmentScoreMessage![0]
          .assessmentScoreStatus;
    }
    else {
      assessment.assessmentScoreId =
          values.data!.assessmentScoreMessage![1]
              .assessmentScoreId;
      message = values.data!.assessmentScoreMessage![1]
          .assessmentScoreStatus;
    }
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final DateFormat timeFormatter = DateFormat('hh:mm a');
    final String formatted = formatter.format(now);
    final String time = timeFormatter.format(now);
    LoginModel loginResponse = await QnaService
        .postAssessmentService(assessment, values,userDetails);
    if (loginResponse.code == 200) {
      Navigator.pushNamed(
          context,
          '/studentResultPage',
          arguments: [
            totalMark,
            formatted,
            time,
            values,
            widget.assessmentID,
            widget.userName,
            message,
            endTimeTaken,
            givenMark,
            widget.isMember,
            widget.assessmentHeaders
          ]);
    }
    else {
      if(context.mounted) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: CustomDialog(
              title: 'Answer not Submitted',
              content: 'please enter the',
              button: AppLocalizations.of(context)!
                  .retry,
            ),
          ),
        );
      }
    }
  }


showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) =>  AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.no_connection,
        //"NO CONNECTION",
        style: const TextStyle(
          color: Color.fromRGBO(82, 165, 160, 1),
          fontSize: 25,
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        AppLocalizations.of(context)!.check_internet,
        //"Please check your internet connectivity",
        style: const TextStyle(
          color: Color.fromRGBO(82, 165, 160, 1),
          fontSize: 16,
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
        ),
      ),
     actions: <Widget>[
        const SizedBox(width: webWidth * 0.020),
        Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            const Color.fromRGBO(255, 255, 255, 1),
            minimumSize: const Size(90, 30),
            side: const BorderSide(
              width: 1.5,
              color: Color.fromRGBO(82, 165, 160, 1),
            ),
          ),
          child: Text(AppLocalizations.of(context)!.ok_caps,
              style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: webWidth * 0.018,
                  color:
                  Color.fromRGBO(82, 165, 160, 1),
                  fontWeight: FontWeight.w500)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )),
        const SizedBox(width: webWidth * 0.005),
      ],
  ));

}

class QuestionModel {
  String qnNumber, question, answer, mark;

  QuestionModel({required this.qnNumber,
    required this.question,
    required this.answer,
    required this.mark});
}

