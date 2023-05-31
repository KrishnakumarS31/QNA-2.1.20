import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Services/qna_service.dart';
import '../Components/custom_incorrect_popup.dart';
import '../EntityModel/static_response.dart';

class StudentForgotPassword extends StatefulWidget {
  const StudentForgotPassword(
      {Key? key,
        required this.email,
        required this.otp,
        required this.isFromStudent,
      })
      : super(key: key);

  final String email;
  final String otp;
  final bool isFromStudent;


  @override
  StudentForgotPasswordState createState() => StudentForgotPasswordState();
}

class StudentForgotPasswordState extends State<StudentForgotPassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();

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
            child:  WillPopScope(
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
                    AppLocalizations.of(context)!.reset_password_caps,
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
                      height: height * 0.55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025),
                                child: TextFormField(
                                  controller: oldPassword,
                                  keyboardType: TextInputType.text,
                                  onChanged: (val) {
                                    formKey.currentState!.validate();
                                  },
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    label: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .new_password_caps,
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
                                    hintText:
                                    AppLocalizations.of(context)!.new_password,
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                82, 165, 160, 1)),
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                  ),
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return "New password is required(Password Should be 8 Characters)";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025),
                                child: TextFormField(
                                  controller: newPassword,
                                  keyboardType: TextInputType.text,
                                  onChanged: (val) {
                                    formKey.currentState!.validate();
                                  },
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    label: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .confirm_new_password_caps,
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
                                    hintText: AppLocalizations.of(context)!
                                        .confirm_new_password,
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                82, 165, 160, 1)),
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                  ),
                                  validator: (value) {
                                    if (newPassword.text != oldPassword.text) {
                                      return AppLocalizations.of(context)!
                                          .mis_match_password;
                                    } else if (value!.isEmpty) {
                                      return "Confirm new password is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
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
                            onPressed: () async {
                              bool valid = formKey.currentState!.validate();
                              if (valid) {
                                StaticResponse res =
                                await QnaService.updatePasswordOtp(
                                    widget.email, widget.otp, newPassword.text);
                                //int statusCode= QnaService.updatePasswordOtp(widget.email,widget.otp, newPassword.text);
                                if (res.code == 200 &&
                                    newPassword.text.isNotEmpty) {
                                  showAlertDialog(context);
                                } else if (res.code == 400) {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: CustomDialog(
                                        title: 'Incorrect OTP',
                                        content:
                                        'Your Password has not been changed',
                                        button: AppLocalizations.of(context)!
                                            .retry,
                                      ),
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
                    AppLocalizations.of(context)!.reset_password_caps,
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
                      height: height * 0.55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025),
                                child: TextFormField(
                                  controller: oldPassword,
                                  keyboardType: TextInputType.text,
                                  onChanged: (val) {
                                    formKey.currentState!.validate();
                                  },
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    label: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .new_password_caps,
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
                                    hintText:
                                    AppLocalizations.of(context)!.new_password,
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                82, 165, 160, 1)),
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                  ),
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return "New password is required(Password Should be 8 Characters)";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025),
                                child: TextFormField(
                                  controller: newPassword,
                                  keyboardType: TextInputType.text,
                                  onChanged: (val) {
                                    formKey.currentState!.validate();
                                  },
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    label: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .confirm_new_password_caps,
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
                                    hintText: AppLocalizations.of(context)!
                                        .confirm_new_password,
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                82, 165, 160, 1)),
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                  ),
                                  validator: (value) {
                                    if (newPassword.text != oldPassword.text) {
                                      return AppLocalizations.of(context)!
                                          .mis_match_password;
                                    } else if (value!.isEmpty) {
                                      return "Confirm new password is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
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
                            onPressed: () async {
                              bool valid = formKey.currentState!.validate();
                              if (valid) {
                                StaticResponse res =
                                await QnaService.updatePasswordOtp(
                                    widget.email, widget.otp, newPassword.text);
                                //int statusCode= QnaService.updatePasswordOtp(widget.email,widget.otp, newPassword.text);
                                if (res.code == 200 &&
                                    newPassword.text.isNotEmpty) {
                                  showAlertDialog(context);
                                } else if (res.code == 400) {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: CustomDialog(
                                        title: 'Incorrect OTP',
                                        content:
                                        'Your Password has not been changed',
                                        button: AppLocalizations.of(context)!
                                            .retry,
                                      ),
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
          Text(
            "Success",
            style: TextStyle(
                color: const Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.02),
          ),
        ],
      ),
      content: Text(
        "Password Changed successfully",
        style: TextStyle(
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: height * 0.018),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(48, 145, 139, 1),
          ),
          child: Text(
            "Ok",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.018),
          ),
          onPressed: () {
            if (widget.isFromStudent == true) {
              Navigator.pushNamedAndRemoveUntil(context, '/studentMemberLoginPage',ModalRoute.withName('/studentSelectionPage'));
            } else if (widget.isFromStudent == false) {
              Navigator.popUntil(context, ModalRoute.withName('/teacherLoginPage'));

            }
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
