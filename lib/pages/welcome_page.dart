import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Components/end_drawer_menu_pre_login.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
// import 'package:universal_internet_checker/universal_internet_checker.dart';
import "package:shared_preferences/shared_preferences.dart";

class WelcomePage extends StatefulWidget {
  static const String id = 'welcome_page';
  const WelcomePage({Key? key,}) : super(key: key);


  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  SharedPreferences? loginData;
  late bool newUser;
  bool teacherClick = false;
  bool memberStudentClick = false;
  String _message = '';
  StreamSubscription? subscription;
 // final UniversalInternetChecker _internetChecker = UniversalInternetChecker();
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
   // getConnectivity();
  }
  // getConnectivity() {
  //   subscription = _internetChecker.onConnectionChange.listen((connected) async {
  //     _message = connected == ConnectionStatus.online
  //         ? 'Connected'
  //         : 'Not Connected';
  //     if (_message=='Not Connected') {
  //       setState(() {
  //         isAlertSet=true;
  //       });
  //       showDialogBox();
  //     } else {
  //         isAlertSet?Navigator.of(context).pop():print("");
  //     }
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription?.cancel();
    super.dispose();
  }

  // showDialogBox() => showCupertinoDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) =>  CupertinoAlertDialog(
  //       title: Text(
  //         AppLocalizations.of(context)!.no_connection,
  //         //"NO CONNECTION",
  //         style: const TextStyle(
  //           color: Color.fromRGBO(82, 165, 160, 1),
  //           fontSize: 25,
  //           fontFamily: "Inter",
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //       content: Text(
  //         AppLocalizations.of(context)!.check_internet,
  //         //"Please check your internet connectivity",
  //         style: const TextStyle(
  //           color: Color.fromRGBO(82, 165, 160, 1),
  //           fontSize: 16,
  //           fontFamily: "Inter",
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //     ));

  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;
    double localWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if(constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    iconTheme: IconThemeData(color: Colors.white,size: localHeight * 0.04),
                    toolbarHeight: localHeight * 0.100,
                    title:
                    SizedBox(
                        height: localHeight * 0.08,
                        child: Image.asset(
                            "assets/images/qna_logo.png")),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: [
                                Color.fromRGBO(0, 106, 100, 1),
                                Color.fromRGBO(82, 165, 160, 1),
                              ])),
                    ),
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: localHeight * 0.25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(width: localWidth * 0.05),
                      Text(
                              AppLocalizations.of(context)!
                                  .welcome,
                              style: TextStyle(
                                  color: const Color.fromRGBO(
                                      28, 78, 80, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: localHeight * 0.035)),]),
                          SizedBox(
                            height: localHeight * 0.20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!.continue_as,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: localHeight * 0.035)),]),
                          SizedBox(
                            height: localHeight * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              ElevatedButton(
                                    style:
                                    ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                          width: 1, // the thickness
                                          color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                      ),
                                      minimumSize:
                                      Size(localWidth * 0.1,localWidth * 0.04),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            39),
                                      ),
                                    ),
                                    child: Text(
                                        AppLocalizations.of(context)!.student,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize:
                                            localHeight *
                                                0.03,
                                            fontWeight: FontWeight
                                                .w600,
                                            color: const Color.fromRGBO(82, 165, 160, 1))),
                                    onPressed: () async {
                                      Navigator.pushNamed(context,
                                          '/studentMemberLoginPage');
                                    },
                                  ),
                                  SizedBox(width: localWidth * 0.03),
                                  ElevatedButton(
                                    style: ElevatedButton
                                        .styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                          width: 1, // the thickness
                                          color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                      ),
                                      minimumSize:
                                      Size(localWidth * 0.1,localWidth * 0.04),
                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(39),
                                      ),
                                    ),
                                    child: Text(
                                        AppLocalizations.of(
                                            context)!
                                            .teacher,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight
                                                .w600,
                                            fontSize:
                                            localHeight *
                                                0.03,
                                            color: const Color.fromRGBO(82, 165, 160, 1))),
                                    onPressed: () {
                                      teacherClick == true;
                                      Navigator.pushNamed(
                                          context,
                                          '/teacherLoginPage');
                                    },
                                  ),
                            ]),
                          SizedBox(
                            height: localHeight * 0.05,
                          ),
                         Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // const SizedBox(width: 90),
                              MouseRegion(
                                  cursor: SystemMouseCursors
                                      .click,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            '/settingsLanguages');
                                      },
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.translate,
                                          color: Color.fromRGBO(
                                              141, 167, 167, 1),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              '/settingsLanguages');
                                        },
                                      ))),
                              MouseRegion(
                                  cursor: SystemMouseCursors
                                      .click,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            '/settingsLanguages');
                                      },
                                      child: Text(
                                          AppLocalizations.of(
                                              context)!
                                              .select_language,
                                          style: TextStyle(
                                              color: const Color
                                                  .fromRGBO(
                                                  48, 145, 139,
                                                  1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight
                                                  .w500,
                                              fontSize: localHeight *
                                                  0.023))))
                            ],
                          ),
                          SizedBox(
                            height: localHeight * 0.08,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          RichText(
                              text: TextSpan(
                                  children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!.product_of,
                                  style: TextStyle(
                                      color: const Color
                                          .fromRGBO(
                                          48, 145, 139, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight
                                          .w400,
                                      fontSize: localHeight *
                                          0.018),
                                ),
                                TextSpan(
                                    text: AppLocalizations.of(context)!.itn_welcome,
                                    style: TextStyle(
                                        color: const Color
                                            .fromRGBO(
                                            28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight
                                            .w700,
                                        fontSize: localHeight *
                                            0.018)),
                              ]))]),
                          SizedBox(
                            height: localHeight * 0.01,
                          ),
                        ],
                      ))));
        }
        else if(constraints.maxWidth > 960) {
          return
            WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: localHeight * 0.100,
                    iconTheme: IconThemeData(color: Colors.white,size: localHeight * 0.04),
                    title:
                    SizedBox(
                        height: localHeight * 0.08,
                        child: Image.asset(
                            "assets/images/qna_logo.png")),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: [
                                Color.fromRGBO(0, 106, 100, 1),
                                Color.fromRGBO(82, 165, 160, 1),
                              ])),
                    ),
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  body:
                  Padding(
                          padding:EdgeInsets.only(left: localWidth * 0.4,right: localWidth * 0.04),
                          child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(height: localHeight* 0.2),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!
                                            .welcome,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                28, 78, 80, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.035)),]),
                              SizedBox(
                                height: localHeight * 0.20,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!.continue_as,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                28, 78, 80, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.035)),]),
                              SizedBox(
                                height: localHeight * 0.05,
                              ),
                              Row(
                                  children: [
                                    ElevatedButton(
                                      style:
                                      ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            width: 1, // the thickness
                                            color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                        ),
                                        minimumSize:
                                        const Size(144, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              39),
                                        ),
                                      ),
                                      child: Text(
                                          AppLocalizations.of(
                                              context)!
                                              .student,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize:
                                              localHeight *
                                                  0.03,
                                              fontWeight: FontWeight
                                                  .w600,
                                              color: const Color.fromRGBO(82, 165, 160, 1))),
                                      onPressed: () async {
                                        Navigator.pushNamed(context,
                                            '/studentMemberLoginPage');
                                      },
                                    ),
                                    const SizedBox(width: 30),
                                    ElevatedButton(
                                      style: ElevatedButton
                                          .styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            width: 1, // the thickness
                                            color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                        ),
                                        minimumSize:
                                        const Size(144, 48),
                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(39),
                                        ),
                                      ),
                                      child: Text(
                                          AppLocalizations.of(
                                              context)!
                                              .teacher,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight
                                                  .w600,
                                              fontSize:
                                              localHeight *
                                                  0.03,
                                              color: const Color.fromRGBO(82, 165, 160, 1))),
                                      onPressed: () {
                                        teacherClick == true;
                                        Navigator.pushNamed(
                                            context,
                                            '/teacherLoginPage');
                                      },
                                    ),
                                  ]),
                              SizedBox(
                                height: localHeight * 0.15,
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 70),
                                  MouseRegion(
                                      cursor: SystemMouseCursors
                                          .click,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                '/settingsLanguages');
                                          },
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.translate,
                                              color: Color.fromRGBO(
                                                  141, 167, 167, 1),
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  '/settingsLanguages');
                                            },
                                          ))),
                                  MouseRegion(
                                      cursor: SystemMouseCursors
                                          .click,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                '/settingsLanguages');
                                          },
                                          child: Text(
                                              AppLocalizations.of(
                                                  context)!
                                                  .select_language,
                                              style: Theme
                                                  .of(context)
                                                  .primaryTextTheme
                                                  .bodyLarge
                                                  ?.merge(TextStyle(
                                                  color: const Color
                                                      .fromRGBO(
                                                      48, 145, 139,
                                                      1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight
                                                      .w500,
                                                  fontSize: localHeight *
                                                      0.023)))))
                                ],
                              ),
                              SizedBox(
                                height: localHeight * 0.1,
                              ),
                              Row(
                                  children: [
                                    const SizedBox(width: 70),
                                    RichText(
                                        text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: AppLocalizations.of(context)!.product_of,
                                                style: TextStyle(
                                                    color: const Color
                                                        .fromRGBO(
                                                        48, 145, 139, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w400,
                                                    fontSize: localHeight *
                                                        0.018),
                                              ),
                                              TextSpan(
                                                  text: AppLocalizations.of(context)!.itn_welcome,
                                                  style: TextStyle(
                                                      color: const Color
                                                          .fromRGBO(
                                                          28, 78, 80, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      fontSize: localHeight *
                                                          0.018)),
                                            ]))]),
                            ],
                          )))));
        }
        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: localHeight * 0.100,
                    iconTheme: IconThemeData(color: Colors.white,size: localHeight * 0.04),
                    title:
                    SizedBox(
                        height: localHeight * 0.08,
                        child: Image.asset(
                            "assets/images/qna_logo.png")),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: [
                                Color.fromRGBO(0, 106, 100, 1),
                                Color.fromRGBO(82, 165, 160, 1),
                              ])),
                    ),
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  body: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child:
                          Column(
                          children: [
                          Padding(
                          padding: EdgeInsets.only(left: localHeight * 0.03),
                      child: Column(
                            children: [
                              SizedBox(height: localHeight* 0.2),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // SizedBox(width: localWidth * 0.05),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .welcome,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                28, 78, 80, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.035)),]),
                              SizedBox(
                                height: localHeight * 0.20,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!.continue_as,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                28, 78, 80, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.035)),]),
                              SizedBox(
                                height: localHeight * 0.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style:
                                      ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            width: 1, // the thickness
                                            color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                        ),
                                        minimumSize:
                                        const Size(144, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              39),
                                        ),
                                      ),
                                      child: Text(
                                          AppLocalizations.of(
                                              context)!
                                              .student,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize:
                                              localHeight *
                                                  0.03,
                                              fontWeight: FontWeight
                                                  .w600,
                                              color: const Color.fromRGBO(82, 165, 160, 1))),
                                      onPressed: () async {
                                        Navigator.pushNamed(context,
                                            '/studentMemberLoginPage');
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton
                                          .styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            width: 1, // the thickness
                                            color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                        ),
                                        minimumSize:
                                        const Size(144, 48),
                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(39),
                                        ),
                                      ),
                                      child: Text(
                                          AppLocalizations.of(
                                              context)!
                                              .teacher,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight
                                                  .w600,
                                              fontSize:
                                              localHeight *
                                                  0.03,
                                              color: const Color.fromRGBO(82, 165, 160, 1))),
                                      onPressed: () {
                                        teacherClick == true;
                                        Navigator.pushNamed(
                                            context,
                                            '/teacherLoginPage');
                                      },
                                    ),
                                    SizedBox(width: localWidth * 0.01)
                                  ]),
                              SizedBox(
                                height: localHeight * 0.15,
                              ),
                            ],
                          )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MouseRegion(
                                    cursor: SystemMouseCursors
                                        .click,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context,
                                              '/settingsLanguages');
                                        },
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.translate,
                                            color: Color.fromRGBO(
                                                141, 167, 167, 1),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context,
                                                '/settingsLanguages');
                                          },
                                        ))),
                                MouseRegion(
                                    cursor: SystemMouseCursors
                                        .click,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context,
                                              '/settingsLanguages');
                                        },
                                        child: Text(
                                            AppLocalizations.of(
                                                context)!
                                                .select_language,
                                            style: Theme
                                                .of(context)
                                                .primaryTextTheme
                                                .bodyLarge
                                                ?.merge(TextStyle(
                                                color: const Color
                                                    .fromRGBO(
                                                    48, 145, 139,
                                                    1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight
                                                    .w500,
                                                fontSize: localHeight *
                                                    0.023)))))
                              ],
                            ),
                            SizedBox(
                              height: localHeight * 0.15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: AppLocalizations.of(context)!.product_of,
                                              style: TextStyle(
                                                  color: const Color
                                                      .fromRGBO(
                                                      48, 145, 139, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight
                                                      .w400,
                                                  fontSize: localHeight *
                                                      0.018),
                                            ),
                                            TextSpan(
                                                text: AppLocalizations.of(context)!.itn_welcome,
                                                style: TextStyle(
                                                    color: const Color
                                                        .fromRGBO(
                                                        28, 78, 80, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w700,
                                                    fontSize: localHeight *
                                                        0.018)),
                                          ]))]),
                      ]
                      ))));
        }
      },
    );
  }
}
