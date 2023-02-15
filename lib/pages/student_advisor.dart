import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import '../Entity/question_paper_model.dart';
import '../Providers/question_num_provider.dart';
import 'student_answersheet.dart';
// import 'package:url_launcher/url_launcher.dart';

class StudMemAdvisor extends StatefulWidget {
  const StudMemAdvisor(
      {Key? key, required this.questions, required this.assessmentId})
      : super(key: key);
  final QuestionPaperModel questions;
  final String assessmentId;

  @override
  StudMemAdvisorState createState() => StudMemAdvisorState();
}

class StudMemAdvisorState extends State<StudMemAdvisor> {
  late Future<QuestionPaperModel> questionPaperModel;
  late QuestionPaperModel values;

  @override
  void initState() {
    super.initState();
    values = widget.questions;
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
          toolbarHeight: localHeight * 0.100,
          centerTitle: true,
          title: Column(children: [
            Text(
              AppLocalizations.of(context)!.advisor,
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: localHeight * 0.024,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              widget.assessmentId,
              //values.data!.assessment!.assessmentCode,
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: localHeight * 0.016,
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(children: [
              Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: localWidth * 0.3, top: localWidth * 0.056),
                      child: Text(
                        AppLocalizations.of(context)!.incorrectly_answered,
                        style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: localHeight * 0.02),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: localHeight * 0.020),
                Column(children: [
                  for (int index = 1;
                      index < context.watch<QuestionNumProvider>().questionNum;
                      index++)
                    Container(
                        // margin: const EdgeInsets.all(5),
                        //padding: const EdgeInsets.all(5),
                        child:
                            //question.answer == "*** not answered ***"
                            //?
                            Provider.of<Questions>(context, listen: false)
                                        .totalQuestion['$index'][1] !=
                                    const Color(0xff52a5a0)
                                ? ListTile(
                                    title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            SizedBox(
                                                height: localHeight * 0.050),
                                            Text(
                                                "Q${values.data!.questions[index - 1].questionId}",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        localHeight * 0.012)),
                                            SizedBox(
                                                width: localHeight * 0.020),
                                            Text(
                                              "${values.data!.questions[index - 1].questionMarks} ${AppLocalizations.of(context)!.marks})",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      179, 179, 179, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      localHeight * 0.012),
                                            ),
                                            SizedBox(
                                                width: localHeight * 0.030),
                                            Provider.of<Questions>(context,
                                                                listen: false)
                                                            .totalQuestion["$index"]
                                                        [2] ==
                                                    true
                                                ? Stack(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .mode_comment_outlined,
                                                          color: const Color
                                                                  .fromRGBO(
                                                              255, 153, 0, 1),
                                                          size: localHeight *
                                                              0.025),
                                                      Positioned(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .copyWith()
                                                                  .size
                                                                  .width *
                                                              0.008,
                                                          top: MediaQuery.of(
                                                                      context)
                                                                  .copyWith()
                                                                  .size
                                                                  .height *
                                                              0.004,
                                                          child: Icon(
                                                            Icons.question_mark,
                                                            color: const Color
                                                                    .fromRGBO(
                                                                255, 153, 0, 1),
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .copyWith()
                                                                    .size
                                                                    .height *
                                                                0.016,
                                                          ))
                                                    ],
                                                  )
                                                : Text("Not answered",
                                                    style:
                                                        // question.answer ==
                                                        //   "*** not answered ***"
                                                        //?
                                                        TextStyle(
                                                            color: const Color
                                                                    .fromRGBO(
                                                                238, 71, 0, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                localHeight *
                                                                    0.014)
                                                    // :
                                                    // TextStyle(
                                                    //     color: const Color.fromRGBO(
                                                    //         82, 165, 160, 1),
                                                    //     fontFamily: 'Inter',
                                                    //     fontWeight: FontWeight.w600,
                                                    //     fontSize: localHeight * 0.014)
                                                    ),
                                          ]),
                                          SizedBox(height: localHeight * 0.010),
                                          Text(
                                            values.data!.questions[index - 1]
                                                .question,
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
                                    subtitle: Column(children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .advisor,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.014)),
                                      ),
                                      SizedBox(height: localHeight * 0.015),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      "${AppLocalizations.of(context)!.study_chapter} ${values.data!.sub_topic}\t",
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromRGBO(
                                                              51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          localHeight * 0.015)),
                                              TextSpan(
                                                  text: values
                                                      .data!
                                                      .questions[index]
                                                      .advisorText,
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromRGBO(
                                                              51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          localHeight * 0.015)),
                                            ])),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text("URL:",
                                                    style: TextStyle(
                                                        color: const Color
                                                                .fromRGBO(
                                                            51, 51, 51, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: localHeight *
                                                            0.015)),
                                                const SizedBox(width: 5),
                                                TextButton(
                                                  //onPressed: _launchURLBrowser,
                                                  onPressed: () {},
                                                  child: Text(
                                                      values
                                                          .data!
                                                          .questions[index - 1]
                                                          .advisorUrl,
                                                      style: TextStyle(
                                                          fontFamily: 'Inter',
                                                          fontSize:
                                                              localHeight *
                                                                  0.015,
                                                          color: const Color
                                                                  .fromRGBO(
                                                              58, 137, 210, 1),
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                )
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 2,
                                            ),
                                          ])
                                    ]),
                                  )
                                : const SizedBox(height: 0)
                        //: null
                        )
                ]),
                const SizedBox(height: 25),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.note_alt,
                        size: localHeight * 0.02,
                        color: const Color.fromRGBO(48, 145, 139, 1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: StudentMemAnswerSheet(
                                questions: values,
                                assessmentId: widget.assessmentId),
                          ),
                        );
                      },
                    ),
                    TextButton(
                        child: Text(AppLocalizations.of(context)!.answer_sheet,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: localHeight * 0.02,
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontWeight: FontWeight.w500)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: StudentMemAnswerSheet(
                                  questions: values,
                                  assessmentId: widget.assessmentId),
                            ),
                          );
                        }),
                    const SizedBox(width: 150),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        size: localHeight * 0.025,
                        color: const Color.fromRGBO(48, 145, 139, 1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: StudentMemAnswerSheet(
                                questions: values,
                                assessmentId: widget.assessmentId),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                // SizedBox(height: localHeight * 0.070),
                const SizedBox(height: 30.0),
                Container(
                  height: localHeight * 0.20,
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
                        top: Radius.elliptical(
                            localWidth / 1.0, localHeight * 0.3)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: localHeight * 0.03, left: localWidth * 0.23),
                        child: Column(children: [
                          Text(
                            AppLocalizations.of(context)!.pls_contact,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: localHeight * 0.020),
                          ),
                          const SizedBox(height: 20.0),
                          RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: ' “ ',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w800,
                                        fontSize: localHeight * 0.030)),
                                TextSpan(
                                    text:
                                        AppLocalizations.of(context)!.retry_msg,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.015)),
                                TextSpan(
                                    text: ' ” ',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w800,
                                        fontSize: localHeight * 0.030)),
                              ])),
                        ]),
                      )
                    ],
                  ),
                ),
                //const SizedBox(height: 30.0),
              ])
            ])));
  }

  // _launchURLBrowser() async {
  //   const url = 'https://flutterdevs.com/';
  //   if (await canLaunch(url)) {
  //     await launch(url, forceSafariVC: true, forceWebView: true);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}

class Question {
  String qnNumber, question, answer, mark, chapterNo, remarks, notesUrl;
  Question(
      {required this.qnNumber,
      required this.question,
      required this.answer,
      required this.chapterNo,
      required this.remarks,
      required this.notesUrl,
      required this.mark});
}
