import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Components/end_drawer_menu_pre_login.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:universal_internet_checker/universal_internet_checker.dart';
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
  final UniversalInternetChecker _internetChecker = UniversalInternetChecker();
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
  }
  getConnectivity() {
    subscription = _internetChecker.onConnectionChange.listen((connected) async {
      _message = connected == ConnectionStatus.online
          ? 'Connected'
          : 'Not Connected';
      if (_message=='Not Connected') {
        setState(() {
          isAlertSet=true;
        });
        showDialogBox();
      } else {
          isAlertSet?Navigator.of(context).pop():print("");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription?.cancel();
    super.dispose();
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) =>  CupertinoAlertDialog(
        title: Text(
          AppLocalizations.of(context)!.no_connection,
          //"NO CONNECTION",
          style: const TextStyle(
            color: Color.fromRGBO(82, 165, 160, 1),
            fontSize: 25,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          AppLocalizations.of(context)!.check_internet,
          //"Please check your internet connectivity",
          style: const TextStyle(
            color: Color.fromRGBO(82, 165, 160, 1),
            fontSize: 16,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;
    double localWidth = MediaQuery.of(context).size.width;
    // const iconAsset = "assets/images/bg.png";
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 500) {
          return Center(
              child: SizedBox(
              width: 400,
              child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: localHeight,
                                    width: 400,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: localHeight * 0.43,
                                          width: 400,
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
                                                bottom: Radius.elliptical(400, localHeight * 0.40)),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: localHeight * 0.05),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(width: 400 * 0.04),
                                                  Container(
                                                    width: 400 * 0.3,
                                                    height: MediaQuery.of(context).size.height * 0.04,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image:
                                                        AssetImage('assets/images/itne_logo.png'),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: localHeight * 0.08),
                                              Container(
                                                width: 400 * 0.53,
                                                height: localHeight * 0.135,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image:
                                                    AssetImage('assets/images/qna_logo.png'),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: localHeight * 0.01),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: localHeight * 0.06,
                                        ),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .welcome,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.035)),
                                        SizedBox(
                                          height: localHeight * 0.03,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 400 / 15,
                                              right: 400 / 15),
                                          child: Column(children: [
                                            SizedBox(
                                              height: localHeight * 0.02,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 400 / 15,
                                                  right: 400 / 15),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: ElevatedButton(
                                                  style:
                                                  ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    minimumSize:
                                                    const Size(280, 48),
                                                    shape:
                                                    RoundedRectangleBorder(
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
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.white)),
                                                  onPressed: () async {
                                                    Navigator.pushNamed(context, '/studentSelectionPage');
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
                                          padding: const EdgeInsets.only(
                                              left: 400 / 15,
                                              right: 400 / 15),
                                          child: Column(children: [
                                            SizedBox(
                                              height: localHeight * 0.02,
                                            ),
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 400 / 15,
                                                    right: 400 / 15),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                      const Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                      minimumSize:
                                                      const Size(280, 48),
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
                                                            fontWeight: FontWeight.w600,
                                                            fontSize:
                                                            localHeight *
                                                                0.03,
                                                            color:
                                                            Colors.white)),
                                                    onPressed: () {
                                                      teacherClick == true;
                                                      Navigator.pushNamed(context, '/teacherLoginPage');
                                                    },
                                                  ),
                                                )),
                                          ]),
                                        ),
                                        SizedBox(
                                          height: localHeight * 0.05,
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
                                                            fontSize: localHeight * 0.023)))))
                                          ],
                                        ),
                                      ],
                                    ))
                              ]),
                        ],
                      ))))));
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
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: localHeight,
                                    width: localWidth,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: localHeight * 0.43,
                                          width: localWidth,
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
                                                bottom: Radius.elliptical(localWidth, localHeight * 0.40)),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: localHeight * 0.15),
                                              // Align(
                                              //   alignment: Alignment.center,
                                              //   child: Container(
                                              //     width: localWidth * 0.50,
                                              //     height: localHeight * 0.20,
                                              //     decoration: const BoxDecoration(
                                              //       image: DecorationImage(
                                              //         fit: BoxFit.fill,
                                              //         image:
                                              //         AssetImage('assets/images/qna_logo.png'),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                              SizedBox(height: localHeight * 0.01),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: localHeight * 0.06,
                                        ),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .welcome,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.035)),
                                        SizedBox(
                                          height: localHeight * 0.03,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: localWidth / 15,
                                              right: localWidth / 15),
                                          child: Column(children: [
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                    minimumSize:
                                                        const Size(280, 48),
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.white)),
                                                  onPressed: () async {
                                                    Navigator.pushNamed(context, '/studentSelectionPage');
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
                                              left: localWidth / 15,
                                              right: localWidth / 15),
                                          child: Column(children: [
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
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color.fromRGBO(
                                                              82, 165, 160, 1),
                                                      minimumSize:
                                                          const Size(280, 48),
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
                                                            fontWeight: FontWeight.w600,
                                                            fontSize:
                                                                localHeight *
                                                                    0.03,
                                                            color:
                                                                Colors.white)),
                                                    onPressed: () {
                                                      teacherClick == true;
                                                        Navigator.pushNamed(context, '/teacherLoginPage');
                                                    },
                                                  ),
                                                )),
                                          ]),
                                        ),
                                        SizedBox(
                                          height: localHeight * 0.05,
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
                                                            fontSize: localHeight * 0.023)))))
                                          ],
                                        ),
                                      ],
                                    ))
                              ]),
                          Positioned(
                            left: localWidth * 0.04,
                            top: localHeight * 0.055,
                            child: Container(
                              width: 400 * 0.3,
                              height: MediaQuery.of(context).size.height * 0.04,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      AssetImage('assets/images/itne_logo.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: localWidth * 0.25,
                            top: localHeight * 0.15,
                            child: Container(
                              width: localWidth * 0.5,
                              height: localHeight * 0.135,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image:
                                      AssetImage('assets/images/qna_logo.png'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))));
        }
      },
    );
  }
}
