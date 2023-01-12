import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Services/qna_service.dart';
import '../Components/custom_incorrect_popup.dart';
//AppLocalizations.of(context)!.agree_privacy_terms
class ResetPassword extends StatefulWidget {
  const ResetPassword({
    Key? key,
  }) : super(key: key);


  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final formKey=GlobalKey<FormState>();
  TextEditingController oldPassword= TextEditingController();
  TextEditingController newPassword= TextEditingController();
  TextEditingController reNewPassword= TextEditingController();

  @override
  void initState() {
    QnaService.sendOtp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                                labelText: AppLocalizations.of(context)!.old_password_caps,
                                labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: height * 0.015),
                                hintText: AppLocalizations.of(context)!.old_password,
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
                              controller: reNewPassword,
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
                                if(newPassword.text!=reNewPassword.text)
                                {
                                  return AppLocalizations.of(context)!.mis_match_password;
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
                        onPressed: () {
                          bool valid=formKey.currentState!.validate();
                          if(valid || newPassword.text==reNewPassword.text){
                           int statusCode= QnaService.updatePassword(oldPassword.text, newPassword.text);
                           if(statusCode==200){
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
      content: Text("Your Password has been changed Successfully",style: TextStyle(
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
            Navigator.of(context).pop();
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