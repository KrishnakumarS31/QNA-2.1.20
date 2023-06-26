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
        if (constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
          return WillPopScope(
              onWillPop: () async => false, child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40.0,
                    color: Color.fromRGBO(28, 78, 80, 1),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                elevation: 0,
                centerTitle: true,
                title:    Text(
                  AppLocalizations.of(context)!.advisor,
                  //"Solution Sheet",
                  style: TextStyle(
                    color: const Color.fromRGBO(28, 78, 80, 1),
                    fontSize: localHeight * 0.0225,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body:
              Column(children: [
                      SizedBox(height: localHeight * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.assessmentId,
                            style: TextStyle(
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: localHeight * 0.02),
                          ),
                        ],
                      ),
                      SizedBox(height: localHeight * 0.020),
              Container(
                height: localHeight * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: kElevationToShadow[2],
                      ),
                      width: localWidth * 0.9,
                      child:
                      SingleChildScrollView(
                        child: Column(children: [
                          for (int index = 1; index <= context
                              .watch<Questions>()
                              .totalQuestion
                              .length; index++)
                            Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(5),
                                child:
                                    Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(82, 165, 160, 0.08),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: localWidth * 0.9,
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
                                              Text("Q$index",
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
                                              SizedBox(width: localHeight * 0.005),
                                              Text(
                                                "${values.data!.questions![index -
                                                    1].questionType}",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: localHeight * 0.012),
                                              ),
                                            SizedBox(height: localHeight * 0.010),
                                              SizedBox(
                                                  width:
                                                  localHeight * 0.020),
                                              Provider
                                                  .of<Questions>(context,
                                                  listen: false)
                                                  .totalQuestion[
                                              "$index"][2] ==
                                                  true
                                                  ? const Text("")
                                                  : Text(
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
                                            ])
                                      ]),
                                    )
                                        : const SizedBox(height: 0)
                                )
                            )
                        ]),
                      )),
                SizedBox(height: localHeight * 0.015),
                ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(
                        width: 1, // the thickness
                        color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                    ),
                    minimumSize:
                    Size(localWidth * 0.1,localWidth * 0.04),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          39),
                    ),
                  ),
                  child: Text(
                      AppLocalizations.of(context)!.view_all_solution,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize:
                          localHeight *
                              0.03,
                          fontWeight: FontWeight
                              .w600,
                          color: const Color.fromRGBO(82, 165, 160, 1))),
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
                    }
                ),
                SizedBox(height: localHeight * 0.01),
                const Divider(
                  thickness: 2,
                ),
                SizedBox(height: localHeight * 0.010),
              Container(
                  height: localHeight * 0.13,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: kElevationToShadow[2],
                  ),
                  width: localWidth * 0.6,
                  child: Column(
                    children:[
                      SizedBox(height: localHeight * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text(AppLocalizations.of(context)!.pls_contact,
                            style: TextStyle(
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: localHeight * 0.02),
                          ),
                        ]
                      ),
                      SizedBox(height: localHeight * 0.015),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          IconButton(
                              iconSize: localHeight * 0.06,
                              icon: const Icon(
                                Icons.mail_outline_outlined,
                                color: Color.fromRGBO(
                                    82, 165, 160, 1),
                              ),
                              onPressed: () async {
                                String email = Uri.encodeComponent("${widget.questions.data!.advisorEmail}");
                                Uri mail = Uri.parse("mailto:$email");
                                if (await launchUrl(mail)) {
                                } else {}
                              }
                              ),
                          IconButton(
                              iconSize: localHeight * 0.06,
                              icon: const Icon(
                                Icons.chat,
                                color: Color.fromRGBO(
                                    82, 165, 160, 1),
                              ),
                              onPressed: () async {
                              }),
                        ]
                      )
                    ]
                  )),
                      SizedBox(height: localHeight * 0.030),

                  ])));
        }
        else if(constraints.maxWidth > 960) {
          return WillPopScope(
              onWillPop: () async => false, child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40.0,
                    color: Color.fromRGBO(28, 78, 80, 1),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                elevation: 0,
                centerTitle: true,
                title:    Text(
                  AppLocalizations.of(context)!.advisor,
                  //"Solution Sheet",
                  style: TextStyle(
                    color: const Color.fromRGBO(28, 78, 80, 1),
                    fontSize: localHeight * 0.0225,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body:
              Column(children: [
                SizedBox(height: localHeight * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.assessmentId,
                      style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: localHeight * 0.02),
                    ),
                  ],
                ),
                SizedBox(height: localHeight * 0.020),
                Container(
                    height: localHeight * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: kElevationToShadow[2],
                    ),
                    width: localWidth * 0.9,
                    child:
                    SingleChildScrollView(
                      child: Column(children: [
                        for (int index = 1; index <= context
                            .watch<Questions>()
                            .totalQuestion
                            .length; index++)
                          Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child:
                              Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(82, 165, 160, 0.08),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: localWidth * 0.9,
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
                                            Text("Q$index",
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
                                            SizedBox(width: localHeight * 0.005),
                                            Text(
                                              "${values.data!.questions![index -
                                                  1].questionType}",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: localHeight * 0.012),
                                            ),
                                            SizedBox(height: localHeight * 0.010),
                                            SizedBox(
                                                width:
                                                localHeight * 0.020),
                                            Provider
                                                .of<Questions>(context,
                                                listen: false)
                                                .totalQuestion[
                                            "$index"][2] ==
                                                true
                                                ? const Text("")
                                                : Text(
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
                                          ])
                                    ]),
                                  )
                                      : const SizedBox(height: 0)
                              )
                          )
                      ]),
                    )),
                SizedBox(height: localHeight * 0.015),
                ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                          width: 1, // the thickness
                          color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                      ),
                      minimumSize:
                      Size(localWidth * 0.1,localWidth * 0.04),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            39),
                      ),
                    ),
                    child: Text(
                        AppLocalizations.of(context)!.view_all_solution,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize:
                            localHeight *
                                0.03,
                            fontWeight: FontWeight
                                .w600,
                            color: const Color.fromRGBO(82, 165, 160, 1))),
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
                    }
                ),
                SizedBox(height: localHeight * 0.005),
                const Divider(
                  thickness: 2,
                ),
                SizedBox(height: localHeight * 0.005),
                Container(
                    height: localHeight * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: kElevationToShadow[2],
                    ),
                    width: localWidth * 0.4,
                    child: Column(
                        children:[
                          SizedBox(height: localHeight * 0.005),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Text(AppLocalizations.of(context)!.pls_contact,
                                  style: TextStyle(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: localHeight * 0.02),
                                ),
                              ]
                          ),
                          SizedBox(height: localHeight * 0.003),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                IconButton(
                                    iconSize: localHeight * 0.04,
                                    icon: const Icon(
                                      Icons.mail_outline_outlined,
                                      color: Color.fromRGBO(
                                          82, 165, 160, 1),
                                    ),
                                    onPressed: () async {
                                      String email = Uri.encodeComponent("${widget.questions.data!.advisorEmail}");
                                      Uri mail = Uri.parse("mailto:$email");
                                      if (await launchUrl(mail)) {
                                      } else {}
                                    }),
                                IconButton(
                                    iconSize: localHeight * 0.04,
                                    icon: const Icon(
                                      Icons.voice_chat_rounded,
                                      color: Color.fromRGBO(
                                          82, 165, 160, 1),
                                    ),
                                    onPressed: () {
                                    }),
                              ]
                          )
                        ]
                    )),

              ])));
        }
        else {
          return WillPopScope(
              onWillPop: () async => false, child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40.0,
                    color: Color.fromRGBO(28, 78, 80, 1),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                elevation: 0,
                centerTitle: true,
                title:    Text(
                  AppLocalizations.of(context)!.advisor,
                  //"Solution Sheet",
                  style: TextStyle(
                    color: const Color.fromRGBO(28, 78, 80, 1),
                    fontSize: localHeight * 0.0225,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body:
              Column(children: [
                SizedBox(height: localHeight * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.assessmentId,
                      style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: localHeight * 0.02),
                    ),
                  ],
                ),
                SizedBox(height: localHeight * 0.020),
                Container(
                    height: localHeight * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: kElevationToShadow[2],
                    ),
                    width: localWidth * 0.9,
                    child:
                    SingleChildScrollView(
                      child: Column(children: [
                        for (int index = 1; index <= context
                            .watch<Questions>()
                            .totalQuestion
                            .length; index++)
                          Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child:
                              Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(82, 165, 160, 0.08),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: localWidth * 0.9,
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
                                            Text("Q$index",
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
                                            SizedBox(width: localHeight * 0.005),
                                            Text(
                                              "${values.data!.questions![index -
                                                  1].questionType}",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: localHeight * 0.012),
                                            ),
                                            SizedBox(height: localHeight * 0.010),
                                            SizedBox(
                                                width:
                                                localHeight * 0.020),
                                            Provider
                                                .of<Questions>(context,
                                                listen: false)
                                                .totalQuestion[
                                            "$index"][2] ==
                                                true
                                                ? const Text("")
                                                : Text(
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
                                              localHeight * 0.01),
                                        ]),
                                    subtitle: Column(children: [
                                      SizedBox(
                                          height: localHeight * 0.01),
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
                                            const SizedBox(height: 6),
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
                                          ])
                                    ]),
                                  )
                                      : const SizedBox(height: 0)
                              )
                          )
                      ]),
                    )),
                SizedBox(height: localHeight * 0.01),
                ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                          width: 1, // the thickness
                          color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                      ),
                      minimumSize:
                      Size(localWidth * 0.1,localWidth * 0.04),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            39),
                      ),
                    ),
                    child: Text(
                        AppLocalizations.of(context)!.view_all_solution,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize:
                            localHeight *
                                0.03,
                            fontWeight: FontWeight
                                .w600,
                            color: const Color.fromRGBO(82, 165, 160, 1))),
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
                    }
                ),
                const Divider(
                  thickness: 2,
                ),
                SizedBox(height: localHeight * 0.001),
                Container(
                    height: localHeight * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: kElevationToShadow[2],
                    ),
                    width: localWidth * 0.8,
                    child: Column(
                        children:[
                          SizedBox(height: localHeight * 0.01),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Text(AppLocalizations.of(context)!.pls_contact,
                                  style: TextStyle(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: localHeight * 0.02),
                                ),
                              ]
                          ),
                          SizedBox(height: localHeight * 0.005),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                IconButton(
                                    iconSize: localHeight * 0.04,
                                    icon: const Icon(
                                      Icons.mail_outline_outlined,
                                      color: Color.fromRGBO(
                                          82, 165, 160, 1),
                                    ),
                                    onPressed: () async {
                                      String email = Uri.encodeComponent("${widget.questions.data!.advisorEmail}");
                                      Uri mail = Uri.parse("mailto:$email");
                                      if (await launchUrl(mail)) {
                                      } else {}
                                    }),
                                IconButton(
                                    iconSize: localHeight * 0.04,
                                    icon: const Icon(
                                      Icons.voice_chat_rounded,
                                      color: Color.fromRGBO(
                                          82, 165, 160, 1),
                                    ),
                                    onPressed: () {
                                    }),
                              ]
                          )
                        ]
                    )),
                SizedBox(height: localHeight * 0.010),

              ])));
        }
      },
    );
  }
}
