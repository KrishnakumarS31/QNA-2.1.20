import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/opening_page.dart';
import 'package:qna_test/Providers/question_num_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'DataSource/app_user_repo.dart';
import 'Entity/app_user.dart';
import 'Providers/LanguageChangeProvider.dart';
import 'Providers/question_prepare_provider.dart';


void main() {
  runApp(
    MultiProvider(providers:[
      ChangeNotifierProvider(create: (_)=> QuestionNumProvider(),),
      ChangeNotifierProvider(create: (_)=> Questions(),),
      ChangeNotifierProvider(create: (_) => LanguageChangeProvider()),
      ChangeNotifierProvider(create: (_)=> QuestionPrepareProvider(),)
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



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }





  void setLocale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }


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

      home: SplashScreen(setLocale: setLocale,),
    );
  }


}

