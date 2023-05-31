import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TeacherForgotPasswordEmail extends StatefulWidget {
  const TeacherForgotPasswordEmail({
    Key? key,

  }) : super(key: key);


  @override
  TeacherForgotPasswordEmailState createState() =>
      TeacherForgotPasswordEmailState();
}

class TeacherForgotPasswordEmailState
    extends State<TeacherForgotPasswordEmail> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    AppLocalizations.of(context)!.forgot_password_caps,
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
                  SizedBox(
                    height: height * 0.055,
                  ),
                  Form(
                    key: formKey,
                    child: SizedBox(
                      height: height * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025, right: height * 0.025),
                            child: TextFormField(
                              controller: _controller,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (val) {
                                formKey.currentState!.validate();
                              },
                              decoration: InputDecoration(
                                label: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .enter_email_id,
                                        style: TextStyle(
                                            color:
                                            const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.017),
                                      ),
                                      TextSpan(
                                          text: "\t*",
                                          style: TextStyle(
                                              color:
                                              const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.017)),
                                    ])),
                                floatingLabelBehavior: FloatingLabelBehavior
                                    .always,
                                helperText:
                                AppLocalizations.of(context)!.email_helper_text,
                                helperStyle: TextStyle(
                                    color: const Color.fromRGBO(
                                        153, 153, 153, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.015),
                                hintText: AppLocalizations.of(context)!
                                    .email_hint,
                                hintStyle: TextStyle(
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.02),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(82, 165, 160, 1)),
                                    borderRadius: BorderRadius.circular(15)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(
                                        r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return AppLocalizations.of(context)!
                                      .enter_valid_email;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color.fromRGBO(82, 165, 160, 1),
                              minimumSize: Size(width * 0.77, height * 0.06),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(39),
                              ),
                            ),
                            onPressed: () {
                              bool valid = formKey.currentState!.validate();
                              if (valid) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: showAlertDialog(height)),
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
                  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
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
                                style: Theme
                                    .of(context)
                                    .primaryTextTheme
                                    .bodyLarge
                                    ?.merge(const TextStyle(
                                    color: Color.fromRGBO(48, 145, 139, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16))),
                          ],
                        ),
                      )),
                ])))));
      }
      else
      {
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
                    AppLocalizations.of(context)!.forgot_password_caps,
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
                  SizedBox(
                    height: height * 0.055,
                  ),
                  Form(
                    key: formKey,
                    child: SizedBox(
                      height: height * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025, right: height * 0.025),
                            child: TextFormField(
                              controller: _controller,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (val) {
                                formKey.currentState!.validate();
                              },
                              decoration: InputDecoration(
                                label: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .enter_email_id,
                                        style: TextStyle(
                                            color:
                                            const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.017),
                                      ),
                                      TextSpan(
                                          text: "\t*",
                                          style: TextStyle(
                                              color:
                                              const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.017)),
                                    ])),
                                floatingLabelBehavior: FloatingLabelBehavior
                                    .always,
                                helperText:
                                AppLocalizations.of(context)!.email_helper_text,
                                helperStyle: TextStyle(
                                    color: const Color.fromRGBO(
                                        153, 153, 153, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.015),
                                hintText: AppLocalizations.of(context)!
                                    .email_hint,
                                hintStyle: TextStyle(
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.02),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(82, 165, 160, 1)),
                                    borderRadius: BorderRadius.circular(15)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(
                                        r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return AppLocalizations.of(context)!
                                      .enter_valid_email;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color.fromRGBO(82, 165, 160, 1),
                              minimumSize: Size(width * 0.77, height * 0.06),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(39),
                              ),
                            ),
                            onPressed: () {
                              bool valid = formKey.currentState!.validate();
                              if (valid) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: showAlertDialog(height)),
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
                  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
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
                                style: Theme
                                    .of(context)
                                    .primaryTextTheme
                                    .bodyLarge
                                    ?.merge(const TextStyle(
                                    color: Color.fromRGBO(48, 145, 139, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16))),
                          ],
                        ),
                      )),
                ])));
      }
    }
    );}

  showAlertDialog(double height) {
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
      actions: [
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.enter_otp,
            //"Enter OTP",
            style: TextStyle(
                color: const Color.fromRGBO(48, 145, 139, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.018),
          ),
          onPressed: () {
            Navigator.pushNamed(
                context,
                '/teacherVerifyOtpPage',
                arguments: _controller.text
            );
          },
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
