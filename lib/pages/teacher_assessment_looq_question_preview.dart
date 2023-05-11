import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../Entity/Teacher/question_entity.dart' as questions;
import '../Providers/create_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';

class TeacherAssessmentLooqQuestionPreview extends StatefulWidget {
  const TeacherAssessmentLooqQuestionPreview(
      {Key? key,
        required this.assessment,
        required this.question,
        required this.index,
        this.pageName,
      required this.quesId})
      : super(key: key);

  final CreateAssessmentModel assessment;
  final questions.Question question;
  final int index;
  final String? pageName;
  final int quesId;

  @override
  TeacherAssessmentLooqQuestionPreviewState createState() =>
      TeacherAssessmentLooqQuestionPreviewState();
}

class TeacherAssessmentLooqQuestionPreviewState
    extends State<TeacherAssessmentLooqQuestionPreview> {
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
    for(int i =0;i<widget.assessment.questions!.length ; i++){
      questionId.add(widget.assessment.questions![i].questionId!);
    }
    for(int i =0;i<widget.assessment.addQuestion!.length ; i++){
      addQuestionId.add(widget.assessment.addQuestion![i].questionId!);
    }
    if(questionId.contains(widget.question.questionId)){
      setState(() {
        index = questionId.indexOf(widget.question.questionId);
        fieldName='question';
        markController.text =
            widget.assessment.questions![index].questionMarks.toString();
      });
    }
    else{
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
                height: height * 0.85,
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
                                      AppLocalizations.of(context)!.qn_qn_page,
                                      //'Question',
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
                                      "${AppLocalizations.of(context)!.marks_qn} : ",
                                      // 'Marks:',
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
                                        enabled: widget.question.questionType=='MCQ',
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
                              AppLocalizations.of(context)!.advisor,
                              //'Advisor',
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
                                    AppLocalizations.of(context)!.back,
                                    //'Back',
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
                                    } else {
                                      //Navigator.pushNamedAndRemoveUntil(context, '/teacherClonedAssessmentPreview',,(route) => route.isFirst);
                                      Navigator.pushNamedAndRemoveUntil(context, '/teacherClonedAssessmentPreview',ModalRoute.withName('/teacherClonedAssessment'),arguments: 'clone');
                                    }
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.save,
                                    //'Save',
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

  final questions.Question question;
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
