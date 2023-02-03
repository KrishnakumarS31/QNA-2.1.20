
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_result_individual_student.dart';

import '../Components/custom_card.dart';
import '../Components/custom_card1.dart';
import '../Components/custom_result_card.dart';




class TeacherResultTotal extends StatefulWidget {
  TeacherResultTotal({
    Key? key,

  }) : super(key: key);


  @override
  TeacherResultTotalState createState() => TeacherResultTotalState();
}

class TeacherResultTotalState extends State<TeacherResultTotal> {

  IconData showIcon=Icons.expand_circle_down_outlined;

  @override
  void initState() {

  }

  changeIcon(IconData pramIcon){
    if(pramIcon==Icons.expand_circle_down_outlined){
      setState(() {
        showIcon=Icons.arrow_circle_up_outlined;
      });
    }
    else{
      setState(() {
        showIcon=Icons.expand_circle_down_outlined;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                  "TOTAL",
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: height * 0.0225,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "UCE112233",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.drafts_outlined,color: Color.fromRGBO(82, 165, 160, 1),),
                            SizedBox(width: width*0.03,),
                            Icon(Icons.print_outlined,color: Color.fromRGBO(82, 165, 160, 1),)
                          ],
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: height * 0.018,),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      showIcon==Icons.expand_circle_down_outlined?
                      CustomCard1(
                        height: height,
                        width: width,
                        subject: 'Maths',
                        title: 'Lesson 14 &15 / Calculus',
                        subTitle: 'Internal Assessment ID: UCE112233',
                        subTopic: 'Chapter 12',
                        std: 'XI',
                        date: '28/12/2022',
                        status: const Color.fromRGBO(255, 157, 77, 1),):
                      Container(
                        decoration: BoxDecoration(

                            border: Border.all(
                              color: Color.fromRGBO(233, 233, 233, 1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        height: height * 0.6912,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Subject - Maths',
                                style: TextStyle(
                                    color: Color.fromRGBO(28, 78, 80, 1),
                                    fontSize: height * 0.0187,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(Icons.circle,color: const Color.fromRGBO(255, 157, 77, 1),size: width * 0.05,),
                                  Text(
                                    '28/12/2022',
                                    style: TextStyle(
                                        color: Color.fromRGBO(102, 102, 102, 0.7),
                                        fontSize: height * 0.0125,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),

                            ),
                            Padding(
                              padding:  EdgeInsets.only(right: width * 0.02,left: width * 0.02),
                              child: Divider(
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03,bottom: height * 0.015,top:height * 0.002 ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      'Advisor',
                                      style: TextStyle(
                                          color: Color.fromRGBO(28, 78, 80, 1),
                                          fontSize: height * 0.0185,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      ' Raghavan, Shanmugam',
                                      style: TextStyle(
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                          fontSize: height * 0.0175,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03,bottom: height * 0.005),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Title - Lesson 14 &15 / Calculus',
                                  style: TextStyle(
                                      color: Color.fromRGBO(82, 165, 160, 1),
                                      fontSize: height * 0.0175,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03,bottom: height * 0.005),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Sub Topic Chapter 12',
                                  style: TextStyle(
                                      color: Color.fromRGBO(82, 165, 160, 1),
                                      fontSize: height * 0.0175,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03,bottom: height * 0.004),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Class XI',
                                  style: TextStyle(
                                      color: Color.fromRGBO(102, 102, 102, 1),
                                      fontSize: height * 0.0175,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height * 0.103,
                                  width: width * 0.31,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Test',
                                        style: TextStyle(
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Category',
                                        style: TextStyle(
                                            color: Color.fromRGBO(102, 102, 102, 1),
                                            fontSize: height * 0.015,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: height * 0.103,
                                  width: width * 0.306,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(width: 1.0, color: Color.fromRGBO(232, 232, 232, 1)),
                                      right: BorderSide(width: 1.0, color: Color.fromRGBO(232, 232, 232, 1)),
                                    ),

                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '20',
                                        style: TextStyle(
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            color: Color.fromRGBO(102, 102, 102, 1),
                                            fontSize: height * 0.015,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Questions',
                                        style: TextStyle(
                                            color: Color.fromRGBO(102, 102, 102, 1),
                                            fontSize: height * 0.015,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: height * 0.103,
                                  width: width * 0.265,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '150',
                                        style: TextStyle(
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.02,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            color: Color.fromRGBO(102, 102, 102, 1),
                                            fontSize: height * 0.015,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Marks',
                                        style: TextStyle(
                                            color: Color.fromRGBO(102, 102, 102, 1),
                                            fontSize: height * 0.015,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Schedule',
                                  style: TextStyle(
                                      color: Color.fromRGBO(28, 78, 80, 1),
                                      fontSize: height * 0.017,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03,top:height * 0.007 ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      'Test max. Time permitted:',
                                      style: TextStyle(
                                          color: Color.fromRGBO(102, 102, 102, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      ' 01:30 Hrs',
                                      style: TextStyle(
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03,top:height * 0.007 ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      'Test Opening Date & Time:',
                                      style: TextStyle(
                                          color: Color.fromRGBO(102, 102, 102, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      ' 28/12/2022  09:00 AM',
                                      style: TextStyle(
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03,top:height * 0.007 ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      'Test Closing Date & Time:',
                                      style: TextStyle(
                                          color: Color.fromRGBO(102, 102, 102, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      ' 31/12/2022  08:30 PM',
                                      style: TextStyle(
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02,),
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03,bottom: height * 0.015,top:height * 0.002 ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      'Guest',
                                      style: TextStyle(
                                          color: Color.fromRGBO(28, 78, 80, 1),
                                          fontSize: height * 0.0185,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '   Allowed',
                                      style: TextStyle(
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                          fontSize: height * 0.0175,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03,bottom: height * 0.015,top:height * 0.002 ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      'URL: ',
                                      style: TextStyle(
                                          color: Color.fromRGBO(102, 102, 102, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: width * 0.21,),
                                    Container(
                                      height: height * 0.037,
                                      width: width * 0.52,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'http://www.qnatest.com/test/132215012345678',
                                        style: TextStyle(
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03,bottom: height * 0.015,top:height * 0.002 ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      'Android APP:',
                                      style: TextStyle(
                                          color: Color.fromRGBO(102, 102, 102, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: width * 0.1,),
                                    Container(
                                      height: height * 0.037,
                                      width: width * 0.52,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'http://www.qnatest.com/test/132215012345678',
                                        style: TextStyle(
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.03,bottom: height * 0.015,top:height * 0.002 ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      'IOS APP:',
                                      style: TextStyle(
                                          color: Color.fromRGBO(102, 102, 102, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: width * 0.17,),
                                    Container(
                                      height: height * 0.037,
                                      width: width * 0.52,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'http://www.qnatest.com/test/132215012345678',
                                        style: TextStyle(
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),

                      ),
                      Positioned(top: showIcon==Icons.expand_circle_down_outlined?height * 0.158:height * 0.661,
                        right: width * 0.07,
                        child: IconButton(
                          icon:  Icon(showIcon,color: Color.fromRGBO(82, 165, 160, 1),size: height * 0.03,),
                          onPressed: () {
                            changeIcon(showIcon);
                          },),)
                    ],
                  ),
                  SizedBox(height: height * 0.02,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Total Participants List (43)',
                      style: TextStyle(
                          fontSize: height * 0.0187,
                          color: Color.fromRGBO(28, 78, 80, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: height*0.004,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tap on respective student for details',
                      style: TextStyle(
                          fontSize: height * 0.0125,
                          color: Color.fromRGBO(148, 148, 148, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400),
                    ),
                  ),

                  SizedBox(height: height * 0.02,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: TeacherResultIndividualStudent(),
                        ),
                      );
                    },
                    child: Result_card(
                      height: height,
                      width: width,
                      name: "Ramesh Kumar",
                      testCode: 'SSSUHE10112025',
                      percent: 95,
                      securedMark: '45',
                      totalMark: '50', ),
                  ),

                  Result_card(
                    height: height,
                    width: width,
                    name: "Praveen Kumar",
                    testCode: 'SSSUHE10112025',
                    percent: 0,
                    securedMark: '00',
                    totalMark: '50', ),

                  SizedBox(
                    height: height * 0.03,
                  )


                ]),
          ),
        ));
  }

}











