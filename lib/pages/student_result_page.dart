import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Entity/question_paper_model.dart';
import '../pages/cookie_policy.dart';
import '../pages/privacy_policy_hamburger.dart';
import '../pages/terms_of_services.dart';
import '../pages/about_us.dart';
import '../pages/help_page.dart';
import 'package:qna_test/pages/settings_languages.dart';
import 'package:shared_preferences/shared_preferences.dart';
class StudentResultPage extends StatefulWidget {
  const StudentResultPage({Key? key,
    required this.totalMarks,
    required this.date,
    required this.time,
    required this.questions,
    required this.assessmentCode,
    required this.userName,
    required this.message,
    required this.endTime,
    required this.givenMark,

    })
      : super(key: key);
  final int totalMarks;
  final QuestionPaperModel questions;
  final String date;
  final String time;
  final String userName;
  final String assessmentCode;
  final String endTime;
  final String message;
  final int givenMark;


  @override
  StudentResultPageState createState() => StudentResultPageState();
}

class StudentResultPageState extends State<StudentResultPage> {
  TextEditingController assessmentID = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  late QuestionPaperModel values;

  @override
  void initState() {
    super.initState();
    values = widget.questions;
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
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 700) {
          return WillPopScope(
              onWillPop: () async {
                showDialog(
                  context: context,
                  builder: (context) =>
                      AlertDialog(
                        insetPadding: EdgeInsets.only(
                            left: localWidth * 0.13, right: localWidth * 0.13),
                        title: Row(children: [
                          SizedBox(width: localHeight * 0.030),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(82, 165, 160, 1),
                            ),
                            height: localHeight * 0.1,
                            width: localWidth * 0.1,
                            child: const Icon(
                              Icons.info_outline_rounded,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          SizedBox(width: localHeight * 0.015),
                          Text(
                            AppLocalizations.of(context)!.confirm,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: localHeight * 0.024,
                                color: const Color.fromRGBO(0, 106, 100, 1),
                                fontWeight: FontWeight.w700),
                          ),
                        ]),
                        content: const Text("Are you sure you want to exit ?"),
                        actions: <Widget>[
                          SizedBox(width: localWidth * 0.020),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color.fromRGBO(255, 255, 255, 1),
                              minimumSize: const Size(90, 30),
                              side: const BorderSide(
                                width: 1.5,
                                color: Color.fromRGBO(82, 165, 160, 1),
                              ),
                            ),
                            child: Text(AppLocalizations.of(context)!.no,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: localHeight * 0.018,
                                    color: const Color.fromRGBO(
                                        82, 165, 160, 1),
                                    fontWeight: FontWeight.w500)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(width: localWidth * 0.005),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: const Size(90, 30),
                              ),
                              child: Text(AppLocalizations.of(context)!.yes,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: localHeight * 0.018,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                            color: Color.fromRGBO(
                                                48, 145, 139, 1),
                                          ));
                                    });
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, '/studentSelectionPage');
                                // Navigator.push(
                                //   context,
                                //   PageTransition(
                                //     type: PageTransitionType.rightToLeft,
                                //     child: StudentSelectionPage(
                                //         ),
                                //   ),
                                // );
                              }),
                          SizedBox(width: localHeight * 0.030),
                        ],
                      ),
                );
                return false;
              },
              child: WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                    endDrawer: Drawer(
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromRGBO(0, 106, 100, 1),
                                    Color.fromRGBO(82, 165, 160, 1),
                                  ],
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //SizedBox(height: height * 0.050),
                                SizedBox(
                                  height: localHeight / 6,
                                  child: Row(
                                      children: [
                                        SizedBox(width: localWidth * 0.015),
                                        CircleAvatar(
                                          backgroundColor:
                                          const Color.fromRGBO(0, 106, 100, 0),
                                          radius: MediaQuery.of(context).size.width * 0.05,
                                          child: Image.asset(
                                            "assets/images/ProfilePic_Avatar.png",
                                          ),
                                        ),
                                        SizedBox(width: localWidth * 0.03),
                                        Text(
                                          widget.userName,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge
                                              ?.merge(const TextStyle(
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -0.02,
                                              fontSize: 16)),
                                        ),
                                      ]),
                                ),
                                //const SizedBox(height: 0.022),
                                Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(left: localWidth * 0.09),
                                        child: Text(
                                          AppLocalizations.of(context)!.student,
                                          style: const TextStyle(
                                              color: Color.fromRGBO(221, 221, 221, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.02,
                                              fontSize: 12),
                                        )),
                                  ],
                                ),
                                //    )
                              ],
                            ),
                          ),
                          Flexible(
                            child: ListView(
                              children: [
                                ListTile(
                                    leading: const Icon(Icons.translate,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.language,
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const SettingsLanguages(),
                                        ),
                                      );
                                    }),
                                const Divider(
                                  thickness: 2,
                                ),
                                ListTile(
                                    leading: const Icon(Icons.verified_user_outlined,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.privacy_and_terms,
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const PrivacyPolicyHamburger(
                                          ),
                                        ),
                                      );
                                    }),
                                ListTile(
                                    leading: const Icon(Icons.library_books_sharp,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.terms_of_services,
                                      //'Terms of Services',
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const TermsOfServiceHamburger(
                                          ),
                                        ),
                                      );
                                    }),
                                ListTile(
                                    leading: const Icon(Icons.note_alt_outlined,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.cookie_policy,
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const CookiePolicy(),
                                        ),
                                      );
                                    }),
                                const Divider(
                                  thickness: 2,
                                ),
                                ListTile(
                                    leading: const Icon(Icons.perm_contact_calendar_outlined,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.about_us,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyLarge
                                          ?.merge(TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16)),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const AboutUs(),
                                        ),
                                      );
                                    }),
                                ListTile(
                                    leading: const Icon(Icons.help_outline,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.help,
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const HelpPageHamburger(),
                                        ),
                                      );
                                    }),
                                const Divider(
                                  thickness: 2,
                                ),
                                ListTile(
                                  leading: const Icon(Icons.power_settings_new,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!.logout,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(226, 68, 0, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.02,
                                        fontSize: 16),
                                  ),
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        insetPadding: EdgeInsets.only(
                                            left: localWidth * 0.13, right: localWidth * 0.13),
                                        title: Row(children: [
                                          SizedBox(width: localHeight * 0.030),
                                          Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(82, 165, 160, 1),
                                            ),
                                            height: localHeight * 0.1,
                                            width: localWidth * 0.1,
                                            child: const Icon(
                                              Icons.info_outline_rounded,
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                            ),
                                          ),
                                          SizedBox(width: localHeight * 0.015),
                                          Text(
                                            AppLocalizations.of(context)!.confirm,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: localHeight * 0.024,
                                                color: const Color.fromRGBO(0, 106, 100, 1),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ]),
                                        content:
                                        const Text("Are you sure you want to logout ??"),
                                        actions: <Widget>[
                                          SizedBox(width: localWidth * 0.020),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              const Color.fromRGBO(255, 255, 255, 1),
                                              minimumSize: const Size(90, 30),
                                              side: const BorderSide(
                                                width: 1.5,
                                                color: Color.fromRGBO(82, 165, 160, 1),
                                              ),
                                            ),
                                            child: Text(AppLocalizations.of(context)!.no,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: localHeight * 0.018,
                                                    color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                    fontWeight: FontWeight.w500)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          SizedBox(width: localWidth * 0.005),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                                minimumSize: const Size(90, 30),
                                              ),
                                              child: Text(AppLocalizations.of(context)!.yes,
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: localHeight * 0.018,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500)),
                                              onPressed: () async {
                                                SharedPreferences preferences =
                                                await SharedPreferences.getInstance();
                                                await preferences.clear();
                                                Navigator.pushNamed(context, '/');
                                              }),
                                          SizedBox(width: localHeight * 0.030),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${AppLocalizations.of(context)!.version}: 1.0.0",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(180, 180, 180, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.02,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(height: localHeight * 0.03),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(40.0),
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        elevation: 0,
                        //backgroundColor: Colors.transparent,
                        flexibleSpace: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(0, 106, 100, 1),
                                Color.fromRGBO(82, 165, 160, 1),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    body: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Container(
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
                                          localWidth, localHeight * 0.35)),
                                ),
                                child: Column(
                                  children: [
                                   // SizedBox(height: localHeight * 0.07),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .result_card,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                localHeight * 0.024),
                                          ),
                                          SizedBox(
                                              height: localHeight * 0.01),
                                          Text(widget.assessmentCode,
                                              style: TextStyle(
                                                  color:
                                                  const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontSize:
                                                  localHeight * 0.016)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: localHeight * 0.015),
                           Column(
                                  children: [
                                    SizedBox(height: localHeight * 0.2),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .for_incorrect,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.018)),
                                   // SizedBox(height: localHeight * 0.040),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          minimumSize: const Size(280, 48),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                39),
                                          ),
                                          side: const BorderSide(
                                            width: 1.5,
                                            color: Color.fromRGBO(
                                                82, 165, 160, 1),
                                          ),
                                        ),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .advisor,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: localHeight * 0.022,
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                fontWeight: FontWeight.w500)),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              '/studMemAdvisor',
                                              arguments: [values,widget.assessmentCode]
                                          );

                                          // Navigator.push(
                                          //   context,
                                          //   PageTransition(
                                          //     type: PageTransitionType
                                          //         .rightToLeft,
                                          //     child: StudMemAdvisor(
                                          //         questions: values,
                                          //         assessmentId:
                                          //         widget.assessmentCode),
                                          //   ),
                                          // );
                                        }),
                                    SizedBox(height: localHeight * 0.010),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        const Color.fromRGBO(82, 165, 160, 1),
                                        minimumSize: const Size(280, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              39),
                                        ),
                                      ),
                                      child: Text(
                                          AppLocalizations.of(context)!.exit,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: localHeight * 0.022,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AlertDialog(
                                                insetPadding: EdgeInsets.only(
                                                    left: localWidth * 0.13,
                                                    right: localWidth * 0.13),
                                                title: Row(children: [
                                                  SizedBox(width: localHeight *
                                                      0.030),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                    ),
                                                    height: localHeight * 0.1,
                                                    width: localWidth * 0.1,
                                                    child: const Icon(
                                                      Icons
                                                          .info_outline_rounded,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ),
                                                  ),
                                                  // SizedBox(width: localHeight *
                                                  //     0.005),
                                                  Text(
                                                    AppLocalizations.of(
                                                        context)!
                                                        .confirm,
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize: localHeight *
                                                            0.024,
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 106, 100, 1),
                                                        fontWeight: FontWeight
                                                            .w700),
                                                  ),
                                                ]),
                                                content: const Text(
                                                    "Are you sure you want to exit ?"),
                                                actions: <Widget>[
                                                  // SizedBox(width: localWidth *
                                                  //     0.015),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      minimumSize: const Size(
                                                          90, 30),
                                                      side: const BorderSide(
                                                        width: 1.5,
                                                        color: Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                      ),
                                                    ),
                                                    child: Text(
                                                        AppLocalizations.of(
                                                            context)!
                                                            .no,
                                                        style: TextStyle(
                                                            fontFamily: 'Inter',
                                                            fontSize:
                                                            localHeight * 0.018,
                                                            color: const Color
                                                                .fromRGBO(
                                                                82, 165, 160,
                                                                1),
                                                            fontWeight:
                                                            FontWeight.w500)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  SizedBox(width: localWidth *
                                                      0.01),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                        const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        minimumSize: const Size(
                                                            90, 30),
                                                      ),
                                                      child: Text(
                                                          AppLocalizations.of(
                                                              context)!
                                                              .yes,
                                                          style: TextStyle(
                                                              fontFamily: 'Inter',
                                                              fontSize:
                                                              localHeight *
                                                                  0.018,
                                                              color: Colors
                                                                  .white,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                      onPressed: () async {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return const Center(
                                                                  child:
                                                                  CircularProgressIndicator(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                        48, 145,
                                                                        139, 1),
                                                                  ));
                                                            });
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.pushNamed(context, '/studentSelectionPage');
                                                        // Navigator.push(
                                                        //   context,
                                                        //   PageTransition(
                                                        //     type: PageTransitionType
                                                        //         .rightToLeft,
                                                        //     child: StudentSelectionPage(
                                                        //         ),
                                                        //   ),
                                                        // );
                                                      }),
                                                  SizedBox(width: localHeight *
                                                      0.030),
                                                ],
                                              ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          // top: localHeight * 0.1,
                          // left: localHeight * 0.50,
                          child: SizedBox(
                            height: localHeight * 0.60,
                            width: localWidth * 0.6,
                            child: Card(
                              elevation: 12,
                              child: Column(children: [
                                const SizedBox(height: 20.0),
                                Text(widget.userName,
                                    style: TextStyle(
                                        color:
                                        const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: localHeight * 0.024)),
                                const SizedBox(height: 25.0),
                                Text('${widget.totalMarks}/${widget.givenMark} ',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 153, 0, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: localHeight * 0.096)),
                                const SizedBox(height: 15.0),
                                Text(AppLocalizations.of(context)!.mark_scored,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: localHeight * 0.018)),
                                const SizedBox(height: 30.0),
                                const Divider(
                                  thickness: 2,
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!
                                            .submission_date,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                161, 161, 161, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.020)),
                                    const SizedBox(width: 25.0),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .submission_time,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                161, 161, 161, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.020)),
                                    const SizedBox(width: 25.0),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .time_taken,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                161, 161, 161, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.020)),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(widget.date,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.022)),
                                    const SizedBox(width: 20.0),
                                    Text(widget.time,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.022)),
                                    const SizedBox(width: 25.0),
                                    Text(widget.endTime.substring(0, 7),
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.022)),
                                  ],
                                ),
                                const SizedBox(height: 30.0),
                                Expanded(
                                  child: Container(
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
                                              localWidth / 1.0,
                                              localHeight * 0.3)),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.message,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: localHeight * 0.024),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )));
        } else {
          return WillPopScope(
              onWillPop: () async {
                showDialog(
                  context: context,
                  builder: (context) =>
                      AlertDialog(
                        insetPadding: EdgeInsets.only(
                            left: localWidth * 0.13, right: localWidth * 0.13),
                        title: Row(children: [
                          SizedBox(width: localHeight * 0.030),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(82, 165, 160, 1),
                            ),
                            height: localHeight * 0.1,
                            width: localWidth * 0.1,
                            child: const Icon(
                              Icons.info_outline_rounded,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          SizedBox(width: localHeight * 0.015),
                          Text(
                            AppLocalizations.of(context)!.confirm,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: localHeight * 0.024,
                                color: const Color.fromRGBO(0, 106, 100, 1),
                                fontWeight: FontWeight.w700),
                          ),
                        ]),
                        content: const Text("Are you sure you want to exit ?"),
                        actions: <Widget>[
                          SizedBox(width: localWidth * 0.020),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color.fromRGBO(255, 255, 255, 1),
                              minimumSize: const Size(90, 30),
                              side: const BorderSide(
                                width: 1.5,
                                color: Color.fromRGBO(82, 165, 160, 1),
                              ),
                            ),
                            child: Text(AppLocalizations.of(context)!.no,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: localHeight * 0.018,
                                    color: const Color.fromRGBO(
                                        82, 165, 160, 1),
                                    fontWeight: FontWeight.w500)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(width: localWidth * 0.005),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: const Size(90, 30),
                              ),
                              child: Text(AppLocalizations.of(context)!.yes,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: localHeight * 0.018,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                            color: Color.fromRGBO(
                                                48, 145, 139, 1),
                                          ));
                                    });
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, '/studentSelectionPage');
                                // Navigator.push(
                                //   context,
                                //   PageTransition(
                                //     type: PageTransitionType.rightToLeft,
                                //     child: StudentSelectionPage(
                                //         ),
                                //   ),
                                // );
                              }),
                          SizedBox(width: localHeight * 0.030),
                        ],
                      ),
                );
                return false;
              },
              child: WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                    endDrawer: Drawer(
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromRGBO(0, 106, 100, 1),
                                    Color.fromRGBO(82, 165, 160, 1),
                                  ],
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: localHeight * 0.050),
                                Container(
                                  alignment: Alignment.center,
                                  height: localHeight / 6,
                                  child: Row(children: [
                                    CircleAvatar(
                                      backgroundColor:
                                      const Color.fromRGBO(0, 106, 100, 0),
                                      radius: MediaQuery.of(context).size.width * 0.15,
                                      child: Image.asset(
                                        "assets/images/ProfilePic_Avatar.png",
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      widget.userName,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyLarge
                                          ?.merge(const TextStyle(
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.02,
                                          fontSize: 16)),
                                    ),
                                  ]),
                                ),
                               // const SizedBox(height: 0.022),
                                Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(left: localWidth * 0.09),
                                        child: Text(
                                          AppLocalizations.of(context)!.student,
                                          style: const TextStyle(
                                              color: Color.fromRGBO(221, 221, 221, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.02,
                                              fontSize: 12),
                                        )),
                                  ],
                                ),
                                //    )
                              ],
                            ),
                          ),
                          Flexible(
                            child: ListView(
                              children: [
                                ListTile(
                                    leading: const Icon(Icons.translate,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.language,
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const SettingsLanguages(),
                                        ),
                                      );
                                    }),
                                const Divider(
                                  thickness: 2,
                                ),
                                ListTile(
                                    leading: const Icon(Icons.verified_user_outlined,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.privacy_and_terms,
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const PrivacyPolicyHamburger(
                                          ),
                                        ),
                                      );
                                    }),
                                ListTile(
                                    leading: const Icon(Icons.library_books_sharp,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.terms_of_services,
                                      //'Terms of Services',
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const TermsOfServiceHamburger(
                                          ),
                                        ),
                                      );
                                    }),
                                ListTile(
                                    leading: const Icon(Icons.note_alt_outlined,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.cookie_policy,
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const CookiePolicy(),
                                        ),
                                      );
                                    }),
                                const Divider(
                                  thickness: 2,
                                ),
                                ListTile(
                                    leading: const Icon(Icons.perm_contact_calendar_outlined,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.about_us,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyLarge
                                          ?.merge(TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16)),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const AboutUs(),
                                        ),
                                      );
                                    }),
                                ListTile(
                                    leading: const Icon(Icons.help_outline,
                                        color: Color.fromRGBO(141, 167, 167, 1)),
                                    title: Text(
                                      AppLocalizations.of(context)!.help,
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.02,
                                          fontSize: 16),
                                    ),
                                    trailing: const Icon(Icons.navigate_next,
                                        color: Color.fromRGBO(153, 153, 153, 1)),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const HelpPageHamburger(),
                                        ),
                                      );
                                    }),
                                const Divider(
                                  thickness: 2,
                                ),
                                ListTile(
                                  leading: const Icon(Icons.power_settings_new,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!.logout,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(226, 68, 0, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.02,
                                        fontSize: 16),
                                  ),
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        insetPadding: EdgeInsets.only(
                                            left: localWidth * 0.13, right: localWidth * 0.13),
                                        title: Row(children: [
                                          SizedBox(width: localHeight * 0.030),
                                          Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(82, 165, 160, 1),
                                            ),
                                            height: localHeight * 0.1,
                                            width: localWidth * 0.1,
                                            child: const Icon(
                                              Icons.info_outline_rounded,
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                            ),
                                          ),
                                          SizedBox(width: localHeight * 0.015),
                                          Text(
                                            AppLocalizations.of(context)!.confirm,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: localHeight * 0.024,
                                                color: const Color.fromRGBO(0, 106, 100, 1),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ]),
                                        content:
                                        const Text("Are you sure you want to logout ??"),
                                        actions: <Widget>[
                                          SizedBox(width: localWidth * 0.020),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              const Color.fromRGBO(255, 255, 255, 1),
                                              minimumSize: const Size(90, 30),
                                              side: const BorderSide(
                                                width: 1.5,
                                                color: Color.fromRGBO(82, 165, 160, 1),
                                              ),
                                            ),
                                            child: Text(AppLocalizations.of(context)!.no,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: localHeight * 0.018,
                                                    color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                    fontWeight: FontWeight.w500)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          SizedBox(width: localWidth * 0.005),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                                minimumSize: const Size(90, 30),
                                              ),
                                              child: Text(AppLocalizations.of(context)!.yes,
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: localHeight * 0.018,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500)),
                                              onPressed: () async {
                                                SharedPreferences preferences =
                                                await SharedPreferences.getInstance();
                                                await preferences.clear();
                                                Navigator.pushNamed(context, '/');
                                              }),
                                          SizedBox(width: localHeight * 0.030),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${AppLocalizations.of(context)!.version}: 1.0.0",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(180, 180, 180, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.02,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(height: localHeight * 0.03),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(40.0),
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        elevation: 0,
                        //backgroundColor: Colors.transparent,
                        flexibleSpace: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(0, 106, 100, 1),
                                Color.fromRGBO(82, 165, 160, 1),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    body: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Container(
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
                                          localWidth, localHeight * 0.35)),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: localHeight * 0.02),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          padding: const EdgeInsets.all(0.0),
                                          height: localHeight * 0.20,
                                          width: localWidth * 0.30,
                                          child: Column(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .result_card,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                    localHeight * 0.024),
                                              ),
                                              SizedBox(
                                                  height: localHeight * 0.01),
                                              Text(widget.assessmentCode,
                                                  style: TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize:
                                                      localHeight * 0.016)),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: localHeight * 0.01),
                            Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(height: localHeight * 0.27),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .for_incorrect,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.018)),
                                    SizedBox(height: localHeight * 0.010),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          minimumSize: const Size(280, 48),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                39),
                                          ),
                                          side: const BorderSide(
                                            width: 1.5,
                                            color: Color.fromRGBO(
                                                82, 165, 160, 1),
                                          ),
                                        ),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .advisor,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: localHeight * 0.022,
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                fontWeight: FontWeight.w500)),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              '/studMemAdvisor',
                                              arguments: [values,widget.assessmentCode]
                                          );
                                          // Navigator.push(
                                          //   context,
                                          //   PageTransition(
                                          //     type: PageTransitionType
                                          //         .rightToLeft,
                                          //     child: StudMemAdvisor(
                                          //         questions: values,
                                          //         assessmentId:
                                          //         widget.assessmentCode),
                                          //   ),
                                          // );
                                        }),
                                    SizedBox(height: localHeight * 0.010),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        const Color.fromRGBO(82, 165, 160, 1),
                                        minimumSize: const Size(280, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              39),
                                        ),
                                      ),
                                      child: Text(
                                          AppLocalizations.of(context)!.exit,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: localHeight * 0.022,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AlertDialog(
                                                insetPadding: EdgeInsets.only(
                                                    left: localWidth * 0.13,
                                                    right: localWidth * 0.13),
                                                title: Row(children: [
                                                  SizedBox(width: localHeight *
                                                      0.030),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                    ),
                                                    height: localHeight * 0.1,
                                                    width: localWidth * 0.1,
                                                    child: const Icon(
                                                      Icons
                                                          .info_outline_rounded,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ),
                                                  ),
                                                  SizedBox(width: localHeight *
                                                      0.015),
                                                  Text(
                                                    AppLocalizations.of(
                                                        context)!
                                                        .confirm,
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize: localHeight *
                                                            0.024,
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 106, 100, 1),
                                                        fontWeight: FontWeight
                                                            .w700),
                                                  ),
                                                ]),
                                                content: const Text(
                                                    "Are you sure you want to exit ?"),
                                                actions: <Widget>[
                                                  SizedBox(width: localWidth *
                                                      0.020),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      minimumSize: const Size(
                                                          90, 30),
                                                      side: const BorderSide(
                                                        width: 1.5,
                                                        color: Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                      ),
                                                    ),
                                                    child: Text(
                                                        AppLocalizations.of(
                                                            context)!
                                                            .no,
                                                        style: TextStyle(
                                                            fontFamily: 'Inter',
                                                            fontSize:
                                                            localHeight * 0.018,
                                                            color: const Color
                                                                .fromRGBO(
                                                                82, 165, 160,
                                                                1),
                                                            fontWeight:
                                                            FontWeight.w500)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  SizedBox(width: localWidth *
                                                      0.005),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                        const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        minimumSize: const Size(
                                                            90, 30),
                                                      ),
                                                      child: Text(
                                                          AppLocalizations.of(
                                                              context)!
                                                              .yes,
                                                          style: TextStyle(
                                                              fontFamily: 'Inter',
                                                              fontSize:
                                                              localHeight *
                                                                  0.018,
                                                              color: Colors
                                                                  .white,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                      onPressed: () async {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return const Center(
                                                                  child:
                                                                  CircularProgressIndicator(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                        48, 145,
                                                                        139, 1),
                                                                  ));
                                                            });
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.pushNamed(context, '/studentSelectionPage');
                                                        // Navigator.push(
                                                        //   context,
                                                        //   PageTransition(
                                                        //     type: PageTransitionType
                                                        //         .rightToLeft,
                                                        //     child: StudentSelectionPage(
                                                        //         ),
                                                        //   ),
                                                        // );
                                                      }),
                                                  SizedBox(width: localHeight *
                                                      0.030),
                                                ],
                                              ),
                                        );
                                      },
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        Positioned(
                          top: localHeight * 0.1,
                          left: localHeight * 0.010,
                          right: localHeight * 0.010,
                          child: SizedBox(
                            height: localHeight * 0.60,
                            width: localWidth * 1.5,
                            child: Card(
                              elevation: 12,
                              child: Column(children: [
                                const SizedBox(height: 20.0),
                                Text(widget.userName,
                                    style: TextStyle(
                                        color:
                                        const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: localHeight * 0.024)),
                                const SizedBox(height: 25.0),
                                Text('${widget.totalMarks}/${widget.givenMark}',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 153, 0, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: localHeight * 0.096)),
                                const SizedBox(height: 15.0),
                                Text(AppLocalizations.of(context)!.mark_scored,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: localHeight * 0.018)),
                                const SizedBox(height: 30.0),
                                const Divider(
                                  thickness: 2,
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    const SizedBox(width: 25.0),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .submission_date,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                161, 161, 161, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.020)),
                                    const SizedBox(width: 25.0),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .submission_time,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                161, 161, 161, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.020)),
                                    const SizedBox(width: 25.0),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .time_taken,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                161, 161, 161, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.020)),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    const SizedBox(width: 25.0),
                                    Text(widget.date,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.022)),
                                    const SizedBox(width: 20.0),
                                    Text(widget.time,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.022)),
                                    const SizedBox(width: 25.0),
                                    Text(widget.endTime.substring(0, 7),
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.022)),
                                  ],
                                ),
                                const SizedBox(height: 30.0),
                                Expanded(
                                  child: Container(
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
                                              localWidth / 1.0,
                                              localHeight * 0.3)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.message,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: localHeight * 0.03),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )));
        }
      },
    );
  }
}
