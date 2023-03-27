import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher_selected_questions_assessment.dart';
import '../Entity/Teacher/question_entity.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Entity/demo_question_model.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Providers/create_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Services/qna_service.dart';

class TeacherAssessmentQuestionBank extends StatefulWidget {
  const TeacherAssessmentQuestionBank(
      {Key? key, this.assessment, required this.setLocale})
      : super(key: key);

  final bool? assessment;
  final void Function(Locale locale) setLocale;

  @override
  TeacherAssessmentQuestionBankState createState() =>
      TeacherAssessmentQuestionBankState();
}

class TeacherAssessmentQuestionBankState
    extends State<TeacherAssessmentQuestionBank> {
  bool additionalDetails = true;
  TextEditingController teacherQuestionBankSearchController =
      TextEditingController();
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    ResponseEntity responseEntity =
        await QnaService.getQuestionBankService(500, 1);
    setState(() {
      questions = List<Question>.from(
          responseEntity.data.map((x) => Question.fromJson(x)));
    });
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {},
    );

    AlertDialog alert = AlertDialog(
      title: const Text("My title"),
      content: const Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      endDrawer: EndDrawerMenuTeacher(setLocale: widget.setLocale),
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
            "SEARCH RESULTS",
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: height * 0.0225,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "MY QUESTION BANK",
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
      body: Padding(
        padding: EdgeInsets.only(left: width * 0.025, right: width * 0.025),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
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
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Color.fromRGBO(82, 165, 160, 1),
                      ),
                      child: IconButton(
                        iconSize: height * 0.04,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     type: PageTransitionType.rightToLeft,
                          //     child:  TeacherAssessmentSearched(),
                          //   ),
                          // );
                        },
                        icon: const Icon(Icons.search),
                      )),
                ]),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(82, 165, 160, 1)),
                    borderRadius: BorderRadius.circular(15)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              enabled: true,
              onChanged: (value) {},
            ),
            SizedBox(
              height: height * 0.015,
            ),
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
                )
              ],
            ),
            SizedBox(
              height: height * 0.015,
            ),
            SizedBox(
              height: height * 0.6,
              width: width * 0.9,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    for (Question i in questions)
                      QuestionPreview(
                        height: height,
                        width: width,
                        question: i,
                      ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: height * 0.02,
            // ),
            Center(
              child: SizedBox(
                width: width * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
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
                        child: TeacherSelectedQuestionAssessment(
                            questions: questions, setLocale: widget.setLocale),
                      ),
                    );
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(
                        fontSize: height * 0.025,
                        fontFamily: "Inter",
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionPreview extends StatefulWidget {
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
  State<QuestionPreview> createState() => _QuestionPreviewState();
}

class _QuestionPreviewState extends State<QuestionPreview> {
  bool? valuefirst = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          checkColor: const Color.fromRGBO(255, 255, 255, 1),
          activeColor: const Color.fromRGBO(82, 165, 160, 1),
          value: valuefirst,
          onChanged: (bool? value) {
            setState(() {
              if (value!) {
                widget.question.questionMark = 10;
                Provider.of<QuestionPrepareProviderFinal>(context,
                        listen: false)
                    .addQuestion(widget.question!);
                Provider.of<CreateAssessmentProvider>(context, listen: false)
                    .addQuestion(widget.question.questionId, 10);
              } else {
                Provider.of<QuestionPrepareProviderFinal>(context,
                        listen: false)
                    .removeQuestion(widget.question.questionId);
                Provider.of<CreateAssessmentProvider>(context, listen: false)
                    .removeQuestion(widget.question.questionId);
              }
              valuefirst = value;
            });
          },
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: widget.width * 0.75,
                color: const Color.fromRGBO(82, 165, 160, 0.1),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: widget.width * 0.02, left: widget.width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.question.subject!,
                            style: TextStyle(
                                fontSize: widget.height * 0.017,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "  |  ${widget.question.topic} - ${widget.question.subTopic}",
                            style: TextStyle(
                                fontSize: widget.height * 0.015,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Text(
                        widget.question.datumClass!,
                        style: TextStyle(
                            fontSize: widget.height * 0.015,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.question.questionType!,
                  style: TextStyle(
                      fontSize: widget.height * 0.0175,
                      fontFamily: "Inter",
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      widget.question.question!,
                      style: TextStyle(
                          fontSize: widget.height * 0.0175,
                          fontFamily: "Inter",
                          color: const Color.fromRGBO(51, 51, 51, 1),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              const Divider()
            ],
          ),
        ),
      ],
    );
  }
}
