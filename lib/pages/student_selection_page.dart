import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/settings_languages.dart';
import 'package:qna_test/Pages/student_guest_login_page.dart';
import 'package:qna_test/Pages/student_member_login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'privacy_policy_hamburger.dart';
import 'terms_of_services.dart';
import 'cookie_policy.dart';
import '../Components/custom_radio_button.dart';

class StudentSelectionPage extends StatefulWidget {
  const StudentSelectionPage({super.key, required this.setLocale});
  final void Function(Locale locale) setLocale;
  @override
  StudentSelectionPageState createState() => StudentSelectionPageState();
}

enum SingingCharacter { guest, member }

class StudentSelectionPageState extends State<StudentSelectionPage> {
  String? _groupValue = '1';
  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    //const IconData chevron_left = IconData(0xe15e, fontFamily: 'MaterialIcons', matchTextDirection: true);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
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
          //backgroundColor: const Color.fromRGBO(0,106,100,1),
        ),
        endDrawer: Drawer(
          child: Column(
            children: [
              Container(
                  color: const Color.fromRGBO(0,106,100,1),
                  height: 55),
              Image.asset(
                "assets/images/rectangle_qna.png",
              ),
              Flexible(
                child: ListView(
                  children: [
                    ListTile(
                        leading:
                        const Icon(
                            Icons.translate,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.language,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: SettingsLanguages(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.verified_user_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.privacy_and_terms,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: PrivacyPolicyHamburger(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.verified_user_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text('Terms of Services',style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: TermsOfServiceHamburger(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.note_alt_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.cookie_policy,style: TextStyle(
                            color: textColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: CookiePolicy(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.perm_contact_calendar_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.about_us,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16)),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.help_outline,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.help,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        onTap: () async {
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(children: [
          Container(
            height: height * 0.43,
            width: width,
            decoration: BoxDecoration(
              // color: Theme.of(context).primaryColor,
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
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.1),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    height: height * 0.20,
                    width: width * 0.30,
                    child: Image.asset("assets/images/question_mark_logo.png"),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  'QNA',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.060,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.03),
              Text(
                AppLocalizations.of(context)!.studentCaps,
                style: TextStyle(
                    fontSize: height * 0.04,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w800,
                    color: const Color.fromRGBO(28, 78, 80, 1)),
              ),
              SizedBox(
                height: height * 0.030,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomRadioButton<String>(
                        value: '1',
                        groupValue: _groupValue,
                        onChanged: _valueChangedHandler(),
                        label: '1',
                        text: AppLocalizations.of(context)!.guest,
                        height: height,
                        width: width,
                        context: context,
                      ),
                      CustomRadioButton<String>(
                        value: '2',
                        groupValue: _groupValue,
                        onChanged: _valueChangedHandler(),
                        label: '2',
                        text: AppLocalizations.of(context)!.member,
                        height: height,
                        width: width,
                        context: context,
                      ),
                    ]),
              ),
              SizedBox(
                height: height * 0.05,
              ),
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
                  if (_groupValue == '2') {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:
                            StudentMemberLoginPage(setLocale: widget.setLocale),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: StudentGuestLogin(setLocale: widget.setLocale),
                      ),
                    );
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: TextStyle(
                      fontSize: height * 0.03,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: height * 0.09,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: SettingsLanguages(setLocale: widget.setLocale),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.g_translate_sharp,
                        color: Color.fromRGBO(141, 167, 167, 1),
                      ),
                      onPressed: () {},
                    ),
                    Text(AppLocalizations.of(context)!.select_language,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText1
                            ?.merge(TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: height * 0.02))),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
