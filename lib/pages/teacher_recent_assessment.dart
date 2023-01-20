import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_prepare_preview_qnBank.dart';
import 'package:qna_test/Pages/teacher_looq_search_question.dart';

import '../Entity/demo_question_model.dart';
import '../Providers/question_prepare_provider.dart';
import 'teacher_prepare_qnBank.dart';


class TeacherRecentAssessment extends StatefulWidget {
  const TeacherRecentAssessment({
    Key? key,

  }) : super(key: key);


  @override
  TeacherRecentAssessmentState createState() => TeacherRecentAssessmentState();
}

class TeacherRecentAssessmentState extends State<TeacherRecentAssessment> {
  bool agree = false;



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
                "IN PROGRESS",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: EdgeInsets.only(top: height * 0.023,left: height * 0.023,right: height * 0.023),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: width*0.48,
                      child: Text("Assessment ID:",
                        style: TextStyle(
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                    Container(
                      width: width*0.32,
                      child: Text("0123456789",
                        style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),),
                    ),
                    Expanded(child: Icon(Icons.circle,color: Color.fromRGBO(255, 166, 0, 1),))


                  ],
                ),
                SizedBox(height: height*0.01,),
                Row(
                  children: [
                    Container(
                      width: width*0.48,
                      child: Text("Institution Assessment ID:",
                        style: TextStyle(
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                    Container(
                      width: width*0.32,
                      child: Text("ABC903857928",
                        style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),),
                    ),
                  ],
                ),
                SizedBox(height: height*0.01,),
                Divider(),
                SizedBox(height: height*0.025,),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Container(
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(
                            color: const Color.fromRGBO(217, 217, 217, 1),
                          ),
                          color: Colors.white,
                        ),
                        height: height * 0.1512,
                        width: width * 0.888,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Padding(
                              padding:  EdgeInsets.only(left: height * 0.03),
                              child: Row(
                                children: [
                                  Text("Maths",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                      fontSize: height * 0.0175,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),),
                                  Text("  |  Calculus - Chapter 12.2/13",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(102, 102, 102, 1),
                                      fontSize: height * 0.015,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration:  const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(color: Color.fromRGBO(204, 204, 204, 1),
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  width: width * 0.44,
                                  height: height * 0.0875,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("50",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontSize: height * 0.03,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),),
                                      Text("Marks",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400,
                                        ),),
                                    ],
                                  ),

                                ),
                                Container(
                                  width: width * 0.44,
                                  height: height * 0.0875,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("50",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontSize: height * 0.03,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),),
                                      Text("Questions",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400,
                                        ),),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -(height* 0.01),
                        left: width * 0.04,
                        child: Container(
                          height: height * 0.02,
                          width: width * 0.15,
                          color: Colors.white,
                          child: Center(
                            child: Text("Class IX",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),),
                          ),
                        )
                    )
                  ],
                ),
                SizedBox(height: height*0.025,),
                Row(
                  children: [
                    Container(
                      width: width * 0.4,
                        child: Text("Time Permitted:",
                          style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),),
                    ),
                    Text("180",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),),
                    Text(" Minutes",
                      style: TextStyle(
                        color: const Color.fromRGBO(153, 153, 153, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),),
                  ],
                ),
                SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Container(
                      width: width * 0.4,
                      child: Text("Start Date & Time:",
                        style: TextStyle(
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                    Text("14/1/2023     |     08:00 AM",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),),
                  ],
                ),
                SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Container(
                      width: width * 0.4,
                      child: Text("End Date & Time:",
                        style: TextStyle(
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                    Text("17/1/2023     |     09:00 AM",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),),
                  ],
                ),
                SizedBox(height: height*0.02,),
                Divider(),
                SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Container(
                      width: width * 0.4,
                      child: Text("Advisor:",
                        style: TextStyle(
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                    Text("Raghavan",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),),
                  ],
                ),
                SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Container(
                      width: width * 0.4,
                      child: Text("Retries:",
                        style: TextStyle(
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                    Text("3",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),),
                  ],
                ),
                SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Container(
                      width: width * 0.4,
                      child: Text("Guest:",
                        style: TextStyle(
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                    Text("Allowed",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),),
                  ],
                ),
                SizedBox(height: height*0.025,),
                Row(
                  children: [
                    Container(
                      width: width * 0.4,
                      child: Text("Answer Sheet:",
                        style: TextStyle(
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                    Text("Viewable",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),),
                  ],
                ),
                SizedBox(height: height * 0.09,),
                Center(
                  child: Container(
                    width: width * 0.888,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                      //shape: StadiumBorder(),
                      onPressed: () {

                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(82, 165, 160, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],

            )
        ),
      ),
    );
  }

}

class CardInfo extends StatelessWidget {
  const CardInfo({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height * 0.1087,
        width: width * 0.888,
        decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(
            color: const Color.fromRGBO(82, 165, 160, 0.15),
          ),
          color: const Color.fromRGBO(82, 165, 160, 0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width * 0.02,right: width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Maths",
                    style: TextStyle(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: height * 0.0175,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "In progress",
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 166, 0, 1),
                      fontSize: height * 0.015,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: width * 0.02),
              child: Text(
                "Calculus - Chapter 12.2",
                style: TextStyle(
                  color: const Color.fromRGBO(102, 102, 102, 1),
                  fontSize: height * 0.015,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: width * 0.02,right: width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Class IX",
                    style: TextStyle(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: height * 0.015,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "10/1/2023",
                    style: TextStyle(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: height * 0.015,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionPreview extends StatelessWidget {
  const QuestionPreview({
    Key? key,
    required this.height,
    required this.width,
    required this.question,
  }) : super(key: key);

  final double height;
  final double width;
  final DemoQuestionModel question;

  @override
  Widget build(BuildContext context) {
    String answer='';
    for(int i=1;i<=question.correctChoice!.length;i++){
      int j=1;
      j=question.correctChoice![i-1]!;
      answer='$answer ${question.choices![j-1]}';
      //question.choices[question.correctChoice[i]];
    }
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            height: height * 0.04,
            width: width * 0.95,
            color: Color.fromRGBO(82, 165, 160, 0.1),
            child: Padding(
              padding:  EdgeInsets.only(right: width * 0.02,left: width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        question.subject,
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(28, 78, 80, 1),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "  |  ${question.topic} - ${question.subTopic}",
                        style: TextStyle(
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(102, 102, 102, 1),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),

                  Text(
                    question.studentClass,
                    style: TextStyle(
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        color: Color.fromRGBO(28, 78, 80, 1),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.01,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              question.question,
              style: TextStyle(
                  fontSize: height * 0.0175,
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
                answer,
                style: TextStyle(
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    color: Color.fromRGBO(82, 165, 160, 1),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                question.questionType,
                style: TextStyle(
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    color: Color.fromRGBO(82, 165, 160, 1),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: height * 0.01,),
          Divider()

        ],
      ),
    );
  }
}