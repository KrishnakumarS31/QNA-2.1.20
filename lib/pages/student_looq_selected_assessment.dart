import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/pages/stud_question01.dart';
import 'package:qna_test/pages/teacher_cloned_assessment_preview.dart';

import '../Entity/question_paper_model.dart';
import '../Services/qna_service.dart';



class StudentLooqSelectedAssessment extends StatefulWidget {
  const StudentLooqSelectedAssessment({
    Key? key,

  }) : super(key: key);


  @override
  StudentLooqSelectedAssessmentState createState() => StudentLooqSelectedAssessmentState();
}

class StudentLooqSelectedAssessmentState extends State<StudentLooqSelectedAssessment> {
  bool additionalDetails = true;
  late QuestionPaperModel values;

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
                "SELECTED",
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: height*0.03,),
                  Center(
                    child: Container(
                      decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(
                          color: const Color.fromRGBO(217, 217, 217, 1),
                        ),
                        color: Colors.white,
                      ),
                      height: height * 0.1675,
                      width: width * 0.888,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Container(
                            height: height * 0.037,
                            decoration:  const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),topRight: Radius.circular(8.0)),
                              color: Color.fromRGBO(82, 165, 160, 1),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.only(left: width * 0.02),
                              child: Row(
                                children: [
                                  Text("Maths",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),),
                                  Text("  |  Class IX",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: height * 0.015,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Text("Calculus - Chapter 12.2/13",
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),),
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
                  SizedBox(height: height*0.025,),
                  Row(
                    children: [
                      Container(
                        width: width * 0.4,
                        child: Text("Assessment ID:",
                          style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontSize: height * 0.02,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),),
                      ),
                      Text("0123456789",
                        style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),),
                    ],
                  ),
                  SizedBox(height: height*0.01,),
                  Row(
                    children: [
                      Container(
                        width: width * 0.4,
                        child: Text("Institute Test ID:",
                          style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontSize: height * 0.02,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),),
                      ),
                      Text("ABC903857928",
                        style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),),
                    ],
                  ),
                  SizedBox(height: height*0.01,),
                  Divider(),
                  SizedBox(height: height*0.01,),
                  Row(
                    children: [
                      Container(
                        width: width * 0.4,
                        child: Text("Time Permitted:",
                          style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontSize: height * 0.02,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),),
                      ),
                      Text("180 Minutes",
                        style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),),
                    ],
                  ),
                  SizedBox(height: height*0.01,),
                  Row(
                    children: [
                      Container(
                        width: width * 0.4,
                        child: Text("Advisor",
                          style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontSize: height * 0.02,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),),
                      ),
                      Text("Raghavan",
                        style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),),
                    ],
                  ),
                  SizedBox(height: height*0.01,),
                  Row(
                    children: [
                      Container(
                        width: width * 0.4,
                        child: Text("Email ID",
                          style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontSize: height * 0.02,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),),
                      ),
                      Text("rsample.sample@gmail.com",
                        style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),),
                    ],
                  ),
                  SizedBox(height: height*0.03,),
                ],
              ),




              Column(
                children: [
                  Center(
                    child: Container(
                      width: width * 0.888,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.0,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                          ),
                          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
                        onPressed: () async {
                          showDialog(context: context, builder: (context){
                            return const Center(child: CircularProgressIndicator(
                              color: Color.fromRGBO(48, 145, 139, 1),
                            ));
                          });

                          values = await QnaService.getQuestion(assessmentId:'98765432');

                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: StudQuestion(
                                assessmentId: '98765432',
                                ques: values,),
                            ),
                          );
                        },
                        child: Text(
                          'Attempt Assessment',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.06,),
                ],
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
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height*0.01,),
          Text("MCQ",
            style: TextStyle(
              color: const Color.fromRGBO(28, 78, 80, 1),
              fontSize: height * 0.015,
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
            ),),
          SizedBox(height: height*0.01,),
          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et nulla cursus, dictum risus sit amet, semper massa. Sed sit. Phasellus viverra, odio dignissim",
            style: TextStyle(
              color: const Color.fromRGBO(51, 51, 51, 1),
              fontSize: height * 0.015,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),),
          SizedBox(height: height*0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("C. Lorem ipsum dolor sit amet",
                style: TextStyle(
                  color: const Color.fromRGBO(82, 165, 160, 1),
                  fontSize: height * 0.015,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),),
              Row(
                children: [
                  Text("Marks: ",
                    style: TextStyle(
                      color: const Color.fromRGBO(102, 102, 102, 1),
                      fontSize: height * 0.015,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),),
                  Text("5",
                    style: TextStyle(
                      color: const Color.fromRGBO(82, 165, 160, 1),
                      fontSize: height * 0.015,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),),
                ],
              ),

            ],
          ),
          Divider()
        ],
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
