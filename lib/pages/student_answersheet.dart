import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Entity/question_paper_model.dart';
import '../Providers/question_num_provider.dart';
import '../DataSource/http_url.dart';
class StudentMemAnswerSheet extends StatefulWidget {
  const StudentMemAnswerSheet(
      {Key? key, required this.questions, required this.assessmentId})
      : super(key: key);
  final QuestionPaperModel questions;
  final String assessmentId;

  @override
  StudentMemAnswerSheetState createState() => StudentMemAnswerSheetState();
}

class StudentMemAnswerSheetState extends State<StudentMemAnswerSheet> {
  late QuestionPaperModel values;
  List<List<String>> options = [];

  @override
  void initState() {
    super.initState();
    values = widget.questions;

    Future<void> _launchUrl() async {
      final Uri url = Uri.parse('https://www.itneducation.com/privacypolicy');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    for (int j = 1; j <= Provider
        .of<Questions>(context, listen: false)
        .totalQuestion
        .length; j++) {
      List<dynamic> selectedAns = Provider
          .of<Questions>(context, listen: false)
          .totalQuestion['$j'][0];
      List<String> selectedAnswers = [];
      for (int t = 0; t < selectedAns.length; t++) {
        if (widget.questions.data!.questions![j - 1].questionType == 'MCQ') {}
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
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery
        .of(context)
        .size
        .width;
    double localHeight = MediaQuery
        .of(context)
        .size
        .height;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
          return WillPopScope(
              onWillPop: () async => false, child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 40.0,
                      color: Color.fromRGBO(28, 78, 80, 1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                elevation: 0,
                centerTitle: true,
                title:    Text(
                  AppLocalizations.of(context)!.solution_sheet,
                  //"Solution Sheet",
                  style: TextStyle(
                    color: const Color.fromRGBO(28, 78, 80, 1),
                    fontSize: localHeight * 0.0225,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(children: [
                    Column(children: [
                      SizedBox(height: localHeight * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.assessmentId,
                              style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: localHeight * 0.025),
                            ),
                        ],
                      ),
                      SizedBox(height: localHeight * 0.020),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: kElevationToShadow[2],
                      ),
                      width: localWidth * 0.9,
                      child:
                      Column(children: [
                        for (int index = 1; index <= context
                            .watch<Questions>()
                            .totalQuestion
                            .length; index++)
                          Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child:
                              Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(82, 165, 160, 0.08),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: localWidth * 0.9,
                                  child:
                              ListTile(
                                  title: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(children: [
                                          Text(
                                              "Q$index",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: localHeight *
                                                      0.012)),
                                          SizedBox(width: localHeight * 0.005),
                                          Text(
                                            "${values.data!.questions![index -
                                                1].questionType}",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                fontSize: localHeight * 0.012),
                                          )
                                        ]),
                                        SizedBox(height: localHeight * 0.010),
                                        Text(
                                          values.data!.questions![index - 1]
                                              .question!,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color:
                                              const Color.fromRGBO(
                                                  51, 51, 51, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: localHeight * 0.013),
                                        ),
                                        SizedBox(height: localHeight * 0.015),
                                      ]),
                                  subtitle: Column(children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          Provider
                                              .of<Questions>(
                                              context, listen: false)
                                              .totalQuestion['$index'][1] ==
                                              const Color(0xffdb2323)
                                              ? "Not Answered"
                                              : "Answer: ${Provider.of<Questions>(context, listen: false).totalQuestion['$index'][0].toString().substring(1,
                                              Provider.of<Questions>(context, listen: false).totalQuestion['$index'][0].toString().length - 1)}",
                                          //options[index-1].toString().substring(1,options[index-1].toString().length-1),
                                          style:
                                          Provider
                                              .of<Questions>(
                                              context, listen: false)
                                              .totalQuestion['$index'][1] ==
                                              const Color(0xffdb2323)
                                              ?
                                          TextStyle(
                                              color: const Color.fromRGBO(
                                                  238, 71, 0, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.014)
                                              : TextStyle(
                                              color: const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.014)
                                      ),
                                    ),
                                    SizedBox(height: localHeight * 0.005),
                                    Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Advisor: ",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: localHeight * 0.014),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: localHeight * 0.005),
                                          Row(
                                              children: [
                                          Text("${AppLocalizations.of(context)!.study_chapter} ${values.data!.questions![index - 1].questionId}\t${values.data!.questions![index - 1].advisorText}",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            51, 51, 51, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight
                                                            .w400,
                                                        fontSize: localHeight *
                                                            0.015))]),
                                          SizedBox(height: localHeight * 0.005),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  final Uri url = Uri.parse("${values.data!.questions![index - 1].advisorUrl}");
                                                  if (!await launchUrl(url)) {
                                                  throw Exception('Could not launch $url');
                                                  }
                                                },
                                                child:
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                        "URL :\t\t",
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                51, 51, 51, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            fontSize: localHeight *
                                                                0.015)),
                                                    TextSpan(
                                                        text: values.data!
                                                            .questions![index - 1].advisorUrl,
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                58, 137, 210, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            fontSize: localHeight *
                                                                0.015)),
                                                  ]))),
                                            ],
                                          ),
                                          SizedBox(height: localHeight * 0.005),
                                        ]),
                                  ]))))
                      ])),
                      SizedBox(height: localHeight * 0.030),
                    ])
                  ]))));
        }
        else if(constraints.maxWidth > 960) {
          return WillPopScope(
              onWillPop: () async => false, child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40.0,
                    color: Color.fromRGBO(28, 78, 80, 1),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                elevation: 0,
                centerTitle: true,
                title:    Text(
                  AppLocalizations.of(context)!.solution_sheet,
                  //"Solution Sheet",
                  style: TextStyle(
                    color: const Color.fromRGBO(28, 78, 80, 1),
                    fontSize: localHeight * 0.0225,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(children: [
                    Column(children: [
                      SizedBox(height: localHeight * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.assessmentId,
                            style: TextStyle(
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: localHeight * 0.025),
                          ),
                        ],
                      ),
                      SizedBox(height: localHeight * 0.020),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: kElevationToShadow[2],
                          ),
                          width: localWidth * 0.6,
                          child:
                          Column(children: [
                            for (int index = 1; index <= context
                                .watch<Questions>()
                                .totalQuestion
                                .length; index++)
                              Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  child:
                                  Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(82, 165, 160, 0.08),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      width: localWidth * 0.6,
                                      child:
                                      ListTile(
                                          title: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Row(children: [
                                                  Text(
                                                      "Q$index",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              82, 165, 160, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: localHeight *
                                                              0.012)),
                                                  SizedBox(width: localHeight * 0.005),
                                                  Text(
                                                    "${values.data!.questions![index -
                                                        1].questionType}",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: localHeight * 0.012),
                                                  )
                                                ]),
                                                SizedBox(height: localHeight * 0.010),
                                                Text(
                                                  values.data!.questions![index - 1]
                                                      .question!,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.013),
                                                ),
                                                SizedBox(height: localHeight * 0.015),
                                              ]),
                                          subtitle: Column(children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  Provider
                                                      .of<Questions>(
                                                      context, listen: false)
                                                      .totalQuestion['$index'][1] ==
                                                      const Color(0xffdb2323)
                                                      ? "Not Answered"
                                                      : "Answer: ${Provider.of<Questions>(context, listen: false).totalQuestion['$index'][0].toString().substring(1,
                                                      Provider.of<Questions>(context, listen: false).totalQuestion['$index'][0].toString().length - 1)}",
                                                  //options[index-1].toString().substring(1,options[index-1].toString().length-1),
                                                  style:
                                                  Provider
                                                      .of<Questions>(
                                                      context, listen: false)
                                                      .totalQuestion['$index'][1] ==
                                                      const Color(0xffdb2323)
                                                      ?
                                                  TextStyle(
                                                      color: const Color.fromRGBO(
                                                          238, 71, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: localHeight * 0.014)
                                                      : TextStyle(
                                                      color: const Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: localHeight * 0.014)
                                              ),
                                            ),
                                            SizedBox(height: localHeight * 0.005),
                                            Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Advisor: ",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: localHeight * 0.014),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: localHeight * 0.005),
                                                  Row(
                                                      children: [
                                                        Text("${AppLocalizations.of(context)!.study_chapter} ${values.data!.questions![index - 1].questionId}\t${values.data!.questions![index - 1].advisorText}",
                                                            style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    51, 51, 51, 1),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight
                                                                    .w400,
                                                                fontSize: localHeight *
                                                                    0.015))]),
                                                  SizedBox(height: localHeight * 0.005),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () async {
                                                            final Uri url = Uri.parse("${values.data!.questions![index - 1].advisorUrl}");
                                                            if (!await launchUrl(url)) {
                                                              throw Exception('Could not launch $url');
                                                            }
                                                          },
                                                          child:
                                                          RichText(
                                                              text: TextSpan(children: [
                                                                TextSpan(
                                                                    text:
                                                                    "URL :\t\t",
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            51, 51, 51, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight
                                                                            .w400,
                                                                        fontSize: localHeight *
                                                                            0.015)),
                                                                TextSpan(
                                                                    text: values.data!
                                                                        .questions![index - 1].advisorUrl,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            58, 137, 210, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight
                                                                            .w400,
                                                                        fontSize: localHeight *
                                                                            0.015)),
                                                              ]))),
                                                    ],
                                                  ),
                                                  SizedBox(height: localHeight * 0.005),
                                                ]),
                                          ]))))
                          ])),
                      SizedBox(height: localHeight * 0.030),
                    ])
                  ]))));
        }
        else {
          return WillPopScope(
              onWillPop: () async => false, child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40.0,
                    color: Color.fromRGBO(28, 78, 80, 1),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                elevation: 0,
                centerTitle: true,
                title:    Text(
                  AppLocalizations.of(context)!.solution_sheet,
                  //"Solution Sheet",
                  style: TextStyle(
                    color: const Color.fromRGBO(28, 78, 80, 1),
                    fontSize: localHeight * 0.0225,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(children: [
                    Column(children: [
                      SizedBox(height: localHeight * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.assessmentId,
                            style: TextStyle(
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: localHeight * 0.025),
                          ),
                        ],
                      ),
                      SizedBox(height: localHeight * 0.020),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: kElevationToShadow[2],
                          ),
                          width: localWidth * 0.9,
                          child:
                          Column(children: [
                            for (int index = 1; index <= context
                                .watch<Questions>()
                                .totalQuestion
                                .length; index++)
                              Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  child:
                                  Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(82, 165, 160, 0.08),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      width: localWidth * 0.9,
                                      child:
                                      ListTile(
                                          title: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Row(children: [
                                                  Text(
                                                      "Q$index",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              82, 165, 160, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: localHeight *
                                                              0.012)),
                                                  SizedBox(width: localHeight * 0.005),
                                                  Text(
                                                    "${values.data!.questions![index -
                                                        1].questionType}",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: localHeight * 0.012),
                                                  )
                                                ]),
                                                SizedBox(height: localHeight * 0.010),
                                                Text(
                                                  values.data!.questions![index - 1]
                                                      .question!,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.013),
                                                ),
                                                SizedBox(height: localHeight * 0.015),
                                              ]),
                                          subtitle: Column(children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  Provider
                                                      .of<Questions>(
                                                      context, listen: false)
                                                      .totalQuestion['$index'][1] ==
                                                      const Color(0xffdb2323)
                                                      ? "Not Answered"
                                                      : "Answer: ${Provider.of<Questions>(context, listen: false).totalQuestion['$index'][0].toString().substring(1,
                                                      Provider.of<Questions>(context, listen: false).totalQuestion['$index'][0].toString().length - 1)}",
                                                  //options[index-1].toString().substring(1,options[index-1].toString().length-1),
                                                  style:
                                                  Provider
                                                      .of<Questions>(
                                                      context, listen: false)
                                                      .totalQuestion['$index'][1] ==
                                                      const Color(0xffdb2323)
                                                      ?
                                                  TextStyle(
                                                      color: const Color.fromRGBO(
                                                          238, 71, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: localHeight * 0.014)
                                                      : TextStyle(
                                                      color: const Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: localHeight * 0.014)
                                              ),
                                            ),
                                            SizedBox(height: localHeight * 0.005),
                                            Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Advisor: ",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: localHeight * 0.014),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: localHeight * 0.005),
                                                  Row(
                                                      children: [
                                                        Text("${AppLocalizations.of(context)!.study_chapter} ${values.data!.questions![index - 1].questionId}\t${values.data!.questions![index - 1].advisorText}",
                                                            style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    51, 51, 51, 1),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight
                                                                    .w400,
                                                                fontSize: localHeight *
                                                                    0.015))]),
                                                  SizedBox(height: localHeight * 0.005),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () async {
                                                            final Uri url = Uri.parse("${values.data!.questions![index - 1].advisorUrl}");
                                                            if (!await launchUrl(url)) {
                                                              throw Exception('Could not launch $url');
                                                            }
                                                          },
                                                          child:
                                                          RichText(
                                                              text: TextSpan(children: [
                                                                TextSpan(
                                                                    text:
                                                                    "URL :\t\t",
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            51, 51, 51, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight
                                                                            .w400,
                                                                        fontSize: localHeight *
                                                                            0.015)),
                                                                TextSpan(
                                                                    text: values.data!
                                                                        .questions![index - 1].advisorUrl,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            58, 137, 210, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight
                                                                            .w400,
                                                                        fontSize: localHeight *
                                                                            0.015)),
                                                              ]))),
                                                    ],
                                                  ),
                                                  SizedBox(height: localHeight * 0.005),
                                                ]),
                                          ]))))
                          ])),
                      SizedBox(height: localHeight * 0.030),
                    ])
                  ]))));
        }
      },
    );
  }
}

