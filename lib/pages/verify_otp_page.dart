import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/custom_incorrect_popup.dart';
import '../EntityModel/static_response.dart';
import '../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../DataSource/http_url.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({
    Key? key,

    required this.isFromStudent,
    required this.email,
  }) : super(key: key);
  final String email;
  final bool isFromStudent;


  @override
  VerifyOtpPageState createState() => VerifyOtpPageState();
}

class VerifyOtpPageState extends State<VerifyOtpPage> {
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
      if (constraints.maxWidth > webWidth) {
        return Center(
            child: SizedBox(
            width: webWidth,
            child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: AppBar(
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
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context)!.verify_otp,
                    //"VERIFY OTP",
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: height * 0.025,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
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
                  SizedBox(height: height * 0.03),
                  SizedBox(height: height * 0.04),
                  Form(
                    key: formKey,
                    child: SizedBox(
                      height: height * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: webWidth * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                          AppLocalizations.of(context)!
                                              .check_email_otp,
                                          //"CHECK YOUR EMAIL FOR OTP",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.017),
                                        ),
                                        TextSpan(
                                            text: "\t*",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    219, 35, 35, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: height * 0.017)),
                                      ])),
                                ),
                                SizedBox(
                                  height: height * 0.0001,
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: otpController,
                                      onChanged: (val) {
                                        formKey.currentState!.validate();
                                      },
                                      decoration: InputDecoration(
                                          helperStyle: const TextStyle(
                                              color:
                                              Color.fromRGBO(
                                                  102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                          hintText:
                                          AppLocalizations.of(context)!
                                              .enter_otp
                                        //"Enter OTP",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^\d+$').hasMatch(value)) {
                                          return
                                            AppLocalizations.of(context)!
                                                .incorrect_otp;
                                          //"Incorrect OTP";
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
                                    Text(
                                        AppLocalizations.of(context)!
                                            .otp_expire_in,
                                        //"The OTP will be expired in",
                                        style: const TextStyle(
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
                                    Text(
                                      AppLocalizations.of(context)!
                                          .don_receive_otp,
                                      //"Don't receive OTP?",
                                      style: const TextStyle(
                                          color: Color.fromRGBO(
                                              153, 153, 153, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                    TextButton(
                                        onPressed: enableResendButton ?
                                            () async {
                                          StaticResponse response = StaticResponse(
                                              code: 0,
                                              message: 'Incorrect Email');
                                          response = await QnaService.sendOtp(
                                              widget.email);
                                          if (response.code == 200) {
                                            showResendDialog(context);
                                          }
                                        }
                                            : null
                                        ,
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .resent_otp,
                                            //"   Resend OTP",
                                            style: TextStyle(
                                                color: enableResendButton ==
                                                    false
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
                                  StaticResponse res = await QnaService
                                      .validateOtp(
                                      widget.email, otp);
                                  if (res.code == 200) {
                                    showAlertDialog(context, res.message);
                                  }
                                  else if (res.code != 200 &&
                                      res.code != null) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: CustomDialog(
                                          title:
                                          AppLocalizations.of(context)!
                                              .alert_popup,
                                          //"Error",
                                          content: res.message,
                                          button:
                                          AppLocalizations.of(context)!.retry,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.validate,
                                //'Validate',
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
      else {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: AppBar(
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
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context)!.verify_otp,
                    //"VERIFY OTP",
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: height * 0.025,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
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
                  SizedBox(height: height * 0.03),
                  SizedBox(height: height * 0.04),
                  Form(
                    key: formKey,
                    child: SizedBox(
                      height: height * 0.6,
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
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                          AppLocalizations.of(context)!
                                              .check_email_otp,
                                          //"CHECK YOUR EMAIL FOR OTP",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.017),
                                        ),
                                        TextSpan(
                                            text: "\t*",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    219, 35, 35, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: height * 0.017)),
                                      ])),
                                ),
                                SizedBox(
                                  height: height * 0.0001,
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: otpController,
                                      onChanged: (val) {
                                        formKey.currentState!.validate();
                                      },
                                      decoration: InputDecoration(
                                          helperStyle: const TextStyle(
                                              color:
                                              Color.fromRGBO(
                                                  102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                          hintText:
                                          AppLocalizations.of(context)!
                                              .enter_otp
                                        //"Enter OTP",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^\d+$').hasMatch(value)) {
                                          return
                                            AppLocalizations.of(context)!
                                                .incorrect_otp;
                                          //"Incorrect OTP";
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
                                    Text(
                                        AppLocalizations.of(context)!
                                            .otp_expire_in,
                                        //"The OTP will be expired in",
                                        style: const TextStyle(
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
                                    Text(
                                      AppLocalizations.of(context)!
                                          .don_receive_otp,
                                      //"Don't receive OTP?",
                                      style: const TextStyle(
                                          color: Color.fromRGBO(
                                              153, 153, 153, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                    TextButton(
                                        onPressed: enableResendButton ?
                                            () async {
                                          StaticResponse response = StaticResponse(
                                              code: 0,
                                              message: 'Incorrect Email');
                                          response = await QnaService.sendOtp(
                                              widget.email);
                                          if (response.code == 200) {
                                            showResendDialog(context);
                                          }
                                        }
                                            : null
                                        ,
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .resent_otp,
                                            //"   Resend OTP",
                                            style: TextStyle(
                                                color: enableResendButton ==
                                                    false
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
                                  StaticResponse res = await QnaService
                                      .validateOtp(
                                      widget.email, otp);
                                  if (res.code == 200) {
                                    showAlertDialog(context, res.message);
                                  }
                                  else if (res.code != 200 &&
                                      res.code != null) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: CustomDialog(
                                          title:
                                          AppLocalizations.of(context)!
                                              .alert_popup,
                                          //"Error",
                                          content: res.message,
                                          button:
                                          AppLocalizations.of(context)!.retry,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.validate,
                                //'Validate',
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

  showAlertDialog(BuildContext context, String? msg) {
    double height = MediaQuery.of(context).size.height;
    Widget okButton = TextButton(
      child: Text(
          AppLocalizations.of(context)!.ok_caps,
        //"OK",
        style: const TextStyle(
            color: Color.fromRGBO(48, 145, 139, 1),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 15),
      ),
      onPressed: () {
        Navigator.pushNamed(
            context,
            '/studentForgotPassword',
            arguments: [widget.email,otp,widget.isFromStudent]
        );
      },
    );
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
              AppLocalizations.of(context)!.success,
            //"Success!",
            style: const TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ],
      ),
      content: Text(
        msg!,
        style: const TextStyle(
            color: Color.fromRGBO(51, 51, 51, 1),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 15),
      ),
      actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showErrorDialog(BuildContext context, String? msg) {
    double height = MediaQuery.of(context).size.height;
    Widget okButton = ElevatedButton(
      child: Text(
          AppLocalizations.of(context)!.ok_caps,
        // "OK",
        style: const TextStyle(
            color: Color.fromRGBO(48, 145, 139, 1),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 15),
      ),
      onPressed: () {
        Navigator.pushNamed(
            context,
            '/studentForgotPassword',
            arguments: [widget.email,otp,widget.isFromStudent]
        );
      },
    );
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
              AppLocalizations.of(context)!.success,
            //"Success!",
            style: const TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ],
      ),
      content: Text(
        msg!,
        style: const TextStyle(
            color: Color.fromRGBO(51, 51, 51, 1),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 15),
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

  showResendDialog(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(48, 145, 139, 1),
      ),
      child: Text(
          AppLocalizations.of(context)!.ok_caps,
        //"OK",
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
              AppLocalizations.of(context)!.otp_sent,
            //"OTP Sent!",
            style: TextStyle(
                color: const Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.02),
          ),
        ],
      ),
      content: Text(
          AppLocalizations.of(context)!.receive_otp,
        //"If this email ID is registered with us you will receive OTP",
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
