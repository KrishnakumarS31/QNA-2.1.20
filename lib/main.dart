import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Providers/question_num_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/pages/opening_page.dart';
import 'DataSource/app_user_repo.dart';
import 'Entity/app_user.dart';
import 'Providers/LanguageChangeProvider.dart';
import 'Providers/create_assessment_provider.dart';
import 'Providers/edit_assessment_provider.dart';
import 'Providers/new_question_provider.dart';
import 'Providers/question_prepare_provider.dart';
import 'my_routers.dart';
import 'Providers/question_prepare_provider_final.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var lang;
  Locale? _locale;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    AppUser? user = await AppUserRepo().getUserDetail();
    if(user?.locale==null){
    }
    else{
      Provider.of<LanguageChangeProvider>(context, listen: false).changeLocale(user!.locale);
      //context.read<LanguageChangeProvider>().changeLocale(user!.locale);
    }
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QNA Test",
      locale: Locale(context.watch<LanguageChangeProvider>().currentLocale),
      onGenerateRoute: MyRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        ),
        home:
       // defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.macOS || kIsWeb
           // ? const WelcomePage()
           // :
        SplashScreen(setLocale: setLocale)
      //initialRoute: '/',
       //  initialRoute: WelcomePage.id,
       // routes: {
       //  WelcomePage.id: (context) => WelcomePage(setLocale: setLocale),},

      //  home:
        // defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.macOS
        //     ?
       // WelcomePage(setLocale: setLocale)
      //  :
      // SplashScreen(setLocale: setLocale)
    );
  }
}