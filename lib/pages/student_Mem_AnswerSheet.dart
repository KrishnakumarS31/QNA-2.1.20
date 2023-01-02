import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/student_result_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class StudentMemAnswerSheet extends StatefulWidget {
  const StudentMemAnswerSheet({super.key});

  @override
  StudentMemAnswerSheetState createState() => StudentMemAnswerSheetState();
}

class StudentMemAnswerSheetState extends State<StudentMemAnswerSheet> {
  List<Question> questionList = [
    Question(
        qnNumber: "1",
        question:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
        answer: "a. Lorem ipsum dolor sit amet, consectetur adipiscing ",
        remarks: "What a terrific learner you are!",
        chapterNo: "5",
        mark: "5"),
    Question(
        qnNumber: "2",
        question:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in  rhoncus lectus efficitur",
        answer: "*** not answered ***",
        remarks: "This thesis statement is superb!",
        chapterNo: "6",
        mark: "10"),
    Question(
        qnNumber: "3",
        question:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies",
        answer: "b. Option 2",
        remarks: "You rocked this essay!",
        chapterNo: "7",
        mark: "10"),
    Question(
        qnNumber: "4",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "b. Option 3",
        remarks: "This thesis statement is superb!",
        chapterNo: "3",
        mark: "5"),
    Question(
        qnNumber: "5",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        chapterNo: "2",
        remarks:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
        mark: "5"),
    Question(
        qnNumber: "6",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        remarks: "Keep up the incredible work!",
        chapterNo: "3",
        mark: "15"),
    Question(
        qnNumber: "7",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "a. Lorem ipsum dolor sit amet, consectetur adipiscing ",
        remarks: "You rocked this essay!",
        chapterNo: "15",
        mark: "10"),
    Question(
        qnNumber: "8",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        chapterNo: "20",
        remarks: "Way to stay focused! I’m proud of you!",
        mark: "10")
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          leading:  IconButton(
            icon:const Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Colors.white,
            ), onPressed: () {
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
              "AssID23515A225",
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
                        onPressed: () {
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: localHeight * 0.020),
                //SizedBox(height: localHeight * 0.030),
                Column(
                  children: questionList.map((question) {
                    return Container(
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
                                  Text("Q${question.qnNumber}",
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          fontSize: localHeight * 0.012)),
                                  SizedBox(width: localHeight * 0.020),
                                  Text(
                                    "(${question.mark} ${AppLocalizations.of(context)!.marks})",
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
                                  question.question,
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
                                  question.answer == "*** not answered ***"
                                  ? question.answer
                                  : "${AppLocalizations.of(context)!.answer}: ${question.answer}",
                                  style:
                                      question.answer == "*** not answered ***"
                                          ? TextStyle(
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
                                              fontSize: localHeight * 0.014)),
                            ),
                          SizedBox(height: localHeight * 0.015),
                          Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                            RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                      "${AppLocalizations.of(context)!.study_chapter} ${question.chapterNo + ""}"
                                          "\t",
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              51, 51, 51, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                          localHeight * 0.015)),
                                  TextSpan(
                                      text: question.remarks,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              51, 51, 51, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                          localHeight * 0.015)),
                                ])),
                            const Divider(
                              thickness: 2,
                            ),
                          ]),
                        ])));
                  }).toList(),
                ),
                SizedBox(height: localHeight * 0.030),
              ])
            ])));
  }
}

class Question {
  String qnNumber, question, answer, mark,remarks,chapterNo;
  Question(
      {required this.qnNumber,
      required this.question,
      required this.answer,
      required this.remarks,
      required this.chapterNo,
      required this.mark});
}
