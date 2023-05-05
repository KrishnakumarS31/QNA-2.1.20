import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:qna_test/Pages/welcome_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../DataSource/app_user_repo.dart';
import '../DataSource/http_url.dart';
import '../Entity/app_user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.setLocale}) : super(key: key);
  final void Function(Locale locale) setLocale;

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
    //getConnectivity();
    Timer(const Duration(seconds: 1), () async {
      AppUser? user = await AppUserRepo().getUserDetail();
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child:
          //StudentMemberLoginPage(setLocale: widget.setLocale)
          const WelcomePage(),
        ),
      );
      //  if (user != null) {
      //widget.setLocale(Locale.fromSubtags(languageCode: user.locale));
      //Navigator.of(context).pushReplacementNamed('/');
      // }
      // else {
      //   Navigator.pushNamed(context, '/settingsLanguages');
      // Navigator.push(
      //   context,
      //   PageTransition(
      //     type: PageTransitionType.rightToLeft,
      //     child: SettingsLanguages(),
      //   ),
      // );
      // }
    });
  }

  getConnectivity() => subscription = Connectivity()
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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return
            domainName == "https://sssuhe.qnatest.com"
                ? EasySplashScreen(
              logoWidth:
              constraints.maxWidth > 700
                  ? width * 0.1
                  : width * 0.3,
              logo: Image.asset(
                  "assets/images/SSSUHE.png"),
              backgroundColor: Colors.white,
              showLoader: true,
              loaderColor: const Color.fromRGBO(82, 165, 160, 1),
              navigator: const WelcomePage(),
            )

            // Container(
            //   width: width,
            //   height: height,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       fit: BoxFit.fill,
            //       image: AssetImage("assets/images/sssuhe_splash.png"),
            //     ),
            //   ),
            // )
            // Container(
            //   width: width,
            //   height: height,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       fit: BoxFit.fill,
            //       image: AssetImage("assets/images/sssuhe_splash.png"),
            //     ),
            //   ),
            // )
                :   EasySplashScreen(
              logoWidth:
              constraints.maxWidth > 700
                  ? width * 0.15
                  : width * 0.7,
              logo: Image.asset(
                  "assets/images/qna_splash_screen.jpg"),
              //backgroundColor: Colors.white,
              showLoader: true,
              loaderColor: const Color.fromRGBO(82, 165, 160, 1),
              navigator: const WelcomePage(),
            );

          //   Container(
          //   width: width,
          //   height: height,
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       fit: BoxFit.fill,
          //       image: AssetImage("assets/images/qna_splash_screen.jpg"),
          //     ),
          //   ),
          // );
        }
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
      ));}
