import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
          image:AssetImage("assets/images/qna_splash_page.png"),
        ),
      ),
    );
  }
}

