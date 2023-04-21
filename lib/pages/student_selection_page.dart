import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/settings_languages.dart';
import 'package:qna_test/Pages/student_assessment_start.dart';
import 'package:qna_test/Pages/student_guest_login_page.dart';
import 'package:qna_test/Pages/student_member_login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Pages/welcome_page.dart';
import '../Components/end_drawer_menu_pre_login.dart';
import '../Components/custom_radio_button.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/user_data_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Services/qna_service.dart';

class StudentSelectionPage extends StatefulWidget {
  const StudentSelectionPage({super.key,});



  @override
  StudentSelectionPageState createState() => StudentSelectionPageState();
}

enum SingingCharacter { guest, member }

class StudentSelectionPageState extends State<StudentSelectionPage> {
  String? _groupValue = '1';

  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }

  SharedPreferences? loginData;
  late bool newUser;

  Future<bool> checkIfAlreadyLoggedIn() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData?.getBool('login') ?? true);
    if (newUser == false && loginData?.getString('role') == 'student') {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromRGBO(48, 145, 139, 1),
            ));
          });
      LoginModel loginResponse = await QnaService.logInUser(
          loginData!.getString('email')!,
          loginData!.getString('password')!,
          loginData!.getString('role')!);
      if (loginResponse.code == 200) {
        loginData?.setBool('login', false);
        loginData?.setString('email', loginData!.getString('email')!);
        loginData?.setString('password', loginData!.getString('password')!);
        loginData?.setString('token', loginResponse.data.accessToken);
        loginData?.setInt('userId', loginResponse.data.userId);
      }
      UserDataModel userDataModel = UserDataModel(code: 0, message: '');
      userDataModel =
          await QnaService.getUserDataService(loginData?.getInt('userId'));
      Navigator.pushNamed(
          context,
          '/studentAssessment',
          arguments: [
            loginData?.getString('email'),
            userDataModel
          ]);

      // Navigator.push(
      //   context,
      //   PageTransition(
      //     type: PageTransitionType.rightToLeft,
      //     child: StudentAssessment(
      //         regNumber: loginData?.getString('email'),
      //         usedData: userDataModel),
      //   ),
      // );
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    leading: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.rightToLeft,
                        //     child: WelcomePage(),
                        //   ),
                        // );
                        // Navigator.of(context).pop();
                      },
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  backgroundColor: Colors.white,
                  body: Column(children: [
                    Container(
                      height: height * 0.43,
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
                          SizedBox(height: height * 0.05),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: width * 0.30,
                              height: height * 0.30,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  //fit: BoxFit.fill,
                                  image:
                                      AssetImage('assets/images/qna_logo.png'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
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
                          padding: EdgeInsets.only(
                              left: width * 0.3, right: width * 0.3),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                            backgroundColor:
                                const Color.fromRGBO(82, 165, 160, 1),
                            minimumSize: Size(width * 0.4, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(39),
                            ),
                          ),
                          onPressed: () async {
                            if (_groupValue == '2') {
                              bool status = await checkIfAlreadyLoggedIn();
                              if (status == false) {
                                Navigator.pushNamed(context, '/studentMemberLoginPage');
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         StudentMemberLoginPage(
                                //             ),
                                //   ),
                                // );
                              }
                            } else {

                              Navigator.pushNamed(context, '/studentGuestLogin');
                              // Navigator.push(
                              //   context,
                              //   PageTransition(
                              //     type: PageTransitionType.rightToLeft,
                              //     child: StudentGuestLogin(
                              //         ),
                              //   ),
                              // );
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/settingsLanguages');
                            },
                            child: IconButton(
                                icon: const Icon(
                                  Icons.translate,
                                  color: Color.fromRGBO(141, 167, 167, 1),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/settingsLanguages');
                                  },
                              ))),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/settingsLanguages');
                                  },
                                  child: Text(
                                  AppLocalizations.of(context)!.select_language,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge
                                      ?.merge(TextStyle(
                                          color: const Color.fromRGBO(
                                              48, 145, 139, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: height * 0.02)))))
                            ],
                          ),
                      ],
                    ),
                  ])));
        } else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
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
                        Navigator.pushNamed(context, '/');
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.rightToLeft,
                        //     child: WelcomePage(),
                        //   ),
                        // );
                      },
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  backgroundColor: Colors.white,
                  body: Column(children: [
                    Container(
                      height: height * 0.43,
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
                          SizedBox(height: height * 0.15),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: width * 0.50,
                              height: height * 0.20,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      AssetImage('assets/images/qna_logo.png'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
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
                          child: Column(children: [
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
                            backgroundColor:
                                const Color.fromRGBO(82, 165, 160, 1),
                            minimumSize: const Size(280, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(39),
                            ),
                          ),
                          onPressed: () async {
                            if (_groupValue == '2') {
                              bool status = await checkIfAlreadyLoggedIn();
                              if (status == false) {
                                Navigator.pushNamed(context, '/studentMemberLoginPage');
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         StudentMemberLoginPage(
                                //             ),
                                //   ),
                                // );
                              }
                            } else {
                              Navigator.pushNamed(context, '/studentGuestLogin');
                              // Navigator.push(
                              //   context,
                              //   PageTransition(
                              //     type: PageTransitionType.rightToLeft,
                              //     child: StudentGuestLogin(
                              //         ),
                              //   ),
                              // );
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/settingsLanguages');
                              },
                              child: IconButton(
                                icon: const Icon(
                                  Icons.translate,
                                  color: Color.fromRGBO(141, 167, 167, 1),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/settingsLanguages');
                                },
                              ))),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/settingsLanguages');
                                  },
                                  child: Text(
                                  AppLocalizations.of(context)!.select_language,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge
                                      ?.merge(TextStyle(
                                          color: const Color.fromRGBO(
                                              48, 145, 139, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: height * 0.023)))))
                            ],
                          ),
                      ],
                    ),
                  ])));
        }
      },
    );
  }
}
