import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/opening_page.dart';
import 'package:qna_test/Providers/question_num_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter/foundation.dart';
import 'Providers/LanguageChangeProvider.dart';
import 'Providers/create_assessment_provider.dart';
import 'Providers/edit_assessment_provider.dart';
import 'Providers/new_question_provider.dart';
import 'Providers/question_prepare_provider.dart';
import 'package:qna_test/Pages/welcome_page.dart';

import 'Providers/question_prepare_provider_final.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuestionNumProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Questions(),
        ),
        ChangeNotifierProvider(create: (_) => LanguageChangeProvider()),
        ChangeNotifierProvider(
          create: (_) => QuestionPrepareProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuestionPrepareProviderFinal(),
        ),
        ChangeNotifierProvider(
          create: (_) => CreateAssessmentProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EditAssessmentProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewQuestionProvider(),
        ),

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

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: _locale,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        ),
        home:
            // defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.macOS
            //     ?
            WelcomePage(setLocale: setLocale)
        //  :
        // SplashScreen(setLocale: setLocale)
        );
  }
}
