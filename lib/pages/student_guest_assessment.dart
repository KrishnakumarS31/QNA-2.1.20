import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/pages/student_assessment_questions.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Components/end_drawer_menu_pre_login.dart';
import '../Entity/question_paper_model.dart';
import '../Services/qna_service.dart';

class StudGuestAssessment extends StatefulWidget {
  const StudGuestAssessment(
      {Key? key, required this.name,})
      : super(key: key);

  final String name;

  @override
  StudGuestAssessmentState createState() => StudGuestAssessmentState();
}

class StudGuestAssessmentState extends State<StudGuestAssessment> {
  final formKey = GlobalKey<FormState>();
  TextEditingController assessmentIdController = TextEditingController();
  late QuestionPaperModel values;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 700) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    backgroundColor: const Color.fromRGBO(0, 106, 100, 1),
                  ),
                  endDrawer: EndDrawerMenuPreLogin(),
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.white,
                  body: Column(children: [
                    Container(
                      height: height * 0.26,
                      width: width,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(0, 106, 100, 1),
                            Color.fromRGBO(82, 165, 160, 1)
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(width, height * 0.30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.03,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              height: height * 0.22,
                              width: width * 0.22,
                              child: Image.asset(
                                  "assets/images/question_mark_logo.png"),
                            ),
                          ),
                          Container(
                            width: width * 0.03,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Form(
                      key: formKey,
                      child: SizedBox(
                        height: height * 0.45,
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.welcome,
                              style: TextStyle(
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontSize: height * 0.036,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            Text(
                              widget.name,
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.033,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.08),
                            SizedBox(
                              width: width * 0.2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .assessment_id,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.017),
                                      ),
                                      TextSpan(
                                          text: "\t*",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.017)),
                                    ])),
                                  ),
                                  SizedBox(
                                    height: height * 0.0001,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        controller: assessmentIdController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          helperStyle: const TextStyle(
                                              color: Color.fromRGBO(
                                                  102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .enter_paper_id,
                                          prefixIcon: Icon(
                                            Icons.account_box_outlined,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            size: height * 0.04,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !RegExp(r'^[a-zA-Z\d]+$')
                                                  .hasMatch(value)) {
                                            return AppLocalizations.of(context)!
                                                .assessment_id_not_found;
                                          } else {
                                            return null;
                                          }
                                        },
                                      )),
                                  Container(
                                    height: height * 0.04,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.016,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: Size(width * 0.27, height * 0.06),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              onPressed: () async {
                                if (assessmentIdController.text.length >= 8) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                          color:
                                              Color.fromRGBO(48, 145, 139, 1),
                                        ));
                                      });
                                  values = await QnaService.getQuestionGuest(
                                      assessmentIdController.text, widget.name);
                                  Navigator.of(context).pop();
                                  if (values.code == 200) {
                                    Navigator.pushNamed(
                                        context,
                                        '/studQuestion',
                                        arguments: [
                                          assessmentIdController.text,
                                          values,
                                          widget.name,
                                        ]);
                                    // Navigator.push(
                                    //   context,
                                    //   PageTransition(
                                    //     type: PageTransitionType.rightToLeft,
                                    //     child: StudQuestion(
                                    //       userName: widget.name,
                                    //       assessmentId: assessmentIdController.text,
                                    //       ques: values,
                                    //     ),
                                    //   ),
                                    // );
                                    assessmentIdController.clear();
                                  } else if (values.code == 400) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: CustomDialog(
                                          title: AppLocalizations.of(context)!
                                              .invalid_assessment_iD,
                                          content: '',
                                          button: AppLocalizations.of(context)!
                                              .retry,
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: CustomDialog(
                                        title: AppLocalizations.of(context)!
                                            .invalid_assessment_iD,
                                        content: '',
                                        button:
                                            AppLocalizations.of(context)!.retry,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.start,
                                style: TextStyle(
                                    fontSize: height * 0.024,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Color.fromRGBO(141, 167, 167, 1),
                          ),
                          onPressed: () {},
                        ),
                        Text(AppLocalizations.of(context)!.search_library,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyLarge
                                ?.merge(const TextStyle(
                                    color: Color.fromRGBO(48, 145, 139, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16))),
                      ],
                    ),
                  ])));
        } else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  endDrawer: EndDrawerMenuPreLogin(),
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  body: Column(children: [
                    Container(
                      height: height * 0.3,
                      width: width,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(0, 106, 100, 1),
                            Color.fromRGBO(82, 165, 160, 1)
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(width, height * 0.30)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: height * 0.0),
                          Center(
                            child: SizedBox(
                              height: height * 0.22,
                              width: width * 0.22,
                              child: Image.asset(
                                  "assets/images/question_mark_logo.png"),
                            ),
                          ),
                          Container(
                            width: width * 0.03,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Form(
                      key: formKey,
                      child: SizedBox(
                        height: height * 0.45,
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.welcome,
                              style: TextStyle(
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontSize: height * 0.036,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            Text(
                              widget.name,
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.033,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.08),
                            SizedBox(
                              width: width * 0.8,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .assessment_id,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.017),
                                      ),
                                      TextSpan(
                                          text: "\t*",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.017)),
                                    ])),
                                  ),
                                  SizedBox(
                                    height: height * 0.0001,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        controller: assessmentIdController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          helperStyle: const TextStyle(
                                              color: Color.fromRGBO(
                                                  102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .enter_paper_id,
                                          prefixIcon: Icon(
                                            Icons.account_box_outlined,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            size: height * 0.04,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          formKey.currentState!.validate();
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter Assessment ID';
                                          } else {
                                            return null;
                                          }
                                        },
                                      )),
                                  Container(
                                    height: height * 0.04,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.016,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: Size(width * 0.77, height * 0.06),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (assessmentIdController.text.length >= 8) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                            color:
                                                Color.fromRGBO(48, 145, 139, 1),
                                          ));
                                        });
                                    values = await QnaService.getQuestionGuest(
                                        assessmentIdController.text,
                                        widget.name);
                                    Navigator.of(context).pop();
                                    if (values.code == 200) {
                                      Navigator.pushNamed(
                                          context,
                                          '/studQuestion',
                                          arguments: [
                                            assessmentIdController.text,
                                            values,
                                            widget.name,
                                          ]);
                                      // Navigator.push(
                                      //   context,
                                      //   PageTransition(
                                      //     type: PageTransitionType.rightToLeft,
                                      //     child: StudQuestion(
                                      //       userName: widget.name,
                                      //
                                      //       assessmentId:
                                      //           assessmentIdController.text,
                                      //       ques: values,
                                      //     ),
                                      //   ),
                                      // );
                                      assessmentIdController.clear();
                                    } else {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title: AppLocalizations.of(context)!
                                                .invalid_assessment_iD,
                                            content: '',
                                            button:
                                                AppLocalizations.of(context)!
                                                    .retry,
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: CustomDialog(
                                          title: AppLocalizations.of(context)!
                                              .invalid_assessment_iD,
                                          content: '',
                                          button: AppLocalizations.of(context)!
                                              .retry,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.start,
                                style: TextStyle(
                                    fontSize: height * 0.024,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                  ])));
        }
      },
    );
  }
}
