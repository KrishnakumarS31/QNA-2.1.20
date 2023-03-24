import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_result_inprogress.dart';
import 'package:qna_test/Pages/teacher_result_submitted.dart';
import 'package:qna_test/Pages/teacher_result_total.dart';
import '../EntityModel/get_result_model.dart';

class TeacherResultAssessment extends StatefulWidget {
  TeacherResultAssessment({
    Key? key,
    required this.result,
    this.userId,
    this.advisorName,
  }) : super(key: key);
  GetResultModel result;
  final int? userId;
  final String? advisorName;

  @override
  TeacherResultAssessmentState createState() => TeacherResultAssessmentState();
}

class TeacherResultAssessmentState extends State<TeacherResultAssessment> {
//  IconData showIcon = Icons.expand_circle_down_outlined;

  @override
  void initState() {
    super.initState();
  }

  // changeIcon(IconData pramIcon) {
  //   if (pramIcon == Icons.expand_circle_down_outlined) {
  //     setState(() {
  //       showIcon = Icons.arrow_circle_up_outlined;
  //     });
  //   } else {
  //     setState(() {
  //       showIcon = Icons.expand_circle_down_outlined;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
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
                      'RESULTS',
                      style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.result.assessmentCode!,
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
                padding: EdgeInsets.only(
                    top: height * 0.023,
                    left: height * 0.023,
                    right: height * 0.023),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.result.assessmentCode!,
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Internal Assessment ID',
                            style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(children: <Widget>[
                        const Expanded(
                            child: Divider(
                          color: Color.fromRGBO(233, 233, 233, 1),
                          thickness: 2,
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Text(
                            'Participation statistics',
                            style: TextStyle(
                                fontSize: height * 0.0187,
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Expanded(
                            child: Divider(
                          color: Color.fromRGBO(233, 233, 233, 1),
                          thickness: 2,
                        )),
                      ]),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: TeacherResultTotal(
                                      result: widget.result,
                                      userId: widget.userId,
                                      advisorName: widget.advisorName),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(233, 233, 233, 1),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              height: height * 0.1675,
                              width: width * 0.277,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(0, 167, 204, 1),
                                          Color.fromRGBO(57, 191, 200, 1),
                                        ],
                                      ),
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    height: height * 0.07,
                                    width: width * 0.277,
                                    child: Text(
                                      "${widget.result.assessmentResults!.length}",
                                      style: TextStyle(
                                          fontSize: height * 0.0187,
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: height * 0.015,
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: TeacherResultSubmitted(
                                      result: widget.result,
                                      advisorName: widget.advisorName),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(233, 233, 233, 1),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              height: height * 0.1675,
                              width: width * 0.277,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(82, 165, 160, 1),
                                          Color.fromRGBO(0, 218, 205, 1),
                                        ],
                                      ),
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    height: height * 0.07,
                                    width: width * 0.277,
                                    child: Text(
                                      "${widget.result.assessmentResults!.length}",
                                      style: TextStyle(
                                          fontSize: height * 0.0187,
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Text(
                                    'Submitted',
                                    style: TextStyle(
                                        fontSize: height * 0.015,
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: TeacherResultInprogress(
                                      result: widget.result,
                                      advisorName: widget.advisorName),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(233, 233, 233, 1),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              height: height * 0.1675,
                              width: width * 0.277,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(255, 153, 0, 1),
                                          Color.fromRGBO(255, 199, 0, 1),
                                        ],
                                      ),
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    height: height * 0.07,
                                    width: width * 0.277,
                                    child: Text(
                                      "${widget.result.assessmentResults!.length}",
                                      style: TextStyle(
                                          fontSize: height * 0.0187,
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Text(
                                    'In Progress',
                                    style: TextStyle(
                                        fontSize: height * 0.015,
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      )
                    ]),
              ),
            )));
  }
}
