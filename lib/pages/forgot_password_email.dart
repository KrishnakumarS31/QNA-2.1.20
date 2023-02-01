import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/verify_otp_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../DataSource/qna_repo.dart';
import '../EntityModel/static_response.dart';
import '../Services/qna_service.dart';
//AppLocalizations.of(context)!.agree_privacy_terms
class ForgotPasswordEmail extends StatefulWidget {
  const ForgotPasswordEmail({
    Key? key, required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;


  @override
  ForgotPasswordEmailState createState() => ForgotPasswordEmailState();
}

class ForgotPasswordEmailState extends State<ForgotPasswordEmail> {
  final formKey=GlobalKey<FormState>();
  final TextEditingController _controller= TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon:const Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Colors.white,
            ), onPressed: () {
            Navigator.of(context).pop();
          },
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("FORGET PASSWORD",
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: height * 0.025,
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
            ),),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                    colors: [Color.fromRGBO(82, 165, 160, 1),Color.fromRGBO(0, 106, 100, 1),])
            ),
          ),
        ),
        body: Column(
            children: [
              SizedBox(height:height * 0.1),
              Form(
                key: formKey,
                child: SizedBox(
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
                        onPressed: () async {
                          bool valid=formKey.currentState!.validate();
                          if(valid){
                            StaticResponse response=StaticResponse(code: 0, message: 'Incorrect Email');
                            response = await QnaService.sendOtp(_controller.text);
                            if(response.code==200)
                            {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: showAlertDialog(context)
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
              SizedBox(
                height: height * 0.06,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
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
          Text("OTP Sent!",
            style: TextStyle(
                color: const Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.02),),
        ],
      ),
      content: Text("If this email ID is registered with us you will receive OTP",style: TextStyle(
          color: const Color.fromRGBO(51, 51, 51, 1),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: height * 0.018),),
      actions: [
        TextButton(
          child:  Text("Enter OTP",style: TextStyle(
              color: const Color.fromRGBO(48, 145, 139, 1),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: height * 0.018),),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: VerifyOtpPage(email:_controller.text,setLocale:widget.setLocale),
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


