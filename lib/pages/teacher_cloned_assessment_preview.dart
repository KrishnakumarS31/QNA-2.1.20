import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_prepare_preview_qnBank.dart';
import 'package:qna_test/pages/teacher_assessment_settings_publish.dart';
import 'package:qna_test/pages/teacher_looq_search_question.dart';
import 'package:qna_test/pages/teacher_published_assessment.dart';

import '../Entity/demo_question_model.dart';
import '../Providers/question_prepare_provider.dart';
import 'teacher_prepare_qnBank.dart';


class TeacherClonedAssessmentPreview extends StatefulWidget {
  const TeacherClonedAssessmentPreview({
    Key? key,

  }) : super(key: key);


  @override
  TeacherClonedAssessmentPreviewState createState() => TeacherClonedAssessmentPreviewState();
}

class TeacherClonedAssessmentPreviewState extends State<TeacherClonedAssessmentPreview> {
  bool additionalDetails = true;

  showAdditionalDetails(){
    setState(() {
      !additionalDetails;
    });
  }


  @override
  void initState() {
    super.initState();
    //quesList = Provider.of<QuestionPrepareProvider>(context, listen: false).getAllQuestion;
  }



  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController teacherQuestionBankSearchController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon:const Icon(
                Icons.menu,
                size: 40.0,
                color: Colors.white,
              ), onPressed: () {
              Navigator.of(context).pop();
            },
            ),
          ),
        ],
        leading: IconButton(
          icon:const Icon(
            Icons.chevron_left,
            size: 40.0,
            color: Colors.white,
          ), onPressed: () {
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
          padding: EdgeInsets.only(top: height * 0.023,left: height * 0.023,right: height * 0.023),
          child:
          Column(
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
                        '20',
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
                        '100',
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
              SizedBox(height: height * 0.02,),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: height * 0.6,
                    width: width * 0.9,

                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // for ( DemoQuestionModel i in quesList )
                          //   QuestionPreview(height: height, width: width,question: i,),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),


                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: height * 0.5,
                      left: width * 0.78,
                      child: FloatingActionButton(onPressed: (){
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const TeacherPrepareQnBank(),
                          ),
                        );
                      },
                        child: Icon(Icons.add),
                        backgroundColor: Color.fromRGBO(82, 165, 160, 1),
                      )
                  )
                ],
              ),
              SizedBox(height: height * 0.03,),
              Center(
                child: Container(
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
                          child: const TeacherClonedAssessmentPreview(),
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
              SizedBox(height: height * 0.03,),
              Center(
                child: Container(
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
                        )
                    ),
                    //shape: StadiumBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const TeacherAssessmentSettingPublish(),
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
          )
      ),
    );
  }

}

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Q1',
                  style: TextStyle(
                      fontSize: height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(82, 165, 160, 1),
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '  MCQ',
                  style: TextStyle(
                      fontSize: height * 0.017,
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
                      fontSize: height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '5',
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
                Icon(Icons.close,color: Color.fromRGBO(51, 51, 51, 1),),
                Text(
                  ' Remove',
                  style: TextStyle(
                      fontSize: height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: height * 0.01,),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et nulla cursus, dictum risus sit amet, semper massa. Sed sit. Phasellus viverra, odio dignissim',
          style: TextStyle(
              fontSize: height * 0.015,
              fontFamily: "Inter",
              color: Color.fromRGBO(51, 51, 51, 1),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: height * 0.01,),
        Divider(),
        SizedBox(height: height * 0.01,),
      ],
    );
  }
}


