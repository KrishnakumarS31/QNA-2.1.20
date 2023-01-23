import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

import '../Entity/question_paper_model.dart';
import '../Providers/question_num_provider.dart';

class StudentMemAnswerSheet extends StatefulWidget {
  const StudentMemAnswerSheet({Key? key, required this.questions})
      : super(key: key);
  final QuestionPaperModel questions;
  @override
  StudentMemAnswerSheetState createState() => StudentMemAnswerSheetState();
}

class StudentMemAnswerSheetState extends State<StudentMemAnswerSheet> {
  late QuestionPaperModel values;

  @override
  void initState() {
    super.initState();
    values = widget.questions;
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
          toolbarHeight: localHeight * 0.100,
          centerTitle: true,
          title: Column(children: [
            Text(
              AppLocalizations.of(context)!.answers,
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: localHeight * 0.024,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              values.data.assessment.assessmentCode,
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: localHeight * 0.016,
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(children: [
              Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: localWidth * 0.35, top: localWidth * 0.056),
                      child: Text(
                        AppLocalizations.of(context)!.answer_sheet,
                        style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: localHeight * 0.02),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: localWidth * 0.2, top: localWidth * 0.056),
                      child: IconButton(
                        icon: Icon(
                          Icons.file_download_outlined,
                          size: localHeight * 0.02,
                          color: const Color.fromRGBO(48, 145, 139, 1),
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                SizedBox(height: localHeight * 0.020),
                //SizedBox(height: localHeight * 0.030),
                Column(children: [
                  for (int index = 1;
                      index < context.watch<QuestionNumProvider>().questionNum;
                      index++)
                    Container(
                        //decoration: BoxDecoration(border: Border.all()),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        //color: const Color.fromRGBO(255, 255, 255, 1),
                        child: ListTile(
                            title: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text(
                                        "Q${values.data.assessment.questions[index].questionId}",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: localHeight * 0.012)),
                                    SizedBox(width: localHeight * 0.020),
                                    Text(
                                      "(${values.data.assessment.questions[index].questionId}${AppLocalizations.of(context)!.marks})",
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              179, 179, 179, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: localHeight * 0.012),
                                    )
                                  ]),
                                  SizedBox(height: localHeight * 0.010),
                                  Text(
                                    values.data.assessment.questions[index]
                                        .question,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color:
                                            const Color.fromRGBO(51, 51, 51, 1),
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
                                    Provider.of<Questions>(context, listen: false)
                                                .totalQuestion['$index'][0] ==
                                            const Color(0xff52a5a0)
                                        ? values.data.assessment.questions[index].choices[index].choiceText
                                        : "Not Answered",
                                    style: Provider.of<Questions>(context,
                                                    listen: false)
                                                .totalQuestion['$index'][0] !=
                                            const Color(0xff52a5a0)
                                        ? TextStyle(
                                            color: const Color.fromRGBO(
                                                238, 71, 0, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.014)
                                        : TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.014)),
                              ),
                              SizedBox(height: localHeight * 0.015),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "${AppLocalizations.of(context)!.study_chapter} ${values.data.assessment.subtopic} \t",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  51, 51, 51, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.015)),
                                      TextSpan(
                                          text: values.data.assessment
                                              .questions[index].advisorText,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  51, 51, 51, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: localHeight * 0.015)),
                                    ])),
                                    const Divider(
                                      thickness: 2,
                                    ),
                                  ]),
                            ])))
                ]),
                SizedBox(height: localHeight * 0.030),
              ])
            ])));
  }
}
