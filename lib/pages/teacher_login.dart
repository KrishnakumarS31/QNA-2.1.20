import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_forgot_password_email.dart';
import 'package:qna_test/Pages/teacher_registration_page.dart';
import 'package:qna_test/Pages/teacher_selection_page.dart';
import 'package:qna_test/Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Components/custom_incorrect_popup.dart';
import 'settings_languages.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key, required this.setLocale});
  final void Function(Locale locale) setLocale;

  @override
  TeacherLoginState createState() => TeacherLoginState();
}

class TeacherLoginState extends State<TeacherLogin> {
  bool _isObscure = true;
  final formKey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool agree = false;
  String name='';
  //late Response userDetails;
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);

  @override
  void initState() {
    //getUserDetails();

    super.initState();
  }



getUserDetails() async {
  //userDetails=await QnaService.getUserDataService();
}
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
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
          backgroundColor: const Color.fromRGBO(0,106,100,1),
        ),
        endDrawer: Drawer(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient:  LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(0, 106, 100, 1),
                        Color.fromRGBO(82, 165, 160, 1),
                      ],
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      alignment: Alignment.center,
                      height: height / 6,
                      child:
                      Row(
                          children:  [
                            CircleAvatar(
                              backgroundColor: const Color.fromRGBO(0,106,100,0),
                              radius: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.15,
                              child: Image.asset(
                                "assets/images/ProfilePic_Avatar.png",
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              "Teacher Name",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  ?.merge(const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.02,
                                  fontSize: 16)),
                            ),
                          ]),
                    ),
                    const SizedBox(height: 0.022),
                    Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: width * 0.09),
                            child: Text(
                              AppLocalizations.of(context)!.teacher,
                              style: const TextStyle(
                                  color: Color.fromRGBO(221, 221, 221, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.02,
                                  fontSize: 12),
                            )
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: width * 0.09),
                            child: const Text(
                              "teacher@gmail.com",
                              style: TextStyle(
                                  color: Color.fromRGBO(221, 221, 221, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.02,
                                  fontSize: 12),
                            )
                        ),
                      ],
                    ),
                    //    )
                  ],
                ),
              ),
              Flexible(
                child: ListView(
                  children: [
                    ListTile(
                        leading:
                        const Icon(
                            Icons.translate,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.language,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: SettingsLanguages(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.verified_user_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.privacy_and_terms,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.note_alt_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.cookie_policy,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.perm_contact_calendar_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.about_us,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16)),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.help_outline,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.help,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        onTap: () async {
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height * 0.26,
                  width: width,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).primaryColor,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(0, 106, 100, 1),
                        Color.fromRGBO(82, 165, 160, 1)
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            width ,
                            height * 0.40)
                    ),
                  ),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children : [
                      SizedBox(height:height * 0.03),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     IconButton(
                      //       icon: Icon(
                      //         Icons.chevron_left,
                      //         size: height * 0.035,
                      //         color: Colors.white,
                      //       ), onPressed: () {
                      //       Navigator.of(context).pop();
                      //     },
                      //     ),
                      //     IconButton(
                      //       icon: Icon(
                      //         Icons.menu,
                      //         size: height * 0.035,
                      //         color: Colors.white,
                      //       ), onPressed: () {
                      //       // Navigator.of(context).pop();
                      //     },
                      //     ),
                      //   ],
                      // ),
                      Align(
                        alignment: Alignment.topCenter,
                        child:
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          height: height * 0.16,
                          width: width * 0.30,
                          // decoration: BoxDecoration(
                          //     //color: Colors.yellow[100],
                          //     border: Border.all(
                          //       color: Colors.red,
                          //       width: 1,
                          //     )),
                          child: Image.asset("assets/images/question_mark_logo.png"),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height:height * 0.03),
                Text(
                  AppLocalizations.of(context)!.teacher_caps,
                  style: TextStyle(
                    fontSize: height* 0.03,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height:height * 0.07),
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
                              child:
                              Text(AppLocalizations.of(context)!.email_id_caps,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1
                                    ?.merge( TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.017)),),

                            ),
                            SizedBox(
                              height: height * 0.0001,
                            ),
                            Align(alignment: Alignment.center,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!.email_id,
                                    hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.02),
                                    prefixIcon: Icon(
                                      Icons.account_box_outlined,color: const Color.fromRGBO(82, 165, 160, 1),size: height * 0.03,),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)){
                                      return AppLocalizations.of(context)!.enter_valid_email;
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                )
                            ),
                          ],
                        ),
                        SizedBox(height:height * 0.0375),
                        //SizedBox(height:height * 0.04),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child:
                              Text(AppLocalizations.of(context)!.password_caps,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1
                                    ?.merge( TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.017)),),

                            ),
                            SizedBox(
                              height: height * 0.0001,
                            ),
                            Align(alignment: Alignment.center,
                                child: TextFormField(
                                  obscureText: _isObscure,
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                              _isObscure ? Icons.visibility : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          }),
                                    hintText: AppLocalizations.of(context)!.your_password,
                                    hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.02),

                                    prefixIcon: Icon(

                                        Icons.lock,color: const Color.fromRGBO(82, 165, 160, 1),size: height * 0.03,),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return AppLocalizations.of(context)!.enter_your_password;
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                )
                            ),
                          ],
                        ),
                        SizedBox(height:height * 0.025),

                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const TeacherForgotPasswordEmail(),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(AppLocalizations.of(context)!.forgot_password,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  ?.merge( TextStyle(
                                  color: const Color.fromRGBO(48, 145, 139, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: height * 0.017)),),
                          ),
                        ),
                        SizedBox(height:height * 0.052),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                    minimumSize: const Size(280, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(39),
                    ),
                  ),
                  //shape: StadiumBorder(),
                  onPressed: () async {
                    //print(userDetails.data.userProfile[0].emailId);
                    bool valid=formKey.currentState!.validate();
                    showDialog(context: context, builder: (context){
                      return const Center(child: CircularProgressIndicator(
                        color: Color.fromRGBO(48, 145, 139, 1),
                      ));
                    });
                    // int statusCode =
                    //     await QnaService.logInUser(emailController.text.trim(), passwordController.text.trim());
                    // Navigator.of(context).pop();
                    // if(statusCode == 200){
                      Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: TeacherSelectionPage(name: name,setLocale: widget.setLocale),
                                ),
                              ).then((value) {
                        emailController.clear();
                        passwordController.clear();
                      });
                   // }
                    // else{
                    //   Navigator.push(
                    //     context,
                    //     PageTransition(
                    //       type: PageTransitionType.rightToLeft,
                    //       child: CustomDialog(
                    //         title: 'Incorrect Email Id / Password',
                    //         content:
                    //         'Entered Email ID or password is not valid',
                    //         button: AppLocalizations.of(context)!.retry,
                    //       ),
                    //     ),
                    //   );
                    // }

                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                        fontSize: height * 0.027,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(height:height * 0.061),
                GestureDetector(
                  onTap: (){
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
                        icon:  Icon(
                          Icons.edit_note_sharp,
                          color: const Color.fromRGBO(141, 167, 167, 1),
                          size: height * 0.034,
                        ),
                        onPressed: () {

                        },
                      ),
                      Text(AppLocalizations.of(context)!.register,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge( TextStyle(
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


