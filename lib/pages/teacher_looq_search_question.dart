import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_looq_clone_preview.dart';

import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/question_entity.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Services/qna_service.dart';

class TeacherLooqQuestionBank extends StatefulWidget {
  const TeacherLooqQuestionBank({
    Key? key,
    required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

  @override
  TeacherLooqQuestionBankState createState() => TeacherLooqQuestionBankState();
}

class TeacherLooqQuestionBankState extends State<TeacherLooqQuestionBank> {
  bool agree = false;

  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  List<Question> questions=[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    ResponseEntity responseEntity=await QnaService.getQuestionBankService(100,1);
    setState(() {
      questions=List<Question>.from(responseEntity.data.map((x) => Question.fromJson(x)));
    });

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController teacherQuestionBankSearchController =
        TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      endDrawer: EndDrawerMenuTeacher(setLocale: widget.setLocale),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: height * 0.100,
        centerTitle: true,
        title:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      activeColor: const Color.fromRGBO(82, 165, 160, 1),
                      fillColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
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
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Text(
                      'Only My Questions',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: height * 0.015),
                    )
                  ],
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
                            onPressed: () {},
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
                for (Question i in questions)
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: TeacherLooqClonePreview(
                                question: i, setLocale: widget.setLocale),
                          ),
                        );
                      },
                      child: QuestionPreview(
                        height: height,
                        width: width,
                        question: i,
                      )),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                      minimumSize: const Size(280, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(39),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
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
    return Column(
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
          padding:  EdgeInsets.only(left: width * 0.03),
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
          padding:  EdgeInsets.only(left: width * 0.03),
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
    );
  }
}
