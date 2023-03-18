import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_forgot_password_email.dart';
import 'package:qna_test/Pages/teacher_registration_page.dart';
import 'package:qna_test/Pages/teacher_selection_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Components/custom_incorrect_popup.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/user_data_model.dart';
import '../Services/qna_service.dart';
import '../Components/end_drawer_menu_pre_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key, required this.setLocale});
  final void Function(Locale locale) setLocale;

  @override
  TeacherLoginState createState() => TeacherLoginState();
}

class TeacherLoginState extends State<TeacherLogin> {
  bool _isObscure = true;
  final formKey = GlobalKey<FormState>();
  String regNumber = "";
  String passWord = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool agree = false;
  String name = '';
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  SharedPreferences? loginData;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    check_if_alread_loggedin();
  }

  void check_if_alread_loggedin()async{
    loginData=await SharedPreferences.getInstance();
    newUser=(loginData?.getBool('login')??true);
    if(newUser==false){
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(48, 145, 139, 1),
                ));
          });
      UserDataModel userDataModel = UserDataModel(code: 0, message: '');
      userDataModel = await QnaService.getUserDataService(loginData?.getInt('userId'));
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: TeacherSelectionPage(
            setLocale: widget.setLocale,
            userId: loginData?.getInt('userId'), userData: userDataModel,
          ),
        ),
      ).then((value) {
        emailController.clear();
        passwordController.clear();
      });
    }
  }

  getUserDetails() async {}


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
        endDrawer: EndDrawerMenuPreLogin(setLocale: widget.setLocale),
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
                        bottom: Radius.elliptical(width, height * 0.40)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.09),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.all(0.0),
                          height: height * 0.16,
                          width: width * 0.30,
                          child: Image.asset(
                              "assets/images/question_mark_logo.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                Text(
                  AppLocalizations.of(context)!.teacher_caps,
                  style: TextStyle(
                    fontSize: height * 0.03,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: height * 0.07),
                SizedBox(
                  width: width * 0.8,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.email_id_caps,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyLarge
                                        ?.merge(TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: height * 0.017)),
                                  ),
                                  const Text('\t*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.0001,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText:
                                    AppLocalizations.of(context)!.email_id,
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                    prefixIcon: Icon(
                                      Icons.account_box_outlined,
                                      color:
                                      const Color.fromRGBO(82, 165, 160, 1),
                                      size: height * 0.03,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    formKey.currentState!.validate();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty || !RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+").hasMatch(value)) {
                                      return AppLocalizations.of(context)!
                                          .enter_valid_email;
                                    } else {
                                      return null;
                                    }
                                  },
                                )),
                          ],
                        ),
                        SizedBox(height: height * 0.0375),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.password_caps,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyLarge
                                        ?.merge(TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: height * 0.017)),
                                  ),
                                  const Text('\t*',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.0001,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  obscureText: _isObscure,
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
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
                                    hintText: AppLocalizations.of(context)!
                                        .your_password,
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color:
                                      const Color.fromRGBO(82, 165, 160, 1),
                                      size: height * 0.03,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    formKey.currentState!.validate();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .enter_your_password;
                                    } else {
                                      return null;
                                    }
                                  },
                                )),
                          ],
                        ),
                        SizedBox(height: height * 0.025),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: TeacherForgotPasswordEmail(
                                    setLocale: widget.setLocale),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              AppLocalizations.of(context)!.forgot_password,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge
                                  ?.merge(TextStyle(
                                  color:
                                  const Color.fromRGBO(48, 145, 139, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: height * 0.017)),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.certify,
                            //"CERTIFY",
                            style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: height * 0.017),
                          ),
                          TextSpan(
                              text: "\t*",
                              style: TextStyle(
                                  color: const Color.fromRGBO(219, 35, 35, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.017)),
                        ])),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.scale(
                        filterQuality: FilterQuality.high,
                        scale: 1.8,
                        child:
                        Checkbox(
                          activeColor: const Color.fromRGBO(82, 165, 160, 1),
                          fillColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.selected)) {
                              return const Color.fromRGBO(82, 165, 160, 1);
                            }
                            return const Color.fromRGBO(82, 165, 160, 1);
                          }),
                          value: agree,
                          onChanged: (val) {
                            setState(() {
                              agree = val!;
                              if (agree) {}
                            });
                          },
                        ),),
                      SizedBox(width: width * 0.05),
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.agree_msg,
                              style:  TextStyle(
                                  fontSize: height * 0.017,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: "Inter"),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)!.privacy_Policy,
                              style:  TextStyle(
                                  fontSize: height * 0.017,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontFamily: "Inter"),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)!.and,
                              style:  TextStyle(
                                  fontSize: height * 0.017,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontFamily: "Inter"),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)!.terms,
                              style:  TextStyle(
                                  fontSize: height * 0.017,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontFamily: "Inter"),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)!.services,
                              style:  TextStyle(
                                  fontSize: height * 0.017,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: "Inter"),
                            ),
                          ])),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                    minimumSize: const Size(280, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(39),
                    ),
                  ),
                  onPressed: () async {
                    if (agree) {
                      bool valid = formKey.currentState!.validate();
                      if (valid == true) {
                        regNumber = emailController.text;
                        passWord = passwordController.text;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                    color: Color.fromRGBO(48, 145, 139, 1),
                                  ));
                            });
                        LoginModel loginResponse =
                        await QnaService.logInUser(regNumber, passWord);

                        Navigator.of(context).pop();
                        if (loginResponse.code == 200) {
                          loginData?.setBool('login', false);
                          loginData?.setString('email', regNumber);
                          loginData?.setString('password', passWord);
                          loginData?.setString('token', loginResponse.data.accessToken);
                          loginData?.setInt('userId', loginResponse.data.userId);
                          UserDataModel userDataModel = UserDataModel();
                          userDataModel = await QnaService.getUserDataService(loginResponse.data.userId);
                          if (userDataModel.data!.role
                              .contains("teacher")) {
                            print(userDataModel.data!.role);
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: TeacherSelectionPage(

                                  setLocale: widget.setLocale,
                                  userId: loginResponse.data!.userId, userData: userDataModel,
                                ),
                              ),
                            ).then((value) {
                              emailController.clear();
                              passwordController.clear();
                            });
                          }
                          else if(!userDataModel.data!.role.contains("teacher"))
                          {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: CustomDialog(
                                  title: "OOPS!",
                                  //'Wrong password',
                                  content:"Sorry You are not a Teacher!",
                                  //'please enter the correct password',
                                  button:
                                  AppLocalizations.of(context)!
                                      .retry,
                                ),
                              ),
                            );
                          }

                        }
                        else if(loginResponse.code == 401) {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: CustomDialog(
                                title: 'Wrong password',
                                content: 'please enter the correct password',
                                button: AppLocalizations.of(context)!.retry,
                              ),
                            ),
                          );
                        }
                      }
                    } else {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: CustomDialog(
                              title: AppLocalizations.of(context)!
                                  .agree_privacy_terms,
                              content: AppLocalizations.of(context)!.error,
                              button: AppLocalizations.of(context)!.retry),
                        ),
                      );
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                        fontSize: height * 0.027,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(height: height * 0.03),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const TeacherRegistrationPage(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit_note_sharp,
                          color: const Color.fromRGBO(141, 167, 167, 1),
                          size: height * 0.034,
                        ),
                        onPressed: () {},
                      ),
                      Text(AppLocalizations.of(context)!.register,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                              color: const Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: height * 0.0225))),
                    ],
                  ),
                ),
              ]),
        ));
  }
}