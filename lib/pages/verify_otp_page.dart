import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/student_forgot_password.dart';
import '../EntityModel/static_response.dart';
import '../Services/qna_service.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({
    Key? key,
    required this.setLocale, required this.email,
  }) : super(key: key);
  final String email;
  final void Function(Locale locale) setLocale;
  @override
  VerifyOtpPageState createState() => VerifyOtpPageState();
}

class VerifyOtpPageState extends State<VerifyOtpPage> {
  final formKey=GlobalKey<FormState>();
TextEditingController otpController = TextEditingController();
late String otp;
  bool error =false;
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 5);
  @override
  void initState() {
    error =false;
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    super.initState();
  }
  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
          title: Text(
            "VERIFY OTP",
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
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
              SizedBox(height:height * 0.03),
              SizedBox(height:height * 0.04),
              Form(
                key: formKey,
                child: SizedBox(
                  height: height * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      SizedBox(
                        width: width * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text:"CHECK YOUR EMAIL FOR OTP",
                                      style: TextStyle(
                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: height * 0.017),),
                                    TextSpan(
                                        text: "\t*",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(219, 35, 35, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.017)),
                                  ])),
                            ),
                            SizedBox(
                              height: height * 0.0001,
                            ),
                            Align(alignment: Alignment.center,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: otpController,
                                  onChanged: (val)
                                  {
                                    formKey.currentState!.validate();
                                  },
                                  decoration: const InputDecoration(
                                    helperStyle: TextStyle(color: Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 16),
                                    hintText: "Enter OTP",

                                  ),
                                  validator: (value){
                                    if(value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)){
                                      return "Incorrect OTP";
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                )
                            ),
                            SizedBox(height:height * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.circle,color: Color.fromRGBO(141, 167, 167, 1),size: 6,),
                                const SizedBox(width: 4,),
                                const Text("The OTP will be expired in",
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)
                                  ),
                                Text(" $minutes:$seconds",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14)
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.circle,color: Color.fromRGBO(141, 167, 167, 1),size: 6,),
                                const SizedBox(width: 4,),
                                const Text("Don't receive OTP?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)
                                  ,),
                                TextButton(onPressed: (){

                                },
                                    child: const Text("   Resend OTP",
                                    style: TextStyle(
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14)))
                              ],
                            )
                          ],
                        ),
                      ),

                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                            minimumSize: const Size(280, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(39),
                            ),
                          ),
                          onPressed: () async {
                            if(formKey.currentState!.validate()) {
                              otp=otpController.text;
                              StaticResponse res=await QnaService.verifyOtp(widget.email,otp);
                              if (res.code==200) {

                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: showAlertDialog(context,res.message)
                                  ),
                                );
                              }
                              else{
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: StudentForgotPassword(email: widget.email, otp: otp,setLocale: widget.setLocale,)
                                  ),
                                );

                              }
                            }
                          },
                          child: Text(
                            'Validate',
                            style: TextStyle(
                                fontSize: height * 0.024,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),

            ]));
  }
  showAlertDialog(BuildContext context,String msg) {
    // set up the button
    double height = MediaQuery.of(context).size.height;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(Icons.check_circle,size: height * 0.04,color: const Color.fromRGBO(66, 194, 0, 1),),
          SizedBox(width: height * 0.002,),
          const Text("Success!",
          style: TextStyle(
              color: Color.fromRGBO(51, 51, 51, 1),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 20),),
        ],
      ),
      content:  Text(msg,style: TextStyle(
          color: Color.fromRGBO(51, 51, 51, 1),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: 15),),
      actions: [
        TextButton(
          child: const Text("Login",style: TextStyle(
              color: Color.fromRGBO(48, 145, 139, 1),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 15),),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: StudentForgotPassword(email: widget.email, otp: otp,setLocale: widget.setLocale)
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


