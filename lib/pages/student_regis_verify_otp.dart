import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/EntityModel/student_registration_model.dart';

import '../Components/custom_incorrect_popup.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/static_response.dart';
import '../Services/qna_service.dart';

class StudentRegisVerifyOtpPage extends StatefulWidget {
  const StudentRegisVerifyOtpPage({Key? key, required this.student})
      : super(key: key);

  final StudentRegistrationModel student;

  @override
  StudentRegisVerifyOtpPageState createState() =>
      StudentRegisVerifyOtpPageState();
}

class StudentRegisVerifyOtpPageState extends State<StudentRegisVerifyOtpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  late String otp;
  bool error = false;
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 5);
  bool enableResendButton = false;

  @override
  void initState() {
    super.initState();
    error = false;
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        enableResendButton = true;
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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints)
    {
      if (constraints.maxWidth > 500) {
        return Center(
            child: SizedBox(
            width: 400,
            child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "VERIFY OTP",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 18.0,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.bottomRight,
                          begin: Alignment.topLeft,
                          colors: [
                            Color.fromRGBO(82, 165, 160, 1),
                            Color.fromRGBO(0, 106, 100, 1),
                          ])),
                ),
              ),
              body: Column(children: [
                SizedBox(height: height * 0.04),
                Form(
                  key: formKey,
                  child: SizedBox(
                    height: height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "CHECK YOUR EMAIL FOR OTP",
                                  style: Theme
                                      .of(context)
                                      .primaryTextTheme
                                      .bodyLarge
                                      ?.merge(const TextStyle(
                                      color: Color.fromRGBO(102, 102, 102, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.0001,
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: otpController,
                                    decoration: const InputDecoration(
                                      helperStyle: TextStyle(
                                          color:
                                          Color.fromRGBO(102, 102, 102, 0.3),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                      hintText: "Enter OTP",
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(r'^\d+$').hasMatch(value)) {
                                        return "Incorrect OTP";
                                      } else {
                                        return null;
                                      }
                                    },
                                  )),
                              SizedBox(height: height * 0.04),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Color.fromRGBO(141, 167, 167, 1),
                                    size: 6,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text("The OTP will be expired in",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              153, 153, 153, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14)),
                                  Text(" $minutes:$seconds",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Color.fromRGBO(141, 167, 167, 1),
                                    size: 6,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text(
                                    "Don't receive OTP?",
                                    style: TextStyle(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  TextButton(
                                      onPressed: enableResendButton ?
                                          () async {
                                        LoginModel response =
                                        await QnaService.postUserDetailsService(
                                            widget.student);
                                        if (response.code == 200) {
                                          if (context.mounted) {
                                            showResendDialog(context);
                                          }
                                          // Navigator.push(
                                          //   context,
                                          //   PageTransition(
                                          //       type: PageTransitionType.rightToLeft,
                                          //       child: showAlertDialog(context)),
                                          // );
                                        }
                                      }
                                          : null
                                      ,
                                      child: Text("   Resend OTP",
                                          style: TextStyle(
                                              color: enableResendButton == false
                                                  ? Colors.grey
                                                  :
                                              const Color.fromRGBO(
                                                  82, 165, 160, 1),
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
                              backgroundColor:
                              const Color.fromRGBO(82, 165, 160, 1),
                              minimumSize: const Size(280, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(39),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                otp = otpController.text;
                                StaticResponse res =
                                await QnaService.verifyOtp(
                                    widget.student.email, otp);
                                if (res.code == 200) {
                                  if (context.mounted) {
                                    showAlertDialog(context);
                                  }
                                } else {
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: CustomDialog(
                                          title: 'Incorrect Otp',
                                          content: 'Entered OTP does not match',
                                          button:
                                          AppLocalizations.of(context)!.retry,
                                        ),
                                      ),
                                    );
                                  }
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
              ])))));
    }
      else{
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    "VERIFY OTP",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 18.0,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 40.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            end: Alignment.bottomRight,
                            begin: Alignment.topLeft,
                            colors: [
                              Color.fromRGBO(82, 165, 160, 1),
                              Color.fromRGBO(0, 106, 100, 1),
                            ])),
                  ),
                ),
                body: Column(children: [
                  SizedBox(height: height * 0.04),
                  Form(
                    key: formKey,
                    child: SizedBox(
                      height: height * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "CHECK YOUR EMAIL FOR OTP",
                                    style: Theme
                                        .of(context)
                                        .primaryTextTheme
                                        .bodyLarge
                                        ?.merge(const TextStyle(
                                        color: Color.fromRGBO(102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.0001,
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: otpController,
                                      decoration: const InputDecoration(
                                        helperStyle: TextStyle(
                                            color:
                                            Color.fromRGBO(102, 102, 102, 0.3),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                        hintText: "Enter OTP",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^\d+$').hasMatch(value)) {
                                          return "Incorrect OTP";
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                                SizedBox(height: height * 0.04),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Color.fromRGBO(141, 167, 167, 1),
                                      size: 6,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text("The OTP will be expired in",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14)),
                                    Text(" $minutes:$seconds",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Color.fromRGBO(141, 167, 167, 1),
                                      size: 6,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      "Don't receive OTP?",
                                      style: TextStyle(
                                          color: Color.fromRGBO(153, 153, 153, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                    TextButton(
                                        onPressed: enableResendButton ?
                                            () async {
                                          LoginModel response =
                                          await QnaService.postUserDetailsService(
                                              widget.student);
                                          if (response.code == 200) {
                                            if (context.mounted) {
                                              showResendDialog(context);
                                            }
                                            // Navigator.push(
                                            //   context,
                                            //   PageTransition(
                                            //       type: PageTransitionType.rightToLeft,
                                            //       child: showAlertDialog(context)),
                                            // );
                                          }
                                        }
                                            : null
                                        ,
                                        child: Text("   Resend OTP",
                                            style: TextStyle(
                                                color: enableResendButton == false
                                                    ? Colors.grey
                                                    :
                                                const Color.fromRGBO(
                                                    82, 165, 160, 1),
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
                                backgroundColor:
                                const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: const Size(280, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  otp = otpController.text;
                                  StaticResponse res =
                                  await QnaService.verifyOtp(
                                      widget.student.email, otp);
                                  if (res.code == 200) {
                                    if (context.mounted) {
                                      showAlertDialog(context);
                                    }
                                  } else {
                                    if (context.mounted) {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title: 'Incorrect Otp',
                                            content: 'Entered OTP does not match',
                                            button:
                                            AppLocalizations.of(context)!.retry,
                                          ),
                                        ),
                                      );
                                    }
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
                ])));
      }
    }
    );}

  showAlertDialog(BuildContext context) {
    // set up the button
    double height = MediaQuery.of(context).size.height;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: height * 0.04,
            color: const Color.fromRGBO(66, 194, 0, 1),
          ),
          SizedBox(
            width: height * 0.002,
          ),
          const Text(
            "Success!",
            style: TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ],
      ),
      content: const Text(
        "Your registration has been\nsuccessfully completed.",
        style: TextStyle(
            color: Color.fromRGBO(51, 51, 51, 1),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 15),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(48, 145, 139, 1),
          ),
          child: const Text(
            "Ok",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          onPressed: () {
           Navigator.popUntil(context, ModalRoute.withName('/studentMemberLoginPage'));
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

  showResendDialog(BuildContext context) {
    // set up the button
    double height = MediaQuery.of(context).size.height;
    Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(48, 145, 139, 1),
      ),
      child: Text(
        "OK",
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: height * 0.018),
      ),
      onPressed: () {
        setState(() {
          enableResendButton = false;
          myDuration = const Duration(minutes: 5);
          countdownTimer =
              Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
        });
        Navigator.pop(context);


      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: height * 0.04,
            color: const Color.fromRGBO(66, 194, 0, 1),
          ),
          SizedBox(
            width: height * 0.002,
          ),
          Text(
            "OTP Sent!",
            style: TextStyle(
                color: const Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.02),
          ),
        ],
      ),
      content: Text(
        "If this email ID is registered with us you will receive OTP",
        style: TextStyle(
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: height * 0.018),
      ),
      actions: [okButton],
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
