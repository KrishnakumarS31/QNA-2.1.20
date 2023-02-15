import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_looq_question_edit.dart';
import 'package:qna_test/Pages/teacher_looq_search_question.dart';
import '../Entity/demo_question_model.dart';
import '../Components/end_drawer_menu_teacher.dart';
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
  List<DemoQuestionModel> quesList = getData();
  static List<DemoQuestionModel> getData() {
    const data = [
      {
        "id": 1,
        "questionType": "MCQ",
        "subject": "Maths",
        "topic": "ADD",
        "subTopic": "Add",
        "studentClass": "2",
        "question": "2 + 2",
        "choices": ["1", "2", "4", "0"],
        "correctChoice": [3],
        "advice": "agraefweg",
        "url": "waffar"
      },
      {
        "id": 2,
        "questionType": "MCQ",
        "subject": "Maths",
        "topic": "ADD",
        "subTopic": "Add",
        "studentClass": "2",
        "question": "2 + 2",
        "choices": ["1", "2", "4", "0"],
        "correctChoice": [3],
        "advice": "agraefweg",
        "url": "waffar"
      },
      {
        "id": 3,
        "questionType": "MCQ",
        "subject": "Maths",
        "topic": "ADD",
        "subTopic": "Add",
        "studentClass": "2",
        "question": "2 + 2",
        "choices": ["1", "2", "4", "0"],
        "correctChoice": [3],
        "advice": "agraefweg",
        "url": "waffar"
      },
      {
        "id": 4,
        "questionType": "MCQ",
        "subject": "Maths",
        "topic": "ADD",
        "subTopic": "Add",
        "studentClass": "2",
        "question": "2 + 2",
        "choices": ["1", "2", "4", "0"],
        "correctChoice": [3],
        "advice": "agraefweg",
        "url": "waffar"
      },
      {
        "id": 5,
        "questionType": "MCQ",
        "subject": "Maths",
        "topic": "ADD",
        "subTopic": "Add",
        "studentClass": "2",
        "question": "2 + 2",
        "choices": ["1", "2", "4", "0"],
        "correctChoice": [3],
        "advice": "agraefweg",
        "url": "waffar"
      }
    ];
    return data.map<DemoQuestionModel>(DemoQuestionModel.fromJson).toList();
  }

  @override
  void initState() {
    super.initState();
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
        title:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                          activeColor: const Color.fromRGBO(82, 165, 160, 1),
                          fillColor: MaterialStateProperty.resolveWith<Color>(
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
                  for (DemoQuestionModel i in quesList)
                    QuestionPreview(
                        height: height,
                        width: width,
                        question: i,
                        setLocale: widget.setLocale),
                  SizedBox(height: height * 0.02),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      "View All",
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
                                  color: const Color.fromRGBO(255, 255, 255, 1),
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
    );
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
  final DemoQuestionModel question;
  final void Function(Locale locale) setLocale;

  @override
  Widget build(BuildContext context) {
    String answer = '';
    for (int i = 1; i <= question.correctChoice!.length; i++) {
      int j = 1;
      j = question.correctChoice![i - 1]!;
      answer = '$answer ${question.choices![j - 1]}';
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: LooqQuestionEdit(question: question, setLocale: setLocale),
          ),
        );
      },
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
              padding: EdgeInsets.only(right: width * 0.02, left: width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        question.subject,
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
                    question.studentClass,
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
              question.questionType,
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
              question.question,
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
    );
  }
}
