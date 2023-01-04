import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:qna_test/Pages/settings_languages.dart';
import 'package:qna_test/Pages/welcome_page.dart';


import '../DataSource/app_user_repo.dart';
import '../Entity/app_user.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,required this.setLocale
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {
int i=0;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
            () async
            {
              AppUser? user = await AppUserRepo().getUserDetail();
              if (user != null) {
                widget.setLocale(Locale.fromSubtags(languageCode: user.locale));
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child:
                    //ResetPassword()
                    WelcomePage(setLocale: widget.setLocale),
                  ),
                );
              }
              else{
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: SettingsLanguages(setLocale: widget.setLocale),
                  ),
                );
              }
            });


  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: 100,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image:AssetImage("assets/images/qna-splash-page-final.jpg"),
        ),
      ),
    );
  }
}