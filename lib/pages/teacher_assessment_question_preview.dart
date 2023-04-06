import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:qna_test/pages/teacher_add_my_question_bank.dart';
import 'package:qna_test/pages/teacher_assessment_summary.dart';
import 'package:qna_test/pages/teacher_selected_questions_assessment.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../Entity/demo_question_model.dart';
import '../Entity/Teacher/question_entity.dart' as Question;
import '../Providers/create_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';

class TeacherAssessmentQuestionPreview extends StatefulWidget {
  const TeacherAssessmentQuestionPreview(
      {Key? key,

      required this.assessment,
      required this.question,
      required this.index,
      this.pageName})
      : super(key: key);

  final CreateAssessmentModel assessment;
  final Question.Question question;
  final int index;
  final String? pageName;

  @override
  TeacherAssessmentQuestionPreviewState createState() =>
      TeacherAssessmentQuestionPreviewState();
}

class TeacherAssessmentQuestionPreviewState
    extends State<TeacherAssessmentQuestionPreview> {
  TextEditingController markController = TextEditingController();
  String fieldName='';
  int index=0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData(){
    List<int> questionId=[];
    List<int> addQuestionId=[];
    print("1");
    for(int i =0;i<widget.assessment.questions!.length ; i++){
      questionId.add(widget.assessment.questions![i].questionId!);
    }
    print("22");
    for(int i =0;i<widget.assessment.addQuestion!.length ; i++){
      addQuestionId.add(widget.assessment.addQuestion![i].questionId!);
    }
    print("2.5");
    if(questionId.contains(widget.question.questionId)){
      print("3");
      setState(() {
        index = questionId.indexOf(widget.question.questionId);
        fieldName='question';
        markController.text =
            widget.assessment.questions![index].questionMarks.toString();
      });
    }
    else{
      print("4");
      setState(() {
        index = addQuestionId.indexOf(widget.question.questionId);
        fieldName='addQuestion';
        markController.text =
            widget.assessment.addQuestion![index].questionMark.toString();
      });
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
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
            body: Center(
              child: SizedBox(
                height: height * 0.9,
                width: width * 0.888,
                child: Card(
                    elevation: 12,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    margin: EdgeInsets.only(
                        left: width * 0.030,
                        right: width * 0.030,
                        bottom: height * 0.015,
                        top: height * 0.025),
                    //padding: const EdgeInsets.all(40),
                    child: Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.03,
                            left: width * 0.03,
                            top: width * 0.03,
                            bottom: width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Question',
                                      style: TextStyle(
                                          fontSize: height * 0.02,
                                          fontFamily: "Inter",
                                          color: const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Text(
                                      '${widget.index + 1}',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: height * 0.02,
                                          fontFamily: "Inter",
                                          color: const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Marks:',
                                      style: TextStyle(
                                          fontSize: height * 0.02,
                                          fontFamily: "Inter",
                                          color: const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
                                      child: TextField(
                                        controller: markController,
                                        style: TextStyle(
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              '${widget.question.questionType}',
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Text(
                              '${widget.question.question}',
                              style: TextStyle(
                                  fontSize: height * 0.017,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            ChooseWidget(
                              height: height,
                              width: width,
                              question: widget.question,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              'Advisor',
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Text(
                              '${widget.question.advisorText}',
                              style: TextStyle(
                                  fontSize: height * 0.017,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            const Divider(),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              '${widget.question.advisorUrl}',
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  decoration: TextDecoration.underline,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(0, 148, 255, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Center(
                              child: SizedBox(
                                width: width * 0.888,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color.fromRGBO(82, 165, 160, 1),
                                    ),
                                    backgroundColor:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    minimumSize: const Size(280, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(39),
                                    ),
                                  ),
                                  //shape: StadiumBorder(),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Back',
                                    style: TextStyle(
                                        fontSize: height * 0.025,
                                        fontFamily: "Inter",
                                        color: const Color.fromRGBO(
                                            82, 165, 160, 1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Center(
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    print("Question id");
                                    print(widget.question.questionId);
                                    Provider.of<QuestionPrepareProviderFinal>(
                                        context,
                                        listen: false)
                                        .updatemark(
                                        int.parse(markController.text),
                                        widget.index);
                                    fieldName=='question'?
                                    Provider.of<CreateAssessmentProvider>(
                                        context,
                                        listen: false)
                                        .updatemark(
                                        int.parse(markController.text),
                                        index)
                                        :
                                    Provider.of<CreateAssessmentProvider>(
                                        context,
                                        listen: false)
                                        .updateAddQuestionmark(
                                        int.parse(markController.text),
                                        index);
                                    if (widget.pageName ==
                                        'TeacherAssessmentSummary') {
                                      Navigator.pushNamed(context, '/teacherAssessmentSummary').then((value) => markController.clear());
                                      // Navigator.push(
                                      //   context,
                                      //   PageTransition(
                                      //     type: PageTransitionType.rightToLeft,
                                      //     child: TeacherAssessmentSummary(
                                      //         ),
                                      //   ),
                                      // );
                                    } else {
                                      //Navigator.pushNamedAndRemoveUntil(context, '/teacherSelectedQuestionAssessment',,(route) => route.isFirst);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => TeacherSelectedQuestionAssessment(
                                              )),
                                              (route) => route.isFirst);
                                    }
                                  },
                                  child: SizedBox(
                                    width: width * 0.888,
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
                                      //shape: StadiumBorder(),
                                      onPressed: () {
                                        print("Question id");
                                        print(widget.question.questionId);
                                        Provider.of<QuestionPrepareProviderFinal>(
                                            context,
                                            listen: false)
                                            .updatemark(
                                            int.parse(markController.text),
                                            widget.index);
                                        fieldName=='question'?
                                        Provider.of<CreateAssessmentProvider>(
                                            context,
                                            listen: false)
                                            .updatemark(
                                            int.parse(markController.text),
                                            index)
                                            :
                                        Provider.of<CreateAssessmentProvider>(
                                            context,
                                            listen: false)
                                            .updateAddQuestionmark(
                                            int.parse(markController.text),
                                            index);
                                        if (widget.pageName ==
                                            'TeacherAssessmentSummary') {
                                          Navigator.pushNamed(context, '/teacherAssessmentSummary');
                                          // Navigator.push(
                                          //   context,
                                          //   PageTransition(
                                          //     type: PageTransitionType.rightToLeft,
                                          //     child: TeacherAssessmentSummary(
                                          //         ),
                                          //   ),
                                          // );
                                        }
                                        else {
                                          //Navigator.pushNamedAndRemoveUntil(context, '/teacherSelectedQuestionAssessment',,(route) => route.isFirst);
                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) => TeacherSelectedQuestionAssessment(
                                                  )),
                                                  (route) => route.isFirst);
                                        }
                                      },
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                            fontSize: height * 0.025,
                                            fontFamily: "Inter",
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))),
              ),
            )));
  }
}

class ChooseWidget extends StatefulWidget {
  const ChooseWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.question})
      : super(key: key);

  final Question.Question question;
  final double height;
  final double width;

  @override
  State<ChooseWidget> createState() => _ChooseWidgetState();
}

class _ChooseWidgetState extends State<ChooseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int j = 0; j < widget.question.choices!.length; j++)
          Padding(
            padding: EdgeInsets.only(bottom: widget.height * 0.013),
            child: Container(
                width: widget.width * 0.744,
                height: widget.height * 0.0412,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border:
                      Border.all(color: const Color.fromRGBO(209, 209, 209, 1)),
                  color: widget.question.choices![j].rightChoice!
                      ? const Color.fromRGBO(82, 165, 160, 1)
                      : const Color.fromRGBO(0, 0, 0, 0),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: widget.width * 0.02,
                      ),
                      Expanded(
                        child: Text(
                          '${widget.question.choices![j].choiceText}',
                          style: TextStyle(
                            color: widget.question.choices![j].rightChoice!
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: widget.height * 0.0162,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ])),
          )
      ],
    );
  }
}
