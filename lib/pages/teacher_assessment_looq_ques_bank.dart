import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Entity/Teacher/question_entity.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/user_details.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Providers/create_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class TeacherAssessmentLooqQuestionBank extends StatefulWidget {
  const TeacherAssessmentLooqQuestionBank(
      {Key? key, this.assessment, })
      : super(key: key);

  final bool? assessment;


  @override
  TeacherAssessmentLooqQuestionBankState createState() =>
      TeacherAssessmentLooqQuestionBankState();
}

class TeacherAssessmentLooqQuestionBankState
    extends State<TeacherAssessmentLooqQuestionBank> {
  bool additionalDetails = true;
  TextEditingController teacherQuestionBankSearchController =
  TextEditingController();
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  List<Question> questions = [];
  bool questionsPresent = false;
  UserDetails userDetails=UserDetails();

  @override
  void initState() {
    super.initState();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    getData('');
  }

  getData(String search) async {
    ResponseEntity responseEntity =
    await QnaService.getQuestionBankService(100000, 1, search,userDetails);
    setState(() {
      responseEntity.data==null?[]:questions = List<Question>.from(
          responseEntity.data.map((x) => Question.fromJson(x)));
      if(questions.isNotEmpty){
        questionsPresent=true;
      }
      else{
        questionsPresent=false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // if (constraints.maxWidth > 900) {return WillPopScope(
          //     onWillPop: () async => false,
          //     child: Scaffold(
          //       resizeToAvoidBottomInset: false,
          //       backgroundColor: Colors.white,
          //       endDrawer: const EndDrawerMenuTeacher(),
          //       appBar: AppBar(
          //         leading: IconButton(
          //           icon: const Icon(
          //             Icons.chevron_left,
          //             size: 40.0,
          //             color: Colors.white,
          //           ),
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //         ),
          //         toolbarHeight: height * 0.100,
          //         centerTitle: true,
          //         title: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Text(
          //                 AppLocalizations.of(context)!.search_results_caps,
          //                 //"SEARCH RESULTS",
          //                 style: TextStyle(
          //                   color: const Color.fromRGBO(255, 255, 255, 1),
          //                   fontSize: height * 0.0225,
          //                   fontFamily: "Inter",
          //                   fontWeight: FontWeight.w400,
          //                 ),
          //               ),
          //               Text(
          //                 AppLocalizations.of(context)!.my_qn_bank,
          //                 //"MY QUESTION BANK",
          //                 style: TextStyle(
          //                   color: const Color.fromRGBO(255, 255, 255, 1),
          //                   fontSize: height * 0.0225,
          //                   fontFamily: "Inter",
          //                   fontWeight: FontWeight.w400,
          //                 ),
          //               ),
          //             ]),
          //         flexibleSpace: Container(
          //           decoration: const BoxDecoration(
          //               gradient: LinearGradient(
          //                   end: Alignment.bottomCenter,
          //                   begin: Alignment.topCenter,
          //                   colors: [
          //                     Color.fromRGBO(0, 106, 100, 1),
          //                     Color.fromRGBO(82, 165, 160, 1),
          //                   ])),
          //         ),
          //       ),
          //       body: Padding(
          //         padding: EdgeInsets.only(left: width * 0.025, right: width * 0.025),
          //         child: Column(
          //           children: [
          //             SizedBox(
          //               height: height * 0.02,
          //             ),
          //             TextField(
          //               controller: teacherQuestionBankSearchController,
          //               keyboardType: TextInputType.text,
          //               decoration: InputDecoration(
          //                 floatingLabelBehavior: FloatingLabelBehavior.always,
          //                 hintStyle: TextStyle(
          //                     color: const Color.fromRGBO(102, 102, 102, 0.3),
          //                     fontFamily: 'Inter',
          //                     fontWeight: FontWeight.w400,
          //                     fontSize: height * 0.016),
          //                 hintText: AppLocalizations.of(context)!.sub_hint_text,
          //                 //"Maths, 10th, 2022, CBSE, Science",
          //                 suffixIcon: Column(children: [
          //                   Container(
          //                       height: height * 0.073,
          //                       width: width * 0.13,
          //                       decoration: const BoxDecoration(
          //                         borderRadius:
          //                         BorderRadius.all(Radius.circular(8.0)),
          //                         color: Color.fromRGBO(82, 165, 160, 1),
          //                       ),
          //                       child: IconButton(
          //                         iconSize: height * 0.04,
          //                         color: const Color.fromRGBO(255, 255, 255, 1),
          //                         onPressed: () {
          //                           setState(() {
          //                             questions.clear();
          //                           });
          //                           getData(teacherQuestionBankSearchController.text);
          //                         },
          //                         icon: const Icon(Icons.search),
          //                       )),
          //                 ]),
          //                 focusedBorder: OutlineInputBorder(
          //                     borderSide: const BorderSide(
          //                         color: Color.fromRGBO(82, 165, 160, 1)),
          //                     borderRadius: BorderRadius.circular(15)),
          //                 border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(15)),
          //               ),
          //               enabled: true,
          //               onChanged: (value) {},
          //             ),
          //             SizedBox(
          //               height: height * 0.015,
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   AppLocalizations.of(context)!.tap_to_review,
          //                   //"Tap to Review/Edit/Delete",
          //                   textAlign: TextAlign.left,
          //                   style: TextStyle(
          //                     color: const Color.fromRGBO(153, 153, 153, 1),
          //                     fontSize: height * 0.015,
          //                     fontFamily: "Inter",
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 ),
          //                 Row(
          //                   children: [
          //                     Text(
          //                       AppLocalizations.of(context)!.my_qns_small,
          //                       //"My Questions",
          //                       textAlign: TextAlign.left,
          //                       style: TextStyle(
          //                         color: const Color.fromRGBO(0, 0, 0, 1),
          //                         fontSize: height * 0.015,
          //                         fontFamily: "Inter",
          //                         fontWeight: FontWeight.w400,
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       width: width * 0.02,
          //                     ),
          //                     const Icon(
          //                       Icons.circle_rounded,
          //                       color: Color.fromRGBO(82, 165, 160, 1),
          //                     )
          //                   ],
          //                 )
          //               ],
          //             ),
          //             SizedBox(
          //               height: height * 0.015,
          //             ),
          //             SizedBox(
          //                 height: height * 0.6,
          //                 width: width * 0.9,
          //                 child: questionsPresent?
          //                 SingleChildScrollView(
          //                   scrollDirection: Axis.vertical,
          //                   child: Column(
          //                     children: [
          //                       for (Question i in questions)
          //                         QuestionPreview(
          //                           height: height,
          //                           width: width,
          //                           question: i,
          //                         ),
          //                     ],
          //                   ),
          //                 )
          //                     :
          //                 Text(
          //                   'NO QUESTIONS FOUND',
          //                   textAlign: TextAlign.center,
          //                   style: TextStyle(
          //                     color: const Color.fromRGBO(28, 78, 80, 1),
          //                     fontSize: height * 0.0175,
          //                     fontFamily: "Inter",
          //                     fontWeight: FontWeight.w700,
          //                   ),
          //                 )
          //             ),
          //             // SizedBox(
          //             //   height: height * 0.02,
          //             // ),
          //
          //             Center(
          //               child: SizedBox(
          //                 width: width * 0.8,
          //                 child: ElevatedButton(
          //                   style: ElevatedButton.styleFrom(
          //                       backgroundColor:
          //                       const Color.fromRGBO(82, 165, 160, 1),
          //                       minimumSize: const Size(280, 48),
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(39),
          //                       ),
          //                       side: const BorderSide(
          //                         color: Color.fromRGBO(82, 165, 160, 1),
          //                       )),
          //                   onPressed: () {
          //                     questionsPresent?
          //                     Navigator.pushNamed(context, '/teacherClonedAssessmentPreview',arguments: 'clone'):{};
          //                     // Navigator.push(
          //                     //   context,
          //                     //   PageTransition(
          //                     //     type: PageTransitionType.rightToLeft,
          //                     //     child: TeacherClonedAssessmentPreview(
          //                     //         ),
          //                     //   ),
          //                     // );
          //                   },
          //                   child: Text(
          //                     AppLocalizations.of(context)!.add_small,
          //                     //'Add',
          //                     style: TextStyle(
          //                         fontSize: height * 0.025,
          //                         fontFamily: "Inter",
          //                         color: const Color.fromRGBO(255, 255, 255, 1),
          //                         fontWeight: FontWeight.w600),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             SizedBox(
          //               height: height * 0.02,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ));}
          if(constraints.maxWidth > 400) {return Center(

            child: WillPopScope(
                onWillPop: () async => false,
                child: Container(
                  width: 400.0,
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.white,
                    endDrawer: const EndDrawerMenuTeacher(),
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
                              AppLocalizations.of(context)!.search_results_caps,
                              //"SEARCH RESULTS",
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontSize: height * 0.0225,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.my_qn_bank,
                              //"MY QUESTION BANK",
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
                    body: Padding(
                      padding: EdgeInsets.only(left: width * 0.025, right: width * 0.025),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
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
                              hintText: AppLocalizations.of(context)!.sub_hint_text,
                              //"Maths, 10th, 2022, CBSE, Science",
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
                                        setState(() {
                                          questions.clear();
                                        });
                                        getData(teacherQuestionBankSearchController.text);
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
                          SizedBox(
                            height: height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.tap_to_review,
                                //"Tap to Review/Edit/Delete",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: const Color.fromRGBO(153, 153, 153, 1),
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.my_qns_small,
                                    //"My Questions",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: height * 0.015,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  const Icon(
                                    Icons.circle_rounded,
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          SizedBox(
                              height: height * 0.6,
                              width: width * 0.9,
                              child: questionsPresent?
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    for (Question i in questions)
                                      QuestionPreview(
                                        height: height,
                                        width: width,
                                        question: i,
                                      ),
                                  ],
                                ),
                              )
                                  :
                              Text(
                                'NO QUESTIONS FOUND',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                          ),
                          // SizedBox(
                          //   height: height * 0.02,
                          // ),

                          Center(
                            child: SizedBox(
                              width: width * 0.8,
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
                                onPressed: () {
                                  questionsPresent?
                                  Navigator.pushNamed(context, '/teacherClonedAssessmentPreview',arguments: 'clone'):{};
                                  // Navigator.push(
                                  //   context,
                                  //   PageTransition(
                                  //     type: PageTransitionType.rightToLeft,
                                  //     child: TeacherClonedAssessmentPreview(
                                  //         ),
                                  //   ),
                                  // );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.add_small,
                                  //'Add',
                                  style: TextStyle(
                                      fontSize: height * 0.025,
                                      fontFamily: "Inter",
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          );}
          else {return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                endDrawer: const EndDrawerMenuTeacher(),
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
                          AppLocalizations.of(context)!.search_results_caps,
                          //"SEARCH RESULTS",
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: height * 0.0225,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.my_qn_bank,
                          //"MY QUESTION BANK",
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
                body: Padding(
                  padding: EdgeInsets.only(left: width * 0.025, right: width * 0.025),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
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
                          hintText: AppLocalizations.of(context)!.sub_hint_text,
                          //"Maths, 10th, 2022, CBSE, Science",
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
                                    setState(() {
                                      questions.clear();
                                    });
                                    getData(teacherQuestionBankSearchController.text);
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
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tap_to_review,
                            //"Tap to Review/Edit/Delete",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: const Color.fromRGBO(153, 153, 153, 1),
                              fontSize: height * 0.015,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.my_qns_small,
                                //"My Questions",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              const Icon(
                                Icons.circle_rounded,
                                color: Color.fromRGBO(82, 165, 160, 1),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      SizedBox(
                          height: height * 0.6,
                          width: width * 0.9,
                          child: questionsPresent?
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                for (Question i in questions)
                                  QuestionPreview(
                                    height: height,
                                    width: width,
                                    question: i,
                                  ),
                              ],
                            ),
                          )
                              :
                          Text(
                            'NO QUESTIONS FOUND',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.0175,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),
                          )
                      ),
                      // SizedBox(
                      //   height: height * 0.02,
                      // ),

                      Center(
                        child: SizedBox(
                          width: width * 0.8,
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
                            onPressed: () {
                              questionsPresent?
                              Navigator.pushNamed(context, '/teacherClonedAssessmentPreview',arguments: 'clone'):{};
                              // Navigator.push(
                              //   context,
                              //   PageTransition(
                              //     type: PageTransitionType.rightToLeft,
                              //     child: TeacherClonedAssessmentPreview(
                              //         ),
                              //   ),
                              // );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.add_small,
                              //'Add',
                              style: TextStyle(
                                  fontSize: height * 0.025,
                                  fontFamily: "Inter",
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                ),
              ));}
        },
    );

  }
}

class QuestionPreview extends StatefulWidget {
  const QuestionPreview({
    Key? key,
    required this.height,
    required this.width,
    required this.question,
  }) : super(key: key);

  final double height;
  final double width;
  final Question question;

  @override
  State<QuestionPreview> createState() => _QuestionPreviewState();
}

class _QuestionPreviewState extends State<QuestionPreview> {
  bool? valueFirst = false;

  @override
  Widget build(BuildContext context) {
    String answer = '';
    for (int i = 0; i < widget.question.choices!.length; i++) {
      answer = '$answer ${widget.question.choices![i]}';
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          checkColor: const Color.fromRGBO(255, 255, 255, 1),
          activeColor: const Color.fromRGBO(82, 165, 160, 1),
          value: valueFirst,
          onChanged: (bool? value) {
            if (value!) {
              if(widget.question.questionType=="MCQ"){
                widget.question.questionMark=1;
                Provider.of<CreateAssessmentProvider>(context, listen: false)
                    .addQuestion(widget.question.questionId, 1);
              }else{
                widget.question.questionMark=0;
                Provider.of<CreateAssessmentProvider>(context, listen: false)
                    .addQuestion(widget.question.questionId, 0);
              }
              //widget.question.questionMark=0;
              Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
                  .addQuestion(widget.question);
            } else {
              Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
                  .removeQuestion(widget.question.questionId);
              Provider.of<CreateAssessmentProvider>(context, listen: false)
                  .removeQuestion(widget.question.questionId);
            }
            setState(() {
              valueFirst = value;
            });
          },
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: widget.width * 0.75,
                color: const Color.fromRGBO(82, 165, 160, 0.1),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: widget.width * 0.02, left: widget.width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.question.subject!,
                            style: TextStyle(
                                fontSize: widget.height * 0.017,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "  |  ${widget.question.topic} - ${widget.question.subTopic}",
                            style: TextStyle(
                                fontSize: widget.height * 0.015,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Text(
                        widget.question.datumClass!,
                        style: TextStyle(
                            fontSize: widget.height * 0.015,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.question.questionType!,
                  style: TextStyle(
                      fontSize: widget.height * 0.0175,
                      fontFamily: "Inter",
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      widget.question.question!,
                      style: TextStyle(
                          fontSize: widget.height * 0.0175,
                          fontFamily: "Inter",
                          color: const Color.fromRGBO(51, 51, 51, 1),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: widget.height * 0.01,
              ),
              const Divider()
            ],
          ),
        ),
      ],
    );
  }
}
