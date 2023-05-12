import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher_result_landing_page.dart';

import '../EntityModel/user_data_model.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Components/end_drawer_menu_teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherSelectionPage extends StatefulWidget {
  const TeacherSelectionPage(
      {Key? key,
      required this.userData,
     })
      : super(key: key);

  final UserDataModel userData;

  @override
  TeacherSelectionPageState createState() => TeacherSelectionPageState();
}

class TeacherSelectionPageState extends State<TeacherSelectionPage> {
  UserDataModel userDataModel = UserDataModel(code: 0, message: '');
  int userId=0;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    setState(() {
      userId=loginData.getInt('userId')!;
    });
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
            endDrawer: const EndDrawerMenuTeacher(),
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
                        Provider.of<QuestionPrepareProviderFinal>(context,
                                listen: false)
                            .reSetQuestionList();
                        Navigator.pushNamed(context, '/teacherQuestionBank');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.qn_button,
                        //AppLocalizations.of(context)!.qn_button,
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
                        Navigator.pushNamed(context, '/teacherAssessmentLanding');

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
                                userId: userId,
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
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                  ]),
            )));
  }
}
