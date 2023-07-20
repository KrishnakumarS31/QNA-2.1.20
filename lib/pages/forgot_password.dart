import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Pages/welcome_page.dart';
import 'package:qna_test/Services/qna_service.dart';
import '../Components/custom_incorrect_popup.dart';
import '../EntityModel/static_response.dart';
import '../DataSource/http_url.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword(
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
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
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
      if(constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 40.0,
                      color: Color.fromRGBO(28, 78, 80, 1),
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
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: height * 0.025,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  flexibleSpace: Container(
                    color: Colors.white,
                  ),
                ),
                body: Column(children: [
                  SizedBox(height: height * 0.1),
                  Center(
                      child:Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: kElevationToShadow[4],
                          ),
                          width: width * 0.9,
                          child:
                          Form(
                            key: formKey,
                            child: SizedBox(
                              height: height * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: height * 0.05),
                                  SizedBox(
                                      width: width * 0.8,
                                      child:
                                      TextFormField(
                                        controller: oldPassword,
                                        keyboardType: TextInputType.text,
                                        onChanged: (val) {
                                          formKey.currentState!.validate();
                                        },
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                          labelStyle: Theme.of(context).textTheme.headlineMedium,
                                          label: Text(AppLocalizations.of(context)!
                                              .new_password,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: height * 0.017),
                                          ),
                                          hintText:
                                          AppLocalizations.of(context)!.new_password,
                                          hintStyle: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.02),
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
                                  SizedBox(height: height * 0.03),
                                  SizedBox(
                                    width: width * 0.8,
                                    child:
                                    TextFormField(
                                      controller: newPassword,
                                      keyboardType: TextInputType.text,
                                      onChanged: (val) {
                                        formKey.currentState!.validate();
                                      },
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                                        label: Text(AppLocalizations.of(context)!
                                            .confirm_new_password,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.017),
                                        ),
                                        hintText: AppLocalizations.of(context)!
                                            .confirm_new_password,
                                        hintStyle: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 0.3),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.02),
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
                                  SizedBox(height: height * 0.03),
                                  IconButton(
                                    iconSize: height * 0.05,
                                    icon: Icon(Icons.arrow_circle_right,
                                      color:
                                      (oldPassword.text.isNotEmpty && newPassword.text.isNotEmpty)
                                          ? const Color.fromRGBO(82, 165, 160, 1)
                                          : const Color.fromRGBO(153, 153, 153, 0.5),
                                    ), onPressed: () async {
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
                                    }}
      ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                ],
                              ),
                            ),
                          ))),
                ])));
      }
      else if(constraints.maxWidth > 960) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 40.0,
                      color: Color.fromRGBO(28, 78, 80, 1),
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
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: height * 0.025,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  flexibleSpace: Container(
                    color: Colors.white,
                  ),
                ),
                body: Column(children: [
                  SizedBox(height: height * 0.1),
                  Center(
                      child:Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: kElevationToShadow[4],
                          ),
                          width: width * 0.35,
                          child:
                          Form(
                            key: formKey,
                            child: SizedBox(
                              height: height * 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: height * 0.05),
                                  SizedBox(
                                    width: width * 0.3,
                                    child:
                                    TextFormField(
                                      controller: oldPassword,
                                      keyboardType: TextInputType.text,
                                      onChanged: (val) {
                                        formKey.currentState!.validate();
                                      },
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                                        label: Text(AppLocalizations.of(context)!
                                            .new_password,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.017),
                                        ),
                                        hintText:
                                        AppLocalizations.of(context)!.new_password,
                                        hintStyle: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 0.3),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.02),
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
                                  SizedBox(height: height * 0.03),
                                  SizedBox(
                                    width: width * 0.3,
                                    child:
                                    TextFormField(
                                      controller: newPassword,
                                      keyboardType: TextInputType.text,
                                      onChanged: (val) {
                                        formKey.currentState!.validate();
                                      },
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                                        label: Text(AppLocalizations.of(context)!
                                            .confirm_new_password,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.017),
                                        ),
                                        hintText: AppLocalizations.of(context)!
                                            .confirm_new_password,
                                        hintStyle: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 0.3),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.02),
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
                                  SizedBox(height: height * 0.03),
                                  IconButton(
                                      iconSize: height * 0.05,
                                      icon: Icon(Icons.arrow_circle_right,
                                        color:
                                        (oldPassword.text.isNotEmpty && newPassword.text.isNotEmpty)
                                            ? const Color.fromRGBO(82, 165, 160, 1)
                                            : const Color.fromRGBO(153, 153, 153, 0.5),
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
                                        }}),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                ],
                              ),
                            ),
                          ))),
                ])));
      }
      else
      {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 40.0,
                      color: Color.fromRGBO(28, 78, 80, 1),
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
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: height * 0.025,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  flexibleSpace: Container(
                    color: Colors.white,
                  ),
                ),
                body: Column(children: [
                  SizedBox(height: height * 0.1),
                  Center(
                      child:Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: kElevationToShadow[4],
                          ),
                          width: width * 0.9,
                          child:
                          Form(
                            key: formKey,
                            child: SizedBox(
                              height: height * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: height * 0.05),
                                  SizedBox(
                                    width: width * 0.7,
                                    child:
                                    TextFormField(
                                      controller: oldPassword,
                                      keyboardType: TextInputType.text,
                                      onChanged: (val) {
                                        formKey.currentState!.validate();
                                      },
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                                        label: Text(AppLocalizations.of(context)!
                                            .new_password,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.017),
                                        ),
                                        hintText:
                                        AppLocalizations.of(context)!.new_password,
                                        hintStyle: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 0.3),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.02),
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
                                  SizedBox(height: height * 0.03),
                                  SizedBox(
                                    width: width * 0.7,
                                    child:
                                    TextFormField(
                                      controller: newPassword,
                                      keyboardType: TextInputType.text,
                                      onChanged: (val) {
                                        formKey.currentState!.validate();
                                      },
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                                        label: Text(AppLocalizations.of(context)!
                                            .confirm_new_password,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.017),
                                        ),
                                        hintText: AppLocalizations.of(context)!
                                            .confirm_new_password,
                                        hintStyle: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 0.3),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.02),
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
                                  SizedBox(height: height * 0.03),
                                  IconButton(
                                      iconSize: height * 0.05,
                                      icon: Icon(Icons.arrow_circle_right,
                                        color:
                                        (oldPassword.text.isNotEmpty && newPassword.text.isNotEmpty)
                                            ? const Color.fromRGBO(82, 165, 160, 1)
                                            : const Color.fromRGBO(153, 153, 153, 0.5),
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
                                        }}),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                ],
                              ),
                            ),
                          ))),
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
        TextButton(
          child: Text(
            "Ok",
            style: TextStyle(
                color: const Color.fromRGBO(48, 145, 139, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.018),
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const WelcomePage(),
              ),
            );
            // Navigator.popUntil(context, ModalRoute.withName('/teacherLoginPage'));
            // if (widget.isFromStudent == true) {
            //   Navigator.pushNamedAndRemoveUntil(context, '/studentMemberLoginPage',ModalRoute.withName('/studentSelectionPage'));
            // } else if (widget.isFromStudent == false) {
            //   Navigator.popUntil(context, ModalRoute.withName('/teacherLoginPage'));
            //
            // }
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
