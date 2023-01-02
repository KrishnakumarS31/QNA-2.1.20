import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/stud_guest_assessment.dart';
import 'package:qna_test/Pages/teacher_selection_page.dart';

import '../Components/custom_incorrect_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../DataSource/qna_test_repo.dart';
import '../Entity/custom_http_response.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

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
  late Future<Response> userDetails;
  @override
  void initState() {
    userDetails=QnaTestRepo.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              size: height * 0.035,
                              color: Colors.white,
                            ), onPressed: () {
                            Navigator.of(context).pop();
                          },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              size: height * 0.035,
                              color: Colors.white,
                            ), onPressed: () {
                            // Navigator.of(context).pop();
                          },
                          ),
                        ],
                      ),
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
                                    color: Color.fromRGBO(102, 102, 102, 1),
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
                                    hintStyle: TextStyle(color: Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.02),
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
                                    color: Color.fromRGBO(102, 102, 102, 1),
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
                                    hintStyle: TextStyle(color: Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.02),

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

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(AppLocalizations.of(context)!.forgot_password,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                ?.merge( TextStyle(
                                color: Color.fromRGBO(48, 145, 139, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: height * 0.017)),),
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
                  onPressed: () {
                    bool valid=formKey.currentState!.validate();
                    if(valid){
                      Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: TeacherSelectionPage(name: name),
                                ),
                              );
                    }

                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                        fontSize: height * 0.032,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(height:height * 0.061),
                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        IconButton(
                          icon:  Icon(
                            Icons.edit_note_sharp,
                            color: Color.fromRGBO(141, 167, 167, 1),
                            size: height * 0.034,
                          ),
                          onPressed: () {

                          },
                        ),
                        Text(AppLocalizations.of(context)!.register,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                ?.merge(const TextStyle(
                                color: Color.fromRGBO(48, 145, 139, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16))),
                      ],
                    )),




              ]),
        ));
  }
}


