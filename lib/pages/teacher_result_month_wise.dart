
import 'package:flutter/material.dart';

import '../Components/custom_card.dart';




class TeacherResultMonth extends StatefulWidget {
  TeacherResultMonth({
    Key? key,

  }) : super(key: key);


  @override
  TeacherResultMonthState createState() => TeacherResultMonthState();
}

class TeacherResultMonthState extends State<TeacherResultMonth> {



  @override
  void initState() {

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
                  "Dec 2022",
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '27 Dec, 2022',
                        style: TextStyle(
                          color: Color.fromRGBO(179, 179, 179, 1),
                            fontSize: height * 0.0187,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
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
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '22 Dec, 2022',
                        style: TextStyle(
                            color: Color.fromRGBO(179, 179, 179, 1),
                            fontSize: height * 0.0187,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
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


                ]),
          ),
        ));
  }

}









