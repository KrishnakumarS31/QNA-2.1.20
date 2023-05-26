import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Components/preference.dart';
import 'package:qna_test/Services/qna_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/custom_incorrect_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Entity/user_details.dart';
import '../EntityModel/login_entity.dart';
import '../Components/end_drawer_menu_pre_login.dart';
import '../EntityModel/user_data_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../Providers/LanguageChangeProvider.dart';

class StudentMemberLoginPage extends StatefulWidget {
  const StudentMemberLoginPage({super.key, });



  @override
  StudentMemberLoginPageState createState() => StudentMemberLoginPageState();
}

class StudentMemberLoginPageState extends State<StudentMemberLoginPage> {
  TextEditingController regNumberController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  String regNumber = "";
  String passWord = "";
  bool _isObscure = true;
  final formKey = GlobalKey<FormState>();
  bool agree = false;
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  //late SharedPreferences loginData;
  //late bool newUser;
  final PrefService _prefService = PrefService();
  UserDetails userDetails=UserDetails();

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
    //checkIfAlreadyLoggedIn();
    //getData();
  }

  // void checkIfAlreadyLoggedIn() async {
  //   userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
  //   loginData = await SharedPreferences.getInstance();
  //   newUser = (userDetails.login ?? true);
  //   if (newUser == false && userDetails.role == 'student') {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return const Center(
  //               child: CircularProgressIndicator(
  //                 color: Color.fromRGBO(48, 145, 139, 1),
  //               ));
  //         });
  //     UserDataModel userDataModel =
  //     await QnaService.getUserDataService(userDetails.userId!,userDetails);
  //     Navigator.pushNamed(context,
  //         '/studentAssessment',
  //         arguments: [regNumber,userDataModel])
  //         .then((value) {
  //       regNumberController.clear();
  //       passWordController.clear();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 400) {
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
                      body: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromRGBO(0, 106, 100, 1),
                                    Color.fromRGBO(82, 165, 160, 1),
                                  ],
                                ),
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.elliptical(
                                        400, localHeight * 0.35)),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: localHeight * 0.050),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                      height: localHeight * 0.20,
                                      width: 400 * 0.30,
                                      child: Image.asset(
                                          "assets/images/question_mark_logo.png"),
                                    ),
                                  ),
                                  SizedBox(height: localHeight * 0.025),
                                ],
                              ),
                            ),
                            SizedBox(height: localHeight * 0.03),
                            Text(
                              AppLocalizations.of(context)!.member_student,
                              style: TextStyle(
                                fontSize: localHeight * 0.035,
                                color: const Color.fromRGBO(
                                    28, 78, 80, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: localHeight * 0.06),
                            SizedBox(
                              width: 400 * 0.8,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: AppLocalizations.of(context)!
                                                      .regId_emailId,
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: localHeight * 0.017),
                                                ),
                                                TextSpan(
                                                    text: "\t*",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            219, 35, 35, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: localHeight * 0.017)),
                                              ])),
                                        ),
                                        SizedBox(
                                          height: localHeight * 0.0001,
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              controller: regNumberController,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.deny(
                                                    ' ')
                                              ],
                                              onChanged: (val) {
                                                formKey.currentState!.validate();
                                              },
                                              decoration: InputDecoration(
                                                helperStyle: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 0.3),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: localHeight * 0.016),
                                                hintText:
                                                AppLocalizations.of(context)!
                                                    .hint_regId,
                                                hintStyle: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 0.3),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: localHeight * 0.02),
                                                prefixIcon: Icon(
                                                    Icons.account_box_outlined,
                                                    size: localHeight * 0.04,
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1)),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    !RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                                                        .hasMatch(value)) {
                                                  return AppLocalizations.of(
                                                      context)!
                                                      .error_regID;
                                                } else {
                                                  return null;
                                                }
                                              },
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: localHeight * 0.06),
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: AppLocalizations.of(context)!
                                                      .password_caps,
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: localHeight * 0.017),
                                                ),
                                                TextSpan(
                                                    text: " *",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            219, 35, 35, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: localHeight * 0.017)),
                                              ])),
                                        ),
                                        SizedBox(
                                          height: localHeight * 0.0001,
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              controller: passWordController,
                                              obscureText: _isObscure,
                                              onChanged: (val) {
                                                formKey.currentState!.validate();
                                              },
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                helperStyle: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        102, 102, 102, 0.3),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 400 * 0.016),
                                                hintText:
                                                AppLocalizations.of(context)!
                                                    .your_password,
                                                hintStyle: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 0.3),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: localHeight * 0.02),
                                                suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _isObscure
                                                          ? Icons.visibility
                                                          : Icons.visibility_off,
                                                      color: const Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isObscure = !_isObscure;
                                                      });
                                                    }),
                                                prefixIcon: Icon(
                                                    Icons.lock_outline_rounded,
                                                    size: localHeight * 0.04,
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1)),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value.length < 8) {
                                                  return AppLocalizations.of(
                                                      context)!
                                                      .enter_pass_min;
                                                  //"Enter password Min 8 Characters";
                                                } else {
                                                  return null;
                                                }
                                              },
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: localHeight * 0.02),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    '/forgotPasswordEmail',
                                                    arguments: true
                                                );

                                                // Navigator.push(
                                                //   context,
                                                //   PageTransition(
                                                //     type: PageTransitionType
                                                //         .rightToLeft,
                                                //     child: ForgotPasswordEmail(
                                                //         isFromStudent: true,
                                                //         ),
                                                //   ),
                                                // );
                                              },
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .forgot_password,
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          48, 145, 139, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontStyle: FontStyle.italic,
                                                      fontSize:
                                                      localHeight * 0.014)),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: localHeight * 0.03),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text:
                                              AppLocalizations.of(context)!.certify,
                                              //"CERTIFY",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: localHeight * 0.017),
                                            ),
                                            TextSpan(
                                                text: "\t*",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        219, 35, 35, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: localHeight * 0.017)),
                                          ])),
                                    ),
                                    SizedBox(height: localHeight * 0.02),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Transform.scale(
                                            filterQuality: FilterQuality.high,
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
                                            )),
                                        const SizedBox(width: 400 * 0.05),
                                        Flexible(
                                          child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: AppLocalizations.of(context)!
                                                      .agree_msg,
                                                  style: TextStyle(
                                                      fontSize: localHeight * 0.018,
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
                                                      fontSize: localHeight * 0.018,
                                                      fontWeight: FontWeight.w400,
                                                      decoration:
                                                      TextDecoration.underline,
                                                      color: const Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                      fontFamily: "Inter"),
                                                ),
                                                TextSpan(
                                                  text: AppLocalizations.of(context)!.and,
                                                  style: TextStyle(
                                                      fontSize: localHeight * 0.018,
                                                      fontWeight: FontWeight.w400,
                                                      color: const Color.fromRGBO(
                                                          51, 51, 51, 1),
                                                      fontFamily: "Inter"),
                                                ),
                                                TextSpan(
                                                  text:
                                                  AppLocalizations.of(context)!.terms_of_services,
                                                  recognizer: TapGestureRecognizer()..onTap = _launchUrlTerms,
                                                  style: TextStyle(
                                                      fontSize: localHeight * 0.018,
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
                                                //   recognizer: TapGestureRecognizer()..onTap = _launchUrlTerms,
                                                //   style: TextStyle(
                                                //       fontSize: localHeight * 0.018,
                                                //       fontWeight: FontWeight.w400,
                                                //       decoration: TextDecoration.underline,
                                                //       color: const Color.fromRGBO(82, 165, 160, 1),
                                                //       fontFamily: "Inter"),
                                                // ),
                                              ])),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: localHeight * 0.02),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              minimumSize: const Size(280, 48),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(39),
                                              ),
                                            ),
                                            child: Text(
                                                AppLocalizations.of(context)!.login_loginPage,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: localHeight * 0.03,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600)),
                                            onPressed: () async {
                                              if (agree) {
                                                _prefService
                                                    .createCache(
                                                    passWordController.text)
                                                    .whenComplete(() async {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    regNumber =
                                                        regNumberController.text;
                                                    passWord =
                                                        passWordController.text;
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return const Center(
                                                              child:
                                                              CircularProgressIndicator(
                                                                color: Color.fromRGBO(
                                                                    48, 145, 139, 1),
                                                              ));
                                                        });
                                                    LoginModel loginResponse =
                                                    await QnaService.logInUser(
                                                        regNumber,
                                                        passWord,
                                                        'student');
                                                    Navigator.of(context).pop();

                                                    if (loginResponse.code == 200) {
                                                      //UserDataModel userDataModel = UserDataModel();
                                                      //userDataModel = await QnaService.getUserDataService(loginResponse.data.userId);
                                                      UserDetails userDetails=UserDetails();
                                                      userDetails.login=false;
                                                      userDetails.email=regNumber;
                                                      userDetails.password=passWord;
                                                      userDetails.role='student';
                                                      userDetails.firstName=loginResponse.data.firstName;
                                                      userDetails.lastName=loginResponse.data.lastName;
                                                      userDetails.token=loginResponse.data.accessToken;
                                                      userDetails.userId=loginResponse.data.userId;
                                                      Provider.of<LanguageChangeProvider>(context, listen: false).updateUserDetails(userDetails);
                                                      // loginData.setBool(
                                                      //     'login', false);
                                                      // loginData.setString(
                                                      //     'email', regNumber);
                                                      // loginData.setString(
                                                      //     'password', passWord);
                                                      // loginData.setString(
                                                      //     'role', 'student');
                                                      // loginData.setString(
                                                      //     'firstName',
                                                      //     loginResponse
                                                      //         .data.firstName);
                                                      // loginData.setString(
                                                      //     'lastName',
                                                      //     loginResponse
                                                      //         .data.lastName);
                                                      // loginData.setString(
                                                      //     'token',
                                                      //     loginResponse
                                                      //         .data.accessToken);
                                                      // loginData.setInt(
                                                      //     'userId',
                                                      //     loginResponse
                                                      //         .data.userId);
                                                      UserDataModel userDataModel =
                                                      await QnaService
                                                          .getUserDataService(
                                                          loginResponse
                                                              .data!
                                                              .userId,userDetails);
                                                      if (userDataModel.data!.role
                                                          .contains("student")) {
                                                        Navigator.pushNamed(context,
                                                            '/studentAssessment',
                                                            arguments: [regNumber,userDataModel])
                                                            .then((value) {
                                                          regNumberController.clear();
                                                          passWordController.clear();
                                                        });
                                                        // Navigator.push(
                                                        //   context,
                                                        //   PageTransition(
                                                        //     type: PageTransitionType
                                                        //         .rightToLeft,
                                                        //     child: StudentAssessment(
                                                        //         regNumber:
                                                        //         regNumber,
                                                        //         usedData:
                                                        //         userDataModel),
                                                        //   ),
                                                        // ).then((value) {
                                                        //   regNumberController
                                                        //       .clear();
                                                        //   passWordController
                                                        //       .clear();
                                                        // });
                                                      }
                                                    } else if (loginResponse.code ==
                                                        400) {
                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type: PageTransitionType
                                                              .rightToLeft,
                                                          child: CustomDialog(
                                                            title: "OOPS!",
                                                            //'Wrong password',
                                                            content:
                                                            "Invalid Role,CheckYour Login Data",
                                                            //'please enter the correct password',
                                                            button:
                                                            AppLocalizations.of(
                                                                context)!
                                                                .retry,
                                                          ),
                                                        ),
                                                      );
                                                    } else if (loginResponse.code ==
                                                        401) {
                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type: PageTransitionType
                                                              .rightToLeft,
                                                          child: CustomDialog(
                                                            title:
                                                            AppLocalizations.of(
                                                                context)!
                                                                .wrong_password,
                                                            //'Wrong password',
                                                            content: AppLocalizations
                                                                .of(context)!
                                                                .pls_enter_cr_pass,
                                                            //'please enter the correct password',
                                                            button:
                                                            AppLocalizations.of(
                                                                context)!
                                                                .retry,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                });
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    child: CustomDialog(
                                                        title: AppLocalizations.of(
                                                            context)!
                                                            .agree_privacy_terms,
                                                        content:
                                                        AppLocalizations.of(
                                                            context)!
                                                            .error,
                                                        button: AppLocalizations.of(
                                                            context)!
                                                            .retry),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: localHeight * 0.02,
                                    ),
                                    MaterialButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/studentRegistrationPage');
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //     const StudentRegistrationPage(),
                                          //   ),
                                          // );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child:GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(context, '/studentRegistrationPage');
                                                    },
                                                    child:
                                                    DecoratedIcon(
                                                      Icons.app_registration,
                                                      color: const Color.fromRGBO(141, 167, 167, 1),
                                                      size: localHeight * 0.034,
                                                    ))),
                                            SizedBox(width: 400 * 0.005),
                                            // IconButton(
                                            //   icon: const Icon(
                                            //     Icons.edit_calendar_sharp,
                                            //     color: Color.fromRGBO(
                                            //         141, 167, 167, 1),
                                            //   ),
                                            //   onPressed: () {
                                            //     Navigator.pushNamed(context, '/studentRegistrationPage');
                                            //   },
                                            // ),
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .register,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        48, 145, 139, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: localHeight * 0.024)),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: localHeight * 0.03,
                            ),
                          ])))),
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
                  body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(0, 106, 100, 1),
                                Color.fromRGBO(82, 165, 160, 1),
                              ],
                            ),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(
                                    localWidth, localHeight * 0.35)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: localHeight * 0.050),
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  height: localHeight * 0.20,
                                  width: localWidth * 0.30,
                                  child: Image.asset(
                                      "assets/images/question_mark_logo.png"),
                                ),
                              ),
                              SizedBox(height: localHeight * 0.025),
                            ],
                          ),
                        ),
                        SizedBox(height: localHeight * 0.03),
                        Text(
                          AppLocalizations.of(context)!.member_student,
                          style: TextStyle(
                            fontSize: localHeight * 0.035,
                            color: const Color.fromRGBO(
                                28, 78, 80, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: localHeight * 0.06),
                        SizedBox(
                          width: localWidth * 0.8,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: AppLocalizations.of(context)!
                                                  .regId_emailId,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: localHeight * 0.017),
                                            ),
                                            TextSpan(
                                                text: "\t*",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        219, 35, 35, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: localHeight * 0.017)),
                                          ])),
                                    ),
                                    SizedBox(
                                      height: localHeight * 0.0001,
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          controller: regNumberController,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                                ' ')
                                          ],
                                          onChanged: (val) {
                                            formKey.currentState!.validate();
                                          },
                                          decoration: InputDecoration(
                                            helperStyle: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: localHeight * 0.016),
                                            hintText:
                                            AppLocalizations.of(context)!
                                                .hint_regId,
                                            hintStyle: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: localHeight * 0.02),
                                            prefixIcon: Icon(
                                                Icons.account_box_outlined,
                                                size: localHeight * 0.04,
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1)),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                                                    .hasMatch(value)) {
                                              return AppLocalizations.of(
                                                  context)!
                                                  .error_regID;
                                            } else {
                                              return null;
                                            }
                                          },
                                        )),
                                  ],
                                ),
                                SizedBox(height: localHeight * 0.06),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: AppLocalizations.of(context)!
                                                  .password_caps,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: localHeight * 0.017),
                                            ),
                                            TextSpan(
                                                text: " *",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        219, 35, 35, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: localHeight * 0.017)),
                                          ])),
                                    ),
                                    SizedBox(
                                      height: localHeight * 0.0001,
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: passWordController,
                                          obscureText: _isObscure,
                                          onChanged: (val) {
                                            formKey.currentState!.validate();
                                          },
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            helperStyle: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: localWidth * 0.016),
                                            hintText:
                                            AppLocalizations.of(context)!
                                                .your_password,
                                            hintStyle: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: localHeight * 0.02),
                                            suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isObscure
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isObscure = !_isObscure;
                                                  });
                                                }),
                                            prefixIcon: Icon(
                                                Icons.lock_outline_rounded,
                                                size: localHeight * 0.04,
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1)),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 8) {
                                              return AppLocalizations.of(
                                                  context)!
                                                  .enter_pass_min;
                                              //"Enter password Min 8 Characters";
                                            } else {
                                              return null;
                                            }
                                          },
                                        )),
                                  ],
                                ),
                                SizedBox(height: localHeight * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                '/forgotPasswordEmail',
                                                arguments: true
                                            );

                                            // Navigator.push(
                                            //   context,
                                            //   PageTransition(
                                            //     type: PageTransitionType
                                            //         .rightToLeft,
                                            //     child: ForgotPasswordEmail(
                                            //         isFromStudent: true,
                                            //         ),
                                            //   ),
                                            // );
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .forgot_password,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      48, 145, 139, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize:
                                                  localHeight * 0.014)),
                                        )),
                                  ],
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                          AppLocalizations.of(context)!.certify,
                                          //"CERTIFY",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.017),
                                        ),
                                        TextSpan(
                                            text: "\t*",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    219, 35, 35, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.017)),
                                      ])),
                                ),
                                SizedBox(height: localHeight * 0.02),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Transform.scale(
                                        filterQuality: FilterQuality.high,
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
                                        )),
                                    SizedBox(width: localWidth * 0.05),
                                    Flexible(
                                      child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: AppLocalizations.of(context)!
                                                  .agree_msg,
                                              style: TextStyle(
                                                  fontSize: localHeight * 0.018,
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
                                                  fontSize: localHeight * 0.018,
                                                  fontWeight: FontWeight.w400,
                                                  decoration:
                                                  TextDecoration.underline,
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontFamily: "Inter"),
                                            ),
                                            TextSpan(
                                              text: AppLocalizations.of(context)!.and,
                                              style: TextStyle(
                                                  fontSize: localHeight * 0.018,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontFamily: "Inter"),
                                            ),
                                            TextSpan(
                                              text:
                                              AppLocalizations.of(context)!.terms_of_services,
                                              recognizer: TapGestureRecognizer()..onTap = _launchUrlTerms,
                                              style: TextStyle(
                                                  fontSize: localHeight * 0.018,
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
                                            //   recognizer: TapGestureRecognizer()..onTap = _launchUrlTerms,
                                            //   style: TextStyle(
                                            //       fontSize: localHeight * 0.018,
                                            //       fontWeight: FontWeight.w400,
                                            //       decoration: TextDecoration.underline,
                                            //       color: const Color.fromRGBO(82, 165, 160, 1),
                                            //       fontFamily: "Inter"),
                                            // ),
                                          ])),
                                    ),
                                  ],
                                ),
                                SizedBox(height: localHeight * 0.02),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          minimumSize: const Size(280, 48),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(39),
                                          ),
                                        ),
                                        child: Text(
                                            AppLocalizations.of(context)!.login_loginPage,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: localHeight * 0.03,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                        onPressed: () async {
                                          if (agree) {
                                            _prefService
                                                .createCache(
                                                passWordController.text)
                                                .whenComplete(() async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                regNumber =
                                                    regNumberController.text;
                                                passWord =
                                                    passWordController.text;
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return const Center(
                                                          child:
                                                          CircularProgressIndicator(
                                                            color: Color.fromRGBO(
                                                                48, 145, 139, 1),
                                                          ));
                                                    });
                                                LoginModel loginResponse =
                                                await QnaService.logInUser(
                                                    regNumber,
                                                    passWord,
                                                    'student');
                                                Navigator.of(context).pop();

                                                if (loginResponse.code == 200) {
                                                  //UserDataModel userDataModel = UserDataModel();
                                                  //userDataModel = await QnaService.getUserDataService(loginResponse.data.userId);
                                                  UserDetails userDetails=UserDetails();
                                                  userDetails.login=false;
                                                  userDetails.email=regNumber;
                                                  userDetails.password=passWord;
                                                  userDetails.role='student';
                                                  userDetails.firstName=loginResponse.data.firstName;
                                                  userDetails.lastName=loginResponse.data.lastName;
                                                  userDetails.token=loginResponse.data.accessToken;
                                                  userDetails.userId=loginResponse.data.userId;
                                                  Provider.of<LanguageChangeProvider>(context, listen: false).updateUserDetails(userDetails);
                                                  // loginData.setBool(
                                                  //     'login', false);
                                                  // loginData.setString(
                                                  //     'email', regNumber);
                                                  // loginData.setString(
                                                  //     'password', passWord);
                                                  // loginData.setString(
                                                  //     'role', 'student');
                                                  // loginData.setString(
                                                  //     'firstName',
                                                  //     loginResponse
                                                  //         .data.firstName);
                                                  // loginData.setString(
                                                  //     'lastName',
                                                  //     loginResponse
                                                  //         .data.lastName);
                                                  // loginData.setString(
                                                  //     'token',
                                                  //     loginResponse
                                                  //         .data.accessToken);
                                                  // loginData.setInt(
                                                  //     'userId',
                                                  //     loginResponse
                                                  //         .data.userId);
                                                  UserDataModel userDataModel =
                                                  await QnaService
                                                      .getUserDataService(
                                                      loginResponse
                                                          .data!
                                                          .userId,userDetails);
                                                  if (userDataModel.data!.role
                                                      .contains("student")) {
                                                    Navigator.pushNamed(context,
                                                        '/studentAssessment',
                                                        arguments: [regNumber,userDataModel])
                                                        .then((value) {
                                                      regNumberController.clear();
                                                      passWordController.clear();
                                                    });
                                                    // Navigator.push(
                                                    //   context,
                                                    //   PageTransition(
                                                    //     type: PageTransitionType
                                                    //         .rightToLeft,
                                                    //     child: StudentAssessment(
                                                    //         regNumber:
                                                    //         regNumber,
                                                    //         usedData:
                                                    //         userDataModel),
                                                    //   ),
                                                    // ).then((value) {
                                                    //   regNumberController
                                                    //       .clear();
                                                    //   passWordController
                                                    //       .clear();
                                                    // });
                                                  }
                                                } else if (loginResponse.code ==
                                                    400) {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: CustomDialog(
                                                        title: "OOPS!",
                                                        //'Wrong password',
                                                        content:
                                                        "Invalid Role,CheckYour Login Data",
                                                        //'please enter the correct password',
                                                        button:
                                                        AppLocalizations.of(
                                                            context)!
                                                            .retry,
                                                      ),
                                                    ),
                                                  );
                                                } else if (loginResponse.code ==
                                                    401) {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: CustomDialog(
                                                        title:
                                                        AppLocalizations.of(
                                                            context)!
                                                            .wrong_password,
                                                        //'Wrong password',
                                                        content: AppLocalizations
                                                            .of(context)!
                                                            .pls_enter_cr_pass,
                                                        //'please enter the correct password',
                                                        button:
                                                        AppLocalizations.of(
                                                            context)!
                                                            .retry,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }
                                            });
                                          } else {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: CustomDialog(
                                                    title: AppLocalizations.of(
                                                        context)!
                                                        .agree_privacy_terms,
                                                    content:
                                                    AppLocalizations.of(
                                                        context)!
                                                        .error,
                                                    button: AppLocalizations.of(
                                                        context)!
                                                        .retry),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: localHeight * 0.02,
                                ),
                                MaterialButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/studentRegistrationPage');
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //     const StudentRegistrationPage(),
                                      //   ),
                                      // );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child:GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context, '/studentRegistrationPage');
                                                },
                                                child:
                                                DecoratedIcon(
                                                  Icons.app_registration,
                                                  color: const Color.fromRGBO(141, 167, 167, 1),
                                                  size: localHeight * 0.034,
                                                ))),
                                        SizedBox(width: localWidth * 0.005),
                                        // IconButton(
                                        //   icon: const Icon(
                                        //     Icons.edit_calendar_sharp,
                                        //     color: Color.fromRGBO(
                                        //         141, 167, 167, 1),
                                        //   ),
                                        //   onPressed: () {
                                        //     Navigator.pushNamed(context, '/studentRegistrationPage');
                                        //   },
                                        // ),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .register,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    48, 145, 139, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.024)),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: localHeight * 0.03,
                        ),
                      ]))));
        }
      },
    );
  }
}
