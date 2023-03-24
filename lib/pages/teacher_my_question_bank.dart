import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_create_assessment.dart';
import 'package:qna_test/Pages/teacher_questionBank_page.dart';
import 'package:qna_test/pages/teacher_question_preview_delete.dart';
import '../Entity/Teacher/question_entity.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../EntityModel/create_question_model.dart' as create_question_model;
import '../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class TeacherMyQuestionBank extends StatefulWidget {
  const TeacherMyQuestionBank(
      {Key? key, this.assessment, required this.setLocale})
      : super(key: key);

  final bool? assessment;
  final void Function(Locale locale) setLocale;

  @override
  TeacherMyQuestionBankState createState() => TeacherMyQuestionBankState();
}

class TeacherMyQuestionBankState extends State<TeacherMyQuestionBank> {
  List<Question> quesList = [];

  @override
  void initState() {
    super.initState();

    quesList = Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
        .getAllQuestion;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: height * 0.100,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.my_qn_bank_caps,
            //"MY QUESTION BANK",
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: height * 0.0225,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),
          ),
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
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding:
                EdgeInsets.only(left: width * 0.055, right: width * 0.055),
                height: height * 0.7,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tap_to_review,
                            //'Tap to Review/Edit/Delete',
                            style: TextStyle(
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(153, 153, 153, 1),
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.my_qns_small,
                                // 'My Questions',
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              const Icon(
                                Icons.circle,
                                color: Color.fromRGBO(82, 165, 160, 1),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      for (int i = 0; i < quesList.length; i++)
                        QuestionPreview(
                            height: height,
                            width: width,
                            question: quesList[i],
                            index: i,
                            assessment: widget.assessment,
                            setLocale: widget.setLocale),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                  minimumSize: const Size(280, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(39),
                  ),
                ),
                onPressed: () async {
                  if (widget.assessment != null) {
                    print("create Aseessment page");
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: TeacherCreateAssessment(
                            setLocale: widget.setLocale),
                      ),
                    );
                  } else {
                    print("create question page");
                    //GetQuestionModel questionBank=await QnaService.getQuestionBankService(1,1);
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: TeacherQuestionBank(setLocale: widget.setLocale,),
                      ),
                    );
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.back_to_qns,
                  //'Back to Questions',
                  style: TextStyle(
                      fontSize: height * 0.025,
                      fontFamily: "Inter",
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ));
  }
}

class QuestionPreview extends StatelessWidget {
  const QuestionPreview(
      {Key? key,
        required this.height,
        required this.width,
        required this.question,
        required this.index,
        this.assessment,
        required this.setLocale})
      : super(key: key);

  final double height;
  final double width;
  final Question question;
  final int index;
  final bool? assessment;
  final void Function(Locale locale) setLocale;

  @override
  Widget build(BuildContext context) {
    String answer = '';
    if(question.choices==null){
      question.choices=[];
    }
    else{
      for (int i = 0; i < question.choices!.length; i++) {
        if(question.choices![i].rightChoice!) {
          answer = '$answer ${question.choices![i].choiceText}';
        }
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: TeacherQuestionPreviewDelete(
                question: question,
                index: index,
                assessment: assessment,
                setLocale: setLocale),
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "  |  ${question.topic} - ${question.subTopic}",
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Text(
                          question.datumClass!,
                          style: TextStyle(
                              fontSize: height * 0.015,
                              fontFamily: "Inter",
                              color: Colors.white,
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
                        color: const Color.fromRGBO(82, 165, 160, 1),
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
