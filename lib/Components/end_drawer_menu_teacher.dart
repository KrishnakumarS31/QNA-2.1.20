import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/pages/reset_password_teacher.dart';
import 'package:qna_test/pages/settings_languages.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../EntityModel/user_data_model.dart';
import '../Pages/teacher_login.dart';
import '../Services/qna_service.dart';
import '../pages/cookie_policy.dart';
import '../pages/privacy_policy_hamburger.dart';
import '../pages/teacher_user_profile.dart';
import '../pages/terms_of_services.dart';
import '../pages/about_us.dart';
import '../pages/help_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndDrawerMenuTeacher extends StatefulWidget {
  const EndDrawerMenuTeacher({Key? key, required this.setLocale})
      : super(key: key);
  final void Function(Locale locale) setLocale;

  @override
  State<EndDrawerMenuTeacher> createState() => _EndDrawerMenuTeacherState();
}

class _EndDrawerMenuTeacherState extends State<EndDrawerMenuTeacher> {
  UserDataModel userDataModel = UserDataModel(code: 0, message: '');
  String name = '';
  String email='';

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    userDataModel=await QnaService.getUserDataService(loginData.getInt('userId'));
    setState((){
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
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
                SizedBox(height: height * 0.050),
                Container(
                  alignment: Alignment.center,
                  height: height / 6,
                  child: Row(children: [
                    CircleAvatar(
                      backgroundColor: const Color.fromRGBO(0, 106, 100, 0),
                      radius: MediaQuery.of(context).size.width * 0.15,
                      child: Image.asset(
                        "assets/images/ProfilePic_Avatar.png",
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      userDataModel.data!.firstName,
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
                const SizedBox(height: 0.022),
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: width * 0.09),
                        child: Text(
                          AppLocalizations.of(context)!.teacher,
                          style: const TextStyle(
                              color: Color.fromRGBO(221, 221, 221, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 12),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: width * 0.09),
                        child: Text(
                          userDataModel.data!.email,
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

                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: TeacherUserProfile(userDataModel: userDataModel,),
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
                          child: const ResetPassword(),
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
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.rightToLeft,
                      //     child:  ChangeEmailTeacher(userId: userDataModel.data!.id),
                      //   ),
                      // );
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
                        content: const Text("Are you sure you want to logout ??"),
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
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: TeacherLogin(
                                        setLocale: widget.setLocale),
                                  ),
                                );
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
                    "${AppLocalizations.of(context)!.version}: 1.0.0",
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
    );
  }
}
