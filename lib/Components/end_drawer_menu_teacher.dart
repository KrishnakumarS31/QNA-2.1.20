import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/reset_password_teacher.dart';
import 'package:qna_test/pages/settings_languages.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Entity/user_details.dart';
import '../EntityModel/user_data_model.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Services/qna_service.dart';
import '../pages/cookie_policy.dart';
import '../pages/privacy_policy_hamburger.dart';
import '../pages/teacher_user_profile.dart';
import '../pages/terms_of_services.dart';
import '../pages/about_us.dart';
import '../pages/help_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DataSource/http_url.dart';
class EndDrawerMenuTeacher extends StatefulWidget {
  const EndDrawerMenuTeacher({Key? key,})
      : super(key: key);


  @override
  State<EndDrawerMenuTeacher> createState() => _EndDrawerMenuTeacherState();
}

class _EndDrawerMenuTeacherState extends State<EndDrawerMenuTeacher> {
  String name = '';
  String email = '';
  int userId = 0;
  UserDetails userDetails=UserDetails();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
      name = userDetails.firstName!;
      email = userDetails.email!;
      userId = userDetails.userId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Drawer(
            child: Column(
              children: [
                constraints.maxWidth > 700
                    ? Container(
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
                                name,
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
                                email,
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
                )
                    : Container(
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
                            name,
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
                                email,
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
                          onTap: () async {
                            UserDataModel userDataModel =
                            await QnaService.getUserDataService(userId,userDetails);
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: TeacherUserProfile(
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
                                child: ResetPassword(userId:userId),
                              ),
                            );
                          }),
                      // ListTile(
                      //     leading: const Icon(Icons.mail_outline_sharp,
                      //         color: Color.fromRGBO(141, 167, 167, 1)),
                      //     title: Text(
                      //       AppLocalizations.of(context)!.change_emailId,
                      //       style: TextStyle(
                      //           color: textColor,
                      //           fontFamily: 'Inter',
                      //           fontWeight: FontWeight.w500,
                      //           letterSpacing: -0.02,
                      //           fontSize: 16),
                      //     ),
                      //     trailing: const Icon(Icons.navigate_next,
                      //         color: Color.fromRGBO(153, 153, 153, 1)),
                      //     onTap: () {
                      //       // Navigator.push(
                      //       //   context,
                      //       //   PageTransition(
                      //       //     type: PageTransitionType.rightToLeft,
                      //       //     child:  ChangeEmailTeacher(userId: userDataModel.data!.id),
                      //       //   ),
                      //       // );
                      //     }),
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
                                child:
                                const SettingsLanguages(),
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
                                child:
                                const HelpPageHamburger(),
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
                              content: const Text("\t\t\t\tAre you sure you want to logout ?"),
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
                                      UserDetails userData=UserDetails();
                                      Provider.of<LanguageChangeProvider>(context, listen: false).updateUserDetails(userData);
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
                              const Text("Are you sure you want to logout ?"),
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
                                      UserDetails userData=UserDetails();
                                      Provider.of<LanguageChangeProvider>(context, listen: false).updateUserDetails(userData);
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
          );
        });
  }
}
