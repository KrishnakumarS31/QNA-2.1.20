import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_prepare_preview_qnBank.dart';
import 'package:qna_test/pages/teacher_assessment_question_bank.dart';
import 'package:qna_test/pages/teacher_assessment_question_preview.dart';
import 'package:qna_test/pages/teacher_looq_search_question.dart';
import 'package:qna_test/pages/teacher_published_assessment.dart';

import '../Entity/demo_question_model.dart';
import '../Providers/question_prepare_provider.dart';
import 'teacher_prepare_qnBank.dart';


class TeacherAssessmentSummary extends StatefulWidget {
  const TeacherAssessmentSummary({
    Key? key,

  }) : super(key: key);


  @override
  TeacherAssessmentSummaryState createState() => TeacherAssessmentSummaryState();
}

class TeacherAssessmentSummaryState extends State<TeacherAssessmentSummary> {
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
          padding: EdgeInsets.only(top: height * 0.023,left: height * 0.023,right: height * 0.023),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height * 0.108,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color.fromRGBO(82, 165, 160, 0.07),),
                child: Padding(
                  padding: EdgeInsets.only(right: width * 0.03,left: width * 0.03),
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
                                'Maths',
                                style: TextStyle(
                                    fontSize: height * 0.017,
                                    fontFamily: "Inter",
                                    color: Color.fromRGBO(28, 78, 80, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '  |  Class X',
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    color: Color.fromRGBO(28, 78, 80, 1),
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
                                    color: Color.fromRGBO(28, 78, 80, 1),
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: width * 0.01,),
                              Icon(Icons.edit_outlined,color: Color.fromRGBO(28, 78, 80, 1),)
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Topic: Calculus',
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(28, 78, 80, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Topic: N/A',
                            style: TextStyle(
                                fontSize: height * 0.017,
                                fontFamily: "Inter",
                                color: Color.fromRGBO(28, 78, 80, 1),
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '14/1/2023',
                            style: TextStyle(
                                fontSize: height * 0.017,
                                fontFamily: "Inter",
                                color: Color.fromRGBO(28, 78, 80, 1),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.02,),
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
                    height: height * 0.48,
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
                      top: height * 0.4,
                      left: width * 0.78,
                      child: FloatingActionButton(onPressed: (){
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const TeacherAssessmentQuestionBank(),
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
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.rightToLeft,
                      //     child: const TeacherClonedAssessmentPreview(),
                      //   ),
                      // );


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
                          child: const TeacherPublishedAssessment(),
                        ),
                      );


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

  showAlertDialog(BuildContext context,double height) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),),
      child: Text(
        'No',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(82, 165, 160, 1),
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),),
      child: Text(
        'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),),
      onPressed:  () {
        Navigator.of(context).pop();
        // Navigator.push(
        //   context,F
        //   PageTransition(
        //     type: PageTransitionType.rightToLeft,
        //     child: TeacherAddMyQuestionBank(),
        //   ),
        // );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(Icons.info,color: Color.fromRGBO(238, 71, 0, 1),),
          Text(
            'Confirm',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to remove this Question?',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: Color.fromRGBO(51, 51, 51, 1),
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

            GestureDetector(
              onTap: (){
                showAlertDialog(context,height);
              },
              child: Row(
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
              ),
            )
          ],
        ),
        SizedBox(height: height * 0.01,),
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TeacherAssessmentQuestionPreview(),
              ),
            );
          },
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et nulla cursus, dictum risus sit amet, semper massa. Sed sit. Phasellus viverra, odio dignissim',
            style: TextStyle(
                fontSize: height * 0.015,
                fontFamily: "Inter",
                color: Color.fromRGBO(51, 51, 51, 1),
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: height * 0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'C. Lorem ipsum dolor sit amet',
              style: TextStyle(
                  fontSize: height * 0.017,
                  fontFamily: "Inter",
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.w400),
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
          ],
        ),
        Divider(),
        SizedBox(height: height * 0.01,),
      ],
    );
  }
}


