import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/opening_page.dart';
import 'package:qna_test/Providers/question_num_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'DataSource/app_user_repo.dart';
import 'Entity/app_user.dart';
import 'Pages/settings_languages.dart';
import 'Pages/stud_guest_assessment.dart';
import 'Pages/welcome_page.dart';
import 'Providers/LanguageChangeProvider.dart';


void main() {
  runApp(
    MultiProvider(providers:[
      ChangeNotifierProvider(create: (_)=> QuestionNumProvider(),),
      ChangeNotifierProvider(create: (_)=> Questions(),),
      ChangeNotifierProvider(create: (_) => LanguageChangeProvider())
    ],
    child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var lang;
  Locale? _locale;

  void setLocale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }
// getData() async {
//
//   AppUser? user =await AppUserRepo().getUserDetail();
//   lang = user?.locale.toString();
// }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //getData();
    return MaterialApp(
      locale: _locale,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        // textTheme: Theme.of(context).textTheme.apply(
        //     fontSizeDelta: lang == 'ta'? -5.0 : 0.0
        // ),
      ),

      home: WelcomePage(setLocale: setLocale),
      //StudGuestAssessment(name: 'Subash',)
     // SplashScreen(setLocale: setLocale,),
    );
  }
}

