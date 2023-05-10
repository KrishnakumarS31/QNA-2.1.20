import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Components/custom_incorrect_popup.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/question_entity.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Services/qna_service.dart';

class TeacherLooqQuestionBank extends StatefulWidget {
  TeacherLooqQuestionBank({
    Key? key,
    required this.search,
  }) : super(key: key);

  String search;

  @override
  TeacherLooqQuestionBankState createState() => TeacherLooqQuestionBankState();
}

class TeacherLooqQuestionBankState extends State<TeacherLooqQuestionBank> {
  bool agree = false;
  List<Question> question = [];
  List<Question> allQuestion = [];
  bool loading = true;
  ScrollController scrollController = ScrollController();
  int pageLimit = 1;
  String searchValue = '';
  TextEditingController teacherQuestionBankSearchController =
  TextEditingController();
  bool questionsPresent= false;

  @override
  void initState() {
    teacherQuestionBankSearchController.text = widget.search;
    initialData();
    super.initState();
  }

  initialData() async {
    ResponseEntity response =
    await QnaService.getSearchQuestion(10, pageLimit, widget.search);
    allQuestion =
    List<Question>.from(response.data.map((x) => Question.fromJson(x)));
    setState(() {
      allQuestion.isEmpty?questionsPresent=false:questionsPresent=true;
      searchValue = widget.search;
      question.addAll(allQuestion);
      loading = false;
      pageLimit++;
    });
  }

  getData(String searchVal) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(48, 145, 139, 1),
              ));
        });
    pageLimit = 1;
    ResponseEntity response =
    await QnaService.getSearchQuestion(100, pageLimit, searchVal);
    if (response.data == null) {
      allQuestion = [];
    } else {
      allQuestion =
      List<Question>.from(response.data.map((x) => Question.fromJson(x)));
    }
    Navigator.of(context).pop();
    setState(() {
      allQuestion.isEmpty?questionsPresent=false:questionsPresent=true;
      searchValue = searchVal;
      question.addAll(allQuestion);
      loading = false;
      pageLimit++;
    });
    // if(allQuestion.isEmpty) {
    //   Navigator.push(
    //     context,
    //     PageTransition(
    //       type: PageTransitionType.rightToLeft,
    //       child: CustomDialog(
    //         title: 'Alert',
    //         content: 'No question found.',
    //         button: 'Retry',
    //       ),
    //     ),
    //   );
    // }
  }

  loadMore(String searchValue) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(48, 145, 139, 1),
              ));
        });
    ResponseEntity response =
    await QnaService.getSearchQuestion(10, pageLimit, searchValue);
    allQuestion =
    List<Question>.from(response.data.map((x) => Question.fromJson(x)));
    Navigator.of(context).pop();
    setState(() {
      question.addAll(allQuestion);
      loading = false;
      pageLimit++;
    });
    if(allQuestion.isEmpty) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: CustomDialog(
            title: 'Alert',
            content: 'No more question found.',
            button: 'Retry',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          endDrawer: const EndDrawerMenuTeacher(),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                size: 40.0,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'));
              },
            ),
            toolbarHeight: height * 0.100,
            centerTitle: true,
            title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "LOOQ",
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: height * 0.0225,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "SEARCH QUESTIONS",
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: height * 0.0225,
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
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.023,
                    left: height * 0.023,
                    right: height * 0.023),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),
                    TextField(
                      controller: teacherQuestionBankSearchController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: height * 0.016),
                        hintText: "Maths, 10th, 2022, CBSE, Science",
                        suffixIcon: Column(children: [
                          Container(
                              height: height * 0.073,
                              width: width * 0.13,
                              decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                color: Color.fromRGBO(82, 165, 160, 1),
                              ),
                              child: IconButton(
                                iconSize: height * 0.04,
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                onPressed: () {
                                  setState(() {
                                    question = [];
                                  });
                                  getData(
                                      teacherQuestionBankSearchController.text);
                                },
                                icon: const Icon(Icons.search),
                              )),
                        ]),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(82, 165, 160, 1)),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      enabled: true,
                      onChanged: (val) {
                        setState(() {
                          question = [];
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          question = [];
                        });
                        getData(value);
                      },
                    ),
                    SizedBox(height: height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tap to Review/Edit/Delete",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: const Color.fromRGBO(153, 153, 153, 1),
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "My Questions",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            const Icon(
                              Icons.circle_rounded,
                              color: Color.fromRGBO(82, 165, 160, 1),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    questionsPresent?
                    Column(
                      children: [
                        for (Question i in question)
                          MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        '/teacherLooqClonePreview',
                                        arguments: i
                                    );
                                  },
                                  child: QuestionPreview(
                                    height: height,
                                    width: width,
                                    question: i,
                                  ))),
                      ],
                    ):
                    Column(
                      children: [
                        SizedBox(height: height * 0.04),
                        Center(
                          child: Text(
                            'NO QUESTIONS FOUND',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.0175,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: height * 0.02,
                    ),
                    MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            question.isEmpty?Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: CustomDialog(
                                  title: 'Alert',
                                  content: 'No Question Found.',
                                  button: 'Retry',
                                ),
                              ),
                            ):
                            loadMore(teacherQuestionBankSearchController.text);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'View More',
                                // "Load More",
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Icon(
                                Icons.expand_more_outlined,
                                color: Color.fromRGBO(82, 165, 160, 1),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color.fromRGBO(82, 165, 160, 1),
                          minimumSize: const Size(280, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(39),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'));
                          //Navigator.of(context).pop();
                        },
                        child: Text(
                          'Back to Questions',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        )
    );
  }
}

class QuestionPreview extends StatelessWidget {
  const QuestionPreview({
    Key? key,
    required this.height,
    required this.width,
    required this.question,
  }) : super(key: key);

  final double height;
  final double width;
  final Question question;

  @override
  Widget build(BuildContext context) {
    String answer = '';
    for (int i = 0; i < question.choices!.length; i++) {
      answer = '$answer ${question.choices![i]}';
    }

    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context,
                  '/teacherLooqClonePreview',
                  arguments: question
              );
            },
            child: Column(
              children: [
                Container(
                  height: height * 0.04,
                  width: width * 0.9,
                  color: const Color.fromRGBO(82, 165, 160, 1),
                  child: Padding(
                    padding: EdgeInsets.only(right: width * 0.02, left: width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              question.subject!,
                              style: TextStyle(
                                  fontSize: height * 0.017,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "  |  ${question.topic} - ${question.subTopic}",
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Text(
                          question.datumClass!,
                          style: TextStyle(
                              fontSize: height * 0.015,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.03),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      question.questionType!,
                      style: TextStyle(
                          fontSize: height * 0.015,
                          fontFamily: "Inter",
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.03),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      question.question!,
                      style: TextStyle(
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          color: const Color.fromRGBO(51, 51, 51, 1),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                const Divider()
              ],
            )));
  }
}
