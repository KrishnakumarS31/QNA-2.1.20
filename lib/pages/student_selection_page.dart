import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Components/end_drawer_menu_pre_login.dart';
import '../Components/custom_radio_button.dart';
import '../Entity/user_details.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/user_data_model.dart';
import '../DataSource/http_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/welcome_page.dart';
import '../Providers/LanguageChangeProvider.dart';
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
  UserDetails userdata=UserDetails();

  Future<bool> checkIfAlreadyLoggedIn() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (userdata.login ?? true);
    if (newUser == false && userdata.role == 'student') {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(48, 145, 139, 1),
                ));
          });
      LoginModel loginResponse = await QnaService.logInUser(
          userdata.email!,
          userdata.password!,
          userdata.role!);
      if (loginResponse.code == 200) {
        loginData?.setBool('login', false);
        loginData?.setString('email', userdata.email!);
        loginData?.setString('password', userdata.password!);
        loginData?.setString('token', loginResponse.data.accessToken);
        loginData?.setInt('userId', loginResponse.data.userId);
      }
      UserDataModel userDataModel = UserDataModel(code: 0, message: '');
      userDataModel =
      await QnaService.getUserDataService(userdata.userId,userdata);
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
    userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 960) {
          return Center(
            child: SizedBox(
              width: webWidth,
              child: WillPopScope(
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
                            // Navigator.popUntil(context, ModalRoute.withName('/'));
                            // Navigator.pushNamed(context, ('/'));
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const WelcomePage(),
                              ),
                            );
                          },
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      endDrawer: const EndDrawerMenuPreLogin(),
                      backgroundColor: Colors.white,
                      body: Column(children: [
                        Container(
                          height: height * 0.43,
                          width: webWidth,
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
                                bottom: Radius.elliptical(400, height * 0.40)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.15),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: webWidth * 0.50,
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
                                  fontSize: height * 0.035,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromRGBO(28, 78, 80, 1)),
                            ),
                            SizedBox(
                              height: height * 0.030,
                            ),
                            CustomRadioButton<String>(
                              value: '1',
                              groupValue: _groupValue,
                              onChanged: _valueChangedHandler(),
                              label: '1',
                              text: AppLocalizations.of(context)!.guest,
                              height: height,
                              width: webWidth,
                              context: context,
                            ),
                            CustomRadioButton<String>(
                              value: '2',
                              groupValue: _groupValue,
                              onChanged: _valueChangedHandler(),
                              label: '2',
                              text: AppLocalizations.of(context)!.member,
                              height: height,
                              width: webWidth,
                              context: context,
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
                                    fontWeight: FontWeight.w600),
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
                      ]))),
            ),
          );
        }
        if(constraints.maxWidth <= 960 && constraints.maxWidth >=500)
        {
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
                        // Navigator.popUntil(context, ModalRoute.withName('/'));
                        // Navigator.pushNamed(context, ('/'));
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const WelcomePage(),
                          ),
                        );
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
                            bottom: Radius.elliptical(400, height * 0.40)),
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
                              fontSize: height * 0.035,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(28, 78, 80, 1)),
                        ),
                        SizedBox(
                          height: height * 0.030,
                        ),
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
                                fontWeight: FontWeight.w600),
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
        else {
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
                        // Navigator.popUntil(context, ModalRoute.withName('/'));
                        // Navigator.pushNamed(context, ('/'));
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const WelcomePage(),
                          ),
                        );
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
                            bottom: Radius.elliptical(400, height * 0.40)),
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
                              fontSize: height * 0.035,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(28, 78, 80, 1)),
                        ),
                        SizedBox(
                          height: height * 0.030,
                        ),
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
                                fontWeight: FontWeight.w600),
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
