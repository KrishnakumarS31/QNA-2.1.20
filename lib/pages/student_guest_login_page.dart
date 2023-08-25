import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/custom_incorrect_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Components/end_drawer_menu_pre_login.dart';

class StudentGuestLogin extends StatefulWidget {
  const StudentGuestLogin({super.key});

  @override
  StudentGuestLoginState createState() => StudentGuestLoginState();
}

enum SingingCharacter { guest, member }

class StudentGuestLoginState extends State<StudentGuestLogin> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController reNameController = TextEditingController();
  TextEditingController rollNumController = TextEditingController();
  bool agree = false;
  String name = '';
  final TextInputFormatter _numericFormatter =
      FilteringTextInputFormatter.digitsOnly;

  Future<void> _launchUrlTerms() async {
    final Uri url = Uri.parse('https://www.itneducation.com/termsofservice');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchUrlPrivacy() async {
    final Uri url = Uri.parse('https://www.itneducation.com/privacypolicy');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.clear();
    rollNumController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 960 && constraints.maxWidth >= 500) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        size: height * 0.05),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: height * 0.06,
                        color: const Color.fromRGBO(28, 78, 80, 1),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    toolbarHeight: height * 0.100,
                    centerTitle: true,
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.guestCaps,
                            //"Guest Student",
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: height * 0.25),
                          Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: kElevationToShadow[4],
                                ),
                                width: width * 0.9,
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(height: height * 0.05),
                                          SizedBox(
                                              width: width * 0.75,
                                              child: TextFormField(
                                                keyboardType: TextInputType.text,
                                                controller: nameController,
                                                onChanged: (val) {
                                                  formKey.currentState!.validate();
                                                },
                                                decoration: InputDecoration(
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                  floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                  hintText:
                                                  AppLocalizations.of(context)!
                                                      .your_name,
                                                  label: Text(
                                                    AppLocalizations.of(context)!
                                                        .name_userId,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: height * 0.0225),
                                                  ),
                                                  hintStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocalizations.of(
                                                        context)!
                                                        .name_uId_helper;
                                                  } else if (!RegExp(
                                                      r'^([A-Za-z0-9]+|([A-Za-z]+\s[A-Za-z]+))$')
                                                      .hasMatch(value)) {
                                                    return AppLocalizations.of(
                                                        context)!
                                                        .name_special_restrict;
                                                  }
                                                  return null;
                                                },
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.06),
                                      SizedBox(
                                          width: width * 0.75,
                                          child: TextFormField(
                                            controller: rollNumController,
                                            inputFormatters: [_numericFormatter],
                                            onChanged: (val) {
                                              formKey.currentState!.validate();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'If you do not know Organization ID, Enter 0';
                                              } else if (!RegExp(r'\d')
                                                  .hasMatch(value)) {
                                                return "Incorrect Organization ID. Enter again.";
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium,
                                              label: Text(
                                                "Organization ID",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.0225),
                                              ),
                                              helperText:
                                              AppLocalizations.of(context)!
                                                  .organization_helper,
                                              helperStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.015),
                                              hintText:
                                              AppLocalizations.of(context)!
                                                  .enter_id,
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.02),
                                            ),
                                          )),
                                      SizedBox(height: height * 0.07),
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(height: height * 0.04),
                          Row(children: [
                            SizedBox(width: width * 0.1),
                            Text(
                              AppLocalizations.of(context)!.privacy_terms,
                              style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.017),
                            ),
                          ]),
                          SizedBox(height: height * 0.02),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: width * 0.08),
                              Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  activeColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                                  fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return const Color.fromRGBO(
                                              82, 165, 160, 1);
                                        }
                                        return const Color.fromRGBO(
                                            82, 165, 160, 1);
                                      }),
                                  value: agree,
                                  onChanged: (val) {
                                    setState(() {
                                      agree = val!;
                                      if (agree) {}
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: width * 0.05),
                              Flexible(
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:
                                        AppLocalizations.of(context)!.agree_msg,
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            color:
                                            const Color.fromRGBO(51, 51, 51, 1),
                                            fontFamily: "Inter"),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .privacy_Policy,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = _launchUrlPrivacy,
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.underline,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: "Inter"),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!.and,
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            color:
                                            const Color.fromRGBO(51, 51, 51, 1),
                                            fontFamily: "Inter"),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .terms_of_services,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => _launchUrlTerms(),
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.underline,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: "Inter"),
                                      ),
                                    ])),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_circle_right),
                            iconSize: height * 0.06,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            onPressed: () {
                              if (agree) {
                                if (formKey.currentState!.validate()) {
                                  name = nameController.text;
                                  // Navigator.pushNamed(
                                  //     context,
                                  //     '/studGuestAssessment',
                                  //     arguments: name);
                                  Navigator.of(context).pushNamed(
                                      '/studGuestAssessment',
                                      arguments: name);
                                  nameController.clear();
                                  rollNumController.clear();
                                }
                              } else {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: CustomDialog(
                                        title: AppLocalizations.of(context)!
                                            .alert_popup,
                                        content: AppLocalizations.of(context)!
                                            .agree_privacy_terms,
                                        button: AppLocalizations.of(context)!
                                            .retry),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: height * 0.15),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .product_of,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                48, 145, 139, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.018),
                                      ),
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .itn_welcome,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: height * 0.018)),
                                    ]))
                              ]),
                        ]),
                  )));
        } else if (constraints.maxWidth > 960) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        size: height * 0.05),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 40.0,
                        color: Color.fromRGBO(28, 78, 80, 1),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    toolbarHeight: height * 0.100,
                    centerTitle: true,
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.guestCaps,
                            //"Guest Student",
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: height * 0.25),
                          Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: kElevationToShadow[4],
                                ),
                                width: width * 0.35,
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(height: height * 0.05),
                                          SizedBox(
                                              width: width * 0.32,
                                              child: TextFormField(
                                                keyboardType: TextInputType.text,
                                                controller: nameController,
                                                onChanged: (val) {
                                                  formKey.currentState!.validate();
                                                },
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                  hintText:
                                                  AppLocalizations.of(context)!
                                                      .your_name,
                                                  label: Text(
                                                    AppLocalizations.of(context)!
                                                        .name_userId,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: height * 0.025),
                                                  ),
                                                  hintStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocalizations.of(
                                                        context)!
                                                        .name_uId_helper;
                                                  } else if (!RegExp(
                                                      r'^([A-Za-z0-9]+|([A-Za-z]+\s[A-Za-z]+))$')
                                                      .hasMatch(value)) {
                                                    return AppLocalizations.of(
                                                        context)!
                                                        .name_special_restrict;
                                                  }
                                                  return null;
                                                },
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.06),
                                      SizedBox(
                                          width: width * 0.32,
                                          child: TextFormField(
                                            controller: rollNumController,
                                            inputFormatters: [_numericFormatter],
                                            onChanged: (val) {
                                              formKey.currentState!.validate();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'If you do not know Organization ID, Enter 0';
                                              } else if (!RegExp(r'\d')
                                                  .hasMatch(value)) {
                                                return "Incorrect Organization ID. Enter again.";
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium,
                                              label: Text(
                                                "Organization ID",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.025),
                                              ),
                                              helperText:
                                              AppLocalizations.of(context)!
                                                  .organization_helper,
                                              helperStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.015),
                                              hintText:
                                              AppLocalizations.of(context)!
                                                  .enter_id,
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.025),
                                            ),
                                          )),
                                      SizedBox(height: height * 0.07),
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(height: height * 0.04),
                          Row(children: [
                            SizedBox(width: width * 0.33),
                            Text(
                              AppLocalizations.of(context)!.privacy_terms,
                              style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.02),
                            ),
                          ]),
                          SizedBox(height: height * 0.02),
                          Row(
                            children: [
                              SizedBox(width: width * 0.33),
                              Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  activeColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                                  fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return const Color.fromRGBO(
                                              82, 165, 160, 1);
                                        }
                                        return const Color.fromRGBO(
                                            82, 165, 160, 1);
                                      }),
                                  value: agree,
                                  onChanged: (val) {
                                    setState(() {
                                      agree = val!;
                                      if (agree) {}
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: width * 0.015),
                              Flexible(
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:
                                        AppLocalizations.of(context)!.agree_msg,
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            color:
                                            const Color.fromRGBO(51, 51, 51, 1),
                                            fontFamily: "Inter"),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .privacy_Policy,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = _launchUrlPrivacy,
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.underline,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: "Inter"),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!.and,
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            color:
                                            const Color.fromRGBO(51, 51, 51, 1),
                                            fontFamily: "Inter"),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .terms_of_services,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => _launchUrlTerms(),
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.underline,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: "Inter"),
                                      ),
                                    ])),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_circle_right),
                            iconSize: height * 0.06,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            onPressed: () {
                              if (agree) {
                                if (formKey.currentState!.validate()) {
                                  name = nameController.text;
                                  // Navigator.pushNamed(
                                  //     context,
                                  //     '/studGuestAssessment',
                                  //     arguments: name);
                                  Navigator.of(context).pushNamed(
                                      '/studGuestAssessment',
                                      arguments: name);
                                  nameController.clear();
                                  rollNumController.clear();
                                }
                              } else {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: CustomDialog(
                                        title: AppLocalizations.of(context)!
                                            .alert_popup,
                                        content: AppLocalizations.of(context)!
                                            .agree_privacy_terms,
                                        button: AppLocalizations.of(context)!
                                            .retry),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: height * 0.1),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .product_of,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                48, 145, 139, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.018),
                                      ),
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .itn_welcome,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: height * 0.018)),
                                    ]))
                              ]),
                        ]),
                  )));
        } else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        size: height * 0.05),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 40.0,
                        color: Color.fromRGBO(28, 78, 80, 1),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    toolbarHeight: height * 0.100,
                    centerTitle: true,
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.guestCaps,
                            //"Guest Student",
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: height * 0.25),
                          Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: kElevationToShadow[4],
                                ),
                                width: width * 0.9,
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(height: height * 0.05),
                                          SizedBox(
                                              width: width * 0.75,
                                              child: TextFormField(
                                                keyboardType: TextInputType.text,
                                                controller: nameController,
                                                onChanged: (val) {
                                                  formKey.currentState!.validate();
                                                },
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                  hintText:
                                                  AppLocalizations.of(context)!
                                                      .your_name,
                                                  label: Text(
                                                    AppLocalizations.of(context)!
                                                        .name_userId,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: height * 0.02),
                                                  ),
                                                  hintStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocalizations.of(
                                                        context)!
                                                        .name_uId_helper;
                                                  } else if (!RegExp(
                                                      r'^([A-Za-z0-9]+|([A-Za-z]+\s[A-Za-z]+))$')
                                                      .hasMatch(value)) {
                                                    return AppLocalizations.of(
                                                        context)!
                                                        .name_special_restrict;
                                                  }
                                                  return null;
                                                },
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.03),
                                      SizedBox(
                                          width: width * 0.75,
                                          child: TextFormField(
                                            controller: rollNumController,
                                            inputFormatters: [_numericFormatter],
                                            onChanged: (val) {
                                              formKey.currentState!.validate();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'If you do not know Organization ID, Enter 0';
                                              } else if (!RegExp(r'\d')
                                                  .hasMatch(value)) {
                                                return "Incorrect Organization ID. Enter again.";
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium,
                                              label: Text(
                                                "Organization ID",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.02),
                                              ),
                                              helperText:
                                              AppLocalizations.of(context)!
                                                  .organization_helper,
                                              helperStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.015),
                                              hintText:
                                              AppLocalizations.of(context)!
                                                  .enter_id,
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.02),
                                            ),
                                          )),
                                      SizedBox(height: height * 0.07),
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(height: height * 0.04),
                          Row(children: [
                            SizedBox(width: width * 0.08),
                            Text(
                              AppLocalizations.of(context)!.privacy_terms,
                              style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.017),
                            ),
                          ]),
                          SizedBox(height: height * 0.02),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: width * 0.05),
                              Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  activeColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                                  fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return const Color.fromRGBO(
                                              82, 165, 160, 1);
                                        }
                                        return const Color.fromRGBO(
                                            82, 165, 160, 1);
                                      }),
                                  value: agree,
                                  onChanged: (val) {
                                    setState(() {
                                      agree = val!;
                                      if (agree) {}
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: width * 0.02),
                              Flexible(
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:
                                        AppLocalizations.of(context)!.agree_msg,
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            color:
                                            const Color.fromRGBO(51, 51, 51, 1),
                                            fontFamily: "Inter"),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .privacy_Policy,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = _launchUrlPrivacy,
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.underline,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: "Inter"),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!.and,
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            color:
                                            const Color.fromRGBO(51, 51, 51, 1),
                                            fontFamily: "Inter"),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .terms_of_services,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => _launchUrlTerms(),
                                        style: TextStyle(
                                            fontSize: height * 0.018,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.underline,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: "Inter"),
                                      ),
                                    ])),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_circle_right),
                            iconSize: height * 0.06,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            onPressed: () {
                              if (agree) {
                                if (formKey.currentState!.validate()) {
                                  name = nameController.text;
                                  // Navigator.pushNamed(
                                  //     context,
                                  //     '/studGuestAssessment',
                                  //     arguments: name);
                                  Navigator.of(context).pushNamed(
                                      '/studGuestAssessment',
                                      arguments: name);
                                  nameController.clear();
                                  rollNumController.clear();
                                }
                              } else {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: CustomDialog(
                                        title: AppLocalizations.of(context)!
                                            .alert_popup,
                                        content: AppLocalizations.of(context)!
                                            .agree_privacy_terms,
                                        button: AppLocalizations.of(context)!
                                            .retry),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: height * 0.1),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .product_of,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                48, 145, 139, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.018),
                                      ),
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .itn_welcome,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: height * 0.018)),
                                    ]))
                              ]),
                        ]),
                  )));
        }
      },
    );
  }
}
