import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_verify_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
//AppLocalizations.of(context)!.agree_privacy_terms
class TeacherForgotPasswordEmail extends StatefulWidget {
  TeacherForgotPasswordEmail({
    Key? key,
  }) : super(key: key);


  @override
  TeacherForgotPasswordEmailState createState() => TeacherForgotPasswordEmailState();
}

class TeacherForgotPasswordEmailState extends State<TeacherForgotPasswordEmail> {
  final formKey=GlobalKey<FormState>();
  TextEditingController _controller= TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
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
                          height * 0.30)
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [
                    Container(
                      width: width * 0.03,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(0.0),
                        height: height * 0.22,
                        width: width * 0.22,
                        // decoration: BoxDecoration(
                        //     //color: Colors.yellow[100],
                        //     border: Border.all(
                        //       color: Colors.red,
                        //       width: 1,
                        //     )),
                        child: Image.asset("assets/images/question_mark_logo.png"),
                      ),
                    ),
                    Container(
                      width: width * 0.03,
                    )

                  ],
                ),
              ),
              SizedBox(height:height * 0.03),
              Text(
                AppLocalizations.of(context)!.forgot_password,
                style: TextStyle(
                  color: Color.fromRGBO(82, 165, 160, 1),
                  fontSize: height * 0.027,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: height * 0.055,
              ),

              Form(
                key: formKey,
                child: Container(
                  height: height*0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Padding(
                        padding:  EdgeInsets.only(left: height * 0.025,right: height * 0.025),
                        child: TextFormField(
                          controller: _controller,
                          keyboardType: TextInputType.text,

                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: AppLocalizations.of(context)!.enter_email_id,
                            labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: height * 0.015),
                            helperText: AppLocalizations.of(context)!.email_helper_text,
                            helperStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w500,fontSize: height * 0.015),
                            hintText: AppLocalizations.of(context)!.email_hint,
                            hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.02),
                            focusedBorder:  OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
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
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                          minimumSize:  Size(width * 0.77, height * 0.06),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(39),
                          ),
                        ),
                        onPressed: () {
                          bool valid=formKey.currentState!.validate();
                          if(valid){
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: showAlertDialog(height)
                              ),
                            );
                          }

                        },
                        child: Text(
                          AppLocalizations.of(context)!.send_otp,
                          style: TextStyle(
                              fontSize: height * 0.024,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Color.fromRGBO(82, 165, 160, 1),
                          ),
                          onPressed: () {},
                        ),
                        Text(AppLocalizations.of(context)!.back,
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
              ),
            ]));
  }
  showAlertDialog(double height) {
    // set up the button
    //double height = MediaQuery.of(context).size.height;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(Icons.check_circle,size: height * 0.04,color: Color.fromRGBO(66, 194, 0, 1),),
          SizedBox(width: height * 0.002,),
          Text("OTP Sent!",
            style: TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.02),),
        ],
      ),
      content: Text("If this email ID is registered with us you will receive OTP",style: TextStyle(
          color: Color.fromRGBO(51, 51, 51, 1),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: height * 0.018),),
      actions: [
        TextButton(
          child:  Text("Enter OTP",style: TextStyle(
              color: Color.fromRGBO(48, 145, 139, 1),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: height * 0.018),),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TeacherVerifyOtpPage(email:_controller.text),
              ),
            );
          },
        )
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
}


