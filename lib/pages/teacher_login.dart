import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Entity/user_details.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/user_data_model.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Services/qna_service.dart';
import '../Components/end_drawer_menu_pre_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key,});



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
  UserDetails userDetails=UserDetails();

  @override
  void initState() {
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    super.initState();
  }

  void checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (userDetails.login ?? true);
    if (newUser == false && userDetails.role == 'teacher') {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromRGBO(48, 145, 139, 1),
            ));
          });
      UserDataModel userDataModel = UserDataModel(code: 0, message: '');
      userDataModel =
          await QnaService.getUserDataService(userDetails.userId,userDetails);
      Navigator.pushNamed(
          context,
          '/teacherSelectionPage',
          arguments: userDataModel
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

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  extendBodyBehindAppBar: true,
                  appBar:AppBar(
                    iconTheme: IconThemeData(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        size: height * 0.05
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: height * 0.06,
                        color: Colors.black,
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
                            AppLocalizations.of(context)!.teacher_caps,
                            //"Teacher Login",
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white
                      ),
                    ),
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  body:
                  SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.2),
                            Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text(
                                  AppLocalizations.of(context)!.login_loginPage,
                                  style: TextStyle(
                                    fontSize: height * 0.02,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                            SizedBox(height: height * 0.02),
                            Center(
                                child:
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: kElevationToShadow[4],
                                  ),
                                  width: width * 0.9,
                                  child:
                                  Form(
                                    key: formKey,
                                    child:
                                    Column(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(height: height * 0.05),
                                            SizedBox(
                                                width: width * 0.8,
                                                child: TextFormField(
                                                  keyboardType: TextInputType.text,
                                                  controller: emailController,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.deny(
                                                        ' ')
                                                  ],
                                                  onChanged: (val) {
                                                    formKey.currentState!.validate();
                                                  },
                                                  decoration: InputDecoration(
                                                    labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.always,
                                                    helperStyle: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: height * 0.016),
                                                    label: Text(
                                                      AppLocalizations.of(context)!
                                                          .regId_emailId,
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: height * 0.025)
                                                    ),
                                                    hintText:
                                                    AppLocalizations.of(context)!
                                                        .hint_regId,
                                                    //Enter here
                                                    hintStyle: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: height * 0.02),
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
                                                ))
                                          ],
                                        ),
                                        SizedBox(height: height * 0.06),
                                        Column(
                                          children: [
                                            SizedBox(
                                                width: width * 0.8,
                                                child: TextFormField(
                                                  controller: passwordController,
                                                  obscureText: _isObscure,
                                                  obscuringCharacter: "*",
                                                  onChanged: (val) {
                                                    formKey.currentState!.validate();
                                                  },
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration( floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                      labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                      label: Text(
                                                        AppLocalizations.of(context)!
                                                            .password,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.025),
                                                      ),
                                                      helperStyle:TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: width * 0.016),
                                                      hintText:
                                                      AppLocalizations.of(context)!
                                                          .your_password,
                                                      //Enter here
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: height * 0.02),
                                                      suffixIcon:
                                                      SizedBox(
                                                          child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children:[
                                                                IconButton(
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
                                                              ]
                                                          ))),
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
                                                ))
                                          ],
                                        ),
                                        SizedBox(height: height * 0.02),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: width * 0.05),
                                            MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        '/forgotPasswordEmail',
                                                        arguments: false
                                                    );
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
                                                          height * 0.018)),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        SizedBox(height: height * 0.03),
                                      ],
                                    ),
                                  ),
                                )),
                            SizedBox(height: height * 0.03),
                            Center(
                                child:IconButton(
                                    iconSize: height * 0.06,
                                  icon: Icon(Icons.arrow_circle_right,
                                    color:
                                    ((passwordController.text.length > 7) && (emailController.text.isNotEmpty || RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+").hasMatch(emailController.text)))
                                        ?  const Color.fromRGBO(82, 165, 160, 1)
                                        :  const Color.fromRGBO(153, 153, 153, 0.5),
                                  ),
                                  onPressed: () async {
                                    bool valid = formKey.currentState!.validate();
                                        regNumber = emailController.text;
                                        passWord = passwordController.text;
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
                                            regNumber, passWord, 'teacher');
                                        Navigator.of(context).pop();
                                        if (loginResponse.code == 200) {
                                          UserDetails userDetails = UserDetails();
                                          userDetails.login = false;
                                          userDetails.email = regNumber;
                                          userDetails.password = passWord;
                                          userDetails.role = 'teacher';
                                          userDetails.firstName =
                                              loginResponse.data.firstName;
                                          userDetails.lastName =
                                              loginResponse.data.lastName;
                                          userDetails.token =
                                              loginResponse.data.accessToken;
                                          userDetails.userId =
                                              loginResponse.data.userId;
                                          Provider.of<LanguageChangeProvider>(
                                              context, listen: false).updateUserDetails(
                                              userDetails);
                                          final SharedPreferences loginData = await SharedPreferences
                                              .getInstance();
                                          loginData.setBool('login', false);
                                          loginData.setString('email', regNumber);
                                          loginData.setString('password', passWord);
                                          loginData.setString('role', 'teacher');
                                          loginData.setString(
                                              'firstName',
                                              loginResponse.data.firstName);
                                          loginData.setString(
                                              'lastName', loginResponse.data.lastName);
                                          loginData.setString(
                                              'token', loginResponse.data.accessToken);
                                          loginData.setInt(
                                              'userId', loginResponse.data.userId);
                                          UserDataModel userDataModel = UserDataModel();
                                          userDataModel =
                                          await QnaService.getUserDataService(
                                              loginResponse.data.userId, userDetails);
                                          if (userDataModel.data!.role
                                              .contains("teacher")) {
                                            Navigator.pushNamed(
                                                context,
                                                '/teacherSelectionPage',
                                                arguments: userDataModel
                                            ).then((value) {
                                              emailController.clear();
                                              passwordController.clear();
                                            });
                                          }
                                        }
                                        else if (loginResponse.code == 400) {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: CustomDialog(
                                                title: AppLocalizations.of(context)!
                                                    .oops,
                                               // "OOPS!",
                                                content: AppLocalizations.of(context)!.invalid_role,
                                                //"Invalid Role, Please Check Your Login Data",
                                                button: AppLocalizations.of(context)!
                                                    .retry,
                                              ),
                                            ),
                                          );
                                        }
                                        else if (loginResponse.code == 401) {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: CustomDialog(
                                                title: AppLocalizations.of(
                                                    context)!
                                                    .wrong_password,
                                                //'Wrong password',
                                                content: AppLocalizations
                                                    .of(context)!
                                                    .pls_enter_cr_pass,
                                                //'please enter the correct password',
                                                button: AppLocalizations.of(context)!
                                                    .retry,
                                              ),
                                            ),
                                          );
                                        }
                                    }
                                )),
                            SizedBox(height: height * 0.03),
                            Center(
                                child: Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.no_account,
                                      //Don’t have an account?
                                      style: TextStyle(
                                        fontSize: height * 0.02,
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    ElevatedButton(
                                      style:
                                      ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            width: 1, // the thickness
                                            color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                        ),
                                        minimumSize:
                                        const Size(189, 37),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              39),
                                        ),
                                      ),
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .register,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize:
                                              height *
                                                  0.02,
                                              fontWeight: FontWeight
                                                  .w400,
                                              color: const Color.fromRGBO(82, 165, 160, 1))),
                                      onPressed: () async {
                                        Navigator.pushNamed(context,
                                            '/teacherRegistrationPage');
                                      },
                                    ),
                                    SizedBox(height: height * 0.1),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: AppLocalizations.of(context)!.product_of,
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromRGBO(
                                                              48, 145, 139, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          fontSize: height *
                                                              0.018),
                                                    ),
                                                    TextSpan(
                                                        text: AppLocalizations.of(context)!.itn_welcome,
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight
                                                                .w700,
                                                            fontSize: height *
                                                                0.018)),
                                                  ]))]),
                                  ],
                                )),
                          ])),
                ));
      }
          else if(constraints.maxWidth > 960) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  extendBodyBehindAppBar: true,
                  appBar:AppBar(
                    iconTheme: IconThemeData(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        size: height * 0.05
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: height * 0.06,
                        color: Colors.black,
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
                            AppLocalizations.of(context)!.teacher_caps,
                            //"Teacher Login",
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white
                      ),
                    ),
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
          body:
          SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child:
          Container(
          padding:EdgeInsets.only(left: height * 0.5,right: height * 0.5),
          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.2),
                            Row(
                                children:[
                                  SizedBox(width: width * 0.08),
                                  Text(
                                    AppLocalizations.of(context)!.login_loginPage,
                                    style: TextStyle(
                                      fontSize: height * 0.02,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1),
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )]),
                            SizedBox(height: height * 0.02),
                            Center(
                                child:
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: kElevationToShadow[4],
                                  ),
                                  width: width * 0.35,
                                  child:
                                  Form(
                                    key: formKey,
                                    child:
                                    Column(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(height: height * 0.05),
                                            SizedBox(
                                                width: width * 0.32,
                                                child: TextFormField(
                                                  keyboardType: TextInputType.text,
                                                  controller: emailController,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.deny(
                                                        ' ')
                                                  ],
                                                  onChanged: (val) {
                                                    formKey.currentState!.validate();
                                                  },
                                                  decoration: InputDecoration( floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                    labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                    helperStyle: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: height * 0.016),
                                                    label: Text(
                                                      AppLocalizations.of(context)!
                                                          .regId_emailId,
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: height * 0.03),
                                                    ),
                                                    hintText:
                                                    AppLocalizations.of(context)!
                                                        .hint_regId,
                                                    //Enter here
                                                    hintStyle: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: height * 0.02),
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
                                                ))
                                          ],
                                        ),
                                        SizedBox(height: height * 0.06),
                                        Column(
                                          children: [
                                            SizedBox(
                                                width: width * 0.32,
                                                child: TextFormField(
                                                  controller: passwordController,
                                                  obscureText: _isObscure,
                                                  obscuringCharacter: "*",
                                                  onChanged: (val) {
                                                    formKey.currentState!.validate();
                                                  },
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration( floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                      labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                      label: Text(
                                                        AppLocalizations.of(context)!
                                                            .password,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.03),
                                                      ),
                                                      helperStyle:TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: width * 0.016),
                                                      hintText:
                                                      AppLocalizations.of(context)!
                                                          .your_password,
                                                      //Enter here
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: height * 0.02),
                                                      suffixIcon:
                                                      SizedBox(
                                                          child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children:[
                                                                IconButton(
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
                                                              ]
                                                          ))),
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
                                                ))
                                          ],
                                        ),
                                        SizedBox(height: height * 0.02),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: width * 0.013),
                                            MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        '/forgotPasswordEmail',
                                                        arguments: false
                                                    );
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
                                                          fontSize: height * 0.018)),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: height * 0.03),
                                      ],
                                    ),
                                  ),
                                )),
                            SizedBox(height: height * 0.03),
                            Center(
                                child:IconButton(
                                    iconSize: height * 0.06,
                                    icon: Icon(Icons.arrow_circle_right,
                                      color:
                                      ((passwordController.text.length > 7) && (emailController.text.isNotEmpty || RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+").hasMatch(emailController.text)))
                                          ?  const Color.fromRGBO(82, 165, 160, 1)
                                          :  const Color.fromRGBO(153, 153, 153, 0.5),
                                    ),
                                    onPressed: () async {
                                      bool valid = formKey.currentState!.validate();
                                      regNumber = emailController.text;
                                      passWord = passwordController.text;
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
                                          regNumber, passWord, 'teacher');
                                      Navigator.of(context).pop();
                                      if (loginResponse.code == 200) {
                                        UserDetails userDetails = UserDetails();
                                        userDetails.login = false;
                                        userDetails.email = regNumber;
                                        userDetails.password = passWord;
                                        userDetails.role = 'teacher';
                                        userDetails.firstName =
                                            loginResponse.data.firstName;
                                        userDetails.lastName =
                                            loginResponse.data.lastName;
                                        userDetails.token =
                                            loginResponse.data.accessToken;
                                        userDetails.userId =
                                            loginResponse.data.userId;
                                        Provider.of<LanguageChangeProvider>(
                                            context, listen: false).updateUserDetails(
                                            userDetails);
                                        final SharedPreferences loginData = await SharedPreferences
                                            .getInstance();
                                        loginData.setBool('login', false);
                                        loginData.setString('email', regNumber);
                                        loginData.setString('password', passWord);
                                        loginData.setString('role', 'teacher');
                                        loginData.setString(
                                            'firstName',
                                            loginResponse.data.firstName);
                                        loginData.setString(
                                            'lastName', loginResponse.data.lastName);
                                        loginData.setString(
                                            'token', loginResponse.data.accessToken);
                                        loginData.setInt(
                                            'userId', loginResponse.data.userId);
                                        UserDataModel userDataModel = UserDataModel();
                                        userDataModel =
                                        await QnaService.getUserDataService(
                                            loginResponse.data.userId, userDetails);
                                        if (userDataModel.data!.role
                                            .contains("teacher")) {
                                          Navigator.pushNamed(
                                              context,
                                              '/teacherSelectionPage',
                                              arguments: userDataModel
                                          ).then((value) {
                                            emailController.clear();
                                            passwordController.clear();
                                          });
                                        }
                                      }
                                      else if (loginResponse.code == 400) {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            child: CustomDialog(
                                              title: AppLocalizations.of(context)!
                                                  .oops,
                                              // "OOPS!",
                                              content: AppLocalizations.of(context)!.invalid_role,
                                              //"Invalid Role, Please Check Your Login Data",
                                              button: AppLocalizations.of(context)!
                                                  .retry,
                                            ),
                                          ),
                                        );
                                      }
                                      else if (loginResponse.code == 401) {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            child: CustomDialog(
                                              title: AppLocalizations.of(
                                                  context)!
                                                  .wrong_password,
                                              //'Wrong password',
                                              content: AppLocalizations
                                                  .of(context)!
                                                  .pls_enter_cr_pass,
                                              //'please enter the correct password',
                                              button: AppLocalizations.of(context)!
                                                  .retry,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                )),
                            SizedBox(height: height * 0.03),
                            Center(
                                child: Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.no_account,
                                      //Don’t have an account?
                                      style: TextStyle(
                                        fontSize: height * 0.02,
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    ElevatedButton(
                                      style:
                                      ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            width: 1, // the thickness
                                            color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                        ),
                                        minimumSize:
                                        const Size(189, 37),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              39),
                                        ),
                                      ),
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .register,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize:
                                              height *
                                                  0.02,
                                              fontWeight: FontWeight
                                                  .w400,
                                              color: const Color.fromRGBO(82, 165, 160, 1))),
                                      onPressed: () async {
                                        Navigator.pushNamed(context,
                                            '/teacherRegistrationPage');
                                      },
                                    ),
                                    SizedBox(height: height * 0.1),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: AppLocalizations.of(context)!.product_of,
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromRGBO(
                                                              48, 145, 139, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          fontSize: height *
                                                              0.018),
                                                    ),
                                                    TextSpan(
                                                        text: AppLocalizations.of(context)!.itn_welcome,
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight
                                                                .w700,
                                                            fontSize: height *
                                                                0.018)),
                                                  ]))]),
                                  ],
                                )),
                          ])),
                )));
          }
      else {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  extendBodyBehindAppBar: true,
                  appBar:AppBar(
                    iconTheme: IconThemeData(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        size: height * 0.05
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: height * 0.06,
                        color: Colors.black,
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
                            AppLocalizations.of(context)!.teacher_caps,
                            //"Teacher Login",
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white
                      ),
                    ),
                  ),
                  endDrawer: const EndDrawerMenuPreLogin(),
                  body:
                  SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.2),
                            Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text(
                                  AppLocalizations.of(context)!.login_loginPage,
                                  style: TextStyle(
                                    fontSize: height * 0.02,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                            SizedBox(height: height * 0.02),
                            Center(
                                child:
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: kElevationToShadow[4],
                                  ),
                                  width: width * 0.9,
                                  child:
                                  Form(
                                    key: formKey,
                                    child:
                                    Column(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(height: height * 0.05),
                                            SizedBox(
                                                width: width * 0.8,
                                                child: TextFormField(
                                                  keyboardType: TextInputType.text,
                                                  controller: emailController,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.deny(
                                                        ' ')
                                                  ],
                                                  onChanged: (val) {
                                                    formKey.currentState!.validate();
                                                  },
                                                  decoration: InputDecoration(
                                                    labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.always,
                                                    helperStyle: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: height * 0.016),
                                                    label: Text(
                                                      AppLocalizations.of(context)!
                                                          .regId_emailId,
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: height * 0.02),
                                                    ),
                                                    hintText:
                                                    AppLocalizations.of(context)!
                                                        .hint_regId,
                                                    //Enter here
                                                    hintStyle: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: height * 0.02),
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
                                                ))
                                          ],
                                        ),
                                        SizedBox(height: height * 0.06),
                                        Column(
                                          children: [
                                            SizedBox(
                                                width: width * 0.8,
                                                child: TextFormField(
                                                  controller: passwordController,
                                                  obscureText: _isObscure,
                                                  obscuringCharacter: "*",
                                                  onChanged: (val) {
                                                    formKey.currentState!.validate();
                                                  },
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration( floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                      labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                      label: Text(
                                                        AppLocalizations.of(context)!
                                                            .password,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.02),
                                                      ),
                                                      helperStyle:TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: width * 0.016),
                                                      hintText:
                                                      AppLocalizations.of(context)!
                                                          .your_password,
                                                      //Enter here
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: height * 0.02),
                                                      suffixIcon:
                                                      SizedBox(
                                                          child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children:[
                                                                IconButton(
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
                                                              ]
                                                          ))),
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
                                                ))
                                          ],
                                        ),
                                        SizedBox(height: height * 0.02),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: width * 0.05),
                                            MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        '/forgotPasswordEmail',
                                                        arguments: false
                                                    );
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
                                                          height * 0.018)),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        SizedBox(height: height * 0.03),
                                      ],
                                    ),
                                  ),
                                )),
                            SizedBox(height: height * 0.03),
                            Center(
                                child:IconButton(
                                    iconSize: height * 0.06,
                                    icon: Icon(Icons.arrow_circle_right,
                                      color:
                                      ((passwordController.text.length > 7) && (emailController.text.isNotEmpty || RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+").hasMatch(emailController.text)))
                                          ?  const Color.fromRGBO(82, 165, 160, 1)
                                          :  const Color.fromRGBO(153, 153, 153, 0.5),
                                    ),
                                    onPressed: () async {
                                      bool valid = formKey.currentState!.validate();
                                      regNumber = emailController.text;
                                      passWord = passwordController.text;
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
                                          regNumber, passWord, 'teacher');
                                      Navigator.of(context).pop();
                                      if (loginResponse.code == 200) {
                                        UserDetails userDetails = UserDetails();
                                        userDetails.login = false;
                                        userDetails.email = regNumber;
                                        userDetails.password = passWord;
                                        userDetails.role = 'teacher';
                                        userDetails.firstName =
                                            loginResponse.data.firstName;
                                        userDetails.lastName =
                                            loginResponse.data.lastName;
                                        userDetails.token =
                                            loginResponse.data.accessToken;
                                        userDetails.userId =
                                            loginResponse.data.userId;
                                        Provider.of<LanguageChangeProvider>(
                                            context, listen: false).updateUserDetails(
                                            userDetails);
                                        final SharedPreferences loginData = await SharedPreferences
                                            .getInstance();
                                        loginData.setBool('login', false);
                                        loginData.setString('email', regNumber);
                                        loginData.setString('password', passWord);
                                        loginData.setString('role', 'teacher');
                                        loginData.setString(
                                            'firstName',
                                            loginResponse.data.firstName);
                                        loginData.setString(
                                            'lastName', loginResponse.data.lastName);
                                        loginData.setString(
                                            'token', loginResponse.data.accessToken);
                                        loginData.setInt(
                                            'userId', loginResponse.data.userId);
                                        UserDataModel userDataModel = UserDataModel();
                                        userDataModel =
                                        await QnaService.getUserDataService(
                                            loginResponse.data.userId, userDetails);
                                        if (userDataModel.data!.role
                                            .contains("teacher")) {
                                          Navigator.pushNamed(
                                              context,
                                              '/teacherSelectionPage',
                                              arguments: userDataModel
                                          ).then((value) {
                                            emailController.clear();
                                            passwordController.clear();
                                          });
                                        }
                                      }
                                      else if (loginResponse.code == 400) {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            child: CustomDialog(
                                              title: AppLocalizations.of(context)!
                                                  .oops,
                                              // "OOPS!",
                                              content: AppLocalizations.of(context)!.invalid_role,
                                              //"Invalid Role, Please Check Your Login Data",
                                              button: AppLocalizations.of(context)!
                                                  .retry,
                                            ),
                                          ),
                                        );
                                      }
                                      else if (loginResponse.code == 401) {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            child: CustomDialog(
                                              title: AppLocalizations.of(
                                                  context)!
                                                  .wrong_password,
                                              //'Wrong password',
                                              content: AppLocalizations
                                                  .of(context)!
                                                  .pls_enter_cr_pass,
                                              //'please enter the correct password',
                                              button: AppLocalizations.of(context)!
                                                  .retry,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                )),
                            SizedBox(height: height * 0.03),
                            Center(
                                child: Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.no_account,
                                      //Don’t have an account?
                                      style: TextStyle(
                                        fontSize: height * 0.02,
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    ElevatedButton(
                                      style:
                                      ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            width: 1, // the thickness
                                            color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                        ),
                                        minimumSize:
                                        const Size(189, 37),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              39),
                                        ),
                                      ),
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .register,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize:
                                              height *
                                                  0.02,
                                              fontWeight: FontWeight
                                                  .w400,
                                              color: const Color.fromRGBO(82, 165, 160, 1))),
                                      onPressed: () async {
                                        Navigator.pushNamed(context,
                                            '/teacherRegistrationPage');
                                      },
                                    ),
                                    SizedBox(height: height * 0.1),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: AppLocalizations.of(context)!.product_of,
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromRGBO(
                                                              48, 145, 139, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          fontSize: height *
                                                              0.018),
                                                    ),
                                                    TextSpan(
                                                        text: AppLocalizations.of(context)!.itn_welcome,
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight
                                                                .w700,
                                                            fontSize: height *
                                                                0.018)),
                                                  ]))]),
                                  ],
                                )),
                          ])),
                ));
      }
      }
    );}}
