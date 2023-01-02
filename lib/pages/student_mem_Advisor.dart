import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/student_result_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'student_Mem_AnswerSheet.dart';

class StudMemAdvisor extends StatefulWidget {
  const StudMemAdvisor({super.key});

  @override
  StudMemAdvisorState createState() => StudMemAdvisorState();
}

class StudMemAdvisorState extends State<StudMemAdvisor> {
  List<Question> questionList = [
    Question(
        qnNumber: "1",
        question:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
        answer: "a. Option 1",
        chapterNo: "5",
        remarks: "This thesis statement is superb!",
        notesUrl: "https://www.google.co.in/",
        mark: "5"),
    Question(
        qnNumber: "2",
        question:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in  rhoncus lectus efficitur",
        answer: "*** not answered ***",
        chapterNo: "7",
        remarks: "What a terrific learner you are!",
        notesUrl: "https://www.google.co.in/",
        mark: "10"),
    Question(
        qnNumber: "3",
        question:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies",
        answer: "b. Option 2",
        chapterNo: "6",
        remarks: "You rocked this essay!",
        notesUrl: "https://www.google.co.in/",
        mark: "10"),
    Question(
        qnNumber: "4",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "b. Option 3",
        chapterNo: "8",
        remarks: "This thesis statement is superb!",
        notesUrl: "https://www.google.co.in/",
        mark: "5"),
    Question(
        qnNumber: "5",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        chapterNo: "3",
        remarks:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
        notesUrl: "https://www.google.co.in/",
        mark: "5"),
    Question(
        qnNumber: "6",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        chapterNo: "1",
        remarks: "Keep up the incredible work!",
        notesUrl: "https://www.google.co.in/",
        mark: "15"),
    Question(
        qnNumber: "7",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "a. Option 2",
        chapterNo: "4",
        remarks: "This thesis statement is superb!",
        notesUrl: "https://www.google.co.in/",
        mark: "10"),
    Question(
        qnNumber: "8",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        chapterNo: "5",
        remarks: "Way to stay focused! I’m proud of you!",
        notesUrl: "https://www.google.co.in/",
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
          leading: IconButton(
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
              AppLocalizations.of(context)!.advisor,
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
                          left: localWidth * 0.3, top: localWidth * 0.056),
                      child: Text(
                        AppLocalizations.of(context)!.incorrectly_answered,
                        style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: localHeight * 0.02),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: localHeight * 0.020),
                Column(
                  children: questionList.map((question) {
                    return Container(
                        // margin: const EdgeInsets.all(5),
                        //padding: const EdgeInsets.all(5),
                        child: question.answer == "*** not answered ***"
                            ? ListTile(
                                title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        SizedBox(height: localHeight * 0.050),
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
                                        ),
                                        SizedBox(width: localHeight * 0.030),
                                        Text(question.answer,
                                            style: question.answer ==
                                                    "*** not answered ***"
                                                ? TextStyle(
                                                    color: const Color.fromRGBO(
                                                        238, 71, 0, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        localHeight * 0.014)
                                                : TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        localHeight * 0.014)),
                                      ]),
                                      SizedBox(height: localHeight * 0.010),
                                      Text(
                                        question.question,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
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
                                    child: Text(AppLocalizations.of(context)!.advisor,
                                        style: TextStyle(
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
                                                  "Study Chapter ${question.chapterNo}"
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
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text("URL:",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        51, 51, 51, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                    localHeight * 0.015)),
                                            const SizedBox(width: 5),
                                            TextButton(
                                                 onPressed: () {  },
                                              child: Text(question.notesUrl,
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: localHeight * 0.015,
                                                      color: const Color.fromRGBO(58, 137, 210, 1),
                                                      fontWeight: FontWeight.w400)
                                            ),)
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 2,
                                        ),
                                      ])
                                ]),
                              )
                            : null);
                  }).toList(),
                ),
                const SizedBox(height: 25),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.note_alt,
                        size: localHeight * 0.02,
                        color: const Color.fromRGBO(48, 145, 139, 1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const StudentMemAnswerSheet(),
                          ),
                        );
                      },
                    ),
                    TextButton(
                        child: Text(AppLocalizations.of(context)!.answer_sheet,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: localHeight * 0.02,
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontWeight: FontWeight.w500)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const StudentMemAnswerSheet(),
                            ),
                          );
                        }),
                    const SizedBox(width: 150),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        size: localHeight * 0.025,
                        color: const Color.fromRGBO(48, 145, 139, 1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const StudentMemAnswerSheet(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                // SizedBox(height: localHeight * 0.070),
                const SizedBox(height: 30.0),
                Container(
                  height: localHeight * 0.20,
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
                        top: Radius.elliptical(
                            localWidth / 1.0, localHeight * 0.3)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: localHeight * 0.03, left: localWidth * 0.23),
                        child:
                        Column(children: [
                          Text(
                            AppLocalizations.of(context)!.pls_contact,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: localHeight * 0.020),
                          ),
                          const SizedBox(height: 20.0),
                          RichText(
                            textAlign: TextAlign.start,
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                    ' “ ',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w800,
                                        fontSize: localHeight * 0.030
                                    )),
                                TextSpan(
                                    text: AppLocalizations.of(context)!.retry_msg,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                        localHeight * 0.015)),
                                TextSpan(
                                    text:
                                    ' ” ',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w800,
                                        fontSize: localHeight * 0.030
                                    )),
                              ])),
                        ]),
                      )
                    ],
                  ),
                ),
                //const SizedBox(height: 30.0),
              ])
            ])));
  }
}

class Question {
  String qnNumber, question, answer, mark, chapterNo, remarks, notesUrl;
  Question(
      {required this.qnNumber,
      required this.question,
      required this.answer,
      required this.chapterNo,
      required this.remarks,
      required this.notesUrl,
      required this.mark});
}
