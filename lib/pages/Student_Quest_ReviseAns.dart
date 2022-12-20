import 'package:flutter/material.dart';

class StudReviseQuest extends StatefulWidget {
  const StudReviseQuest({super.key});

  @override
  StudReviseQuestState createState() => StudReviseQuestState();
}

class StudReviseQuestState extends State<StudReviseQuest> {
  List<Question> questionList = [
    Question(
        qnNumber: "1",
        question:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
        answer: "a. Option 1",
        mark: "5"),
    Question(
        qnNumber: "2",
        question:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in  rhoncus lectus efficitur",
        answer: "*** not answered ***",
        mark: "10"),
    Question(
        qnNumber: "3",
        question:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies",
        answer: "b. Option 2",
        mark: "10"),
    Question(
        qnNumber: "4",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        mark: "5"),
    Question(
        qnNumber: "5",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        mark: "5"),
    Question(
        qnNumber: "6",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        mark: "15"),
    Question(
        qnNumber: "7",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        mark: "10"),
    Question(
        qnNumber: "8",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                tooltip: "Revise",
                icon: const Icon(
                  Icons.chevron_left,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          centerTitle: true,
          title: Column(children: [
            Text(
              "Review",
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: localHeight * 0.018,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Answer Sheet",
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: localHeight * 0.018,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "AssID23515A225",
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: localHeight * 0.014,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                    colors: [
                  Color.fromRGBO(82, 165, 160, 1),
                  Color.fromRGBO(0, 106, 100, 1),
                ])),
          ),
        ),
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(children: [
              Column(
                  children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: localWidth * 0.056, top: localWidth * 0.056),
                      child: Text(
                        "Student",
                        style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: localHeight * 0.02),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: localHeight * 0.020),
                Row(children: [
                  Padding(
                    padding: EdgeInsets.only(left: localWidth * 0.056),
                    child: Text(
                        "Please tap on the questions to revise again before SUBMIT",
                        style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            fontSize: localHeight * 0.011)),
                  )
                ]),
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
                                  "(${question.mark} Marks)",
                                  style: TextStyle(
                                      color: const Color.fromRGBO(
                                          179, 179, 179, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: localHeight * 0.012),
                                )
                              ]),
                              SizedBox(height: localHeight * 0.010),
                              Text(question.question,
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
                        subtitle:
                        Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                        child: Text(question.answer,
                          style: TextStyle(
                              color: const Color.fromRGBO(
                                  0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: localHeight * 0.014)),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                      ]),
                    )
                    );
                  }).toList(),
                ),
                    Column(
                      children: [
                        Align(alignment: Alignment.center,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: const Size(280, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              //shape: StadiumBorder(),
                              child: const Text('Submit',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                  )
                              ),
                              onPressed: () { }
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: localHeight * 0.030),
              ])
            ])));
  }
}

class Question {
  String qnNumber, question, answer, mark;
  Question(
      {required this.qnNumber,
      required this.question,
      required this.answer,
      required this.mark});
}
