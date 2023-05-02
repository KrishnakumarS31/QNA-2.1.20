import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/Teacher/response_entity.dart';
import 'package:qna_test/Pages/teacher_prepare_qnBank.dart';
import 'package:qna_test/pages/teacher_my_question_bank.dart';
import 'package:qna_test/pages/teacher_question_delete_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/question_entity.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Services/qna_service.dart';
import '../EntityModel/create_question_model.dart' as create_question_model;
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Components/today_date.dart';

class TeacherAddMyQuestionBank extends StatefulWidget {
  TeacherAddMyQuestionBank({
    Key? key,
    required this.assessment,

  }) : super(key: key);

  bool assessment = false;



  @override
  TeacherAddMyQuestionBankState createState() =>
      TeacherAddMyQuestionBankState();
}

class TeacherAddMyQuestionBankState extends State<TeacherAddMyQuestionBank> {
  List<Question> finalQuesList = [];

  showAlertDialog(BuildContext context, double height) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        AppLocalizations.of(context)!.no,
        //'No',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        AppLocalizations.of(context)!.yes,
        //'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () async {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color.fromRGBO(48, 145, 139, 1),
              ));
            });

        create_question_model.CreateQuestionModel createQuestionModel =
            create_question_model.CreateQuestionModel();
        createQuestionModel.questions = finalQuesList;
        SharedPreferences loginData = await SharedPreferences.getInstance();
        createQuestionModel.authorId = loginData.getInt('userId');
        ResponseEntity statusCode =
            await QnaService.createQuestionTeacherService(createQuestionModel);
        Navigator.of(context).pop();
        if (statusCode.code == 200) {
          Navigator.pushNamed(
              context,
              '/teacherMyQuestionBank',
              arguments: widget.assessment
          );

          // Navigator.push(
          //   context,
          //   PageTransition(
          //     type: PageTransitionType.rightToLeft,
          //     child: TeacherMyQuestionBank(
          //         assessment: widget.assessment,),
          //   ),
          // );
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.confirm,
        //'Confirm',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(0, 106, 100, 1),
            fontWeight: FontWeight.w700),
      ),
      content: Text(
        AppLocalizations.of(context)!.sure_to_submit_qn_bank,
        //'Are you sure you want to submit to My Question Bank?',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontWeight: FontWeight.w400),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    finalQuesList.addAll(
        Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
            .getAllQuestion);

  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            endDrawer: EndDrawerMenuTeacher(),
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
            appBar: AppBar(
              // leading: IconButton(
              //   icon: const Icon(
              //     Icons.chevron_left,
              //     size: 40.0,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              automaticallyImplyLeading: false,
              toolbarHeight: height * 0.100,
              centerTitle: true,
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.add,
                      //'ADD',
                      style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.add_my_qn,
                      //"MY QUESTION",
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
            body: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.0375,
                        left: width * 0.055,
                        right: width * 0.055),
                    child: Container(
                      height: height * 0.1412,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(82, 165, 160, 0.08),
                          border: Border.all(
                            color: const Color.fromRGBO(28, 78, 80, 0.08),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.02, right: width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  finalQuesList.isEmpty?'':finalQuesList[0].subject!,
                                  style: TextStyle(
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      color:
                                          const Color.fromRGBO(28, 78, 80, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  todayDate(),
                                  style: TextStyle(
                                      fontSize: height * 0.015,
                                      fontFamily: "Inter",
                                      color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.02, right: width * 0.02),
                            child: const Divider(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.02),
                            child: Row(
                              children: [
                                Text(
                                  finalQuesList.isEmpty?'':finalQuesList[0].topic!,
                                  style: TextStyle(
                                      fontSize: height * 0.0175,
                                      fontFamily: "Inter",
                                      color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                Text(
                                  '|',
                                  style: TextStyle(
                                      fontSize: height * 0.0175,
                                      fontFamily: "Inter",
                                      color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                Text(
                                  finalQuesList.isEmpty?'':finalQuesList[0].subTopic!,
                                  style: TextStyle(
                                      fontSize: height * 0.0175,
                                      fontFamily: "Inter",
                                      color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.02),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                finalQuesList.isEmpty?'':finalQuesList[0].datumClass!,
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: width * 0.055, right: width * 0.055),
                        height: height * 0.55,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ListView.builder(
                              //   itemCount: quesList.length,
                              //     itemBuilder: (context, index){
                              //     return
                              //     }),
                              for (int i = 0; i < finalQuesList.length; i++)
                                QuestionPreview(
                                    height: height,
                                    width: width,
                                    question: finalQuesList[i],
                                    quesNum: i,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: height * 0.47,
                          left: width * 0.8,
                          child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context,
                                    '/teacherPrepareQnBank',
                                    arguments: [false,'']
                                );

                                // Navigator.push(
                                //   context,
                                //   PageTransition(
                                //     type: PageTransitionType.rightToLeft,
                                //     child: TeacherPrepareQnBank(
                                //         assessment: false,
                                //         ),
                                //   ),
                                // );
                              },
                              child: FloatingActionButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context,
                                      '/teacherPrepareQnBank',
                                      arguments: [
                                        false,
                                        ''
                                      ]);

                                  // Navigator.push(
                                  //   context,
                                  //   PageTransition(
                                  //     type: PageTransitionType.rightToLeft,
                                  //     child: TeacherPrepareQnBank(
                                  //         assessment: false,
                                  //         ),
                                  //   ),
                                  // );
                                },
                                backgroundColor:
                                    const Color.fromRGBO(28, 78, 80, 1),
                                child: const Icon(Icons.add),
                              )
                          ))
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                      minimumSize: const Size(280, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(39),
                      ),
                    ),
                    //shape: StadiumBorder(),
                    onPressed: () {
                      showAlertDialog(context, height);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.submit,
                      //'Submit',
                      style: TextStyle(
                          fontSize: height * 0.025,
                          fontFamily: "Inter",
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )));
  }
}

class QuestionPreview extends StatelessWidget {
  const QuestionPreview(
      {Key? key,
      required this.height,
      required this.width,
      required this.question,
      required this.quesNum,
      })
      : super(key: key);

  final double height;
  final int quesNum;
  final double width;
  final dynamic question;

  @override
  Widget build(BuildContext context) {
    List<String> temp = [];
    for (int i = 0; i < question.choices!.length; i++) {
      if (question.choices![i].rightChoice!) {
        temp.add(question.choices![i].choiceText!);
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: const Color.fromRGBO(82, 165, 160, 0.08),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${question.questionType}',
                    style: TextStyle(
                        fontSize: height * 0.02,
                        fontFamily: "Inter",
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontWeight: FontWeight.w600),
                  ),
                  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          '/teacherQuesDelete',
                          arguments: [
                            quesNum,
                            question,
                            false
                          ]);

                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.rightToLeft,
                      //     child: TeacherQuesDelete(
                      //         quesNum: quesNum,
                      //         finalQuestion: question, assessment: false,),
                      //   ),
                      // );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.edit_button,
                          //'Edit',
                          style: TextStyle(
                              fontSize: height * 0.0185,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        const Icon(
                          Icons.mode_edit_outline_outlined,
                          color: Color.fromRGBO(28, 78, 80, 1),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${question.question}',
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  temp.toString().substring(1, temp.toString().length - 1),
                  style: TextStyle(
                      fontSize: height * 0.02,
                      fontFamily: "Inter",
                      color: const Color.fromRGBO(82, 165, 160, 1),
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
