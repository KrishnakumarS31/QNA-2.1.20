import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher_assessment_landing.dart';
import 'package:qna_test/pages/teacher_result_landing_page.dart';

import '../EntityModel/user_data_model.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Components/end_drawer_menu_teacher.dart';
import 'teacher_questionBank_page.dart';

class TeacherSelectionPage extends StatefulWidget {
  const TeacherSelectionPage(
      {Key? key,
      required this.userData,
      required this.setLocale,
      required this.userId})
      : super(key: key);

  final UserDataModel userData;
  final void Function(Locale locale) setLocale;
  final int? userId;

  @override
  TeacherSelectionPageState createState() => TeacherSelectionPageState();
}

class TeacherSelectionPageState extends State<TeacherSelectionPage> {
  UserDataModel userDataModel = UserDataModel(code: 0, message: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
            ),
            endDrawer: EndDrawerMenuTeacher(setLocale: widget.setLocale),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height * 0.3625,
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
                            bottom: Radius.elliptical(width, height * 0.40)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.07),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              height: height * 0.28,
                              width: width * 0.33,
                              child: Image.asset(
                                  "assets/images/qna_logo.png"),
                            ),
                          ),
                          // Text(
                          //   'QNA',
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: height * 0.055,
                          //       fontFamily: "Inter",
                          //       fontWeight: FontWeight.w800),
                          // ),
                          // Text(
                          //   'TEST',
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: height * 0.025,
                          //       fontFamily: "Inter",
                          //       fontWeight: FontWeight.w800),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Text(
                      AppLocalizations.of(context)!.welcome,
                      style: TextStyle(
                        fontSize: height * 0.037,
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Text(
                      widget.userData.data!.firstName.toString(),
                      style: TextStyle(
                        fontSize: height * 0.04,
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: height * 0.037),
                    Text(
                      AppLocalizations.of(context)!.prepare_caps,
                      // 'PREPARE',
                      style: TextStyle(
                        fontSize: height * 0.018,
                        color: const Color.fromRGBO(209, 209, 209, 1),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                      onPressed: () async {
                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return const Center(
                        //           child: CircularProgressIndicator(
                        //             color: Color.fromRGBO(48, 145, 139, 1),
                        //           ));
                        //     });
                        // ResponseEntity responseEntity=await QnaService.getQuestionBankService(3,1);
                        // List<Question> questions=[];
                        // if(responseEntity.data==null){
                        //
                        // }
                        // else{
                        //   questions=List<Question>.from(responseEntity.data.map((x) => Question.fromJson(x)));
                        // }
                        // Navigator.of(context).pop();
                        Provider.of<QuestionPrepareProviderFinal>(context,
                                listen: false)
                            .reSetQuestionList();
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: TeacherQuestionBank(
                              setLocale: widget.setLocale,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.qn_button,
                        //'Questions',
                        style: TextStyle(
                            fontSize: height * 0.032,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: height * 0.0375),
                    Text(
                      AppLocalizations.of(context)!.view_edit_del,
                      //'VIEW/EDIT/PREPARE',
                      style: TextStyle(
                        fontSize: height * 0.018,
                        color: const Color.fromRGBO(209, 209, 209, 1),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => TeacherAssessmentLanding(
                                    setLocale: widget.setLocale)),
                                (route) => route.isFirst);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.assessment_button,
                        //'Assessments',
                        style: TextStyle(
                            fontSize: height * 0.032,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: height * 0.0375),
                    Text(
                      AppLocalizations.of(context)!.view_caps,
                      //'VIEW',
                      style: TextStyle(
                        fontSize: height * 0.018,
                        color: const Color.fromRGBO(209, 209, 209, 1),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: TeacherResultLanding(
                                userId: widget.userId,
                                advisorName: widget.userData.data!.firstName),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.results_button,
                        //'Results',
                        style: TextStyle(
                            fontSize: height * 0.032,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                  ]),
            )));
  }
}
