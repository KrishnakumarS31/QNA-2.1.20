import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Pages/student_member_login_page.dart';
import 'package:qna_test/Services/qna_service.dart';
import '../Components/custom_incorrect_popup.dart';
import '../EntityModel/static_response.dart';

class StudentForgotPassword extends StatefulWidget {
  const StudentForgotPassword({
    Key? key,
    required this.email,
    required this.otp,required this.setLocale
  }) : super(key: key);

final String email;
final String otp;
final void Function(Locale locale) setLocale;
  @override
  StudentForgotPasswordState createState() => StudentForgotPasswordState();
}

class StudentForgotPasswordState extends State<StudentForgotPassword> {
  final formKey=GlobalKey<FormState>();
  TextEditingController oldPassword= TextEditingController();
  TextEditingController newPassword= TextEditingController();


  @override
  void initState() {
    //QnaService.sendOtp('jjkj');
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
                AppLocalizations.of(context)!.reset_password_caps,
                style: TextStyle(
                  color: const Color.fromRGBO(82, 165, 160, 1),
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
                child: SizedBox(
                  height: height*0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: height * 0.025,right: height * 0.025),
                            child: TextFormField(
                              controller: oldPassword,
                              keyboardType: TextInputType.text,

                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelText: AppLocalizations.of(context)!.new_password_caps,
                                labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: height * 0.015),
                                hintText: AppLocalizations.of(context)!.new_password,
                                hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.02),
                                focusedBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return AppLocalizations.of(context)!.enter_email_id;
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(height: height * 0.03,),
                          Padding(
                            padding:  EdgeInsets.only(left: height * 0.025,right: height * 0.025),
                            child: TextFormField(
                              controller: newPassword,
                              keyboardType: TextInputType.text,

                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelText: AppLocalizations.of(context)!.confirm_new_password_caps,
                                labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: height * 0.015),
                                hintText: AppLocalizations.of(context)!.confirm_new_password,
                                hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.02),
                                focusedBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return AppLocalizations.of(context)!.enter_email_id;
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                          ),

                        ],
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                          minimumSize:  Size(width * 0.77, height * 0.06),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(39),
                          ),
                        ),
                        onPressed: () async {
                          bool valid=formKey.currentState!.validate();
                          if(valid){
                            StaticResponse res=await QnaService.updatePasswordOtp(widget.email,widget.otp,newPassword.text);
                            //int statusCode= QnaService.updatePasswordOtp(widget.email,widget.otp, newPassword.text);
                            if(res.code==200){
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: showAlertDialog(context)
                                ),
                              );
                            }
                            else{
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: CustomDialog(title: 'Incorrect Password', content: 'Your Password has not been changed', button: AppLocalizations.of(context)!.retry,),
                                ),
                              );
                            }

                          }

                        },
                        child: Text(
                          AppLocalizations.of(context)!.submit,
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


            ]));
  }
  showAlertDialog(BuildContext context) {
    // set up the button
    double height = MediaQuery.of(context).size.height;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(Icons.check_circle,size: height * 0.04,color: const Color.fromRGBO(66, 194, 0, 1),),
          SizedBox(width: height * 0.002,),
          Text("Success",
            style: TextStyle(
                color: const Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.02),),
        ],
      ),
      content: Text("Password Changed successfully",style: TextStyle(
          color: const Color.fromRGBO(51, 51, 51, 1),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: height * 0.018),),
      actions: [
        TextButton(
          child:  Text("OK",style: TextStyle(
              color: const Color.fromRGBO(48, 145, 139, 1),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: height * 0.018),),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child:
                StudentMemberLoginPage(setLocale: widget.setLocale),
              ),
            );
            //Navigator.of(context).pop();
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