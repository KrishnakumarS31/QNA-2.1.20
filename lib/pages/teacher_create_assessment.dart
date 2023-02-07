import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_prepare_qnBank.dart';
import 'package:qna_test/pages/teacher_assessment_question_bank.dart';

import 'teacher_assessment_settings.dart';


class TeacherCreateAssessment extends StatefulWidget {
  const TeacherCreateAssessment({
    Key? key,

  }) : super(key: key);


  @override
  TeacherCreateAssessmentState createState() => TeacherCreateAssessmentState();
}

class TeacherCreateAssessmentState extends State<TeacherCreateAssessment> {
  bool agree = false;


  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController TeacherCreateAssessmentSearchController = TextEditingController();
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
                "PREPARE",
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
                              fontSize: height * 0.015,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontWeight: FontWeight.w400),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sub Topic: N/A',
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '14/1/2023',
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02,),
                Text("Search Question",
                  style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                  ),),
                SizedBox(height: height * 0.01),
                //SizedBox(height: height * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Library Of My Questions",
                      style: TextStyle(
                        color: const Color.fromRGBO(153, 153, 153, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                TextField(
                  controller: TeacherCreateAssessmentSearchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.016),
                    hintText: "Maths, 10th, 2022",
                    suffixIcon:
                    Column(
                        children: [
                          Container(
                              height: height * 0.073,
                              width: width*0.13,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                color: Color.fromRGBO(82, 165, 160, 1),
                              ),
                              child: IconButton(
                                iconSize: height * 0.04,
                                color: const Color.fromRGBO(255, 255, 255, 1), onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: const TeacherAssessmentQuestionBank(),
                                  ),
                                );

                              }, icon: const Icon(Icons.search),
                              )),
                        ]),
                    focusedBorder:  OutlineInputBorder(
                        borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  enabled: true,
                  onChanged: (value) {
                  },
                ),
                SizedBox(height: height * 0.08),
                Center(
                 // child: Container(
                    //padding: const EdgeInsets.all(0.0),
                    // height: height * 0.55,
                    // width: width * 0.32,
                    child: Image.asset("assets/images/create_assessment.png"),
                 // ),
                ),
                SizedBox(height: height * 0.03),
                Align(
                  alignment: Alignment.center,
                  //margin: EdgeInsets.only(left: height * 0.040),
                  child: Text("Search from my question bank",
                          style: TextStyle(
                              fontSize: height * 0.015,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(153, 153, 153, 1),
                              fontFamily: "Inter"),),
                ),
                SizedBox(height: height * 0.08),
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
                            child: const TeacherPrepareQnBank(),
                          ),
                        );


                      },
                      child: Text(
                        'Create New Question',
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
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.rightToLeft,
                        //     child: const TeacherPublishedAssessment(),
                        //   ),
                        // );


                      },
                      child: Text(
                        'Save',
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
      ),
    );
  }

}

class CardInfo extends StatelessWidget {
  const CardInfo({
    Key? key,
    required this.height,
    required this.width,
    required this.status
  }) : super(key: key);

  final double height;
  final double width;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: ()
        {

        },
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
                    Row(
                      children: [
                        Text("Maths ",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),),
                        Text(" | Class IX",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),),
                      ],
                    ),
                    Icon(Icons.circle_rounded,color: status=='In progress'?Color.fromRGBO(255, 166, 0, 1):status=='Active'?Color.fromRGBO(60, 176, 0, 1):Color.fromRGBO(136, 136, 136, 1),)
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: width * 0.02),
                child: Row(
                  children: [
                    Text("Assessment ID: ",
                      style: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),),
                    Text(" 0123456789",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Institute Test ID: ",
                          style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),),
                        Text(" ABC903857928",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),),
                      ],
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
      ),
    );
  }
}









