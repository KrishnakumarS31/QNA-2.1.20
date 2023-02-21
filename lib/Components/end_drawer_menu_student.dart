import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/reset_password_student.dart';
import 'package:qna_test/pages/settings_languages.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/pages/student_user_profile.dart';
import '../EntityModel/user_data_model.dart';
import '../Services/qna_service.dart';
import '../pages/change_email_student.dart';
import '../pages/cookie_policy.dart';
import '../pages/privacy_policy_hamburger.dart';
import '../pages/terms_of_services.dart';
import '../pages/about_us.dart';
import '../pages/help_page.dart';

class EndDrawerMenuStudent extends StatefulWidget {
   EndDrawerMenuStudent({Key? key, required this.setLocale,this.userName, this.email,this.userId})
      : super(key: key);
  final void Function(Locale locale) setLocale;
  final String? userName;
   final String? email;
   int? userId;

  @override
  State<EndDrawerMenuStudent> createState() => _EndDrawerMenuStudentState();
}

class _EndDrawerMenuStudentState extends State<EndDrawerMenuStudent> {
  UserDataModel userDataModel = UserDataModel(code: 0, message: '');

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    userDataModel=await QnaService.getUserDataService(widget.userId);
    setState((){
    });
  }


  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;
    double localWidth = MediaQuery.of(context).size.width;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    print(userDataModel.data?.countryNationality);
    return Drawer(
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
                const SizedBox(height: 50),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                Container(
                  alignment: Alignment.center,
                  // height: localHeight / 6,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    CircleAvatar(
                      backgroundColor: const Color.fromRGBO(0, 106, 100, 0),
                      radius: MediaQuery.of(context).size.width * 0.15,
                      child: Image.asset(
                        "assets/images/ProfilePic_Avatar.png",
                      ),
                    ),
                    //const SizedBox(height: 2.0),
                    Text(
                        widget.userName!,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge
                          ?.merge(const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.02,
                          fontSize: 16)),
                    ),
                  ]),
                ),
                ]
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.student,
                      style: const TextStyle(
                          color: Color.fromRGBO(221, 221, 221, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.02,
                          fontSize: 12),
                    ),
                    Text(
                      widget.email!,
                      style: const TextStyle(
                          color: Color.fromRGBO(221, 221, 221, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.02,
                          fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: localHeight * 0.02),
              ],
            ),
          ),
          Flexible(
            child: ListView(
              children: [
                ListTile(
                    leading: const Icon(Icons.people_alt,
                        color: Color.fromRGBO(141, 167, 167, 1)),
                    title: Text(
                      AppLocalizations.of(context)!.user_profile,
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
                    onTap: () {
                      print("rfv");
                      print(userDataModel.data!.password);
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: StudentUserProfile(
                            userDataModel: userDataModel,
                          ),
                        ),
                      );
                    }),
                ListTile(
                    leading: const Icon(Icons.key_outlined,
                        color: Color.fromRGBO(141, 167, 167, 1)),
                    title: Text(
                      AppLocalizations.of(context)!.change_password,
                      style: TextStyle(
                          color: textColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.02,
                          fontSize: 16),
                    ),
                    trailing: const Icon(Icons.navigate_next,
                        color: Color.fromRGBO(153, 153, 153, 1)),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ResetPasswordStudent(
                            userId: userDataModel.data!.id,
                          ),
                        ),
                      );
                    }),
                ListTile(
                    leading: const Icon(Icons.mail_outline_sharp,
                        color: Color.fromRGBO(141, 167, 167, 1)),
                    title: Text(
                      AppLocalizations.of(context)!.change_emailId,
                      style: TextStyle(
                          color: textColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.02,
                          fontSize: 16),
                    ),
                    trailing: const Icon(Icons.navigate_next,
                        color: Color.fromRGBO(153, 153, 153, 1)),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ChangeEmailStudent(
                              userId: userDataModel.data!.id),
                        ),
                      );
                    }),
                const Divider(
                  thickness: 2,
                ),
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
                          child: SettingsLanguages(setLocale: widget.setLocale),
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
                          child: PrivacyPolicyHamburger(
                              setLocale: widget.setLocale),
                        ),
                      );
                    }),
                ListTile(
                    leading: const Icon(Icons.verified_user_outlined,
                        color: Color.fromRGBO(141, 167, 167, 1)),
                    title: Text(
                      'Terms of Services',
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
                          child: TermsOfServiceHamburger(
                              setLocale: widget.setLocale),
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
                          child: CookiePolicy(setLocale: widget.setLocale),
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
                          child: AboutUs(setLocale: widget.setLocale),
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
                          child: HelpPageHamburger(setLocale: widget.setLocale),
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
                    onTap: () async {}),
                SizedBox(height: localHeight * 0.03),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Version : 1.0.0",
                    style: TextStyle(
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
    );
  }
}
