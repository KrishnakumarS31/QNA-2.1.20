import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/demo_question_model.dart';

class TeacherAssessmentSearched extends StatefulWidget {
  const TeacherAssessmentSearched({
    Key? key,
    required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

  @override
  TeacherAssessmentSearchedState createState() =>
      TeacherAssessmentSearchedState();
}

class TeacherAssessmentSearchedState extends State<TeacherAssessmentSearched> {
  bool agree = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController teacherQuestionBankSearchController =
        TextEditingController();
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
            "ASSESSMENTS",
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: height * 0.0225,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "SEARCH RESULTS",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search",
                  style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                //SizedBox(height: height * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Library of Assessments",
                      style: TextStyle(
                        color: const Color.fromRGBO(153, 153, 153, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          activeColor: const Color.fromRGBO(82, 165, 160, 1),
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                            if (states.contains(MaterialState.selected)) {
                              return const Color.fromRGBO(
                                  82, 165, 160, 1); // Disabled color
                            }
                            return const Color.fromRGBO(
                                82, 165, 160, 1); // Regular color
                          }),
                          value: agree,
                          onChanged: (val) {
                            setState(() {
                              agree = val!;
                              if (agree) {}
                            });
                          },
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        Text(
                          'Only My Assessments',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: height * 0.015),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: height * 0.02),
                TextField(
                  controller: teacherQuestionBankSearchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 0.3),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: height * 0.016),
                    hintText: "Maths, 10th, 2022, CBSE, Science",
                    suffixIcon: Column(children: [
                      Container(
                          height: height * 0.073,
                          width: width * 0.13,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Color.fromRGBO(82, 165, 160, 1),
                          ),
                          child: IconButton(
                            iconSize: height * 0.04,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: TeacherAssessmentSearched(
                                      setLocale: widget.setLocale),
                                ),
                              );
                            },
                            icon: const Icon(Icons.search),
                          )),
                    ]),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(82, 165, 160, 1)),
                        borderRadius: BorderRadius.circular(15)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  enabled: true,
                  onChanged: (value) {},
                ),
                SizedBox(height: height * 0.04),
                Text(
                  "Search Results",
                  style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Tap to See Details/Clone",
                  style: TextStyle(
                    color: const Color.fromRGBO(153, 153, 153, 1),
                    fontSize: height * 0.015,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CardInfo(
                  height: height,
                  width: width,
                  status: 'In progress',
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CardInfo(
                  height: height,
                  width: width,
                  status: 'In progress',
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CardInfo(
                  height: height,
                  width: width,
                  status: 'Active',
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CardInfo(
                  height: height,
                  width: width,
                  status: 'In progress',
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CardInfo(
                  height: height,
                  width: width,
                  status: 'Inactive',
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CardInfo(
                  height: height,
                  width: width,
                  status: 'Active',
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CardInfo(
                  height: height,
                  width: width,
                  status: 'Inactive',
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Load More",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.expand_more_outlined,
                      color: Color.fromRGBO(82, 165, 160, 1),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            )),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  const CardInfo(
      {Key? key,
      required this.height,
      required this.width,
      required this.status})
      : super(key: key);

  final double height;
  final double width;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // if (status == 'In progress')
          // {
          //   Navigator.push(
          //     context,
          //     PageTransition(
          //       type: PageTransitionType.rightToLeft,
          //       child: TeacherRecentAssessment(),
          //     ),
          //   );
          // }
          // else if(status == 'Active'){
          //   Navigator.push(
          //     context,
          //     PageTransition(
          //       type: PageTransitionType.rightToLeft,
          //       child: TeacherActiveAssessment(),
          //     ),
          //   );
          // }
          // else{
          //   Navigator.push(
          //     context,
          //     PageTransition(
          //       type: PageTransitionType.rightToLeft,
          //       child: TeacherInactiveAssessment(),
          //     ),
          //   );
          // }
        },
        child: Container(
          height: height * 0.1087,
          width: width * 0.888,
          decoration: BoxDecoration(
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
                padding:
                    EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Maths ",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          " | Class IX",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.circle_rounded,
                      color: status == 'In progress'
                          ? const Color.fromRGBO(255, 166, 0, 1)
                          : status == 'Active'
                              ? const Color.fromRGBO(60, 176, 0, 1)
                              : const Color.fromRGBO(136, 136, 136, 1),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: Row(
                  children: [
                    Text(
                      "Assessment ID: ",
                      style: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      " 0123456789",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Institute Test ID: ",
                          style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          " ABC903857928",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
    String answer = '';
    for (int i = 1; i <= question.correctChoice!.length; i++) {
      int j = 1;
      j = question.correctChoice![i - 1]!;
      answer = '$answer ${question.choices![j - 1]}';
      //question.choices[question.correctChoice[i]];
    }
    return Column(
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        Container(
          height: height * 0.04,
          width: width * 0.95,
          color: const Color.fromRGBO(82, 165, 160, 0.1),
          child: Padding(
            padding: EdgeInsets.only(right: width * 0.02, left: width * 0.02),
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
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "  |  ${question.topic} - ${question.subTopic}",
                      style: TextStyle(
                          fontSize: height * 0.015,
                          fontFamily: "Inter",
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Text(
                  question.studentClass,
                  style: TextStyle(
                      fontSize: height * 0.015,
                      fontFamily: "Inter",
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            question.question,
            style: TextStyle(
                fontSize: height * 0.0175,
                fontFamily: "Inter",
                color: const Color.fromRGBO(51, 51, 51, 1),
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              answer,
              style: TextStyle(
                  fontSize: height * 0.02,
                  fontFamily: "Inter",
                  color: const Color.fromRGBO(82, 165, 160, 1),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              question.questionType,
              style: TextStyle(
                  fontSize: height * 0.02,
                  fontFamily: "Inter",
                  color: const Color.fromRGBO(82, 165, 160, 1),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.01,
        ),
        const Divider()
      ],
    );
  }
}
