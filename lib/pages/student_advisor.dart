import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Entity/question_paper_model.dart';
import '../Providers/question_num_provider.dart';

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
  List<int> inCorrectAns = [];

  @override
  void initState() {
    super.initState();
    values = widget.questions;
    getData();
  }

  getData() {
    for (int j = 1;
    j <=
        Provider
            .of<Questions>(context, listen: false)
            .totalQuestion
            .length;
    j++) {
      List<dynamic> correctAns = [];
      for (int i = 0; i < values.data!.questions![j - 1].choices!.length; i++) {
        if (values.data!.questions![j - 1].choices![i].rightChoice!) {
          correctAns.add(values.data!.questions![j - 1].choices![i].choiceText);
        }
      }
      correctAns.sort();
      List<dynamic> selectedAns =
      Provider
          .of<Questions>(context, listen: false)
          .totalQuestion['$j'][0];
      selectedAns.sort();
      if (listEquals(correctAns, selectedAns)) {} else {
        inCorrectAns.add(j);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery
        .of(context)
        .size
        .width;
    double localHeight = MediaQuery
        .of(context)
        .size
        .height;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // if (constraints.maxWidth > 900) {
        //   return WillPopScope(
        //       onWillPop: () async => false,
        //       child: Scaffold(
        //           appBar: AppBar(
        //             leading: IconButton(
        //               icon: const Icon(
        //                 Icons.chevron_left,
        //                 size: 40.0,
        //                 color: Colors.white,
        //               ),
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //             ),
        //             toolbarHeight: localHeight * 0.100,
        //             centerTitle: true,
        //             title: Column(children: [
        //               Text(
        //                 AppLocalizations.of(context)!.advisor,
        //                 style: TextStyle(
        //                   color: const Color.fromRGBO(255, 255, 255, 1),
        //                   fontSize: localHeight * 0.034,
        //                   fontFamily: "Inter",
        //                   fontWeight: FontWeight.w700,
        //                 ),
        //               ),
        //               Text(
        //                 widget.assessmentId,
        //                 style: TextStyle(
        //                   color: const Color.fromRGBO(255, 255, 255, 1),
        //                   fontSize: localHeight * 0.026,
        //                   fontFamily: "Inter",
        //                   fontWeight: FontWeight.w400,
        //                 ),
        //               ),
        //             ]),
        //             flexibleSpace: Container(
        //               decoration: const BoxDecoration(
        //                   gradient: LinearGradient(
        //                       end: Alignment.bottomCenter,
        //                       begin: Alignment.topCenter,
        //                       colors: [
        //                         Color.fromRGBO(0, 106, 100, 1),
        //                         Color.fromRGBO(82, 165, 160, 1),
        //                       ])),
        //             ),
        //           ),
        //           resizeToAvoidBottomInset: true,
        //           backgroundColor: Colors.white,
        //           body: SingleChildScrollView(
        //               physics: const ClampingScrollPhysics(),
        //               child: Column(children: [
        //                 Align(
        //                   alignment: Alignment.center,
        //                   child: Text(
        //                     AppLocalizations.of(context)!.incorrectly_answered,
        //                     style: TextStyle(
        //                         color: const Color.fromRGBO(82, 165, 160, 1),
        //                         fontFamily: 'Inter',
        //                         fontWeight: FontWeight.w500,
        //                         fontSize: localHeight * 0.03),
        //                   ),
        //                 ),
        //                 SizedBox(height: localHeight * 0.020),
        //                 Column(children: [
        //                   Column(children: [
        //                     SizedBox(height: localHeight * 0.020),
        //                     Column(
        //                         children: [
        //                       for (int index = 1;
        //                       index <=
        //                           context
        //                               .watch<Questions>()
        //                               .totalQuestion
        //                               .length;
        //                       index++)
        //                         Container(
        //                             child: inCorrectAns.contains(index)
        //                                 ? ListTile(
        //                               title: Column(
        //                                   crossAxisAlignment:
        //                                   CrossAxisAlignment.start,
        //                                   children: [
        //                                     Row(children: [
        //                                       SizedBox(
        //                                           height:
        //                                           localHeight * 0.050),
        //                                       Text("Q $index",
        //                                           style: TextStyle(
        //                                               color: const Color
        //                                                   .fromRGBO(
        //                                                   82, 165, 160, 1),
        //                                               fontFamily: 'Inter',
        //                                               fontWeight:
        //                                               FontWeight.w700,
        //                                               fontSize:
        //                                               localHeight *
        //                                                   0.012)),
        //                                       SizedBox(
        //                                           width:
        //                                           localHeight * 0.020),
        //                                       Text(
        //                                         "(${values.data!
        //                                             .questions![index - 1]
        //                                             .questionMarks} ${AppLocalizations
        //                                             .of(context)!.marks})",
        //                                         style: TextStyle(
        //                                             color: const Color
        //                                                 .fromRGBO(
        //                                                 179, 179, 179, 1),
        //                                             fontFamily: 'Inter',
        //                                             fontWeight:
        //                                             FontWeight.w500,
        //                                             fontSize: localHeight *
        //                                                 0.012),
        //                                       ),
        //                                       SizedBox(
        //                                           width:
        //                                           localHeight * 0.030),
        //                                       Provider
        //                                           .of<Questions>(context,
        //                                           listen: false)
        //                                           .totalQuestion[
        //                                       "$index"][2] ==
        //                                           true
        //                                           ? Stack(
        //                                         children: [
        //                                           Icon(
        //                                               Icons
        //                                                   .mode_comment_outlined,
        //                                               color: const Color
        //                                                   .fromRGBO(
        //                                                   255,
        //                                                   153,
        //                                                   0,
        //                                                   1),
        //                                               size:
        //                                               localHeight *
        //                                                   0.025),
        //                                           Positioned(
        //                                               left: MediaQuery
        //                                                   .of(
        //                                                   context)
        //                                                   .copyWith()
        //                                                   .size
        //                                                   .width *
        //                                                   0.002,
        //                                               top: MediaQuery
        //                                                   .of(
        //                                                   context)
        //                                                   .copyWith()
        //                                                   .size
        //                                                   .height *
        //                                                   0.003,
        //                                               child: Icon(
        //                                                 Icons
        //                                                     .question_mark,
        //                                                 color: const Color
        //                                                     .fromRGBO(
        //                                                     255,
        //                                                     153,
        //                                                     0,
        //                                                     1),
        //                                                 size: MediaQuery
        //                                                     .of(
        //                                                     context)
        //                                                     .copyWith()
        //                                                     .size
        //                                                     .height *
        //                                                     0.016,
        //                                               ))
        //                                         ],
        //                                       )
        //                                           : Text(
        //                                           Provider
        //                                               .of<Questions>(context, listen: false)
        //                                               .totalQuestion['$index'][0].isEmpty?
        //                                           AppLocalizations.of(context)!.not_answered:
        //                                           AppLocalizations.of(context)!.incorrectly_answered
        //                                           ,
        //                                           //"Not answered",
        //                                           style: TextStyle(
        //                                               color: const Color
        //                                                   .fromRGBO(
        //                                                   238,
        //                                                   71,
        //                                                   0,
        //                                                   1),
        //                                               fontFamily:
        //                                               'Inter',
        //                                               fontWeight:
        //                                               FontWeight
        //                                                   .w600,
        //                                               fontSize:
        //                                               localHeight *
        //                                                   0.014)),
        //                                     ]),
        //                                     SizedBox(
        //                                         height:
        //                                         localHeight * 0.010),
        //                                     Text(
        //                                       values
        //                                           .data!
        //                                           .questions![index - 1]
        //                                           .question!,
        //                                       textAlign: TextAlign.start,
        //                                       style: TextStyle(
        //                                           color:
        //                                           const Color.fromRGBO(
        //                                               51, 51, 51, 1),
        //                                           fontFamily: 'Inter',
        //                                           fontWeight:
        //                                           FontWeight.w400,
        //                                           fontSize:
        //                                           localHeight * 0.013),
        //                                     ),
        //                                     SizedBox(
        //                                         height:
        //                                         localHeight * 0.015),
        //                                   ]),
        //                               subtitle: Column(children: [
        //                                 SizedBox(
        //                                     height: localHeight * 0.015),
        //                                 Column(
        //                                     crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                     children: [
        //                                       RichText(
        //                                           text: TextSpan(children: [
        //                                             TextSpan(
        //                                                 text:
        //                                                 "${AppLocalizations.of(
        //                                                     context)!
        //                                                     .study_chapter} ${values
        //                                                     .data!.subTopic}\t",
        //                                                 style: TextStyle(
        //                                                     color: const Color
        //                                                         .fromRGBO(
        //                                                         51, 51, 51, 1),
        //                                                     fontFamily: 'Inter',
        //                                                     fontWeight:
        //                                                     FontWeight.w600,
        //                                                     fontSize:
        //                                                     localHeight *
        //                                                         0.015)),
        //                                             TextSpan(
        //                                                 text: values
        //                                                     .data!
        //                                                     .questions![
        //                                                 index - 1]
        //                                                     .advisorText,
        //                                                 style: TextStyle(
        //                                                     color: const Color
        //                                                         .fromRGBO(
        //                                                         51, 51, 51, 1),
        //                                                     fontFamily: 'Inter',
        //                                                     fontWeight:
        //                                                     FontWeight.w400,
        //                                                     fontSize:
        //                                                     localHeight *
        //                                                         0.015)),
        //                                           ])),
        //                                       const SizedBox(height: 10),
        //                                       Row(
        //                                         children: [
        //                                           Text("URL:",
        //                                               style: TextStyle(
        //                                                   color: const Color
        //                                                       .fromRGBO(
        //                                                       51,
        //                                                       51,
        //                                                       51,
        //                                                       1),
        //                                                   fontFamily:
        //                                                   'Inter',
        //                                                   fontWeight:
        //                                                   FontWeight
        //                                                       .w400,
        //                                                   fontSize:
        //                                                   localHeight *
        //                                                       0.015)),
        //                                           const SizedBox(width: 5),
        //                                           Flexible(
        //                                               child:
        //                                               TextButton(
        //                                                 onPressed: () async {
        //                                                   final Uri url = Uri.parse(values.data!.questions![index - 1].advisorUrl!);
        //                                                   if (!await launchUrl(url)) {
        //                                                     throw Exception('Could not launch $url');
        //                                                   }
        //                                                 },
        //                                                 child: Text(
        //                                                     values
        //                                                         .data!
        //                                                         .questions![
        //                                                     index - 1]
        //                                                         .advisorUrl!,
        //                                                     style: TextStyle(
        //                                                         fontFamily:
        //                                                         'Inter',
        //                                                         fontSize:
        //                                                         localHeight *
        //                                                             0.015,
        //                                                         color: const Color
        //                                                             .fromRGBO(
        //                                                             58,
        //                                                             137,
        //                                                             210,
        //                                                             1),
        //                                                         fontWeight:
        //                                                         FontWeight
        //                                                             .w400)),
        //                                               )),
        //                                         ],
        //                                       ),
        //                                       const Divider(
        //                                         thickness: 2,
        //                                       ),
        //                                     ])
        //                               ]),
        //                             )
        //                                 : const SizedBox(height: 0)
        //                         )
        //                     ]),
        //                     const SizedBox(height: 25),
        //                   ])
        //                 ]),
        //                 const Divider(
        //                   thickness: 2,
        //                 ),
        //                 Row(
        //                   children: [
        //                     IconButton(
        //                       icon: Icon(
        //                         Icons.note_alt,
        //                         size: localHeight * 0.02,
        //                         color: const Color.fromRGBO(48, 145, 139, 1),
        //                       ),
        //                       onPressed: () {
        //                         values.data!.assessmentType != "test"
        //                             ?
        //                         Navigator.pushNamed(context, '/studentMemAnswerSheet',arguments: [values,widget.assessmentId])
        //                             :
        //                         Navigator.push(
        //                           context,
        //                           PageTransition(
        //                             type:
        //                             PageTransitionType.rightToLeft,
        //                             child: CustomDialog(
        //                               title:
        //                               AppLocalizations.of(context)!.alert_popup,
        //                               //'Alert',
        //                               content:
        //                               AppLocalizations.of(context)!.shown_for_practice,
        //                              // 'Answersheet are shown only in Practice mode',
        //                               button:
        //                               AppLocalizations.of(context)!.ok_caps,
        //                               //"OK",
        //                             ),
        //                           ),
        //                         );
        //                       },
        //                     ),
        //                     TextButton(
        //                         child: Text(
        //                             AppLocalizations.of(context)!.answer_sheet,
        //                             style: TextStyle(
        //                                 fontFamily: 'Inter',
        //                                 fontSize: localHeight * 0.03,
        //                                 color: const Color.fromRGBO(
        //                                     48, 145, 139, 1),
        //                                 fontWeight: FontWeight.w500)),
        //                         onPressed: () {
        //                           values.data!.assessmentType != "test"
        //                               ?
        //                           Navigator.pushNamed(context, '/studentMemAnswerSheet',arguments: [values,widget.assessmentId])
        //                               : Navigator.push(
        //                             context,
        //                             PageTransition(
        //                               type:
        //                               PageTransitionType.rightToLeft,
        //                               child:  CustomDialog(
        //                                 title:
        //                                 AppLocalizations.of(context)!.alert_popup,
        //                                 //'Alert',
        //                                 content:
        //                                 AppLocalizations.of(context)!.shown_for_practice,
        //                                 //'Answersheet are shown only in Practice mode',
        //                                 button:
        //                                 AppLocalizations.of(context)!.ok_caps,
        //                                 //"OK",
        //                               ),
        //                             ),
        //                           );
        //                         }),
        //                     const SizedBox(width: 150),
        //                     IconButton(
        //                       icon: Icon(
        //                         Icons.chevron_right,
        //                         size: localHeight * 0.025,
        //                         color: const Color.fromRGBO(48, 145, 139, 1),
        //                       ),
        //                       onPressed: () {
        //                         values.data!.assessmentType != "test"
        //                             ?
        //                         Navigator.pushNamed(context, '/studentMemAnswerSheet',arguments: [values,widget.assessmentId])
        //                             : Navigator.push(
        //                           context,
        //                           PageTransition(
        //                             type:
        //                             PageTransitionType.rightToLeft,
        //                             child:  CustomDialog(
        //                               title:
        //                               AppLocalizations.of(context)!.alert_popup,
        //                               //'Alert',
        //                               content:
        //                               AppLocalizations.of(context)!.shown_for_practice,
        //                               //'Answersheet are shown only in Practice mode',
        //                               button:
        //                               AppLocalizations.of(context)!.ok_caps,
        //                               //"OK",
        //                             ),
        //                           ),
        //                         );
        //                       },
        //                     ),
        //                   ],
        //                 ),
        //                 const Divider(
        //                   thickness: 2,
        //                 ),
        //                 widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
        //                     ? Row(
        //                   children: [
        //                     IconButton(
        //                       icon: Icon(
        //                         Icons.quick_contacts_dialer_rounded,
        //                         size: localHeight * 0.02,
        //                         color: const Color.fromRGBO(48, 145, 139, 1),
        //                       ),
        //                       onPressed: () {
        //                         Navigator.push(
        //                           context,
        //                           PageTransition(
        //                             type:
        //                             PageTransitionType.rightToLeft,
        //                             child: CustomDialog(
        //                               title: AppLocalizations.of(context)!.advisor_contact,
        //                               content:
        //                               widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
        //                                   ? "${widget.questions.data!.advisorName}"
        //                                   :  widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
        //                                   ? "${widget.questions.data!.advisorEmail}"
        //                                   : widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null
        //                                   ? "${widget.questions.data!.advisorName}"
        //                                   : AppLocalizations.of(context)!.not_given,
        //                               //"Not given",
        //                               button: AppLocalizations.of(context)!.ok_caps,
        //                               subContent: "${widget.questions.data!.advisorEmail}",
        //                               //"OK",
        //                             ),
        //                           ),
        //                         );
        //                       },
        //                     ),
        //                     TextButton(
        //                         child: Text(
        //                             AppLocalizations.of(context)!.advisor_contact,
        //                             style: TextStyle(
        //                                 fontFamily: 'Inter',
        //                                 fontSize: localHeight * 0.03,
        //                                 color: const Color.fromRGBO(
        //                                     48, 145, 139, 1),
        //                                 fontWeight: FontWeight.w500)),
        //                         onPressed: () {
        //                           Navigator.push(
        //                             context,
        //                             PageTransition(
        //                               type:
        //                               PageTransitionType.rightToLeft,
        //                               child: CustomDialog(
        //                                 title: AppLocalizations.of(context)!.advisor_contact,
        //                                 content:
        //                                 widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
        //                                     ? "${widget.questions.data!.advisorName}"
        //                                     :  widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
        //                                     ? "${widget.questions.data!.advisorEmail}"
        //                                     : widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null
        //                                     ? "${widget.questions.data!.advisorName}"
        //                                     : AppLocalizations.of(context)!.not_given,
        //                                 //"Not given",
        //                                 button: AppLocalizations.of(context)!.ok_caps,
        //                                 subContent: "${widget.questions.data!.advisorEmail}",
        //                                 //"OK",
        //                               ),
        //                             ),
        //                           );
        //                         }),
        //                     const SizedBox(width: 130),
        //                     IconButton(
        //                       icon: Icon(
        //                         Icons.chevron_right,
        //                         size: localHeight * 0.025,
        //                         color: const Color.fromRGBO(48, 145, 139, 1),
        //                       ),
        //                       onPressed: () {
        //                         Navigator.push(
        //                           context,
        //                           PageTransition(
        //                             type:
        //                             PageTransitionType.rightToLeft,
        //                             child: CustomDialog(
        //                               title: AppLocalizations.of(context)!.advisor_contact,
        //                               content:
        //                               widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
        //                                   ? "${widget.questions.data!.advisorName}"
        //                                   :  widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
        //                                   ? "${widget.questions.data!.advisorEmail}"
        //                                   : widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null
        //                                   ? "${widget.questions.data!.advisorName}"
        //                                   : AppLocalizations.of(context)!.not_given,
        //                               //"Not given",
        //                               button: AppLocalizations.of(context)!.ok_caps,
        //                               subContent: "${widget.questions.data!.advisorEmail}",
        //                               //"OK",
        //                             ),
        //                           ),
        //                         );
        //                       },
        //                     ),
        //                   ],
        //                 )
        //                     : const SizedBox(),
        //                 widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
        //                     ? const Divider(
        //                   thickness: 2,
        //                 )
        //                     : const SizedBox(),
        //                 const SizedBox(height: 30.0),
        //                 Container(
        //                   height: localHeight * 0.20,
        //                   width: localWidth,
        //                   decoration: BoxDecoration(
        //                     gradient: const LinearGradient(
        //                       begin: Alignment.topLeft,
        //                       end: Alignment.bottomRight,
        //                       colors: [
        //                         Color.fromRGBO(0, 106, 100, 1),
        //                         Color.fromRGBO(82, 165, 160, 1),
        //                       ],
        //                     ),
        //                     borderRadius: BorderRadius.vertical(
        //                         top: Radius.elliptical(
        //                             localWidth / 1.0, localHeight * 0.3)),
        //                   ),
        //                   child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         Text(
        //                           "\n \n${AppLocalizations.of(context)!.pls_contact}",
        //                           textAlign: TextAlign.center,
        //                           style: TextStyle(
        //                               color: const Color.fromRGBO(
        //                                   255, 255, 255, 1),
        //                               fontFamily: 'Inter',
        //                               fontWeight: FontWeight.w700,
        //                               fontSize: localHeight * 0.020),
        //                         ),
        //                         const SizedBox(height: 20.0),
        //                         RichText(
        //                             textAlign: TextAlign.start,
        //                             text: TextSpan(children: [
        //                               TextSpan(
        //                                   text: ' “ ',
        //                                   style: TextStyle(
        //                                       color: const Color.fromRGBO(
        //                                           255, 255, 255, 1),
        //                                       fontFamily: 'Inter',
        //                                       fontWeight: FontWeight.w800,
        //                                       fontSize: localHeight * 0.030)),
        //                               TextSpan(
        //                                   text: AppLocalizations.of(context)!
        //                                       .retry_msg,
        //                                   style: TextStyle(
        //                                       color: const Color.fromRGBO(
        //                                           255, 255, 255, 1),
        //                                       fontFamily: 'Inter',
        //                                       fontWeight: FontWeight.w400,
        //                                       fontSize: localHeight * 0.015)),
        //                               TextSpan(
        //                                   text: ' ” ',
        //                                   style: TextStyle(
        //                                       color: const Color.fromRGBO(
        //                                           255, 255, 255, 1),
        //                                       fontFamily: 'Inter',
        //                                       fontWeight: FontWeight.w800,
        //                                       fontSize: localHeight * 0.030)),
        //                             ])),
        //                       ]),
        //                 ),
        //               ]))));
        // }
        if (constraints.maxWidth > 400) {
          return Center(
            child: SizedBox(
                width: 400,
              child: WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
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
                                    padding: const EdgeInsets.only(
                                        left: 400 * 0.3,
                                        top: 400 * 0.056),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .incorrectly_answered,
                                      style: TextStyle(
                                          color:
                                          const Color.fromRGBO(82, 165, 160, 1),
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
                                index <=
                                    context
                                        .watch<Questions>()
                                        .totalQuestion
                                        .length;
                                index++)
                                  Container(
                                      child: inCorrectAns.contains(index)
                                          ? ListTile(
                                        title: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(children: [
                                                SizedBox(
                                                    height:
                                                    localHeight * 0.050),
                                                Text("Q $index",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        fontSize:
                                                        localHeight *
                                                            0.012)),
                                                SizedBox(
                                                    width:
                                                    localHeight * 0.020),
                                                Text(
                                                  "(${values.data!
                                                      .questions![index - 1]
                                                      .questionMarks} ${AppLocalizations
                                                      .of(context)!.marks})",
                                                  style: TextStyle(
                                                      color: const Color
                                                          .fromRGBO(
                                                          179, 179, 179, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: localHeight *
                                                          0.012),
                                                ),
                                                SizedBox(
                                                    width:
                                                    localHeight * 0.030),
                                                Provider
                                                    .of<Questions>(context,
                                                    listen: false)
                                                    .totalQuestion[
                                                "$index"][2] ==
                                                    true
                                                    ? Stack(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .mode_comment_outlined,
                                                        color: const Color
                                                            .fromRGBO(
                                                            255,
                                                            153,
                                                            0,
                                                            1),
                                                        size:
                                                        localHeight *
                                                            0.025),
                                                    Positioned(
                                                        left: MediaQuery
                                                            .of(
                                                            context)
                                                            .copyWith()
                                                            .size
                                                            .width *
                                                            0.008,
                                                        top: MediaQuery
                                                            .of(
                                                            context)
                                                            .copyWith()
                                                            .size
                                                            .height *
                                                            0.004,
                                                        child: Icon(
                                                          Icons
                                                              .question_mark,
                                                          color: const Color
                                                              .fromRGBO(
                                                              255,
                                                              153,
                                                              0,
                                                              1),
                                                          size: MediaQuery
                                                              .of(
                                                              context)
                                                              .copyWith()
                                                              .size
                                                              .height *
                                                              0.016,
                                                        ))
                                                  ],
                                                )
                                                    :

                                                Text(
                                                    Provider
                                                        .of<Questions>(context, listen: false)
                                                        .totalQuestion['$index'][0].isEmpty?
                                                    AppLocalizations.of(context)!.not_answered:
                                                    AppLocalizations.of(context)!.incorrectly_answered,
                                                    //"Not answered",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            238,
                                                            71,
                                                            0,
                                                            1),
                                                        fontFamily:
                                                        'Inter',
                                                        fontWeight:
                                                        FontWeight
                                                            .w600,
                                                        fontSize:
                                                        localHeight *
                                                            0.014)),
                                              ]),
                                              SizedBox(
                                                  height:
                                                  localHeight * 0.010),
                                              Text(
                                                values
                                                    .data!
                                                    .questions![index - 1]
                                                    .question!,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color:
                                                    const Color.fromRGBO(
                                                        51, 51, 51, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize:
                                                    localHeight * 0.013),
                                              ),
                                              SizedBox(
                                                  height:
                                                  localHeight * 0.015),
                                            ]),
                                        subtitle: Column(children: [
                                          SizedBox(
                                              height: localHeight * 0.015),
                                          Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                          "${AppLocalizations.of(
                                                              context)!
                                                              .study_chapter} ${values
                                                              .data!.subTopic}\t",
                                                          style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  51, 51, 51, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize:
                                                              localHeight *
                                                                  0.015)),
                                                      TextSpan(
                                                          text: values
                                                              .data!
                                                              .questions![
                                                          index - 1]
                                                              .advisorText,
                                                          style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  51, 51, 51, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              fontSize:
                                                              localHeight *
                                                                  0.015)),
                                                    ])),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Text("URL:",
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                51,
                                                                51,
                                                                51,
                                                                1),
                                                            fontFamily:
                                                            'Inter',
                                                            fontWeight:
                                                            FontWeight
                                                                .w400,
                                                            fontSize:
                                                            localHeight *
                                                                0.015)),
                                                    const SizedBox(width: 5),
                                                    Flexible(
                                                        child:
                                                        TextButton(
                                                          onPressed: () async {
                                                            final Uri url = Uri.parse(values.data!.questions![index - 1].advisorUrl!);
                                                            if (!await launchUrl(url)) {
                                                              throw Exception('Could not launch $url');
                                                            }
                                                          },
                                                          child: Text(
                                                              values
                                                                  .data!
                                                                  .questions![
                                                              index - 1]
                                                                  .advisorUrl!,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Inter',
                                                                  fontSize:
                                                                  localHeight *
                                                                      0.015,
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      58,
                                                                      137,
                                                                      210,
                                                                      1),
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                        )),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 2,
                                                ),
                                              ])
                                        ]),
                                      )
                                          : const SizedBox(height: 0)
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
                                      values.data!.assessmentType != "test"
                                          ?
                                      Navigator.pushNamed(context, '/studentMemAnswerSheet',arguments: [values,widget.assessmentId])
                                          : Navigator.push(
                                        context,
                                        PageTransition(
                                          type:
                                          PageTransitionType.rightToLeft,
                                          child:  CustomDialog(
                                            title: AppLocalizations.of(context)!.alert_popup,
                                            //'Alert',
                                            content: AppLocalizations.of(context)!.shown_for_practice,
                                            //'Answersheet are shown only in Practice mode',
                                            button:
                                            AppLocalizations.of(context)!.ok_caps,
                                            //"OK",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  TextButton(
                                      child: Text(
                                          AppLocalizations.of(context)!.answer_sheet,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: localHeight * 0.02,
                                              color: const Color.fromRGBO(
                                                  48, 145, 139, 1),
                                              fontWeight: FontWeight.w500)),
                                      onPressed: () {
                                        values.data!.assessmentType != "test"
                                            ?
                                        Navigator.pushNamed(context, '/studentMemAnswerSheet',arguments: [values,widget.assessmentId])
                                            : Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .rightToLeft,
                                            child: CustomDialog(
                                              title: AppLocalizations.of(context)!.alert_popup,
                                              //'Alert',
                                              content: AppLocalizations.of(context)!.shown_for_practice,
                                              //'Answersheet are shown only in Practice mode',
                                              button:
                                              AppLocalizations.of(context)!.ok_caps,
                                              //"OK",
                                            ),
                                          ),
                                        );
                                      }),
                                  const SizedBox(width: 400 * 0.35),
                                  IconButton(
                                    icon: Icon(
                                      Icons.chevron_right,
                                      size: localHeight * 0.025,
                                      color: const Color.fromRGBO(48, 145, 139, 1),
                                    ),
                                    onPressed: () {
                                      values.data!.assessmentType != "test"
                                          ?
                                      Navigator.pushNamed(context, '/studentMemAnswerSheet',arguments: [values,widget.assessmentId])
                                          : Navigator.push(
                                        context,
                                        PageTransition(
                                          type:
                                          PageTransitionType.rightToLeft,
                                          child:  CustomDialog(
                                            title: AppLocalizations.of(context)!.alert_popup,
                                            //'Alert',
                                            content: AppLocalizations.of(context)!.shown_for_practice,
                                            //'Answersheet are shown only in Practice mode',
                                            button:
                                            AppLocalizations.of(context)!.ok_caps,
                                            //"OK",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                  ? Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.quick_contacts_dialer_rounded,
                                      size: localHeight * 0.02,
                                      color: const Color.fromRGBO(48, 145, 139, 1),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type:
                                          PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title: AppLocalizations.of(context)!.advisor_contact,
                                            content:
                                            widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                                ? "${widget.questions.data!.advisorName}"
                                                :  widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                                ? "${widget.questions.data!.advisorEmail}"
                                                : widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null
                                                ? "${widget.questions.data!.advisorName}"
                                                : AppLocalizations.of(context)!.not_given,
                                            //"Not given",
                                            button: AppLocalizations.of(context)!.ok_caps,
                                            subContent: "${widget.questions.data!.advisorEmail}",
                                            //"OK",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  TextButton(
                                      child: Text(
                                          AppLocalizations.of(context)!.advisor_contact,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: localHeight * 0.02,
                                              color: const Color.fromRGBO(
                                                  48, 145, 139, 1),
                                              fontWeight: FontWeight.w500)),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                            PageTransitionType.rightToLeft,
                                            child: CustomDialog(
                                              title: AppLocalizations.of(context)!.advisor_contact,
                                              content:
                                              widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                                  ? "${widget.questions.data!.advisorName}"
                                                  :  widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                                  ? "${widget.questions.data!.advisorEmail}"
                                                  : widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null
                                                  ? "${widget.questions.data!.advisorName}"
                                                  : AppLocalizations.of(context)!.not_given,
                                              //"Not given",
                                              button: AppLocalizations.of(context)!.ok_caps,
                                              subContent: "${widget.questions.data!.advisorEmail}",
                                              //"OK",
                                            ),
                                          ),
                                        );
                                      }),
                                  const SizedBox(width: 400 * 0.30),
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
                                          type:
                                          PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title: AppLocalizations.of(context)!.advisor_contact,
                                            content:
                                            widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                                ? "${widget.questions.data!.advisorName}"
                                                :  widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                                ? "${widget.questions.data!.advisorEmail}"
                                                : widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null
                                                ? "${widget.questions.data!.advisorName}"
                                                : AppLocalizations.of(context)!.not_given,
                                            //"Not given",
                                            button: AppLocalizations.of(context)!.ok_caps,
                                            subContent: "${widget.questions.data!.advisorEmail}",
                                            //"OK",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                                  : const SizedBox(),
                              widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                  ? const Divider(
                                thickness: 2,
                              )
                                  : const SizedBox(),
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
                                          400 / 1.0, localHeight * 0.25)),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 35,
                                          left: 75),
                                      child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(AppLocalizations.of(context)!.pls_contact,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: localHeight * 0.020),
                                            ),
                                            SizedBox(height: localHeight * 0.010),
                                            RichText(
                                                textAlign: TextAlign.start,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: ' “ ',
                                                      style: TextStyle(
                                                          color:
                                                          const Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                          FontWeight.w800,
                                                          fontSize:
                                                          localHeight * 0.030)),
                                                  TextSpan(
                                                      text: AppLocalizations.of(
                                                          context)!
                                                          .retry_msg,
                                                      style: TextStyle(
                                                          color:
                                                          const Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontSize:
                                                          localHeight * 0.015)),
                                                  TextSpan(
                                                      text: ' ” ',
                                                      style: TextStyle(
                                                          color:
                                                          const Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                          FontWeight.w800,
                                                          fontSize:
                                                          localHeight * 0.030)),
                                                ])),
                                          ]),
                                    )
                                  ],
                                ),
                              ),
                            ])
                          ])
                      )
                  )),
            ),
          );
        }



        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
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
                                    left: localWidth * 0.3,
                                    top: localWidth * 0.056),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .incorrectly_answered,
                                  style: TextStyle(
                                      color:
                                      const Color.fromRGBO(82, 165, 160, 1),
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
                            index <=
                                context
                                    .watch<Questions>()
                                    .totalQuestion
                                    .length;
                            index++)
                              Container(
                                  child: inCorrectAns.contains(index)
                                      ? ListTile(
                                    title: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            SizedBox(
                                                height:
                                                localHeight * 0.050),
                                            Text("Q $index",
                                                style: TextStyle(
                                                    color: const Color
                                                        .fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    fontSize:
                                                    localHeight *
                                                        0.012)),
                                            SizedBox(
                                                width:
                                                localHeight * 0.020),
                                            Text(
                                              "(${values.data!
                                                  .questions![index - 1]
                                                  .questionMarks} ${AppLocalizations
                                                  .of(context)!.marks})",
                                              style: TextStyle(
                                                  color: const Color
                                                      .fromRGBO(
                                                      179, 179, 179, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize: localHeight *
                                                      0.012),
                                            ),
                                            SizedBox(
                                                width:
                                                localHeight * 0.030),
                                            Provider
                                                .of<Questions>(context,
                                                listen: false)
                                                .totalQuestion[
                                            "$index"][2] ==
                                                true
                                                ? Stack(
                                              children: [
                                                Icon(
                                                    Icons
                                                        .mode_comment_outlined,
                                                    color: const Color
                                                        .fromRGBO(
                                                        255,
                                                        153,
                                                        0,
                                                        1),
                                                    size:
                                                    localHeight *
                                                        0.025),
                                                Positioned(
                                                    left: MediaQuery
                                                        .of(
                                                        context)
                                                        .copyWith()
                                                        .size
                                                        .width *
                                                        0.008,
                                                    top: MediaQuery
                                                        .of(
                                                        context)
                                                        .copyWith()
                                                        .size
                                                        .height *
                                                        0.004,
                                                    child: Icon(
                                                      Icons
                                                          .question_mark,
                                                      color: const Color
                                                          .fromRGBO(
                                                          255,
                                                          153,
                                                          0,
                                                          1),
                                                      size: MediaQuery
                                                          .of(
                                                          context)
                                                          .copyWith()
                                                          .size
                                                          .height *
                                                          0.016,
                                                    ))
                                              ],
                                            )
                                                :

                                            Text(
                                                Provider
                                                    .of<Questions>(context, listen: false)
                                                    .totalQuestion['$index'][0].isEmpty?
                                                AppLocalizations.of(context)!.not_answered:
                                                AppLocalizations.of(context)!.incorrectly_answered,
                                                //"Not answered",
                                                style: TextStyle(
                                                    color: const Color
                                                        .fromRGBO(
                                                        238,
                                                        71,
                                                        0,
                                                        1),
                                                    fontFamily:
                                                    'Inter',
                                                    fontWeight:
                                                    FontWeight
                                                        .w600,
                                                    fontSize:
                                                    localHeight *
                                                        0.014)),
                                          ]),
                                          SizedBox(
                                              height:
                                              localHeight * 0.010),
                                          Text(
                                            values
                                                .data!
                                                .questions![index - 1]
                                                .question!,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color:
                                                const Color.fromRGBO(
                                                    51, 51, 51, 1),
                                                fontFamily: 'Inter',
                                                fontWeight:
                                                FontWeight.w400,
                                                fontSize:
                                                localHeight * 0.013),
                                          ),
                                          SizedBox(
                                              height:
                                              localHeight * 0.015),
                                        ]),
                                    subtitle: Column(children: [
                                      SizedBox(
                                          height: localHeight * 0.015),
                                      Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                      "${AppLocalizations.of(
                                                          context)!
                                                          .study_chapter} ${values
                                                          .data!.subTopic}\t",
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromRGBO(
                                                              51, 51, 51, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize:
                                                          localHeight *
                                                              0.015)),
                                                  TextSpan(
                                                      text: values
                                                          .data!
                                                          .questions![
                                                      index - 1]
                                                          .advisorText,
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromRGBO(
                                                              51, 51, 51, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontSize:
                                                          localHeight *
                                                              0.015)),
                                                ])),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text("URL:",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            51,
                                                            51,
                                                            51,
                                                            1),
                                                        fontFamily:
                                                        'Inter',
                                                        fontWeight:
                                                        FontWeight
                                                            .w400,
                                                        fontSize:
                                                        localHeight *
                                                            0.015)),
                                                const SizedBox(width: 5),
                                                Flexible(
                                                    child:
                                                    TextButton(
                                                      onPressed: () async {
                                                        final Uri url = Uri.parse(values.data!.questions![index - 1].advisorUrl!);
                                                        if (!await launchUrl(url)) {
                                                          throw Exception('Could not launch $url');
                                                        }
                                                      },
                                                      child: Text(
                                                          values
                                                              .data!
                                                              .questions![
                                                          index - 1]
                                                              .advisorUrl!,
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'Inter',
                                                              fontSize:
                                                              localHeight *
                                                                  0.015,
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  58,
                                                                  137,
                                                                  210,
                                                                  1),
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400)),
                                                    )),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 2,
                                            ),
                                          ])
                                    ]),
                                  )
                                      : const SizedBox(height: 0)
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
                                  values.data!.assessmentType != "test"
                                      ?
                                  Navigator.pushNamed(context, '/studentMemAnswerSheet',arguments: [values,widget.assessmentId])
                                      : Navigator.push(
                                    context,
                                    PageTransition(
                                      type:
                                      PageTransitionType.rightToLeft,
                                      child:  CustomDialog(
                                        title: AppLocalizations.of(context)!.alert_popup,
                                        //'Alert',
                                        content: AppLocalizations.of(context)!.shown_for_practice,
                                        //'Answersheet are shown only in Practice mode',
                                        button:
                                        AppLocalizations.of(context)!.ok_caps,
                                        //"OK",
                                      ),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                  child: Text(
                                      AppLocalizations.of(context)!.answer_sheet,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: localHeight * 0.02,
                                          color: const Color.fromRGBO(
                                              48, 145, 139, 1),
                                          fontWeight: FontWeight.w500)),
                                  onPressed: () {
                                    values.data!.assessmentType != "test"
                                        ?
                                    Navigator.pushNamed(context, '/studentMemAnswerSheet',arguments: [values,widget.assessmentId])
                                        : Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType
                                            .rightToLeft,
                                        child: CustomDialog(
                                          title: AppLocalizations.of(context)!.alert_popup,
                                          //'Alert',
                                          content: AppLocalizations.of(context)!.shown_for_practice,
                                          //'Answersheet are shown only in Practice mode',
                                          button:
                                          AppLocalizations.of(context)!.ok_caps,
                                          //"OK",
                                        ),
                                      ),
                                    );
                                  }),
                              SizedBox(width: localWidth * 0.35),
                              IconButton(
                                icon: Icon(
                                  Icons.chevron_right,
                                  size: localHeight * 0.025,
                                  color: const Color.fromRGBO(48, 145, 139, 1),
                                ),
                                onPressed: () {
                                  values.data!.assessmentType != "test"
                                      ?
                                  Navigator.pushNamed(context, '/studentMemAnswerSheet',arguments: [values,widget.assessmentId])
                                      : Navigator.push(
                                    context,
                                    PageTransition(
                                      type:
                                      PageTransitionType.rightToLeft,
                                      child:  CustomDialog(
                                        title: AppLocalizations.of(context)!.alert_popup,
                                        //'Alert',
                                        content: AppLocalizations.of(context)!.shown_for_practice,
                                        //'Answersheet are shown only in Practice mode',
                                        button:
                                        AppLocalizations.of(context)!.ok_caps,
                                        //"OK",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                              ? Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.quick_contacts_dialer_rounded,
                                  size: localHeight * 0.02,
                                  color: const Color.fromRGBO(48, 145, 139, 1),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type:
                                      PageTransitionType.rightToLeft,
                                      child: CustomDialog(
                                        title: AppLocalizations.of(context)!.advisor_contact,
                                        content:
                                        widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                            ? "${widget.questions.data!.advisorName}"
                                            :  widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                            ? "${widget.questions.data!.advisorEmail}"
                                            : widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null
                                            ? "${widget.questions.data!.advisorName}"
                                            : AppLocalizations.of(context)!.not_given,
                                        //"Not given",
                                        button: AppLocalizations.of(context)!.ok_caps,
                                        subContent: "${widget.questions.data!.advisorEmail}",
                                        //"OK",
                                      ),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                  child: Text(
                                      AppLocalizations.of(context)!.advisor_contact,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: localHeight * 0.02,
                                          color: const Color.fromRGBO(
                                              48, 145, 139, 1),
                                          fontWeight: FontWeight.w500)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type:
                                        PageTransitionType.rightToLeft,
                                        child: CustomDialog(
                                          title: AppLocalizations.of(context)!.advisor_contact,
                                          content:
                                          widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                              ? "${widget.questions.data!.advisorName}"
                                              :  widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                              ? "${widget.questions.data!.advisorEmail}"
                                              : widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null
                                              ? "${widget.questions.data!.advisorName}"
                                              : AppLocalizations.of(context)!.not_given,
                                          //"Not given",
                                          button: AppLocalizations.of(context)!.ok_caps,
                                          subContent: "${widget.questions.data!.advisorEmail}",
                                          //"OK",
                                        ),
                                      ),
                                    );
                                  }),
                              SizedBox(width: localWidth * 0.30),
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
                                      type:
                                      PageTransitionType.rightToLeft,
                                      child: CustomDialog(
                                        title: AppLocalizations.of(context)!.advisor_contact,
                                        content:
                                        widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                            ? "${widget.questions.data!.advisorName}"
                                            :  widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                                            ? "${widget.questions.data!.advisorEmail}"
                                            : widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null
                                            ? "${widget.questions.data!.advisorName}"
                                            : AppLocalizations.of(context)!.not_given,
                                        //"Not given",
                                        button: AppLocalizations.of(context)!.ok_caps,
                                        subContent: "${widget.questions.data!.advisorEmail}",
                                        //"OK",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                              : const SizedBox(),
                          widget.questions.data!.assessmentSettings!.showAdvisorName == true && widget.questions.data!.advisorName != null || widget.questions.data!.assessmentSettings!.showAdvisorEmail == true && widget.questions.data!.advisorEmail != null
                              ? const Divider(
                            thickness: 2,
                          )
                              : const SizedBox(),
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
                                      400 / 1.0, localHeight * 0.25)),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 35,
                                      left: 75),
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(AppLocalizations.of(context)!.pls_contact,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: localHeight * 0.020),
                                        ),
                                        SizedBox(height: localHeight * 0.010),
                                        RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: ' “ ',
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      fontSize:
                                                      localHeight * 0.030)),
                                              TextSpan(
                                                  text: AppLocalizations.of(
                                                      context)!
                                                      .retry_msg,
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize:
                                                      localHeight * 0.015)),
                                              TextSpan(
                                                  text: ' ” ',
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      fontSize:
                                                      localHeight * 0.030)),
                                            ])),
                                      ]),
                                )
                              ],
                            ),
                          ),
                        ])
                      ])
                  )
              ));
        }
      },
    );
  }
}
