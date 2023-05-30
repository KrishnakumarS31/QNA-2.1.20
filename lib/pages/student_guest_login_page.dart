import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/custom_incorrect_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Components/end_drawer_menu_pre_login.dart';

class StudentGuestLogin extends StatefulWidget {
  const StudentGuestLogin({super.key,});


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
        if (constraints.maxWidth > 400) {
          print("yes its true");
          return Center(
            child: Container(
              width: 400,
              child: WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                      extendBodyBehindAppBar: true,
                      appBar: AppBar(
                        systemOverlayStyle: const SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                        ),
                        elevation: 0,
                        leading: IconButton(
                          icon: const Icon(
                            Icons.chevron_left,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      endDrawer: const EndDrawerMenuPreLogin(),
                      backgroundColor: Colors.white,
                      body: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: height * 0.3,
                                width: 400,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromRGBO(0, 106, 100, 1),
                                      Color.fromRGBO(82, 165, 160, 1)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                      bottom:
                                      Radius.elliptical(400, height * 0.30)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(height: 20),
                                    Center(
                                      child: SizedBox(
                                        height: height * 0.25,
                                        width: 400 * 0.22,
                                        child: Image.asset(
                                            "assets/images/question_mark_logo.png"),
                                      ),
                                    ),
                                    Container(
                                      width: 400 * 0.03,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              Text(
                                '${AppLocalizations.of(context)!.guestCaps} ${AppLocalizations.of(context)!.studentCaps}',
                                style: TextStyle(
                                  fontSize: height * 0.035,
                                  color: const Color.fromRGBO(
                                      28, 78, 80, 1),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: height * 0.07),
                              SizedBox(
                                width: 400 * 0.8,
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: AppLocalizations.of(context)!
                                                        .name,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: height * 0.017),
                                                  ),
                                                  TextSpan(
                                                      text: "\t*",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              219, 35, 35, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: height * 0.017)),
                                                ])),
                                          ),
                                          SizedBox(
                                            height: height * 0.0001,
                                          ),
                                          Align(
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                keyboardType: TextInputType.text,
                                                controller: nameController,
                                                onChanged: (val) {
                                                  formKey.currentState!.validate();
                                                },
                                                decoration: InputDecoration(
                                                  hintText:
                                                  AppLocalizations.of(context)!
                                                      .your_name,
                                                  hintStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                  prefixIcon: Icon(
                                                    Icons.account_box_outlined,
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    size: height * 0.03,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocalizations.of(
                                                        context)!
                                                        .enter_your_name;
                                                  } else if (!RegExp(r'^[a-z A-Z]+$')
                                                      .hasMatch(value)) {
                                                    return AppLocalizations.of(
                                                        context)!
                                                        .enter_valid_name;
                                                  }
                                                  return null;
                                                },
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.06),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: AppLocalizations.of(context)!
                                                        .registrationIdRollNum,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: height * 0.017),
                                                  ),
                                                  // TextSpan(
                                                  //     text: "\t*",
                                                  //     style: TextStyle(
                                                  //         color: const Color.fromRGBO(
                                                  //             219, 35, 35, 1),
                                                  //         fontFamily: 'Inter',
                                                  //         fontWeight: FontWeight.w600,
                                                  //         fontSize: height * 0.017)),
                                                ])),
                                          ),
                                          SizedBox(
                                            height: height * 0.0001,
                                          ),
                                          Align(
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                controller: rollNumController,
                                                onChanged: (val) {
                                                  //formKey.currentState!.validate();
                                                },
                                                // validator: (value) {
                                                //   if (value!.isEmpty ||
                                                //       !RegExp(r'^[a-z A-Z\d]+$')
                                                //           .hasMatch(value)) {
                                                //     return AppLocalizations.of(context)!
                                                //         .enter_id;
                                                //   } else {
                                                //     return null;
                                                //   }
                                                // },
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                  hintText:
                                                  AppLocalizations.of(context)!
                                                      .enter_id,
                                                  hintStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                  prefixIcon: Icon(
                                                      Icons.assignment_ind_outlined,
                                                      color: const Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                      size: height * 0.03),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.07),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: AppLocalizations.of(context)!
                                                    .privacy_terms,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.017),
                                              ),
                                              TextSpan(
                                                  text: "\t*",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          219, 35, 35, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: height * 0.017)),
                                            ])),
                                      ),
                                      SizedBox(height: height * 0.02),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              activeColor: const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              fillColor: MaterialStateProperty
                                                  .resolveWith<Color>((states) {
                                                if (states.contains(
                                                    MaterialState.selected)) {
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
                                          SizedBox(width: 400 * 0.05),
                                          Flexible(
                                            child: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: AppLocalizations.of(context)!
                                                        .agree_msg,
                                                    style: TextStyle(
                                                        fontSize: height * 0.018,
                                                        fontWeight: FontWeight.w400,
                                                        color: const Color.fromRGBO(
                                                            51, 51, 51, 1),
                                                        fontFamily: "Inter"),
                                                  ),
                                                  TextSpan(
                                                    text: AppLocalizations.of(context)!
                                                        .privacy_Policy,
                                                    recognizer: TapGestureRecognizer()..onTap = _launchUrlPrivacy,
                                                    style: TextStyle(
                                                        fontSize: height * 0.018,
                                                        fontWeight: FontWeight.w400,
                                                        decoration:
                                                        TextDecoration.underline,
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontFamily: "Inter"),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                    AppLocalizations.of(context)!.and,
                                                    style: TextStyle(
                                                        fontSize: height * 0.018,
                                                        fontWeight: FontWeight.w400,
                                                        color: const Color.fromRGBO(
                                                            51, 51, 51, 1),
                                                        fontFamily: "Inter"),
                                                  ),
                                                  TextSpan(
                                                    text: AppLocalizations.of(context)!.terms_of_services,
                                                    recognizer: TapGestureRecognizer()..onTap = () => _launchUrlTerms(),
                                                    style: TextStyle(
                                                        fontSize: height * 0.018,
                                                        fontWeight: FontWeight.w400,
                                                        decoration:
                                                        TextDecoration.underline,
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontFamily: "Inter"),
                                                  ),
                                                  // TextSpan(
                                                  //   text: AppLocalizations.of(context)!
                                                  //       .services,
                                                  //   recognizer: TapGestureRecognizer()..onTap = () => _launchUrlTerms(),
                                                  //   style: TextStyle(
                                                  //       fontSize: height * 0.018,
                                                  //       fontWeight: FontWeight.w400,
                                                  //       decoration:
                                                  //       TextDecoration.underline,
                                                  //       color: const Color.fromRGBO(
                                                  //           82, 165, 160, 1),
                                                  //       fontFamily: "Inter"),
                                                  // ),
                                                ])),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.04),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                                  minimumSize: const Size(280, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39),
                                  ),
                                ),
                                onPressed: () {
                                  if (agree) {
                                    if (formKey.currentState!.validate()) {
                                      name = nameController.text;
                                      // Navigator.pushNamed(
                                      //     context,
                                      //     '/studGuestAssessment',
                                      //     arguments: name);
                                      Navigator.of(context).pushNamed('/studGuestAssessment',arguments: name);
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
                                                .agree_privacy_terms,
                                            content:
                                            AppLocalizations.of(context)!.error,
                                            button: AppLocalizations.of(context)!
                                                .retry),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.login,
                                  style: TextStyle(
                                      fontSize: height * 0.03,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                            ]),
                      ))),
            ),
          );
        }
        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                    ),
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: height * 0.3,
                            width: width,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(0, 106, 100, 1),
                                  Color.fromRGBO(82, 165, 160, 1)
                                ],
                              ),
                              borderRadius: BorderRadius.vertical(
                                  bottom:
                                  Radius.elliptical(width, height * 0.30)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 20),
                                Center(
                                  child: SizedBox(
                                    height: height * 0.25,
                                    width: width * 0.22,
                                    child: Image.asset(
                                        "assets/images/question_mark_logo.png"),
                                  ),
                                ),
                                Container(
                                  width: width * 0.03,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          Text(
                            '${AppLocalizations.of(context)!.guestCaps} ${AppLocalizations.of(context)!.studentCaps}',
                            style: TextStyle(
                              fontSize: height * 0.035,
                              color: const Color.fromRGBO(
                                  28, 78, 80, 1),
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: height * 0.07),
                          SizedBox(
                            width: width * 0.8,
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: AppLocalizations.of(context)!
                                                    .name,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.017),
                                              ),
                                              TextSpan(
                                                  text: "\t*",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          219, 35, 35, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: height * 0.017)),
                                            ])),
                                      ),
                                      SizedBox(
                                        height: height * 0.0001,
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            controller: nameController,
                                            onChanged: (val) {
                                              formKey.currentState!.validate();
                                            },
                                            decoration: InputDecoration(
                                              hintText:
                                              AppLocalizations.of(context)!
                                                  .your_name,
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.02),
                                              prefixIcon: Icon(
                                                Icons.account_box_outlined,
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                size: height * 0.03,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                    context)!
                                                    .enter_your_name;
                                              } else if (!RegExp(r'^[a-z A-Z]+$')
                                                  .hasMatch(value)) {
                                                return AppLocalizations.of(
                                                    context)!
                                                    .enter_valid_name;
                                              }
                                              return null;
                                            },
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.06),
                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: AppLocalizations.of(context)!
                                                    .registrationIdRollNum,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.017),
                                              ),
                                              // TextSpan(
                                              //     text: "\t*",
                                              //     style: TextStyle(
                                              //         color: const Color.fromRGBO(
                                              //             219, 35, 35, 1),
                                              //         fontFamily: 'Inter',
                                              //         fontWeight: FontWeight.w600,
                                              //         fontSize: height * 0.017)),
                                            ])),
                                      ),
                                      SizedBox(
                                        height: height * 0.0001,
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: TextFormField(
                                            controller: rollNumController,
                                            onChanged: (val) {
                                              //formKey.currentState!.validate();
                                            },
                                            // validator: (value) {
                                            //   if (value!.isEmpty ||
                                            //       !RegExp(r'^[a-z A-Z\d]+$')
                                            //           .hasMatch(value)) {
                                            //     return AppLocalizations.of(context)!
                                            //         .enter_id;
                                            //   } else {
                                            //     return null;
                                            //   }
                                            // },
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText:
                                              AppLocalizations.of(context)!
                                                  .enter_id,
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.02),
                                              prefixIcon: Icon(
                                                  Icons.assignment_ind_outlined,
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  size: height * 0.03),
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.07),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .privacy_terms,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: height * 0.017),
                                          ),
                                          TextSpan(
                                              text: "\t*",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      219, 35, 35, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: height * 0.017)),
                                        ])),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Transform.scale(
                                        scale: 1.5,
                                        child: Checkbox(
                                          activeColor: const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>((states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
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
                                                text: AppLocalizations.of(context)!
                                                    .agree_msg,
                                                style: TextStyle(
                                                    fontSize: height * 0.018,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color.fromRGBO(
                                                        51, 51, 51, 1),
                                                    fontFamily: "Inter"),
                                              ),
                                              TextSpan(
                                                text: AppLocalizations.of(context)!
                                                    .privacy_Policy,
                                                recognizer: TapGestureRecognizer()..onTap = _launchUrlPrivacy,
                                                style: TextStyle(
                                                    fontSize: height * 0.018,
                                                    fontWeight: FontWeight.w400,
                                                    decoration:
                                                    TextDecoration.underline,
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: "Inter"),
                                              ),
                                              TextSpan(
                                                text:
                                                AppLocalizations.of(context)!.and,
                                                style: TextStyle(
                                                    fontSize: height * 0.018,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color.fromRGBO(
                                                        51, 51, 51, 1),
                                                    fontFamily: "Inter"),
                                              ),
                                              TextSpan(
                                                text: AppLocalizations.of(context)!.terms_of_services,
                                                recognizer: TapGestureRecognizer()..onTap = () => _launchUrlTerms(),
                                                style: TextStyle(
                                                    fontSize: height * 0.018,
                                                    fontWeight: FontWeight.w400,
                                                    decoration:
                                                    TextDecoration.underline,
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: "Inter"),
                                              ),
                                              // TextSpan(
                                              //   text: AppLocalizations.of(context)!
                                              //       .services,
                                              //   recognizer: TapGestureRecognizer()..onTap = () => _launchUrlTerms(),
                                              //   style: TextStyle(
                                              //       fontSize: height * 0.018,
                                              //       fontWeight: FontWeight.w400,
                                              //       decoration:
                                              //       TextDecoration.underline,
                                              //       color: const Color.fromRGBO(
                                              //           82, 165, 160, 1),
                                              //       fontFamily: "Inter"),
                                              // ),
                                            ])),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.04),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color.fromRGBO(82, 165, 160, 1),
                              minimumSize: const Size(280, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(39),
                              ),
                            ),
                            onPressed: () {
                              if (agree) {
                                if (formKey.currentState!.validate()) {
                                  name = nameController.text;
                                  // Navigator.pushNamed(
                                  //     context,
                                  //     '/studGuestAssessment',
                                  //     arguments: name);
                                  Navigator.of(context).pushNamed('/studGuestAssessment',arguments: name);
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
                                            .agree_privacy_terms,
                                        content:
                                        AppLocalizations.of(context)!.error,
                                        button: AppLocalizations.of(context)!
                                            .retry),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: TextStyle(
                                  fontSize: height * 0.03,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                        ]),
                  )));
        }
      },
    );
  }
}
