import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher_assessment_landing.dart';
import 'package:qna_test/pages/teacher_assessment_looq_preapare_ques.dart';
import 'package:qna_test/pages/teacher_assessment_looq_ques_bank.dart';
import 'package:qna_test/pages/teacher_assessment_settings_publish.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/get_assessment_model.dart';
import '../Entity/Teacher/question_entity.dart' as Questions;

import '../Entity/Teacher/response_entity.dart';
import '../EntityModel/CreateAssessmentModel.dart' as CreateAssessmentModel;
import '../Providers/create_assessment_provider.dart';
import '../Providers/edit_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Services/qna_service.dart';
import 'teacher_prepare_qnBank.dart';
class TeacherClonedAssessmentPreview extends StatefulWidget {
  const TeacherClonedAssessmentPreview({
    Key? key,
    required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

  @override
  TeacherClonedAssessmentPreviewState createState() =>
      TeacherClonedAssessmentPreviewState();
}

class TeacherClonedAssessmentPreviewState
    extends State<TeacherClonedAssessmentPreview> {
  bool additionalDetails = true;
  GetAssessmentModel assessment =GetAssessmentModel();
  CreateAssessmentModel.CreateAssessmentModel finalAssessment=CreateAssessmentModel.CreateAssessmentModel(questions: []);
  List<Questions.Question> quesList=[];

  int mark=0;
  int totalMarks =0;

  showAdditionalDetails() {
    setState(() {
      !additionalDetails;
    });
  }


  @override
  void initState() {
    print("Yeah page loading");
    assessment=Provider.of<EditAssessmentProvider>(context, listen: false).getAssessment;
    finalAssessment=Provider.of<CreateAssessmentProvider>(context, listen: false).getAssessment;
    quesList=Provider.of<QuestionPrepareProviderFinal>(context, listen: false).getAllQuestion;
    finalAssessment.removeQuestions=[];
    for(int i=quesList.length;i< finalAssessment.questions!.length;i++){
      //Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(assessment.questions![i]);
      mark=mark + finalAssessment.questions![i].questionMarks!;
    }
    print(finalAssessment.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController teacherQuestionBankSearchController =
        TextEditingController();
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
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
            "CLONED",
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: height * 0.0225,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "ASSESSMENTS",
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
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${assessment.questions!.length}',
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(82, 165, 160, 1),
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
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '$totalMarks',
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(82, 165, 160, 1),
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
                    height: height * 0.6,
                    width: width * 0.9,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i =0;i< quesList.length;i++ )
                          QuestionWidget(height: height,index: i,assessment: assessment, setLocale: widget.setLocale,question: quesList[i]),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: height * 0.5,
                      left: width * 0.78,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: TeacherAssessmentLooqQuestionBank(
                                  setLocale: widget.setLocale,),
                            ),
                          );
                        },
                        child: Icon(Icons.add),
                        backgroundColor: Color.fromRGBO(82, 165, 160, 1),
                      ))
                ],
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
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      minimumSize: const Size(280, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(39),
                      ),
                    ),
                    //shape: StadiumBorder(),
                    onPressed: () async {
                      print("Hi THere");
                      finalAssessment.assessmentStatus='inprogress';
                      CreateAssessmentModel.AssessmentSettings assessmentSettings=CreateAssessmentModel.AssessmentSettings();
                      finalAssessment.assessmentSettings=assessmentSettings;
                      print(finalAssessment.toString());
                      ResponseEntity statusCode = await QnaService.createAssessmentTeacherService(finalAssessment);
                      if(statusCode.code==200){
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: TeacherAssessmentLanding(
                                setLocale: widget.setLocale),
                          ),
                        );
                      }
                    },
                    child: Text(

                      'Save List',
                      style: TextStyle(
                          fontSize: height * 0.025,
                          fontFamily: "Inter",
                          color: Color.fromRGBO(82, 165, 160, 1),
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
                    //shape: StadiumBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: TeacherAssessmentSettingPublish(
                              setLocale: widget.setLocale),
                        ),
                      );

//TeacherPublishedAssessment
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: height * 0.025,
                          fontFamily: "Inter",
                          color: Color.fromRGBO(255, 255, 255, 1),
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
  QuestionWidget({
    Key? key,
    required this.height,
    required this.index,
    required this.assessment,
    required this.question,
    required this.setLocale
  }) : super(key: key);

  final double height;
  final int index;
  GetAssessmentModel assessment;
  Questions.Question question;
  final void Function(Locale locale) setLocale;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {

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
        Navigator.of(context).pop();
        //widget.assessment.questions!.removeAt(widget.index);
        Provider.of<QuestionPrepareProviderFinal>(context, listen: false).deleteQuestionList(widget.index);
        Provider.of<CreateAssessmentProvider>(context, listen: false).removeLooqQuestionInAssess(widget.question!.questionId);
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: TeacherClonedAssessmentPreview(
                setLocale: widget.setLocale),
          ),
        );
      },
    );
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  'Q${widget.index + 1}',
                  style: TextStyle(
                      fontSize: widget.height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(82, 165, 160, 1),
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '  ${widget.question.questionType}',
                  style: TextStyle(
                      fontSize: widget.height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Marks: ',
                  style: TextStyle(
                      fontSize: widget.height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '${widget.question!.questionMark}',
                  style: TextStyle(
                      fontSize: widget.height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(82, 165, 160, 1),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                showAlertDialog(context,widget.height);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.close,
                    color: Color.fromRGBO(51, 51, 51, 1),
                  ),
                  Text(
                    ' Remove',
                    style: TextStyle(
                        fontSize: widget.height * 0.017,
                        fontFamily: "Inter",
                        color: Color.fromRGBO(51, 51, 51, 1),
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            '${widget.question.question}',
            style: TextStyle(
                fontSize: widget.height * 0.015,
                fontFamily: "Inter",
                color: Color.fromRGBO(51, 51, 51, 1),
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: widget.height * 0.01,
        ),
        Divider(),
        SizedBox(
          height: widget.height * 0.01,
        ),
      ],
    );
  }
}
