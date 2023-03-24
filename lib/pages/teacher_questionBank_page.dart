import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Entity/Teacher/question_entity.dart';
import 'package:qna_test/Pages/teacher_looq_search_question.dart';
import 'package:qna_test/pages/teacher_question_edit.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Services/qna_service.dart';
import 'teacher_prepare_qnBank.dart';

class TeacherQuestionBank extends StatefulWidget {
  const TeacherQuestionBank({
    Key? key,
    required this.setLocale,
  }) : super(key: key);

  final void Function(Locale locale) setLocale;
  @override
  TeacherQuestionBankState createState() => TeacherQuestionBankState();
}

class TeacherQuestionBankState extends State<TeacherQuestionBank> {
  bool agree = false;
  int pageNumber = 1;
  List<Question> questionList = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    ResponseEntity responseEntity =
        await QnaService.getQuestionBankService(5, pageNumber);
    List<Question> questions = List<Question>.from(
        responseEntity.data.map((x) => Question.fromJson(x)));
    setState(() {
      questionList.addAll(questions);
      pageNumber++;
    });
  }

  getQuestionData() async {
    ResponseEntity responseEntity =
        await QnaService.getQuestionBankService(5, pageNumber);
    List<Question> questions = List<Question>.from(
        responseEntity.data.map((x) => Question.fromJson(x)));
    setState(() {
      questionList.addAll(questions);
      pageNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController teacherQuestionBankSearchController =
        TextEditingController();
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
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
                    "MY QUESTIONS",
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
          endDrawer: EndDrawerMenuTeacher(setLocale: widget.setLocale),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Search Library  (LOOQ)",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.02,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                              activeColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return const Color.fromRGBO(82, 165, 160, 1);
                                }
                                return const Color.fromRGBO(82, 165, 160, 1);
                              }),
                              value: agree,
                              onChanged: (val) {
                                setState(() {
                                  agree = val!;
                                  if (agree) {}
                                });
                              },
                            ),
                            Text(
                              'Only My Questions',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: height * 0.015),
                            )
                          ],
                        )
                      ],
                    ),
                    Text(
                      "Library Of Online Questions",
                      style: TextStyle(
                        color: const Color.fromRGBO(153, 153, 153, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: TeacherLooqQuestionBank(
                                          setLocale: widget.setLocale),
                                    ),
                                  );
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
                      onChanged: (value) {},
                    ),
                    SizedBox(height: height * 0.03),
                    Container(
                      margin: EdgeInsets.only(left: height * 0.040),
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "DISCLAIMER:",
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontFamily: "Inter"),
                            ),
                            TextSpan(
                              text:
                                  "\t ITNEducation is not responsible for\nthe content and accuracy of the Questions & Answer \n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t available in the Library.",
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(153, 153, 153, 1),
                                  fontFamily: "Inter"),
                            ),
                          ])),
                    ),
                    SizedBox(height: height * 0.02),
                    const Divider(
                      thickness: 2,
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      "My Question Bank",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.02,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Column(children: [
                      for (Question i in questionList)
                        QuestionPreview(
                            height: height,
                            width: width,
                            question: i,
                            setLocale: widget.setLocale),
                      SizedBox(height: height * 0.02),
                      GestureDetector(
                        onTap: () {
                          getQuestionData();
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "View More",
                                style: TextStyle(
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Color.fromRGBO(28, 78, 80, 1),
                              ),
                            ]),
                      ),
                      SizedBox(height: height * 0.02),
                      Center(
                        child: SizedBox(
                          width: width * 0.8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: const Size(280, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                                side: const BorderSide(
                                  color: Color.fromRGBO(82, 165, 160, 1),
                                )),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: TeacherPrepareQnBank(
                                      setLocale: widget.setLocale),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Prepare New Questions',
                                  style: TextStyle(
                                      fontSize: height * 0.025,
                                      fontFamily: "Inter",
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontWeight: FontWeight.w600),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  size: height * 0.03,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                    ]),
                  ],
                )),
          ),
        ));
  }
}

class QuestionPreview extends StatelessWidget {
  const QuestionPreview({
    Key? key,
    required this.height,
    required this.width,
    required this.question,
    required this.setLocale,
  }) : super(key: key);

  final double height;
  final double width;
  final Question question;
  final void Function(Locale locale) setLocale;

  @override
  Widget build(BuildContext context) {
    String answer = '';
<<<<<<< HEAD
    if (question.choices == null) {
      question.choices = [];
    } else {
=======
    if(question.choices==null){
      question.choices=[];
    }else{
>>>>>>> 4c32e916df3504bd18672b98f2d532b6f0c0aa31
      for (int i = 0; i < question.choices!.length; i++) {
        answer = '$answer ${question.choices![i].choiceText}';
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: QuestionEdit(question: question, setLocale: setLocale),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: const Color.fromRGBO(82, 165, 160, 0.08),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.04,
                  width: width * 0.95,
                  color: const Color.fromRGBO(82, 165, 160, 1),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.02, left: width * 0.02),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${question.questionType}',
                    style: TextStyle(
                        fontSize: height * 0.02,
                        fontFamily: "Inter",
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Align(
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
                SizedBox(
                  height: height * 0.01,
                ),
                const Divider()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
