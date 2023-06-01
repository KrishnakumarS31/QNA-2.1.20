import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Services/qna_service.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Entity/user_details.dart';
import '../Providers/LanguageChangeProvider.dart';

//AppLocalizations.of(context)!.agree_privacy_terms
class ChangeEmailStudent extends StatefulWidget {
  const ChangeEmailStudent({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  ChangeEmailStudentState createState() => ChangeEmailStudentState();
}

class ChangeEmailStudentState extends State<ChangeEmailStudent> {
  final formKey = GlobalKey<FormState>();
  TextEditingController oldEmail = TextEditingController();
  TextEditingController newEmail = TextEditingController();
  TextEditingController reNewEmail = TextEditingController();
  UserDetails userDetails=UserDetails();

  @override
  void initState() {
    QnaService.sendOtp('jjk');
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 500) {
            return Center(
                child: SizedBox(
                width: 500,
                child: WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
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
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                          AppLocalizations.of(context)!.change_emailId,
                              //"CHANGE EMAIL ID",
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontSize: height * 0.0225,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter,
                                colors: [
                                  Color.fromRGBO(0, 106, 100, 1),
                                  Color.fromRGBO(82, 165, 160, 1),
                                ])),
                      ),
                    ),
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.white,
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
                                      controller: newEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        labelText: AppLocalizations.of(context)!.new_email_id,
                                        //"NEW EMAIL ID",
                                        labelStyle: TextStyle(
                                            color: const Color.fromRGBO(
                                                51, 51, 51, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.015),
                                        hintText:
                                        AppLocalizations.of(context)!.new_email_id,
                                        //"New Email Id",
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
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .enter_email_id;
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
                                      controller: reNewEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        labelText: AppLocalizations.of(context)!.confirm_new_mail_caps,
          //"CONFIRM NEW EMAIL ID",
                                        labelStyle: TextStyle(
                                            color: const Color.fromRGBO(
                                                51, 51, 51, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.015),
                                        hintText: AppLocalizations.of(context)!.confirm_new_mail,
          //"Confirm New Email Id",
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
                                        if (newEmail.text != reNewEmail.text) {
                                          return AppLocalizations.of(context)!.reenter_email;
          //"Re-Enter Email correctly";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: height * 0.04),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: height * 0.04,
                                        right: height * 0.025),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children:  [
                                        const Icon(
                                          Icons.circle,
                                          color: Color.fromRGBO(
                                              141, 167, 167, 1),
                                          size: 6,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(AppLocalizations.of(context)!.otp_sent_to_new,
          //"OTP will be sent to new EMAIL ID",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: height * 0.04,
                                          right: height * 0.025),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children:  [
                                          const Icon(
                                            Icons.circle,
                                            color: Color.fromRGBO(
                                                141, 167, 167, 1),
                                            size: 6,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
          AppLocalizations.of(context)!.password_unchanged,
          //"Password will remain unchanged.",
                                              style: const TextStyle(
                                                  color:
                                                  Color.fromRGBO(
                                                      153, 153, 153, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14)),
                                        ],
                                      ))
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                                  minimumSize: Size(
                                      400 * 0.77, height * 0.06),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39),
                                  ),
                                ),
                                onPressed: () async {
                                  bool valid = formKey.currentState!.validate();
                                  if (valid ||
                                      newEmail.text == reNewEmail.text) {
                                    ResponseEntity response =
                                    await QnaService.updatePassword(
                                        oldEmail.text,
                                        newEmail.text, widget.userId, context,
                                        userDetails);
                                    if (response.code == 200) {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: showAlertDialog(context)),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title:
          AppLocalizations.of(context)!.incorrect_email,
          //'Incorrect Email',
                                            content:
          AppLocalizations.of(context)!.email_changed,
          //'Your Email has not been changed',
                                            button: AppLocalizations.of(
                                                context)!
                                                .retry,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(
          AppLocalizations.of(context)!.update_email,
          //"Update EMail ID",
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
          else {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
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
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.change_emailId,
                              //"CHANGE EMAIL ID",
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontSize: height * 0.0225,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter,
                                colors: [
                                  Color.fromRGBO(0, 106, 100, 1),
                                  Color.fromRGBO(82, 165, 160, 1),
                                ])),
                      ),
                    ),
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.white,
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
                                      controller: newEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        labelText: AppLocalizations.of(context)!.new_email_id,
                                        //"NEW EMAIL ID",
                                        labelStyle: TextStyle(
                                            color: const Color.fromRGBO(
                                                51, 51, 51, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.015),
                                        hintText:
                                        AppLocalizations.of(context)!.new_email_id,
                                        //"New Email Id",
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
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .enter_email_id;
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
                                      controller: reNewEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        labelText: AppLocalizations.of(context)!.confirm_new_mail_caps,
                                        //"CONFIRM NEW EMAIL ID",
                                        labelStyle: TextStyle(
                                            color: const Color.fromRGBO(
                                                51, 51, 51, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.015),
                                        hintText: AppLocalizations.of(context)!.confirm_new_mail,
                                        //"Confirm New Email Id",
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
                                        if (newEmail.text != reNewEmail.text) {
                                          return AppLocalizations.of(context)!.reenter_email;
                                          //"Re-Enter Email correctly";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: height * 0.04),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: height * 0.04,
                                        right: height * 0.025),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children:  [
                                        const Icon(
                                          Icons.circle,
                                          color: Color.fromRGBO(
                                              141, 167, 167, 1),
                                          size: 6,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(AppLocalizations.of(context)!.otp_sent_to_new,
                                            //"OTP will be sent to new EMAIL ID",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: height * 0.04,
                                          right: height * 0.025),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children:  [
                                          const Icon(
                                            Icons.circle,
                                            color: Color.fromRGBO(
                                                141, 167, 167, 1),
                                            size: 6,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                              AppLocalizations.of(context)!.password_unchanged,
                                              //"Password will remain unchanged.",
                                              style: const TextStyle(
                                                  color:
                                                  Color.fromRGBO(
                                                      153, 153, 153, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14)),
                                        ],
                                      ))
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                                  minimumSize: Size(
                                      width * 0.77, height * 0.06),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39),
                                  ),
                                ),
                                onPressed: () async {
                                  bool valid = formKey.currentState!.validate();
                                  if (valid ||
                                      newEmail.text == reNewEmail.text) {
                                    ResponseEntity response =
                                    await QnaService.updatePassword(
                                        oldEmail.text,
                                        newEmail.text, widget.userId, context,
                                        userDetails);
                                    if (response.code == 200) {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: showAlertDialog(context)),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title:
                                            AppLocalizations.of(context)!.incorrect_email,
                                            //'Incorrect Email',
                                            content:
                                            AppLocalizations.of(context)!.email_changed,
                                            //'Your Email has not been changed',
                                            button: AppLocalizations.of(
                                                context)!
                                                .retry,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.update_email,
                                  //"Update EMail ID",
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
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    double height = MediaQuery
        .of(context)
        .size
        .height;
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
              AppLocalizations.of(context)!.success,
            //"Success",
            style: TextStyle(
                color: const Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.02),
          ),
        ],
      ),
      content: Text(
        "Your Email has been changed Successfully",
        style: TextStyle(
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: height * 0.018),
      ),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(
                color: const Color.fromRGBO(48, 145, 139, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.018),
          ),
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
