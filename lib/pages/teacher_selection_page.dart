import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/pages/teacher_assessment_landing.dart';
import 'package:qna_test/pages/teacher_result_landing_page.dart';
import '../EntityModel/user_data_model.dart';
import '../Services/qna_service.dart';
import '../Components/end_drawer_menu_teacher.dart';
import 'teacher_questionBank_page.dart';

class TeacherSelectionPage extends StatefulWidget {
  const TeacherSelectionPage(
      {Key? key,
      required this.name,
      required this.setLocale,
      required this.userId})
      : super(key: key);

  final String name;
  final void Function(Locale locale) setLocale;
  final int? userId;

  @override
  TeacherSelectionPageState createState() => TeacherSelectionPageState();
}

class TeacherSelectionPageState extends State<TeacherSelectionPage> {
  UserDataModel userDataModel = UserDataModel(code: 0, message: '');
  String name = '';
  String email = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    userDataModel = await QnaService.getUserDataService(widget.userId);
    setState(() {
      name = userDataModel.data!.firstName;
      email = userDataModel.data!.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                          height: height * 0.16,
                          width: width * 0.30,
                          child: Image.asset(
                              "assets/images/question_mark_logo.png"),
                        ),
                      ),
                      Text(
                        'QNA',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.055,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        'TEST',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w800),
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
                  name,
                  style: TextStyle(
                    fontSize: height * 0.04,
                    color: const Color.fromRGBO(28, 78, 80, 1),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: height * 0.037),
                Text(
                  'PREPARE',
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
                        child: TeacherQuestionBank(setLocale: widget.setLocale),
                      ),
                    );
                  },
                  child: Text(
                    'Questions',
                    style: TextStyle(
                        fontSize: height * 0.032,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: height * 0.0375),
                Text(
                  'VIEW/EDIT/PREPARE',
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
                        child: TeacherAssessmentLanding(
                          setLocale: widget.setLocale,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Assessments',
                    style: TextStyle(
                        fontSize: height * 0.032,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: height * 0.0375),
                Text(
                  'VIEW',
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
                        child: const TeacherResultLanding(),
                      ),
                    );
                  },
                  child: Text(
                    'Results',
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
        ));
  }
}
