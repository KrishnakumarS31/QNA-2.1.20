import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Pages/privacy_policy_hamburger.dart';
import 'package:qna_test/Pages/settings_languages.dart';
import 'package:qna_test/pages/about_us.dart';
import 'package:qna_test/pages/cookie_policy.dart';
import 'package:qna_test/pages/help_page.dart';
import '../Components/custom_incorrect_popup.dart';
import '../DataSource/http_url.dart';
import '../Entity/question_paper_model.dart';
import '../Services/qna_service.dart';
import 'terms_of_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 700) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                    ),
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    // leading: IconButton(
                    //   icon: const Icon(
                    //     Icons.chevron_left,
                    //     size: 30,
                    //     color: Colors.white,
                    //   ),
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    // ),
                    backgroundColor: Colors.transparent,
                  ),
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
                                height: height / 6,
                                child: Row(
                                    children: [
                                      SizedBox(width: width * 0.015),
                                      CircleAvatar(
                                        backgroundColor:
                                        const Color.fromRGBO(0, 106, 100, 0),
                                        radius: MediaQuery.of(context).size.width * 0.05,
                                        child: Image.asset(
                                          "assets/images/ProfilePic_Avatar.png",
                                        ),
                                      ),
                                      SizedBox(width: width * 0.03),
                                      Text(
                                        widget.name,
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
                                      padding: EdgeInsets.only(left: width * 0.09),
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
                                          left: width * 0.13, right: width * 0.13),
                                      title: Row(children: [
                                        SizedBox(width: height * 0.030),
                                        Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                          height: height * 0.1,
                                          width: width * 0.1,
                                          child: const Icon(
                                            Icons.info_outline_rounded,
                                            color: Color.fromRGBO(255, 255, 255, 1),
                                          ),
                                        ),
                                        SizedBox(width: height * 0.015),
                                        Text(
                                          AppLocalizations.of(context)!.confirm,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: height * 0.024,
                                              color: const Color.fromRGBO(0, 106, 100, 1),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ]),
                                      content:
                                      const Text("Are you sure you want to logout ??"),
                                      actions: <Widget>[
                                        SizedBox(width: width * 0.020),
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
                                                  fontSize: height * 0.018,
                                                  color:
                                                  const Color.fromRGBO(82, 165, 160, 1),
                                                  fontWeight: FontWeight.w500)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        SizedBox(width: width * 0.005),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              const Color.fromRGBO(82, 165, 160, 1),
                                              minimumSize: const Size(90, 30),
                                            ),
                                            child: Text(AppLocalizations.of(context)!.yes,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: height * 0.018,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500)),
                                            onPressed: () async {
                                              SharedPreferences preferences =
                                              await SharedPreferences.getInstance();
                                              await preferences.clear();
                                              Navigator.pushNamed(context, '/');
                                            }),
                                        SizedBox(width: height * 0.030),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: height * 0.03),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${AppLocalizations.of(context)!.version}: $version",
                                  style: const TextStyle(
                                      color: Color.fromRGBO(180, 180, 180, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.02,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                height: height * 0.25,
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
                                              Icons.event_note_outlined,
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
                                            null
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
                                            title: '${values.message}',
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
                                          title: '${values.message}',
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     IconButton(
                      //       icon: const Icon(
                      //         Icons.search,
                      //         color: Color.fromRGBO(141, 167, 167, 1),
                      //       ),
                      //       onPressed: () {},
                      //     ),
                      //     Text(AppLocalizations.of(context)!.search_library,
                      //         style: Theme.of(context)
                      //             .primaryTextTheme
                      //             .bodyLarge
                      //             ?.merge(const TextStyle(
                      //                 color: Color.fromRGBO(48, 145, 139, 1),
                      //                 fontFamily: 'Inter',
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: 16))),
                      //   ],
                      // ),
                    ]),
                  )));
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
                              SizedBox(height: height * 0.050),
                              Container(
                                alignment: Alignment.center,
                                height: height / 6,
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
                                    widget.name,
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
                                      padding: EdgeInsets.only(left: width * 0.09),
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
                                    builder: (context) =>
                                    constraints.maxWidth > 700
                                        ? AlertDialog(
                                      insetPadding: EdgeInsets.only(
                                          left: width * 0.13, right: width * 0.13),
                                      title: Row(
                                          children: [
                                            SizedBox(width: height * 0.030),
                                            Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(82, 165, 160, 1),
                                              ),
                                              height: height * 0.1,
                                              width: width * 0.1,
                                              child: const Icon(Icons.info_outline_rounded,
                                                color: Color.fromRGBO(255, 255, 255, 1),
                                              ),
                                            ),
                                            SizedBox(width: height * 0.003),
                                            Text(AppLocalizations.of(context)!.confirm,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: height * 0.024,
                                                  color: const Color.fromRGBO(0, 106, 100, 1),
                                                  fontWeight: FontWeight.w700
                                              ),),
                                          ]
                                      ),
                                      content: const Text("\t\t\t\tAre you sure you want to logout ??"),
                                      actions: <Widget>[
                                        // constraints.maxWidth > 700
                                        //     ? const SizedBox()
                                        //     :
                                        SizedBox(width: width * 0.030),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                                            minimumSize: const Size(90, 30),
                                            side: const BorderSide(
                                              width: 1.5,
                                              color: Color.fromRGBO(82, 165, 160, 1),
                                            ),
                                          ),
                                          child: Text(AppLocalizations.of(context)!.no,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: height * 0.018,
                                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                                  fontWeight: FontWeight.w500
                                              )
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        constraints.maxWidth > 700
                                            ? SizedBox(width: width * 0.05)
                                            : SizedBox(width: width * 0.005),
                                        ElevatedButton(
                                            style:
                                            ElevatedButton.styleFrom(
                                              backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                              minimumSize: const Size(90, 30),
                                            ),
                                            child: Text(AppLocalizations.of(context)!.yes,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: height * 0.018,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500
                                                )
                                            ),
                                            onPressed: () async {
                                              SharedPreferences preferences =
                                              await SharedPreferences.getInstance();
                                              await preferences.clear();
                                              Navigator.pushNamed(context, '/');
                                            }
                                        ),
                                        constraints.maxWidth > 700
                                            ? SizedBox(width: width * 0.040)
                                            : SizedBox(width: width * 0.030),
                                      ],
                                    )
                                        : AlertDialog(
                                      insetPadding: EdgeInsets.only(
                                          left: width * 0.13, right: width * 0.13),
                                      title: Row(children: [
                                        SizedBox(width: height * 0.030),
                                        Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                          height: height * 0.1,
                                          width: width * 0.1,
                                          child: const Icon(
                                            Icons.info_outline_rounded,
                                            color: Color.fromRGBO(255, 255, 255, 1),
                                          ),
                                        ),
                                        SizedBox(width: height * 0.015),
                                        Text(
                                          AppLocalizations.of(context)!.confirm,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: height * 0.024,
                                              color: const Color.fromRGBO(0, 106, 100, 1),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ]),
                                      content:
                                      const Text("Are you sure you want to logout ??"),
                                      actions: <Widget>[
                                        SizedBox(width: width * 0.020),
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
                                                  fontSize: height * 0.018,
                                                  color:
                                                  const Color.fromRGBO(82, 165, 160, 1),
                                                  fontWeight: FontWeight.w500)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        SizedBox(width: width * 0.005),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              const Color.fromRGBO(82, 165, 160, 1),
                                              minimumSize: const Size(90, 30),
                                            ),
                                            child: Text(AppLocalizations.of(context)!.yes,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: height * 0.018,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500)),
                                            onPressed: () async {
                                              SharedPreferences preferences =
                                              await SharedPreferences.getInstance();
                                              await preferences.clear();
                                              Navigator.pushNamed(context, '/');
                                            }),
                                        SizedBox(width: height * 0.030),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: height * 0.03),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${AppLocalizations.of(context)!.version}: $version",
                                  style: const TextStyle(
                                      color: Color.fromRGBO(180, 180, 180, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.02,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                            Icons.event_note_outlined,
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
                                            null
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
                                    } else if (values.code == 400) {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title: '${values.message}',
                                            content: '',
                                            button:
                                            AppLocalizations.of(context)!
                                                .retry,
                                          ),
                                        ),
                                      );
                                    }
                                    else {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type:
                                          PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title: '${values.message}',
                                            content: '',
                                            button: AppLocalizations.of(context)!.retry,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  // else {
                                  //   Navigator.push(
                                  //     context,
                                  //     PageTransition(
                                  //       type: PageTransitionType.rightToLeft,
                                  //       child: CustomDialog(
                                  //         title: AppLocalizations.of(context)!
                                  //             .invalid_assessment_iD,
                                  //         content: '',
                                  //         button: AppLocalizations.of(context)!
                                  //             .retry,
                                  //       ),
                                  //     ),
                                  //   );
                                  // }
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
