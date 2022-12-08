import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
            ()=>  Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const LandingPage(),
              ),
    ));


  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: 100,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image:AssetImage("assets/images/qna_initial_page.png"),
        ),
      ),
    );
  }
}

