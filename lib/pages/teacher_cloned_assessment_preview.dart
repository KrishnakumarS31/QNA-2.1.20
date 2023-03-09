import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_prepare_preview_qnBank.dart';
import 'package:qna_test/pages/teacher_assessment_settings_publish.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Providers/edit_assessment_provider.dart';
import 'about_us.dart';
import 'cookie_policy.dart';
import '../Components/end_drawer_menu_teacher.dart';
import 'help_page.dart';
import 'settings_languages.dart';
import 'package:qna_test/Pages/privacy_policy_hamburger.dart';
import 'package:qna_test/Pages/terms_of_services.dart';
import 'package:qna_test/pages/reset_password_teacher.dart';
import 'teacher_prepare_qnBank.dart';
import '../EntityModel/get_assessment_model.dart' as assessment_model;
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
  assessment_model.Datum assessment =assessment_model.Datum();
  int totalMarks =0;

  showAdditionalDetails() {
    setState(() {
      !additionalDetails;
    });
  }


  @override
  void initState() {
    super.initState();
    //assessment=Provider.of<EditAssessmentProvider>(context, listen: false).getAssessment;
    for(int i=0;i<assessment.questions!.length;i++){
      totalMarks = totalMarks + assessment.questions![i].questionMarks!;
    }
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
                          for (int i =0;i< assessment.questions!.length;i++ )
                          QuestionWidget(height: height,index: i,assessment: assessment, setLocale: widget.setLocale,),
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
                              child: TeacherPrepareQnBank(
                                  setLocale: widget.setLocale,assessmentStatus: 'TeacherClonedAssessmentPreview',),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: TeacherClonedAssessmentPreview(
                              setLocale: widget.setLocale),
                        ),
                      );
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
    required this.setLocale
  }) : super(key: key);

  final double height;
  final int index;
  assessment_model.Datum assessment;
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
        widget.assessment.questions![widget.index].removeQuestions?.add(widget.index);
        widget.assessment.questions!.removeAt(widget.index);
        //Provider.of<EditAssessmentProvider>(context, listen: false).updateAssessment(widget.assessment);
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
                  '  ${widget.assessment.questions![widget.index].questionType}',
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
                  '${widget.assessment.questions![widget.index].questionMarks}',
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
            '${widget.assessment.questions![widget.index].question}',
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
