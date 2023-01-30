import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/pages/teacher_result_month_wise.dart';

import '../Components/custom_card.dart';




class TeacherResultLanding extends StatefulWidget {
  const TeacherResultLanding({
    Key? key,

  }) : super(key: key);


  @override
  TeacherResultLandingState createState() => TeacherResultLandingState();
}

class TeacherResultLandingState extends State<TeacherResultLanding> {



  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((_) {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
          ),
          context: context,
          builder: (builder) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              ),
              height: MediaQuery.of(context).copyWith().size.height * 0.245,
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).copyWith().size.width * 0.10 ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).copyWith().size.height * 0.026,),
                    Padding(
                      padding:  EdgeInsets.only(right: MediaQuery.of(context).copyWith().size.width * 0.055),
                      child: Align(alignment: Alignment.topRight,child: IconButton(icon: Icon(Icons.close,color: const Color.fromRGBO(82, 165, 160, 1),size: MediaQuery.of(context).copyWith().size.width * 0.07,), onPressed: () { Navigator.of(context).pop(); },),),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.square,color: const Color.fromRGBO(5, 169, 203, 1),size: MediaQuery.of(context).copyWith().size.height * 0.02,),
                        Text("  Total Number of Participant",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge( TextStyle(
                              color: const Color.fromRGBO(51, 51, 51, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).copyWith().size.height * 0.016)),),
                        SizedBox(
                          width: MediaQuery.of(context).copyWith().size.width * 0.052,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).copyWith().size.height * 0.019,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.square,color: const Color.fromRGBO(82, 165, 160, 1),size: MediaQuery.of(context).copyWith().size.height * 0.02,),
                        Text("  Submitted",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge( TextStyle(
                              color: const Color.fromRGBO(51, 51, 51, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).copyWith().size.height * 0.016)),),
                        SizedBox(
                          width: MediaQuery.of(context).copyWith().size.width * 0.18,
                        ),
                        Icon(Icons.square,color: const Color.fromRGBO(106, 160, 204, 1),size: MediaQuery.of(context).copyWith().size.height * 0.02,),
                        Text("  Retries",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge( TextStyle(
                              color: const Color.fromRGBO(51, 51, 51, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).copyWith().size.height * 0.016)),),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).copyWith().size.height * 0.019,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.square,color: const Color.fromRGBO(255, 153, 0, 1),size: MediaQuery.of(context).copyWith().size.height * 0.02,),
                        Text("  In Progress",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge( TextStyle(
                              color: const Color.fromRGBO(51, 51, 51, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).copyWith().size.height * 0.016)),),
                        SizedBox(
                          width: MediaQuery.of(context).copyWith().size.width * 0.16,
                        ),
                        Icon(Icons.square,color: const Color.fromRGBO(179, 179, 179, 1),size: MediaQuery.of(context).copyWith().size.height * 0.02,),
                        Text("  Not Started",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge( TextStyle(
                              color: const Color.fromRGBO(51, 51, 51, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).copyWith().size.height * 0.016)),),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }



  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
              'RESULTS',
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: height * 0.0175,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "MY ASSESSMENTS",
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      children: <Widget>[
                        const Expanded(
                            child: Divider(
                              color: Color.fromRGBO(233, 233, 233, 1),
                              thickness: 2,
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10,left: 10),
                            child: Text(
                              'DEC 2022',
                              style: TextStyle(
                                  fontSize: height * 0.0187,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700),
                            ),
                        ),
                        const Expanded(
                            child: Divider(
                              color: Color.fromRGBO(233, 233, 233, 1),
                              thickness: 2,
                            )
                        ),
                      ]
                  ),
                  SizedBox(height: height * 0.01,),


                  CustomCard(
                    height: height,
                    width: width,
                    subject: 'Maths',
                    title: 'Lesson 14 &15 / Calculus',
                    subTopic: 'Chapter 12',
                    std: 'XI',
                    date: '28/12/2022',
                    status: const Color.fromRGBO(255, 157, 77, 1),),


                  SizedBox(height: height * 0.01,),
                  CustomCard(
                    height: height,
                    width: width,
                    subject: 'Maths',
                    title: 'Lesson 14 &15 / Calculus',
                    subTopic: 'Chapter 12',
                    std: 'XI',
                    date: '28/12/2022',
                    status: const Color.fromRGBO(255, 157, 77, 1),),

                  SizedBox(height: height * 0.02,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: TeacherResultMonth(),
                          ),
                        );
                      },
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [


                          Text(
                          'View All',
                          style: TextStyle(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0187,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            icon:  Icon(
                              Icons.chevron_right,
                              color: const Color.fromRGBO(141, 167, 167, 1),
                              size: height * 0.034,
                            ),
                            onPressed: () {

                            },
                          ),
                        ],
                      ),

                    ),
                  ),
                  SizedBox(height: height * 0.02,),



                  Row(
                      children: <Widget>[
                        const Expanded(
                            child: Divider(
                              color: Color.fromRGBO(233, 233, 233, 1),
                              thickness: 2,
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10,left: 10),
                          child: Text(
                            'NOV 2022',
                            style: TextStyle(
                                fontSize: height * 0.0187,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Expanded(
                            child: Divider(
                              color: Color.fromRGBO(233, 233, 233, 1),
                              thickness: 2,
                            )
                        ),
                      ]
                  ),
                  SizedBox(height: height * 0.01,),
                  CustomCard(
                    height: height,
                    width: width,
                    subject: 'Maths',
                    title: 'Lesson 14 &15 / Calculus',
                    subTopic: 'Chapter 12',
                    std: 'XI',
                    date: '28/12/2022',
                    status: const Color.fromRGBO(66, 194, 0, 1),),
                  SizedBox(height: height * 0.01,),
                  CustomCard(
                    height: height,
                    width: width,
                    subject: 'Maths',
                    title: 'Lesson 14 &15 / Calculus',
                    subTopic: 'Chapter 12',
                    std: 'XI',
                    date: '28/12/2022',
                    status: const Color.fromRGBO(66, 194, 0, 1),),
                  SizedBox(height: height * 0.02,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: TeacherResultMonth(),
                          ),
                        );
                      },
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [


                          Text(
                            'View All',
                            style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.0187,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            icon:  Icon(
                              Icons.chevron_right,
                              color: const Color.fromRGBO(141, 167, 167, 1),
                              size: height * 0.034,
                            ),
                            onPressed: () {

                            },
                          ),
                        ],
                      ),

                    ),
                  ),
                  SizedBox(height: height * 0.02,),
                  SizedBox(height: height * 0.03,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
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
                      //     child: LooqQuestionEdit(question: widget.question,),
                      //   ),
                      // );
                    },
                    child: Text(
                      'Load More',
                      style: TextStyle(
                          fontSize: height * 0.025,
                          fontFamily: "Inter",
                          color: Color.fromRGBO(82, 165, 160, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: height * 0.03,),

                ]),
          ),
        ));
  }

}









