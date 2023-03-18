import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/settings_languages.dart';
import 'package:qna_test/Pages/teacher_login.dart';
import 'package:qna_test/Pages/teacher_selection_page.dart';
import '../Components/end_drawer_menu_pre_login.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/user_data_model.dart';
import '../Services/qna_service.dart';
import 'student_selection_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'package:shared_preferences/shared_preferences.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required this.setLocale}) : super(key: key);
  final void Function(Locale locale) setLocale;
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  SharedPreferences? loginData;
  late bool newUser;
  Future<bool> check_if_alread_loggedin()async{
    loginData=await SharedPreferences.getInstance();
    newUser=(loginData?.getBool('login')??true);
    if(newUser==false){
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(48, 145, 139, 1),
                ));
          });
      LoginModel loginResponse = await QnaService.logInUser(loginData!.getString('email')!, loginData!.getString('password')!,loginData!.getString('role')!);
      if (loginResponse.code == 200) {
        loginData?.setBool('login', false);
        loginData?.setString('email', loginData!.getString('email')!);
        loginData?.setString('password', loginData!.getString('password')!);
        loginData?.setString('token', loginResponse.data.accessToken);
        loginData?.setInt('userId', loginResponse.data.userId);
      }
      UserDataModel userDataModel = UserDataModel(code: 0, message: '');
      userDataModel = await QnaService.getUserDataService(loginData?.getInt('userId'));
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: TeacherSelectionPage(
            setLocale: widget.setLocale,
            userId: loginData?.getInt('userId'), userData: userDataModel,
          ),
        ),
      );
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
    double localHeight = MediaQuery.of(context).size.height;
    double localWidth = MediaQuery.of(context).size.width;
    const iconAsset = "assets/images/bg.png";
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 700) {
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
              ),
              endDrawer: EndDrawerMenuPreLogin(setLocale: widget.setLocale),
              body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        SizedBox(
                            height: localHeight,
                            width: localWidth,
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 2.5,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(iconAsset),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: localHeight * 0.06,
                                ),
                                Text(AppLocalizations.of(context)!.welcome,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.050)),
                                SizedBox(
                                  height: localHeight * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: localWidth / 15, right: localWidth / 15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: localWidth / 15,
                                              right: localWidth / 15),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .learner_applicant,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: localHeight * 0.024)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: localHeight * 0.02,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: localWidth / 15,
                                              right: localWidth / 15),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                                minimumSize: const Size(280, 48),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(39),
                                                ),
                                              ),
                                              child: Text(
                                                  AppLocalizations.of(context)!.student,
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: localHeight * 0.044,
                                                      color: Colors.white)),
                                              onPressed: () async {
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type: PageTransitionType.rightToLeft,
                                                    child: StudentSelectionPage(
                                                        setLocale: widget.setLocale),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: localWidth / 15, right: localWidth / 15),
                                      child: Column(children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: localWidth / 15,
                                              right: localWidth / 15),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .instructor_examiner,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyLarge
                                                    ?.merge(TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: localHeight * 0.024))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: localHeight * 0.02,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: localWidth / 15,
                                                right: localWidth / 15),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  minimumSize: const Size(280, 48),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(39),
                                                  ),
                                                ),
                                                child: Text(
                                                    AppLocalizations.of(context)!.teacher,
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize: localHeight * 0.044,
                                                        color: Colors.white)),
                                                onPressed: () async {
                                                  bool status =await check_if_alread_loggedin();
                                                  if(status==false){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => TeacherLogin(
                                                            setLocale: widget.setLocale),
                                                      ),
                                                    );
                                                  }

                                                },
                                              ),
                                            )),
                                      ]),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: localHeight * 0.07,
                                ),

                                SizedBox(
                                  height: localHeight * 0.05,
                                ),
                                MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: SettingsLanguages(
                                              setLocale: widget.setLocale),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.translate,
                                            color: Color.fromRGBO(141, 167, 167, 1),
                                          ),
                                          onPressed: () {},
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .select_language,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  48, 145, 139, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: localHeight * 0.026),
                                        )
                                      ],
                                    )),
                              ],
                            ))
                      ]),
                      Positioned(
                        left: localWidth * 0.04,
                        top: localHeight * 0.055,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              //fit: BoxFit.fitWidth,
                              image: AssetImage('assets/images/itne_logo.png'),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: localWidth * 0.25,
                        top: localHeight * 0.15,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              //fit: BoxFit.fill,
                              image: AssetImage('assets/images/qna_logo.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )));
        }



        else {
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
              ),
              endDrawer: EndDrawerMenuPreLogin(setLocale: widget.setLocale),
              body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        SizedBox(
                            height: localHeight,
                            width: localWidth,
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 2.5,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(iconAsset),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: localHeight * 0.06,
                                ),
                                Text(AppLocalizations.of(context)!.welcome,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.030)),
                                SizedBox(
                                  height: localHeight * 0.03,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: localWidth / 15, right: localWidth / 15),
                                  child: Column(children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: localWidth / 15,
                                          right: localWidth / 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .learner_applicant,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.014)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: localHeight * 0.02,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: localWidth / 15,
                                          right: localWidth / 15),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            const Color.fromRGBO(82, 165, 160, 1),
                                            minimumSize: const Size(280, 48),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(39),
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!.student,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: localHeight * 0.024,
                                                  color: Colors.white)),
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.rightToLeft,
                                                child: StudentSelectionPage(
                                                    setLocale: widget.setLocale),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                                SizedBox(
                                  height: localHeight * 0.07,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: localWidth / 15, right: localWidth / 15),
                                  child: Column(children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: localWidth / 15,
                                          right: localWidth / 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .instructor_examiner,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyLarge
                                                ?.merge(TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.014))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: localHeight * 0.02,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: localWidth / 15,
                                            right: localWidth / 15),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              minimumSize: const Size(280, 48),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(39),
                                              ),
                                            ),
                                            child: Text(
                                                AppLocalizations.of(context)!.teacher,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: localHeight * 0.024,
                                                    color: Colors.white)),
                                            onPressed: () async {
                                              bool status =await check_if_alread_loggedin();
                                              if(status==false){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => TeacherLogin(
                                                        setLocale: widget.setLocale),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        )),
                                  ]),
                                ),
                                SizedBox(
                                  height: localHeight * 0.05,
                                ),
                                MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: SettingsLanguages(
                                              setLocale: widget.setLocale),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.translate,
                                            color: Color.fromRGBO(141, 167, 167, 1),
                                          ),
                                          onPressed: () {},
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .select_language,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  48, 145, 139, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: localHeight * 0.016),
                                        )
                                      ],
                                    )),
                              ],
                            ))
                      ]),
                      Positioned(
                        left: localWidth * 0.04,
                        top: localHeight * 0.055,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/itne_logo.png'),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: localWidth * 0.25,
                        top: localHeight * 0.15,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.135,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/qna_logo.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )));
        }
      },
    );
  }
}
