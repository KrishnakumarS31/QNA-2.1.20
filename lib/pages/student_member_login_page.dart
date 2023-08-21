import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Components/preference.dart';
import 'package:qna_test/Services/qna_service.dart';
import '../Components/custom_incorrect_popup.dart';
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


  @override
  void initState() {
    super.initState();
    //checkIfAlreadyLoggedIn();
    //getData();
  }

  // showDialogSave(BuildContext context, double height,double width,int? code) {
  //   // set up the buttons
  //   Widget cancelButton = ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       minimumSize: width>960 ? Size(width * 0.06, height * 0.05): (width <= 960 && width > 500) ? Size(width * 0.15, height * 0.03) : Size(width * 0.2, height * 0.05),
  //       shape: RoundedRectangleBorder(      borderRadius:
  //       BorderRadius
  //           .circular(
  //           39),),
  //       backgroundColor: Colors.white,
  //       textStyle: TextStyle(
  //           fontSize: height * 0.02,
  //           fontFamily: "Inter",
  //           color: const Color.fromRGBO(48, 145, 139, 1),
  //           fontWeight: FontWeight.w500),
  //     ),
  //     child: Text(
  //       AppLocalizations.of(context)!.retry,
  //       //'No',
  //       style: TextStyle(
  //           fontSize: height * 0.02,
  //           fontFamily: "Inter",
  //           color: const Color.fromRGBO(48, 145, 139, 1),
  //           fontWeight: FontWeight.w500),
  //     ),
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //     },
  //   );
  //   AlertDialog alert = AlertDialog(
  //     title: Row(
  //       children: [
  //         const Icon(
  //           Icons.info,
  //           color: Color.fromRGBO(238, 71, 0, 1),
  //         ),
  //         Text(
  //           AppLocalizations.of(context)!.oops,
  //           //'Confirm',
  //           style: TextStyle(
  //               fontSize: height * 0.02,
  //               fontFamily: "Inter",
  //               color: const Color.fromRGBO(0, 106, 100, 1),
  //               fontWeight: FontWeight.w700),
  //         ),
  //       ],
  //     ),
  //     content: Text(
  //       //AppLocalizations.of(context)!.sure_to_submit_qn_bank,
  //       code == 401 ? 'Please enter the correct password.' : code == 400 ? 'Invalid role. Check your login data': "Server error",
  //       style: TextStyle(
  //           fontSize: height * 0.02,
  //           fontFamily: "Inter",
  //           color: const Color.fromRGBO(51, 51, 51, 1),
  //           fontWeight: FontWeight.w400),
  //     ),
  //     actions: [
  //
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           cancelButton,
  //           SizedBox(height:10.0),
  //         ],
  //       ),
  //
  //     ],
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  showDialogSave(BuildContext context, double height,double width,int? code) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: width>960 ? Size(width * 0.06, height * 0.05): (width <= 960 && width > 500) ? Size(width * 0.15, height * 0.03) : Size(width * 0.2, height * 0.05),
        shape: RoundedRectangleBorder(      borderRadius:
        BorderRadius
            .circular(
            39),),
        backgroundColor: Colors.white,
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        AppLocalizations.of(context)!.retry,
        //'No',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.info,
            color: Color.fromRGBO(238, 71, 0, 1),
          ),
          Text(
            AppLocalizations.of(context)!.confirm,
            //'Confirm',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        //AppLocalizations.of(context)!.sure_to_submit_qn_bank,
         code == 401 ? 'Please enter the correct password.' : code == 400 ? 'Invalid role. Check your login data': "Server error",
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontWeight: FontWeight.w400),
      ),
      actions: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cancelButton,
            const SizedBox(height:10.0),
          ],
        ),

      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;
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
                      size: localHeight * 0.05
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: localHeight * 0.06,
                      color: const Color.fromRGBO(28, 78, 80, 1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  toolbarHeight: localHeight * 0.100,
                  centerTitle: true,
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.member_student,
                          //"Student Login",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: localHeight * 0.025,
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
                          SizedBox(height: localHeight * 0.2),
                          Center(
                              child:
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: kElevationToShadow[4],
                                ),
                                width: localWidth * 0.9,
                                child:
                                Form(
                                  key: formKey,
                                  child:
                                  Column(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(height: localHeight * 0.05),
                                          SizedBox(
                                              width: localWidth * 0.8,
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
                                                  labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                  floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                  helperStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016),
                                                  label: Text(
                                                    AppLocalizations.of(context)!
                                                        .regId_emailId,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: localHeight * 0.025),
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
                                                      fontSize: localHeight * 0.02),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocalizations.of(
                                                        context)!
                                                        .email_uId_helper;
                                                  }
                                                  else if(RegExp(r'^[a-zA-Z0-9]+$')
                                                      .hasMatch(value)) {
                                                    return null;
                                                  }
                                                  else if(!RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                                                .hasMatch(value)) {
                                                    return AppLocalizations.of(context)!
                                                        .enter_valid_email;
                                                  }
                                                  else {
                                                    return null;
                                                  }
                                                },
                                              ))
                                        ],
                                      ),
                                      SizedBox(height: localHeight * 0.06),
                                      Column(
                                        children: [
                                          SizedBox(
                                              width: localWidth * 0.8,
                                              child: TextFormField(
                                                controller: passWordController,
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
                                                          fontSize: localHeight * 0.025),
                                                    ),
                                                    helperStyle:TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: localWidth * 0.016),
                                                    hintText:
                                                    AppLocalizations.of(context)!
                                                        .your_password,
                                                    //Enter here
                                                    hintStyle: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: localHeight * 0.02),
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
                                      SizedBox(height: localHeight * 0.02),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: localWidth * 0.05),
                                          MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      '/forgotPasswordEmail',
                                                      arguments: true
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
                                                        localHeight * 0.018)),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: localHeight * 0.02,
                                      ),
                                      SizedBox(height: localHeight * 0.03),
                                      Center(
                                        child: ElevatedButton(
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
                                              AppLocalizations.of(context)!.login_loginPage,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize:
                                                  localHeight *
                                                      0.02,
                                                  fontWeight: FontWeight
                                                      .w400,
                                                  color: const Color.fromRGBO(82, 165, 160, 1))),
                                          onPressed: () async {
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
                                                        arguments: [userDataModel,null,regNumber])
                                                        .then((value) {
                                                      regNumberController.clear();
                                                      passWordController.clear();
                                                    });
                                                  }
                                                }
                                                else if (loginResponse.code ==
                                                    400 || loginResponse.code == 401) {
                                                  showDialogSave( context,localHeight,localWidth,loginResponse.code);
                                                }
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(height:localHeight * 0.05)
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(height: localHeight * 0.03),

                          SizedBox(height: localHeight * 0.03),
                          Center(
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.no_account,
                                    //Don’t have an account?
                                    style: TextStyle(
                                      fontSize: localHeight * 0.02,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1),
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: localHeight * 0.015),
                                  ElevatedButton(
                                    style:
                                    ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                          width: 1, // the thickness
                                          color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                      ),
                                      minimumSize:
                                     const Size(189 , 37),
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
                                            localHeight *
                                                0.02,
                                            fontWeight: FontWeight
                                                .w400,
                                            color: const Color.fromRGBO(82, 165, 160, 1))),
                                    onPressed: () async {
                                      Navigator.pushNamed(context,
                                          '/studentRegistrationPage');
                                    },
                                  ),
                                  SizedBox(height: localHeight * 0.01),
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
                                        AppLocalizations.of(
                                            context)!
                                            .continue_as_guest,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize:
                                            localHeight *
                                                0.02,
                                            fontWeight: FontWeight
                                                .w400,
                                            color: const Color.fromRGBO(82, 165, 160, 1))),
                                    onPressed: () async {
                                      Navigator.pushNamed(context,
                                          '/studentGuestLogin');
                                    },
                                  ),
                                  SizedBox(height: localHeight * 0.05),
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
                                                        fontSize: localHeight *
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
                                                          fontSize: localHeight *
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
                  iconTheme: IconThemeData(color: const Color.fromRGBO(28, 78, 80, 1),
                      size: localHeight * 0.05),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: localHeight * 0.06,
                      color: const Color.fromRGBO(28, 78, 80, 1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  toolbarHeight: localHeight * 0.100,
                  centerTitle: true,
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.member_student,
                          //"Student Login",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: localHeight * 0.025,
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
                    Center(
                      child: SizedBox(
                          width: localWidth * 0.7,
                          child: Column(
                              children: [
                                SizedBox(height: localHeight * 0.15),
                                Center(
                                    child:
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: kElevationToShadow[4],
                                      ),
                                      width: localWidth * 0.35,
                                      child:
                                      Form(
                                        key: formKey,
                                        child:
                                        Column(
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(height: localHeight * 0.05),
                                                SizedBox(
                                                    width: localWidth * 0.32,
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
                                                      decoration: InputDecoration( floatingLabelBehavior:
                                                      FloatingLabelBehavior.always,
                                                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                        helperStyle: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016),
                                                        label: Text(
                                                          AppLocalizations.of(context)!
                                                              .regId_emailId,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(
                                                                  102, 102, 102, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: localHeight * 0.03),
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
                                                            fontSize: localHeight * 0.02),
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return AppLocalizations.of(
                                                              context)!
                                                              .email_uId_helper;
                                                        }
                                                        else if(RegExp(r'^[a-zA-Z0-9]+$')
                                                            .hasMatch(value)) {
                                                          return null;
                                                        }
                                                        else if(!RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                                                            .hasMatch(value)) {
                                                          return AppLocalizations.of(context)!
                                                              .enter_valid_email;
                                                        }
                                                        else {
                                                          return null;
                                                        }
                                                      },
                                                    ))
                                              ],
                                            ),
                                            SizedBox(height: localHeight * 0.06),
                                            Column(
                                              children: [
                                                SizedBox(
                                                    width: localWidth * 0.32,
                                                    child: TextFormField(
                                                      controller: passWordController,
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
                                                                fontSize: localHeight * 0.03),
                                                          ),
                                                          helperStyle:TextStyle(
                                                              color: const Color.fromRGBO(
                                                                  102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: localWidth * 0.016),
                                                          hintText:
                                                          AppLocalizations.of(context)!
                                                              .your_password,
                                                          //Enter here
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(
                                                                  102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: localHeight * 0.02),
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
                                            SizedBox(height: localHeight * 0.02),
                                            SizedBox(
                                              width: localWidth * 0.32,
                                              child: MouseRegion(
                                                  cursor: SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/forgotPasswordEmail',
                                                          arguments: true
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
                                                            localHeight * 0.018)),
                                                  )),
                                            ),
                                            SizedBox(height: localHeight * 0.03),
                                            Center(

                                              child: ElevatedButton(
                                                style:
                                                ElevatedButton.styleFrom(
                                                  backgroundColor:  const Color.fromRGBO(82, 165, 160, 1),
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
                                                    AppLocalizations.of(context)!.login_loginPage,
                                                  // "Login",
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize:
                                                      localHeight *
                                                          0.02,
                                                      fontWeight: FontWeight
                                                          .w400,
                                                      color: Colors.white,
                                                    )),
                                                onPressed: () async {
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
                                                              arguments: [userDataModel,null,regNumber])
                                                              .then((value) {
                                                            regNumberController.clear();
                                                            passWordController.clear();
                                                          });
                                                        }
                                                      }
                                                      else if (loginResponse.code ==
                                                          400 || loginResponse.code == 401) {
                                                        showDialogSave( context,localHeight,localWidth,loginResponse.code);

                                                      }
                                                    }
                                                  });
                                                },
                                              ),

                                            ),
                                            SizedBox(height: localHeight * 0.05),

                                          ],
                                        ),
                                      ),
                                    )),
                                SizedBox(height: localHeight * 0.03),

                                // SizedBox(height: localHeight * 0.03),
                                Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.no_account,
                                          //Don’t have an account?
                                          style: TextStyle(
                                            fontSize: localHeight * 0.02,
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: localHeight * 0.015),
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
                                                  localHeight *
                                                      0.02,
                                                  fontWeight: FontWeight
                                                      .w400,
                                                  color: const Color.fromRGBO(82, 165, 160, 1))),
                                          onPressed: () async {
                                            Navigator.pushNamed(context,
                                                '/studentRegistrationPage');
                                          },
                                        ),
                                        SizedBox(height: localHeight * 0.015),
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
                                              AppLocalizations.of(
                                                  context)!
                                                  .continue_as_guest,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize:
                                                  localHeight *
                                                      0.02,
                                                  fontWeight: FontWeight
                                                      .w400,
                                                  color: const Color.fromRGBO(82, 165, 160, 1))),
                                          onPressed: () async {
                                            Navigator.pushNamed(context,
                                                '/studentGuestLogin');
                                          },
                                        ),
                                        SizedBox(height: localHeight * 0.05),
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
                                                              fontSize: localHeight *
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
                                                                fontSize: localHeight *
                                                                    0.018)),
                                                      ]))]),
                                      ],
                                    )),
                              ])),
                    )),
              ));
        }
        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                extendBodyBehindAppBar: true,
                appBar:AppBar(
                  iconTheme: IconThemeData(color: const Color.fromRGBO(28, 78, 80, 1),size: localHeight * 0.05),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: localHeight * 0.06,
                      color: const Color.fromRGBO(28, 78, 80, 1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  toolbarHeight: localHeight * 0.100,
                  centerTitle: true,
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.member_student,
                          //"Student Login",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: localHeight * 0.025,
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
                          SizedBox(height: localHeight * 0.2),
                          Center(
                              child:
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: kElevationToShadow[4],
                                ),
                                width: localWidth * 0.9,
                                child:
                                Form(
                                  key: formKey,
                                  child:
                                  Column(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(height: localHeight * 0.05),
                                          SizedBox(
                                              width: localWidth * 0.7,
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
                                                decoration: InputDecoration( floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                                  labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                  helperStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016),
                                                  label: Text(
                                                    AppLocalizations.of(context)!
                                                        .regId_emailId,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: localHeight * 0.02),
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
                                                      fontSize: localHeight * 0.02),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocalizations.of(
                                                        context)!
                                                        .email_uId_helper;
                                                  }
                                                  else if(RegExp(r'^[a-zA-Z0-9]+$')
                                                      .hasMatch(value)) {
                                                    return null;
                                                  }
                                                  else if(!RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                                                      .hasMatch(value)) {
                                                    return AppLocalizations.of(context)!
                                                        .enter_valid_email;
                                                  }
                                                  else {
                                                    return null;
                                                  }
                                                },
                                              ))
                                        ],
                                      ),
                                      SizedBox(height: localHeight * 0.03),
                                      Column(
                                        children: [
                                          SizedBox(
                                              width: localWidth * 0.7,
                                              child: TextFormField(
                                                controller: passWordController,
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
                                                          fontSize: localHeight * 0.02),
                                                    ),
                                                    helperStyle:TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: localWidth * 0.016),
                                                    hintText:
                                                    AppLocalizations.of(context)!
                                                        .your_password,
                                                    //Enter here
                                                    hintStyle: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: localHeight * 0.02),
                                                    suffixIcon:
                                                    Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: Row(
                                                            mainAxisSize: MainAxisSize.min,
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
                                      SizedBox(height: localHeight * 0.02),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: localWidth * 0.1),
                                          MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      '/forgotPasswordEmail',
                                                      arguments: true
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
                                                        localHeight * 0.018)),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: localHeight * 0.02,
                                      ),

                                      Center(
                                        child:ElevatedButton(
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
                                              AppLocalizations.of(context)!.login_loginPage,
                                            //"Login",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize:
                                                localHeight *
                                                    0.02,
                                                fontWeight: FontWeight
                                                    .w400,
                                                color: Colors.white,
                                              )
                                          ),

                                          onPressed: () async {
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
                                                        arguments: [userDataModel,null,regNumber])
                                                        .then((value) {
                                                      regNumberController.clear();
                                                      passWordController.clear();
                                                    });
                                                  }
                                                }
                                                else if (loginResponse.code ==
                                                    400 || loginResponse.code == 401) {
                                                  showDialogSave(context,localHeight,localWidth,loginResponse.code);
                                                }
                                              }
                                            });
                                          },


                                        ),
                                      ),
                                      SizedBox(height: localHeight * 0.05),
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(height: localHeight * 0.03),

                          SizedBox(height: localHeight * 0.02),
                          Center(
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.no_account,
                                    //Don’t have an account?
                                    style: TextStyle(
                                      fontSize: localHeight * 0.02,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1),
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: localHeight * 0.015),
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
                                            localHeight *
                                                0.02,
                                            fontWeight: FontWeight
                                                .w400,
                                            color: const Color.fromRGBO(82, 165, 160, 1))),
                                    onPressed: () async {
                                      Navigator.pushNamed(context,
                                          '/studentRegistrationPage');
                                    },
                                  ),
                                  SizedBox(height: localHeight * 0.015),
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
                                        AppLocalizations.of(
                                            context)!
                                            .continue_as_guest,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize:
                                            localHeight *
                                                0.02,
                                            fontWeight: FontWeight
                                                .w400,
                                            color: const Color.fromRGBO(82, 165, 160, 1))),
                                    onPressed: () async {
                                      Navigator.pushNamed(context,
                                          '/studentGuestLogin');
                                    },
                                  ),
                                  SizedBox(height: localHeight * 0.05),
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
                                                        fontSize: localHeight *
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
                                                          fontSize: localHeight *
                                                              0.018)),
                                                ]))]),
                                ],
                              )),
                        ])),
              ));
        }
      },
    );
  }
}
