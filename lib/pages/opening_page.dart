import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qna_test/pages/welcome_page.dart';
import '../DataSource/app_user_repo.dart';
import '../DataSource/http_url.dart';
import '../Entity/app_user.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

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
    Timer(const Duration(seconds: 1), () async {
      AppUser? user = await AppUserRepo().getUserDetail();
      // Navigator.pushNamed(context, '/');
      // Navigator.push(
      //   context,
      //   PageTransition(
      //     type: PageTransitionType.rightToLeft,
      //     child:
      //     //StudentMemberLoginPage(setLocale: widget.setLocale)
      //     const WelcomePage(),
      //   ),
      // );
    });
  }

  // getConnectivity() => subscription = Connectivity()
  //     .onConnectivityChanged
  //     .listen((ConnectivityResult result) async {
  //   isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //   if (!isDeviceConnected && isAlertSet == false) {
  //     showDialogBox();
  //     setState(() {
  //       isAlertSet = true;
  //     });
  //   } else {}
  // });

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return
            // domainName == "https://sssuhe.qnatest.com"
            //     ?
            // AnimatedSplashScreen(
            //   splash: "assets/images/SSSUHE.png",
            //   nextScreen: const WelcomePage(),
            //   splashIconSize: height * 0.4,
            //   centered: true,
            //   backgroundColor: Colors.black,
            //   splashTransition: SplashTransition.fadeTransition,
            // )
            //   // logoWidth:
            //   // constraints.maxWidth > 700
            //   //     ? width * 0.1
            //   //     : width * 0.3,
            //   // logo: Image.asset(
            //   //     "assets/images/SSSUHE.png"),
            //   // backgroundColor: Colors.black,
            //   // showLoader: true,
            //   // loaderColor: const Color.fromRGBO(82, 165, 160, 1),
            //   // navigator: const WelcomePage(),
            //     :
            AnimatedSplashScreen(
              splash: "assets/images/qna_splash_screen.jpg",
              centered: true,
              duration: 1,
              splashIconSize: height,
              nextScreen: const WelcomePage(),
              splashTransition: SplashTransition.fadeTransition,
            );
        }
    );
  }

  // showDialogBox() =>
  //     showCupertinoDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //       title: const Text(
  //         "NO CONNECTION",
  //         style: TextStyle(
  //           color: Color.fromRGBO(82, 165, 160, 1),
  //           fontSize: 25,
  //           fontFamily: "Inter",
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //       content: const Text(
  //         "Please check your internet connectivity",
  //         style: TextStyle(
  //           color: Color.fromRGBO(82, 165, 160, 1),
  //           fontSize: 16,
  //           fontFamily: "Inter",
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () async {
  //             Navigator.pop(context, 'Cancel');
  //             setState(() {
  //               isAlertSet = false;
  //             });
  //             isDeviceConnected =
  //             await InternetConnectionChecker().hasConnection;
  //             if (!isDeviceConnected) {
  //               showDialogBox();
  //               setState(() {
  //                 isAlertSet = true;
  //               });
  //             }
  //           },
  //           child: const Text(
  //             "OK",
  //             style: TextStyle(
  //               color: Color.fromRGBO(82, 165, 160, 1),
  //               fontSize: 20,
  //               fontFamily: "Inter",
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         )
  //       ],
  //     ));

}
