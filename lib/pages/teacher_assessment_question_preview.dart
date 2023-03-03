import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:qna_test/pages/teacher_add_my_question_bank.dart';
import 'package:qna_test/pages/teacher_assessment_summary.dart';
import '../EntityModel/get_assessment_model.dart' as assessment_model;
import '../Entity/demo_question_model.dart';
import '../Entity/question_model.dart';

class TeacherAssessmentQuestionPreview extends StatefulWidget {
  const TeacherAssessmentQuestionPreview({
    Key? key,
    required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

  @override
  TeacherAssessmentQuestionPreviewState createState() =>
      TeacherAssessmentQuestionPreviewState();
}

class TeacherAssessmentQuestionPreviewState
    extends State<TeacherAssessmentQuestionPreview> {
  String? _groupValue;
  TextEditingController adviceController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  IconData showIcon = Icons.expand_circle_down_outlined;
  List<dynamic> selected = [];
  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        // appBar: AppBar(
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.only(right: 10),
        //       child: IconButton(
        //         icon: const Icon(
        //           Icons.menu,
        //           size: 40.0,
        //           color: Colors.white,
        //         ),
        //         onPressed: () {
        //           Navigator.of(context).pop();
        //         },
        //       ),
        //     ),
        //   ],
        //   leading: IconButton(
        //     icon: const Icon(
        //       Icons.chevron_left,
        //       size: 40.0,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        //   toolbarHeight: height * 0.100,
        //   centerTitle: true,
        //   title: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         Text(
        //           "SELECTED QUESTION",
        //           style: TextStyle(
        //             color: const Color.fromRGBO(255, 255, 255, 1),
        //             fontSize: height * 0.0225,
        //             fontFamily: "Inter",
        //             fontWeight: FontWeight.w400,
        //           ),
        //         ),
        //       ]),
        //   flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //             end: Alignment.bottomCenter,
        //             begin: Alignment.topCenter,
        //             colors: [
        //               Color.fromRGBO(0, 106, 100, 1),
        //               Color.fromRGBO(82, 165, 160, 1),
        //             ])),
        //   ),
        // ),
        body: Center(
          child: SizedBox(
            height: height * 0.85,
            width: width * 0.888,
            child: Card(
                elevation: 12,
                color: const Color.fromRGBO(255, 255, 255, 1),
                margin: EdgeInsets.only(
                    left: width * 0.030,
                    right: width * 0.030,
                    bottom: height * 0.015,
                    top: height * 0.025),
                //padding: const EdgeInsets.all(40),
                child: Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.03,
                        left: width * 0.03,
                        top: width * 0.03,
                        bottom: width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Question',
                                  style: TextStyle(
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  '01',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Marks:',
                                  style: TextStyle(
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  '5',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          'MCQ',
                          style: TextStyle(
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et nulla cursus, dictum risus sit amet, semper massa. Etiam et nulla cursus, dictum risus sit',
                          style: TextStyle(
                              fontSize: height * 0.017,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(51, 51, 51, 1),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        ChooseWidget(
                          height: height,
                          width: width,
                          selected: selected,
                          choices: const ['yellow', 'apple', 'red', 'orange'],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          'Advisor',
                          style: TextStyle(
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et nulla cursus, dictum',
                          style: TextStyle(
                              fontSize: height * 0.017,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(51, 51, 51, 1),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        const Divider(),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          'www.gworkspacetest.bestschool.com/SN8u9*VHcvasok',
                          style: TextStyle(
                              fontSize: height * 0.015,
                              decoration: TextDecoration.underline,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(0, 148, 255, 1),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Center(
                          child: SizedBox(
                            width: width * 0.888,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color.fromRGBO(82, 165, 160, 1),
                                ),
                                backgroundColor:
                                    const Color.fromRGBO(255, 255, 255, 1),
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
                                    color:
                                        const Color.fromRGBO(82, 165, 160, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Center(
                          child: SizedBox(
                            width: width * 0.888,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(82, 165, 160, 1),
                                  minimumSize: const Size(280, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39),
                                  ),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                  )),
                              //shape: StadiumBorder(),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: TeacherAssessmentSummary(
                                        setLocale: widget.setLocale),
                                  ),
                                );
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    fontSize: height * 0.025,
                                    fontFamily: "Inter",
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
        ));
  }

  changeIcon(IconData pramIcon) {
    if (pramIcon == Icons.expand_circle_down_outlined) {
      setState(() {
        showIcon = Icons.arrow_circle_up_outlined;
      });
    } else {
      setState(() {
        showIcon = Icons.expand_circle_down_outlined;
      });
    }
  }
}

class ChooseWidget extends StatefulWidget {
  const ChooseWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.choices,
    required this.selected,
  }) : super(key: key);

  final List<dynamic> choices;
  final List<dynamic> selected;
  final double height;
  final double width;

  @override
  State<ChooseWidget> createState() => _ChooseWidgetState();
}

class _ChooseWidgetState extends State<ChooseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int j = 1; j <= widget.choices.length; j++)
          GestureDetector(
            onTap: () {
              // setState(() {
              // print("dsfsdf");
              // print(widget.selected);
              // if(widget.selected.contains(j)){
              //   widget.selected.remove(j);
              //   print("remove");
              //   print(widget.selected);
              // }
              // else{
              //   widget.selected.add(j);
              //   print("add");
              //   print(widget.selected);
              // }
              // });
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.height * 0.013),
              child: Container(
                  width: widget.width * 0.744,
                  height: widget.height * 0.0412,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: const Color.fromRGBO(209, 209, 209, 1)),
                    color: const Color.fromRGBO(82, 165, 160, 1),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: widget.width * 0.02,
                        ),
                        Expanded(
                          child: Text(
                            '${widget.choices[j - 1]}',
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize: widget.height * 0.0162,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ])),
            ),
          )
      ],
    );
  }
}
