import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Services/qna_service.dart';
import 'package:qna_test/pages/settings_languages.dart';
import '../Components/custom_incorrect_popup.dart';
import '../EntityModel/login_entity.dart';
import 'cookie_policy.dart';
import 'forgot_password_email.dart';
import 'student_registration_page.dart';
import 'student_MemLoged_Start.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'privacy_policy_hamburger.dart';
import 'terms_of_services.dart';

class StudentMemberLoginPage extends StatefulWidget {
  const StudentMemberLoginPage({super.key, required this.setLocale});
  final void Function(Locale locale) setLocale;

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
        endDrawer: Drawer(
          child: Column(
            children: [
              Container(
                  color: const Color.fromRGBO(0, 106, 100, 1), height: 55),
              Image.asset(
                "assets/images/rectangle_qna.png",
              ),
              Flexible(
                child: ListView(
                  children: [
                    ListTile(
                        leading: const Icon(Icons.translate,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(
                          AppLocalizations.of(context)!.language,
                          style: TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16),
                        ),
                        trailing: const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: SettingsLanguages(
                                  setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading: const Icon(Icons.verified_user_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(
                          AppLocalizations.of(context)!.privacy_and_terms,
                          style: TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16),
                        ),
                        trailing: const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: PrivacyPolicyHamburger(
                                  setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    ListTile(
                        leading: const Icon(Icons.verified_user_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(
                          'Terms of Services',
                          style: TextStyle(
                              color: textColor,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16),
                        ),
                        trailing: const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: TermsOfServiceHamburger(
                                  setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    ListTile(
                        leading: const Icon(Icons.note_alt_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(
                          AppLocalizations.of(context)!.cookie_policy,
                          style: TextStyle(
                              color: textColor,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16),
                        ),
                        trailing: const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: CookiePolicy(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading: const Icon(
                            Icons.perm_contact_calendar_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(
                          AppLocalizations.of(context)!.about_us,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(TextStyle(
                                  color: textColor,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.02,
                                  fontSize: 16)),
                        ),
                        trailing: const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {}),
                    ListTile(
                        leading: const Icon(Icons.help_outline,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(
                          AppLocalizations.of(context)!.help,
                          style: TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16),
                        ),
                        onTap: () async {}),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                      bottom:
                          Radius.elliptical(localWidth, localHeight * 0.35)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: localHeight * 0.050),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: localHeight * 0.20,
                        width: localWidth * 0.30,
                        child:
                            Image.asset("assets/images/question_mark_logo.png"),
                      ),
                    ),
                    SizedBox(height: localHeight * 0.025),
                  ],
                ),
              ),
              SizedBox(height: localHeight * 0.03),
              Text(
                AppLocalizations.of(context)!.member_student,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w800,
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
                                text:
                                    AppLocalizations.of(context)!.regId_emailId,
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: localHeight * 0.017),
                              ),
                              TextSpan(
                                  text: "\t*",
                                  style: TextStyle(
                                      color:
                                          const Color.fromRGBO(219, 35, 35, 1),
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
                                onChanged: (val)
                                {
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
                                      AppLocalizations.of(context)!.hint_regId,
                                  prefixIcon: const Icon(
                                      Icons.contacts_outlined,
                                      color: Color.fromRGBO(82, 165, 160, 1)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty)
                                  {
                                    return AppLocalizations.of(context)!.error_regID;
                                  } else {
                                    return null;
                                  }
                                },
                              )),
                        ],
                      ),
                      SizedBox(height: localHeight * 0.06),
                      //SizedBox(height:height * 0.04),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text:
                                    AppLocalizations.of(context)!.password_caps,
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: localHeight * 0.017),
                              ),
                              TextSpan(
                                  text: "\t*",
                                  style: TextStyle(
                                      color:
                                          const Color.fromRGBO(219, 35, 35, 1),
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
                                onChanged: (val)
                                {
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
                                  hintText: AppLocalizations.of(context)!
                                      .your_password,
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure ? Icons.visibility : Icons.visibility_off,color: const Color.fromRGBO(82, 165, 160, 1),),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  prefixIcon: const Icon(
                                      Icons.lock_outline_rounded,
                                      color: Color.fromRGBO(82, 165, 160, 1)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter password";
                                  } else {
                                    return null;
                                  }
                                },
                              )),
                        ],
                      ),
                      SizedBox(height: localHeight * 0.02),
                      Container(
                          padding: EdgeInsets.only(left: localHeight * 0.25),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: ForgotPasswordEmail(setLocale: widget.setLocale),
                                    ),
                                  );
                                },
                                child: Text(
                                    AppLocalizations.of(context)!.forgot_password,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(48, 145, 139, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.014)),
                              ),
                            ],
                          )),
                      SizedBox(height:localHeight * 0.03),
                      Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "CERTIFY",
                                style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: localHeight * 0.017),),
                              TextSpan(
                                  text: "\t*",
                                  style: TextStyle(
                                      color: const Color.fromRGBO(219, 35, 35, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: localHeight * 0.017)),
                            ])),
                      ),
                      SizedBox(height:localHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            activeColor: const Color.fromRGBO(82, 165, 160, 1),
                            fillColor: MaterialStateProperty
                                .resolveWith<Color>((states) {
                              if (states.contains(
                                  MaterialState.selected)) {
                                return const Color.fromRGBO(82, 165, 160, 1); // Disabled color
                              }
                              return const Color.fromRGBO(82, 165, 160, 1); // Regular color
                            }),
                            value: agree,
                            onChanged: (val) {
                              setState(() {
                                agree = val!;
                                if (agree) {
                                }
                              });
                            },
                          ),
                          RichText(
                                text:  TextSpan(children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.agree_msg,
                                    style: const TextStyle(fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: "Inter"),
                                  ),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.privacy_Policy,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        decoration:
                                        TextDecoration.underline,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: "Inter"),
                                  ),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.and,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: "Inter"),),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.terms,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        decoration:
                                        TextDecoration.underline,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: "Inter"),
                                  ),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.services,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: "Inter"),),
                                ])
                            ),
                        ],
                      ),
                      SizedBox(height:localHeight * 0.02),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: const Size(280, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              child: Text(AppLocalizations.of(context)!.login,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: localHeight * 0.024,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              onPressed: () async {
                               if(agree) {
                                 if (formKey.currentState!.validate()) {
                                   regNumber = regNumberController.text;
                                   passWord = passWordController.text;
                                   showDialog(
                                       context: context,
                                       builder: (context) {
                                         return const Center(
                                             child: CircularProgressIndicator(
                                               color: Color.fromRGBO(
                                                   48, 145, 139, 1),
                                             ));
                                       });
                                   LoginModel loginResponse =
                                   await QnaService.logInUser(
                                       regNumber, passWord);
                                   Navigator.of(context).pop();
                                   if (loginResponse.code == 200) {
                                     Navigator.push(
                                       context,
                                       PageTransition(
                                         type: PageTransitionType.rightToLeft,
                                         child: StudentMemLogedStart(
                                           regNumber: regNumber,
                                           setLocale: widget.setLocale,
                                           userId: loginResponse.data!.userId,
                                         ),
                                       ),
                                     ).then((value) {
                                       regNumberController.clear();
                                       passWordController.clear();
                                     });
                                   } else {
                                     Navigator.push(
                                       context,
                                       PageTransition(
                                         type: PageTransitionType.rightToLeft,
                                         child: CustomDialog(
                                           title: 'Wrong password',
                                           content: 'please enter the correct password',
                                           button: AppLocalizations.of(context)!
                                               .retry,
                                         ),
                                       ),
                                     );
                                   }
                                 }
                               } else{
                                 Navigator.push(
                                   context,
                                   PageTransition(
                                     type: PageTransitionType.rightToLeft,
                                     child: CustomDialog(title: AppLocalizations.of(context)!.agree_privacy_terms, content: AppLocalizations.of(context)!.error, button: AppLocalizations.of(context)!.retry),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StudentRegistrationPage(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_note_sharp,
                                  color: Color.fromRGBO(141, 167, 167, 1),
                                ),
                                onPressed: () {},
                              ),
                              Text(AppLocalizations.of(context)!.register,
                                  style: TextStyle(
                                      color: const Color.fromRGBO(48, 145, 139, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: localHeight * 0.018)),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: localHeight * 0.03,
              ),
            ])));
  }
}
