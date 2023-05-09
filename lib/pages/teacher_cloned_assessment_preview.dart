import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/assessment_settings_model.dart';
import '../Entity/Teacher/get_assessment_model.dart';
import '../Entity/Teacher/question_entity.dart' as Questions;

import '../Entity/Teacher/response_entity.dart';
import '../EntityModel/CreateAssessmentModel.dart' as CreateAssessmentModel;
import '../Providers/create_assessment_provider.dart';
import '../Providers/edit_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Services/qna_service.dart';

class TeacherClonedAssessmentPreview extends StatefulWidget {
  const TeacherClonedAssessmentPreview({
    Key? key,required this.assessmentType
  }) : super(key: key);
  final String assessmentType;
  @override
  TeacherClonedAssessmentPreviewState createState() =>
      TeacherClonedAssessmentPreviewState();
}

class TeacherClonedAssessmentPreviewState
    extends State<TeacherClonedAssessmentPreview> {
  bool additionalDetails = true;
  GetAssessmentModel assessment = GetAssessmentModel();
  CreateAssessmentModel.CreateAssessmentModel finalAssessment =
  CreateAssessmentModel.CreateAssessmentModel(questions: []);
  List<Questions.Question> quesList = [];

  int mark = 0;
  int totalQuestion = 0;

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
        //Provider.of<QuestionsForAssessmentSettingsPublishedProvider>(context, listen: false).addQuestion(widget.questions! as QuestionEntityForAssessmentSettingsPublished);
        Navigator.pushNamed(context, '/teacherAssessmentSettingPublish',arguments: widget.assessmentType);
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.rightToLeft,
        //     child: TeacherAssessmentSettingPublish(),
        //   ),
        // );
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
    getData();
    super.initState();
  }

  getData() {
    setState(() {
      assessment = Provider.of<EditAssessmentProvider>(context, listen: false)
          .getAssessment;

      finalAssessment =
          Provider.of<CreateAssessmentProvider>(context, listen: false)
              .getAssessment;

      quesList =
          Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
              .getAllQuestion;

      finalAssessment.removeQuestions = [];
      for (int i = 0; i < quesList.length; i++) {
        mark = mark + quesList[i].questionMark!;
      }
    });
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
                Navigator.of(context).pop();
              },
            ),
            toolbarHeight: height * 0.100,
            centerTitle: true,
            title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  top: height * 0.023,
                  left: height * 0.023,
                  right: height * 0.023),
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
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${quesList.length}',
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
                            '$mark',
                            style: TextStyle(
                                fontSize: height * 0.017,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(234, 9, 9, 1.0),
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
                              for (int i = 0; i < quesList.length; i++)
                                QuestionWidget(
                                  height: height,
                                  index: i,
                                  assessment: assessment,
                                  question: quesList[i],
                                  finalAssessment: finalAssessment,
                                  assessmentType: widget.assessmentType,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: height * 0.5,
                          left: width * 0.78,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/teacherAssessmentLooqQuestionBank',
                                  arguments: false);
                              // Navigator.push(
                              //   context,
                              //   PageTransition(
                              //     type: PageTransitionType.rightToLeft,
                              //     child: TeacherAssessmentLooqQuestionBank(
                              //
                              //     ),
                              //   ),
                              // );
                            },
                            backgroundColor:
                            const Color.fromRGBO(82, 165, 160, 1),
                            child: const Icon(Icons.add),
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
                          backgroundColor:
                          const Color.fromRGBO(255, 255, 255, 1),
                          minimumSize: const Size(280, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(39),
                          ),
                        ),
                        //shape: StadiumBorder(),
                        onPressed: () async {
                          finalAssessment.assessmentStatus = 'inprogress';
                          AssessmentSettings assessmentSettings =
                          AssessmentSettings();
                          finalAssessment.assessmentSettings =
                              assessmentSettings;
                          DateTime startDate=DateTime.now();
                          startDate = DateTime(
                              startDate.year,
                              startDate.month,
                              startDate.day,
                              startDate.hour,
                              startDate.minute);
                          finalAssessment.assessmentStartdate =
                              startDate
                                  .microsecondsSinceEpoch;
                          ResponseEntity statusCode =
                          await QnaService.createAssessmentTeacherService(
                              finalAssessment);
                          if (statusCode.code == 200) {
                            Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));
                          }
                        },
                        child: Text(
                          'Save List',
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
                          bool markZero = true;
                          for (int i = 0; i < quesList.length; i++) {
                            if(quesList[i].questionMark != 0){
                              markZero = false;
                            }
                            else{
                              markZero = true;
                            }
                          }
                          if(markZero){
                            showAlertDialog(context, height);
                          }else{
                            finalAssessment.assessmentId=null;
                            Provider.of<CreateAssessmentProvider>(context, listen: false)
                                .updateAssessment(finalAssessment);
                            Navigator.pushNamed(context, '/teacherAssessmentSettingPublish',arguments: widget.assessmentType);
                          }

                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     type: PageTransitionType.rightToLeft,
                          //     child: TeacherAssessmentSettingPublish(
                          //        ),
                          //   ),
                          // );

//TeacherPublishedAssessment
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
        ));
  }
}

class QuestionWidget extends StatefulWidget {
  QuestionWidget(
      {Key? key,
        required this.height,
        required this.index,
        required this.assessment,
        required this.question,
        required this.finalAssessment,
        required this.assessmentType
      })
      : super(key: key);

  final double height;
  final int index;
  GetAssessmentModel assessment;
  Questions.Question question;
  CreateAssessmentModel.CreateAssessmentModel finalAssessment;
  String assessmentType;


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
        Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
            .deleteQuestionList(widget.index);
        Provider.of<CreateAssessmentProvider>(context, listen: false)
            .removeLooqQuestionInAssess(widget.question.questionId);

        Navigator.of(context).pushNamedAndRemoveUntil('/teacherClonedAssessmentPreview', ModalRoute.withName('/teacherClonedAssessment'),arguments: widget.assessmentType);


        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.rightToLeft,
        //     child: TeacherClonedAssessmentPreview(),
        //   ),
        // );
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
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, '/teacherAssessmentLooqQuestionPreview',
                  arguments: [
                    widget.finalAssessment,
                    widget.question,
                    widget.index,
                    '',
                    widget.question.questionId
                  ]);
            },
            child: Column(
              children: [
                SizedBox(
                  height: widget.height * 0.01,
                ),
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/teacherAssessmentLooqQuestionPreview',
                              arguments: [
                                widget.finalAssessment,
                                widget.question,
                                widget.index,
                                '',
                                widget.question.questionId
                              ]);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Q${widget.index + 1}',
                                  style: TextStyle(
                                      fontSize: widget.height * 0.017,
                                      fontFamily: "Inter",
                                      color:
                                      const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '  ${widget.question.questionType}',
                                  style: TextStyle(
                                      fontSize: widget.height * 0.017,
                                      fontFamily: "Inter",
                                      color:
                                      const Color.fromRGBO(51, 51, 51, 1),
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
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${widget.question.questionMark}',
                                  style: TextStyle(
                                      fontSize: widget.height * 0.017,
                                      fontFamily: "Inter",
                                      color:
                                      const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    showAlertDialog(context, widget.height);
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
                                            color: const Color.fromRGBO(
                                                51, 51, 51, 1),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ))),
                SizedBox(
                  height: widget.height * 0.01,
                ),
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/teacherAssessmentLooqQuestionPreview',
                            arguments: [
                              widget.finalAssessment,
                              widget.question,
                              widget.index,
                              '',
                              widget.question.questionId
                            ]);
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
                    )),
                SizedBox(
                  height: widget.height * 0.01,
                ),
                const Divider(),
                SizedBox(
                  height: widget.height * 0.01,
                ),
              ],
            )));
  }
}
