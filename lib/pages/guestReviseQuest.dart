import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/student_result_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'guest_result_page.dart';
class guestReviseQuest extends StatefulWidget {
  const guestReviseQuest({super.key});

  @override
  guestReviseQuestState createState() => guestReviseQuestState();
}

class guestReviseQuestState extends State<guestReviseQuest> {
  List<QuestionModel> questionList = [
    QuestionModel(
        qnNumber: "1",
        question:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
        answer: "a. Lorem ipsum dolor sit amet, consectetur adipiscing ",
        mark: "5"),
    QuestionModel(
        qnNumber: "2",
        question:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in  rhoncus lectus efficitur",
        answer: "*** not answered ***",
        mark: "10"),
    QuestionModel(
        qnNumber: "3",
        question:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies",
        answer: "b. Option 2",
        mark: "10"),
    QuestionModel(
        qnNumber: "4",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "b. Option 3",
        mark: "5"),
    QuestionModel(
        qnNumber: "5",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        mark: "5"),
    QuestionModel(
        qnNumber: "6",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        mark: "15"),
    QuestionModel(
        qnNumber: "7",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "a. Lorem ipsum dolor sit amet, consectetur adipiscing ",
        mark: "10"),
    QuestionModel(
        qnNumber: "8",
        question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        answer: "*** not answered ***",
        mark: "10")
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   leading:
        //   GestureDetector(
        //     onTap: () {
        //   Navigator.of(context).pop();
        //       },
        //   child: Image.asset(
        //     "assets/images/Back_Chevron.png",
        //   ),
        // ),
        //   // leading: Row(
        //   // children:[
        //   // IconButton(
        //   //   tooltip: "Revise",
        //   //   icon: const Icon(
        //   //     Icons.chevron_left,
        //   //     size: 30,
        //   //     color: Colors.white,
        //   //   ),
        //   //   onPressed: () {
        //   //     Navigator.of(context).pop();
        //   //   },
        //   // ),
        //   //   Text(
        //   // " \t Revise",
        //   // style: TextStyle(
        //   //   color: const Color.fromRGBO(255, 255, 255, 1),
        //   //   fontSize: localHeight * 0.018,
        //   //   fontFamily: "Inter",
        //   //   fontWeight: FontWeight.w700,
        //   // ),
        //   //   ),
        //   // ]),
        //   centerTitle: true,
        //   title: Column(children: [
        //     Text(
        //       "Review",
        //       style: TextStyle(
        //         color: const Color.fromRGBO(255, 255, 255, 1),
        //         fontSize: localHeight * 0.018,
        //         fontFamily: "Inter",
        //         fontWeight: FontWeight.w700,
        //       ),
        //     ),
        //     Text(
        //       "Answer Sheet",
        //       style: TextStyle(
        //         color: const Color.fromRGBO(255, 255, 255, 1),
        //         fontSize: localHeight * 0.018,
        //         fontFamily: "Inter",
        //         fontWeight: FontWeight.w700,
        //       ),
        //     ),
        //     Text(
        //       "AssID23515A225",
        //       style: TextStyle(
        //         color: const Color.fromRGBO(255, 255, 255, 1),
        //         fontSize: localHeight * 0.014,
        //         fontFamily: "Inter",
        //         fontWeight: FontWeight.w700,
        //       ),
        //     ),
        //   ]),
        //   flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //             end: Alignment.bottomRight,
        //             begin: Alignment.topLeft,
        //             colors: [
        //           Color.fromRGBO(82, 165, 160, 1),
        //           Color.fromRGBO(0, 106, 100, 1),
        //         ])),
        //   ),
        // ),
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(children: [
              Column(
                  children: [
                    Container(
                      height: localHeight * 0.25,
                      width: localWidth * 1 ,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(0, 106, 100, 1),
                            Color.fromRGBO(82, 165, 160, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                localWidth * 2.0,
                                localHeight * 0.6)
                        ),
                      ),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children : [
                          SizedBox(height: localHeight * 0.060),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                                children:[
                                  IconButton(
                                    tooltip: AppLocalizations.of(context)!.revise,
                                    icon: const Icon(
                                      Icons.chevron_left,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.revise,
                                    style: TextStyle(
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: localHeight * 0.018,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ]),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child:
                            SizedBox(
                              child: Column(children: [
                                Text(
                                  AppLocalizations.of(context)!.review,
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: localHeight * 0.020,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.answer_sheet,
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: localHeight * 0.020,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: localHeight * 0.03,
                                ),
                                Text(
                                  "AssID23515A225",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: localHeight * 0.016,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                              // decoration: BoxDecoration(
                              //     //color: Colors.yellow[100],
                              //     border: Border.all(
                              //       color: Colors.red,
                              //       width: 1,
                              //     )),
                              // child: Image.asset("assets/images\question_mark_logo.png"),
                            ),
                          ),
                          SizedBox(height: localHeight * 0.025),

                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: localWidth * 0.056, top: localWidth * 0.056),
                          child: Text(
                            AppLocalizations.of(context)!.guest,
                            style: TextStyle(
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: localHeight * 0.02),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: localHeight * 0.020),
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(left: localWidth * 0.056),
                        child: Text(
                            AppLocalizations.of(context)!.pls_tap_ques,
                            style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: localHeight * 0.011)),
                      )
                    ]),
                    //SizedBox(height: localHeight * 0.030),
                    Column(
                      children: questionList.map((question) {
                        return Container(
                          //decoration: BoxDecoration(border: Border.all()),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            //color: const Color.fromRGBO(255, 255, 255, 1),
                            child: ListTile(
                              title: Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text("Q${question.qnNumber}",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: localHeight * 0.012)),
                                      SizedBox(width: localHeight * 0.020),
                                      Text(
                                        "(${question.mark} ${AppLocalizations.of(context)!.marks})",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                179, 179, 179, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.012),
                                      )
                                    ]),
                                    SizedBox(height: localHeight * 0.010),
                                    Text(question.question,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              51, 51, 51, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: localHeight * 0.013),
                                    ),
                                    SizedBox(height: localHeight * 0.015),
                                  ]),
                              subtitle:
                              Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(question.answer,
                                          style:
                                          question.answer == "*** not answered ***"
                                              ? TextStyle(
                                              color: const Color.fromRGBO(
                                                  238, 71, 0, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.014)
                                              : TextStyle(
                                              color: const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.014)
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 2,
                                    ),
                                  ]),
                            )
                        );
                      }).toList(),
                    ),
                    Column(
                      children: [
                        Align(alignment: Alignment.center,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: const Size(280, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              //shape: StadiumBorder(),
                              child:Text(AppLocalizations.of(context)!.submit,
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                  )
                              ),
                              onPressed: () {
                                _showMyDialog();
                              }
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: localHeight * 0.030),
                  ])
            ])));
  }

  Future<void> _showMyDialog() async {
    double localHeight = MediaQuery.of(context).size.height;
    double localWidth = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.only(left: localWidth * 0.13,right: localWidth * 0.13),
          title: Row(
              children:  [
                SizedBox(width: localHeight * 0.030),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(66, 194, 0, 1),
                  ),
                  height: localHeight * 0.10,
                  width: localWidth * 0.10,
                  child: const Icon(Icons.info_outline_rounded,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                SizedBox(width: localHeight * 0.015),
                Text(AppLocalizations.of(context)!.confirm,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: localHeight * 0.024,
                      color: const Color.fromRGBO(0, 106, 100, 1),
                      fontWeight: FontWeight.w700
                  ),),
              ]
          ),
          content:
          // SingleChildScrollView(
          //   child:
          Text(AppLocalizations.of(context)!.sure_to_submit,),
          //),
          actions: <Widget>[
            SizedBox(width: localHeight * 0.020),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                minimumSize: const Size(90, 30),
                side: const BorderSide(
                  width: 1.5,
                  color: Color.fromRGBO(82, 165, 160, 1),
                ),
              ),
              child:  Text(AppLocalizations.of(context)!.no,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: localHeight * 0.018,
                      color: const Color.fromRGBO(82, 165, 160, 1),
                      fontWeight: FontWeight.w500
                  )
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: localHeight * 0.005),
            ElevatedButton(
                style:
                ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                  minimumSize: const Size(90, 30),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(50),
                  // ),
                ),
                //shape: StadiumBorder(),
                child:  Text(AppLocalizations.of(context)!.yes,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: localHeight * 0.018,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const GuestResultPage(),
                    ),
                  );
                }
            ),
            SizedBox(width: localHeight * 0.030),
          ],
        );
      },
    );
  }
}

class QuestionModel {
  String qnNumber, question, answer, mark;
  QuestionModel(
      {required this.qnNumber,
        required this.question,
        required this.answer,
        required this.mark});
}
