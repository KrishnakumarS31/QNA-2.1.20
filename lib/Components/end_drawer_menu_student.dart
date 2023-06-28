import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/reset_password_student.dart';
import 'package:qna_test/pages/settings_languages.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/pages/student_user_profile.dart';
import '../Entity/user_details.dart';
import '../EntityModel/user_data_model.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Services/qna_service.dart';
import '../pages/change_email_student.dart';
import '../pages/cookie_policy.dart';
import '../pages/privacy_policy_hamburger.dart';
import '../pages/terms_of_services.dart';
import '../pages/about_us.dart';
import '../pages/help_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DataSource/http_url.dart';

class EndDrawerMenuStudent extends StatefulWidget {
  EndDrawerMenuStudent({Key? key, this.userName, this.email, this.userId})
      : super(key: key);
  final String? userName;
  final String? email;
  int? userId;

  @override
  State<EndDrawerMenuStudent> createState() => _EndDrawerMenuStudentState();
}

class _EndDrawerMenuStudentState extends State<EndDrawerMenuStudent> {
  int userId = 0;
  String name = '';
  String email = '';
  UserDetails userDetails = UserDetails();
  @override
  void initState() {
    super.initState();
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      userDetails = Provider.of<LanguageChangeProvider>(context, listen: false)
          .userDetails;
      name = userDetails.firstName!;
      email = userDetails.email!;
      userId = userDetails.userId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Drawer(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        child: Column(
          children: [
            constraints.maxWidth <= 960 && constraints.maxWidth >=500
                ? Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1)
              ),
              child: Column(
                children: [
                  SizedBox(height: localHeight * 0.050),
                  Container(
                    alignment: Alignment.topLeft,
                    height: localHeight / 10,
                    child: Row(
                        children: [
                          SizedBox(width: width * 0.015),
                          CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.08,
                            backgroundColor:
                            const Color.fromRGBO(0, 106, 100, 0),
                            child: Image.asset(
                              "assets/images/ProfilePic_Avatar.png",
                            ),
                          ),
                          // const SizedBox(width: 5),
                          Text(
                            name,
                            style: TextStyle(
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.04),
                          ),
                        ]),
                  ),
                  Center(
                      child: Text(
                        AppLocalizations.of(context)!.student,
                        style: TextStyle(
                            color: const Color.fromRGBO(153, 153, 153, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,

                            fontSize: width * 0.03),
                      )),
                  SizedBox(height: localHeight * 0.020),
                  //    )
                ],
              ),
            )
                : constraints.maxWidth > 960
            ? Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1)
              ),
              child: Column(
                children: [
                  SizedBox(height: localHeight * 0.050),
                  Container(
                    alignment: Alignment.topLeft,
                    height: localHeight / 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20),
                          CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.02,
                            backgroundColor:
                            const Color.fromRGBO(0, 106, 100, 0),
                            child: Image.asset(
                              "assets/images/ProfilePic_Avatar.png",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            name,
                            style: const TextStyle(
                                color: Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ]),
                  ),
                  Center(
                      child: Text(
                        AppLocalizations.of(context)!.student,
                        style: const TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,

                            fontSize: 16),
                      )),
                  SizedBox(height: localHeight * 0.020),
                  //    )
                ],
              ),
            )
            : Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1)
              ),
              child: Column(
                children: [
                  SizedBox(height: localHeight * 0.050),
                  Container(
                    alignment: Alignment.topLeft,
                    height: localHeight / 10,
                    child: Row(
                        children: [
                          SizedBox(width: width * 0.015),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.08,
                        backgroundColor:
                        const Color.fromRGBO(0, 106, 100, 0),
                        child: Image.asset(
                          "assets/images/ProfilePic_Avatar.png",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        name,
                        style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.05),
                      ),
                    ]),
                  ),
                  Center(
                      child: Text(
                        AppLocalizations.of(context)!.student,
                        style: TextStyle(
                            color: const Color.fromRGBO(153, 153, 153, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,

                            fontSize: width * 0.04),
                      )),
                  // Column(
                  //   children: [
                  //     Container(
                  //         padding: const EdgeInsets.only(left: 15),
                  //         child: Text(
                  //           AppLocalizations.of(context)!.student,
                  //           style: TextStyle(
                  //               color: const Color.fromRGBO(153, 153, 153, 1),
                  //               fontFamily: 'Inter',
                  //               fontWeight: FontWeight.w500,
                  //
                  //               fontSize: width * 0.04),
                  //         )),
                  //     // Container(
                  //     //     padding: const EdgeInsets.only(left: 15),
                  //     //     child: Text(
                  //     //       email,
                  //     //       style: const TextStyle(
                  //     //           color: Color.fromRGBO(221, 221, 221, 1),
                  //     //           fontFamily: 'Inter',
                  //     //           fontWeight: FontWeight.w500,
                  //     //           fontSize: 12),
                  //     //     )),
                  //   ],
                  // ),
                  SizedBox(height: localHeight * 0.020),
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
                        style: TextStyle(
                                color: textColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                      ),
                      onTap: () async {
                        UserDataModel userDataModel =
                            await QnaService.getUserDataService(
                                userId, userDetails);
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
                            fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ResetPasswordStudent(
                              userId: userId,
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
                            fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ChangeEmailStudent(userId: userId),
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
                            fontSize: 16),
                      ),
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
                            fontSize: 16),
                      ),
                      onTap: () async {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const PrivacyPolicyHamburger(),
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
                            fontSize: 16),
                      ),
                      onTap: () async {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const TermsOfServiceHamburger(),
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
                            fontSize: 16),
                      ),
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
                        style: TextStyle(
                                color: textColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                      ),
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
                            fontSize: 16),
                      ),
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
                          fontSize: 16),
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) =>
                             AlertDialog(
                                insetPadding: const EdgeInsets.only(
                                    left: 25, right: 25),
                                title: Row(children: [
                                  SizedBox(width: localHeight * 0.030),
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(82, 165, 160, 1),
                                    ),
                                    height: localHeight * 0.1,
                                    width: 40,
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
                                        color: const Color.fromRGBO(
                                            0, 106, 100, 1),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ]),
                                content: Text(
                                    AppLocalizations.of(context)!.want_to_logout),
                                  //"Are you sure you want to logout ?"),
                                actions: <Widget>[
                                  const SizedBox(width: 30),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      minimumSize: const Size(90, 30),
                                      side: const BorderSide(
                                        width: 1.5,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                    ),
                                    child: Text(
                                        AppLocalizations.of(context)!.no,
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
                                  const SizedBox(width: 5),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            82, 165, 160, 1),
                                        minimumSize: const Size(90, 30),
                                      ),
                                      child: Text(
                                          AppLocalizations.of(context)!.yes,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: localHeight * 0.018,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                      onPressed: () async {
                                        UserDetails userData = UserDetails();
                                        Provider.of<LanguageChangeProvider>(
                                                context,
                                                listen: false)
                                            .updateUserDetails(userData);
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
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
                      "${AppLocalizations.of(context)!.version}: $version",
                      style: const TextStyle(
                          color: Color.fromRGBO(180, 180, 180, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          
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
    });
  }
}
