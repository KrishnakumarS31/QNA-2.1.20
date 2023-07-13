import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Services/qna_service.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Entity/user_details.dart';
import '../Providers/LanguageChangeProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ChangeEmailTeacher extends StatefulWidget {
  const ChangeEmailTeacher({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  ChangeEmailTeacherState createState() => ChangeEmailTeacherState();
}

class ChangeEmailTeacherState extends State<ChangeEmailTeacher> {
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
          if (constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
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
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.change_emailId,
                              //"CHANGE EMAIL ID",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.0225,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.white,
                    body: Column(children: [
                      SizedBox(height: height * 0.07),
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
                                height: height * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: height* 0.03),
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
                                              labelStyle: Theme.of(context).textTheme.headlineMedium,
                                              label: Text(
                                                AppLocalizations.of(context)!.new_email_id,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.02),
                                              ),
                                              //"NEW EMAIL ID",
                                              hintText:
                                              AppLocalizations.of(context)!.enter_here,
                                              //"New Email Id",
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.02),
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
                                              labelStyle: Theme.of(context).textTheme.headlineMedium,
                                              label: Text(
                                                AppLocalizations.of(context)!.confirm_new_mail,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.02),
                                              ),
                                              hintText: AppLocalizations.of(context)!.enter_here,
                                              //"Confirm New Email Id",
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.02),
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
                                        Row(
                                            children: [
                                              SizedBox(width: width * 0.05),
                                              Text(AppLocalizations.of(context)!.otp_sent_to_new,
                                                //"OTP will be sent to new EMAIL ID",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                    fontFamily: 'Inter',
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14))
                            ]),
                                        SizedBox(height: height * 0.01),
                                        Row(
                                            children: [
                                              SizedBox(width: width * 0.05),
                                              Text(
                                                  AppLocalizations.of(context)!.password_unchanged,
                                                  //"Password will remain unchanged.",
                                                  style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          153, 153, 153, 1),
                                                      fontFamily: 'Inter',
                                                      fontStyle: FontStyle.italic,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14))
                                            ]),
                                      ],
                                    ),
                                    Center(
                                        child: IconButton(
                                          iconSize: height * 0.06,
                                          icon: Icon(Icons.arrow_circle_right,
                                            color:
                                            (reNewEmail.text.isNotEmpty && newEmail.text.isNotEmpty)
                                                ? const Color.fromRGBO(82, 165, 160, 1)
                                                : const Color.fromRGBO(153, 153, 153, 0.5),
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
                                        )),
                                    SizedBox(
                                      height: height * 0.04,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))])));
          }
          else if(constraints.maxWidth > 960){
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
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
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.change_emailId,
                              //"CHANGE EMAIL ID",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.0225,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.white,
                    body:
                    Container(
                        padding: EdgeInsets.only(
                            left: height * 0.5, right: height * 0.5),
                        child:
                        Column(children: [
                          SizedBox(height: height * 0.07),
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
                                    height: height * 0.6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height* 0.03),
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
                                                  labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                  label: Text(
                                                    AppLocalizations.of(context)!.new_email_id,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: height * 0.02),
                                                  ),
                                                  //"NEW EMAIL ID",
                                                  hintText:
                                                  AppLocalizations.of(context)!.enter_here,
                                                  //"New Email Id",
                                                  hintStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.02),
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
                                                  labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                  label: Text(
                                                    AppLocalizations.of(context)!.confirm_new_mail,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: height * 0.02),
                                                  ),
                                                  hintText: AppLocalizations.of(context)!.enter_here,
                                                  //"Confirm New Email Id",
                                                  hintStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.02),
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
                                            Row(
                                                children: [
                                                  SizedBox(width: width * 0.02),
                                                  Text(AppLocalizations.of(context)!.otp_sent_to_new,
                                                      //"OTP will be sent to new EMAIL ID",
                                                      style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              153, 153, 153, 1),
                                                          fontFamily: 'Inter',
                                                          fontStyle: FontStyle.italic,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14))
                                                ]),
                                            SizedBox(height: height * 0.01),
                                            Row(
                                                children: [
                                                  SizedBox(width: width * 0.02),
                                                  Text(
                                                      AppLocalizations.of(context)!.password_unchanged,
                                                      //"Password will remain unchanged.",
                                                      style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              153, 153, 153, 1),
                                                          fontFamily: 'Inter',
                                                          fontStyle: FontStyle.italic,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14))
                                                ]),
                                            SizedBox(height: height * 0.03),
                                          ],
                                        ),
                                        Center(
                                            child: IconButton(
                                              iconSize: height * 0.06,
                                              icon: Icon(Icons.arrow_circle_right,
                                                color:
                                                (reNewEmail.text.isNotEmpty && newEmail.text.isNotEmpty)
                                                    ? const Color.fromRGBO(82, 165, 160, 1)
                                                    : const Color.fromRGBO(153, 153, 153, 0.5),
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
                                            )),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))]))));
          }
          else {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
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
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.change_emailId,
                              //"CHANGE EMAIL ID",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.0225,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.white,
                    body: Column(children: [
                      SizedBox(height: height * 0.07),
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
                                height: height * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: height* 0.03),
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
                                              labelStyle: Theme.of(context).textTheme.headlineMedium,
                                              label: Text(
                                                AppLocalizations.of(context)!.new_email_id,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.02),
                                              ),
                                              //"NEW EMAIL ID",
                                              hintText:
                                              AppLocalizations.of(context)!.enter_here,
                                              //"New Email Id",
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.02),
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
                                              labelStyle: Theme.of(context).textTheme.headlineMedium,
                                              label: Text(
                                                AppLocalizations.of(context)!.confirm_new_mail,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.02),
                                              ),
                                              hintText: AppLocalizations.of(context)!.enter_here,
                                              //"Confirm New Email Id",
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.02),
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
                                        Row(
                                            children: [
                                              SizedBox(width: width * 0.05),
                                              Text(AppLocalizations.of(context)!.otp_sent_to_new,
                                                  //"OTP will be sent to new EMAIL ID",
                                                  style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          153, 153, 153, 1),
                                                      fontFamily: 'Inter',
                                                      fontStyle: FontStyle.italic,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14))
                                            ]),
                                        SizedBox(height: height * 0.01),
                                        Row(
                                            children: [
                                              SizedBox(width: width * 0.05),
                                              Text(
                                                  AppLocalizations.of(context)!.password_unchanged,
                                                  //"Password will remain unchanged.",
                                                  style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          153, 153, 153, 1),
                                                      fontFamily: 'Inter',
                                                      fontStyle: FontStyle.italic,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14))
                                            ]),
                                        SizedBox(height: height * 0.03),
                                      ],
                                    ),
                                    Center(
                                        child: IconButton(
                                          iconSize: height * 0.06,
                                          icon: Icon(Icons.arrow_circle_right,
                                            color:
                                            (reNewEmail.text.isNotEmpty && newEmail.text.isNotEmpty)
                                                ? const Color.fromRGBO(82, 165, 160, 1)
                                                : const Color.fromRGBO(153, 153, 153, 0.5),
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
                                        )),
                                    SizedBox(
                                      height: height * 0.03,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))])));
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
        AppLocalizations.of(context)!.email_changed_succ,
        // "Your Email has been changed Successfully",
        style: TextStyle(
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: height * 0.018),
      ),
      actions: [
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.login_loginPage,
            //"OK",
            style: TextStyle(
                color: const Color.fromRGBO(48, 145, 139, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: height * 0.018),
          ),
          onPressed: () async {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.clear();
            if(context.mounted) {
              Navigator.pushNamedAndRemoveUntil(context, '/teacherLoginPage',
                  ModalRoute.withName('/teacherSelectionPage'));
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
