import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_add_my_question_bank.dart';
import 'package:qna_test/Pages/teacher_assessment_settings_publish.dart';
import 'package:qna_test/pages/teacher_assessment_landing.dart';
import 'package:qna_test/pages/teacher_assessment_question_bank.dart';
import 'package:qna_test/pages/teacher_assessment_question_preview.dart';
import 'package:qna_test/pages/teacher_published_assessment.dart';
import 'package:qna_test/pages/teacher_selected_questions_assessment.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/question_entity.dart' as Question;
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/create_assessment_provider.dart';
import '../Providers/question_prepare_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
class TeacherAssessmentSummary extends StatefulWidget {
  const TeacherAssessmentSummary({
    Key? key,
    required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;
  @override
  TeacherAssessmentSummaryState createState() =>
      TeacherAssessmentSummaryState();
}

class TeacherAssessmentSummaryState extends State<TeacherAssessmentSummary> {
  bool additionalDetails = true;
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  List<Question.Question> questionList = [];
  CreateAssessmentModel assessment=CreateAssessmentModel(questions: []);
  int totalQues =0;
  int totalMark=0;
  showAdditionalDetails() {
    setState(() {
      !additionalDetails;
    });
  }

  showAlertDialog(BuildContext context, double height) {
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        'No',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: TeacherAssessmentSettingPublish(setLocale: widget.setLocale),
          ),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.error,
            color: const Color.fromRGBO(238, 71, 0, 1),
            size: height * 0.05,
          ),
          Text(
            'Marks not filled',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        'Do you want to still continue?',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontWeight: FontWeight.w400),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  getData(){
    setState(() {
      questionList = Provider.of<QuestionPrepareProviderFinal>(context, listen: false).getAllQuestion;
      assessment=Provider.of<CreateAssessmentProvider>(context, listen: false).getAssessment;
      totalQues=assessment.questions.length;
      for(int i =0;i<assessment.questions.length;i++){
        totalMark=totalMark+assessment.questions[i].questionMarks!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            "SELECTED QUESTIONS",
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: height * 0.0225,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "FOR ASSESSMENTS",
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
          padding: EdgeInsets.only(
              top: height * 0.023, left: height * 0.023, right: height * 0.023),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height * 0.108,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color.fromRGBO(82, 165, 160, 0.07),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.03, left: width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                assessment.subject!,
                                style: TextStyle(
                                    fontSize: height * 0.017,
                                    fontFamily: "Inter",
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '  |  ${assessment.createAssessmentModelClass}',
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: height * 0.017,
                                    fontFamily: "Inter",
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              const Icon(
                                Icons.edit_outlined,
                                color: Color.fromRGBO(28, 78, 80, 1),
                              )
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Topic: ${assessment.topic}',
                        style: TextStyle(
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Topic: ${assessment.subTopic}',
                            style: TextStyle(
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '14/1/2023',
                            style: TextStyle(
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Total Questions: ',
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '20',
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Total Marks: ',
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '100',
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: height * 0.48,
                    width: width * 0.9,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for ( int i = 0;i< assessment.questions.length;i++ )
                            QuestionWidget(height: height, question: questionList[i],index: i,assessment: assessment, setLocale: widget.setLocale,),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: height * 0.4,
                      left: width * 0.78,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: TeacherAssessmentQuestionBank(
                                  setLocale: widget.setLocale),
                            ),
                          );
                        },
                        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                        child: const Icon(Icons.add),
                      ))
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Center(
                child: SizedBox(
                  width: width * 0.888,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromRGBO(82, 165, 160, 1),
                      ),
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      minimumSize: const Size(280, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(39),
                      ),
                    ),
                    onPressed: () {
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.rightToLeft,
                      //     child:  TeacherClonedAssessmentPreview(setLocale: widget.setLocale),
                      //   ),
                      // );
                    },
                    child: Text(
                      'Save Assessment',
                      style: TextStyle(
                          fontSize: height * 0.025,
                          fontFamily: "Inter",
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Center(
                child: SizedBox(
                  width: width * 0.888,
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
                          child: TeacherPublishedAssessment(
                              setLocale: widget.setLocale),
                        ),
                      );
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: height * 0.025,
                          fontFamily: "Inter",
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key? key,
    required this.height,
    required this.question,
    required this.index,
    required this.assessment,
    required this.setLocale
  }) : super(key: key);

  final double height;
  final Question.Question question;
  final int index;
  final CreateAssessmentModel assessment;
  final void Function(Locale locale) setLocale;


  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  showAlertDialog(BuildContext context, double height) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        'No',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Provider.of<QuestionPrepareProviderFinal>(context, listen: false).removeQuestion(widget.question.questionId);
        Provider.of<CreateAssessmentProvider>(context, listen: false).removeQuestion(widget.question.questionId);
        Navigator.of(context).pop();
        setState(() {

        });
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: TeacherSelectedQuestionAssessment(setLocale: widget.setLocale,),
          ),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.info,
            color: Color.fromRGBO(238, 71, 0, 1),
          ),
          Text(
            'Confirm',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to remove this Question?',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontWeight: FontWeight.w400),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  String ans ='';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      for(int i=0;i< widget.question.choices!.length;i++){
        if(widget.question.choices![i].rightChoice!){
          ans='${widget.question.choices![i].choiceText}, $ans';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: const Color.fromRGBO(82, 165, 160, 0.08),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: widget.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Q${widget.index+1}',
                        style: TextStyle(
                            fontSize: widget.height * 0.017,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '  ${widget.question.questionType}',
                        style: TextStyle(
                            fontSize: widget.height * 0.017,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(51, 51, 51, 1),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      showAlertDialog(context, widget.height,);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.close,
                          color: Color.fromRGBO(51, 51, 51, 1),
                        ),
                        Text(
                          ' Remove',
                          style: TextStyle(
                              fontSize: widget.height * 0.017,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(51, 51, 51, 1),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: TeacherAssessmentQuestionPreview(setLocale: widget.setLocale, assessment: widget.assessment, question: widget.question, index: widget.index,),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${widget.question.question}',
                    style: TextStyle(
                        fontSize: widget.height * 0.015,
                        fontFamily: "Inter",
                        color: const Color.fromRGBO(51, 51, 51, 1),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ans,
                      style: TextStyle(
                          fontSize: widget.height * 0.017,
                          fontFamily: "Inter",
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Marks: ',
                        style: TextStyle(
                            fontSize: widget.height * 0.017,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${widget.assessment.questions[widget.index].questionMarks}',
                        style: TextStyle(
                            fontSize: widget.height * 0.017,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              SizedBox(
                height: widget.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
