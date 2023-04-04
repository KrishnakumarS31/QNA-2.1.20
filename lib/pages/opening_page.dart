import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/settings_languages.dart';
import 'package:qna_test/Pages/welcome_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../DataSource/app_user_repo.dart';
import '../DataSource/http_url.dart';
import '../Entity/app_user.dart';
import '../Providers/LanguageChangeProvider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key,}) : super(key: key);


  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  int i = 0;
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConectivity();
    Timer(const Duration(seconds: 1), () async {
      AppUser? user = await AppUserRepo().getUserDetail();
      if (user != null) {
        Provider.of<LanguageChangeProvider>(context, listen: false).changeLocale(user!.locale);
        Navigator.pushNamed(context, '/');
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.rightToLeft,
        //     child:
        //         //StudentMemberLoginPage(setLocale: widget.setLocale)
        //         WelcomePage(),
        //   ),
        // );
      } else {
        Navigator.pushNamed(context, '/settingsLanguages');
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.rightToLeft,
        //     child: SettingsLanguages(),
        //   ),
        // );
      }
    });
  }

  getConectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() {
            isAlertSet = true;
          });
        } else {}
      });

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      domainName == "https://sssuhe.qnatest.com"
      ?  Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/sssuhe_splash.png"),
          ),
        ),
      )
      : Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/qna_splash_screen.jpg"),
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text(
              "NO CONNECTION",
              style: TextStyle(
                color: Color.fromRGBO(82, 165, 160, 1),
                fontSize: 25,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
            content: const Text(
              "Please check your internet connectivity",
              style: TextStyle(
                color: Color.fromRGBO(82, 165, 160, 1),
                fontSize: 16,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() {
                    isAlertSet = false;
                  });
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected) {
                    showDialogBox();
                    setState(() {
                      isAlertSet = true;
                    });
                  }
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Color.fromRGBO(82, 165, 160, 1),
                    fontSize: 20,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ));
}
