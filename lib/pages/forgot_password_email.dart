import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Components/custom_incorrect_popup.dart';
import '../EntityModel/static_response.dart';
import '../Services/qna_service.dart';
class ForgotPasswordEmail extends StatefulWidget {
  const ForgotPasswordEmail({
    Key? key,

    required this.isFromStudent,
  }) : super(key: key);

  final bool isFromStudent;

  @override
  ForgotPasswordEmailState createState() => ForgotPasswordEmailState();
}

class ForgotPasswordEmailState extends State<ForgotPasswordEmail> {
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
                              height: height * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: height * 0.05),
                                  SizedBox(
                                      width: width * 0.8,
                                      child:
                                      TextFormField(
                                        controller: _controller,
                                        keyboardType: TextInputType.emailAddress,
                                        onChanged: (val) {
                                          formKey.currentState!.validate();
                                        },
                                        decoration: InputDecoration(
                                          floatingLabelBehavior: FloatingLabelBehavior
                                              .always,
                                          labelStyle: Theme.of(context).textTheme.headlineMedium,
                                          label: Text(AppLocalizations.of(context)!
                                              .email_id_caps,
                                            style: TextStyle(
                                                color:
                                                const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: height * 0.020),
                                          ),
                                          helperText: AppLocalizations.of(context)!
                                              .email_helper_text,
                                          helperStyle: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016),
                                          suffixIcon: IconButton(
                                            iconSize: height * 0.05,
                                            icon: Icon(Icons.arrow_circle_right,
                                              color:
                                              (_controller.text.isNotEmpty)
                                                  ? const Color.fromRGBO(82, 165, 160, 1)
                                                  : const Color.fromRGBO(153, 153, 153, 0.5),
                                            ),
                                            onPressed: () async {
                                              bool valid = formKey.currentState!.validate();
                                              if (valid) {
                                                StaticResponse response = StaticResponse(
                                                    code: 0, message: 'Incorrect Email');
                                                response =
                                                await QnaService.sendOtp(_controller.text);
                                                if (response.code == 200) {
                                                  showAlertDialog(context);
                                                } else if (response.code != null &&
                                                    response.code != 200) {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.rightToLeft,
                                                      child: CustomDialog(
                                                        title: AppLocalizations.of(context)!
                                                            .alert_popup,
                                                        //'Wrong password',
                                                        content: response.message,
                                                        //'please enter the correct password',
                                                        button: AppLocalizations.of(context)!
                                                            .retry,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                            suffixIconColor:
                                            MaterialStateColor.resolveWith((states) =>
                                            states.contains(MaterialState.focused)
                                            //   _controller.text.isEmpty
                                             ? const Color.fromRGBO(82, 165, 160, 1)
                                              : const Color.fromRGBO(153, 153, 153, 0.5)),
                                          hintStyle: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.018),
                                          hintText: AppLocalizations.of(context)!
                                              .enter_here,
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
                                      )),
                                  SizedBox(
                                    height: height * 0.06,
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
                body:
    Container(
    padding:EdgeInsets.only(left: height * 0.5,right: height * 0.5),
    child:
    Column(children: [
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
                              height: height * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: height * 0.05),
                                  SizedBox(
                                      width: width * 0.3,
                                      child:
                                      TextFormField(
                                        controller: _controller,
                                        keyboardType: TextInputType.emailAddress,
                                        onChanged: (val) {
                                          formKey.currentState!.validate();
                                        },
                                        decoration: InputDecoration(
                                          floatingLabelBehavior: FloatingLabelBehavior
                                              .always,
                                          labelStyle: Theme.of(context).textTheme.headlineMedium,
                                          label: Text(AppLocalizations.of(context)!.email_id_caps,
                                            style: TextStyle(
                                                color:
                                                const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: height * 0.020),
                                          ),
                                          helperText: AppLocalizations.of(context)!
                                              .email_helper_text,
                                          helperStyle: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016),
                                          suffixIconColor:
                                          MaterialStateColor.resolveWith((states) =>
                                          states.contains(MaterialState.focused)
                                          //   _controller.text.isEmpty
                                              ? const Color.fromRGBO(82, 165, 160, 1)
                                              : const Color.fromRGBO(153, 153, 153, 0.5)),
                                          suffixIcon: IconButton(
                                            iconSize: height * 0.05,
                                            icon: Icon(Icons.arrow_circle_right,
                                              color:
                                              (_controller.text.isNotEmpty)
                                                  ? const Color.fromRGBO(82, 165, 160, 1)
                                                  : const Color.fromRGBO(153, 153, 153, 0.5),
                                            ),
                                            onPressed: () async {
                                              bool valid = formKey.currentState!.validate();
                                              if (valid) {
                                                StaticResponse response = StaticResponse(
                                                    code: 0, message: 'Incorrect Email');
                                                response =
                                                await QnaService.sendOtp(_controller.text);
                                                if (response.code == 200) {
                                                  showAlertDialog(context);
                                                } else if (response.code != null &&
                                                    response.code != 200) {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.rightToLeft,
                                                      child: CustomDialog(
                                                        title: AppLocalizations.of(context)!
                                                            .alert_popup,
                                                        //'Wrong password',
                                                        content: response.message,
                                                        //'please enter the correct password',
                                                        button: AppLocalizations.of(context)!
                                                            .retry,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                          hintStyle: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.018),
                                          hintText: AppLocalizations.of(context)!
                                              .enter_here,
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
                                      )),
                                  SizedBox(
                                    height: height * 0.06,
                                  ),
                                ],
                              ),
                            ),
                          ))),
                ]))));
      }
      else {
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
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                            Column(
                            children: [
                                  SizedBox(
                                      height: height * 0.05),
                                  SizedBox(
                                      width: width * 0.7,
                                      child:
                                      TextFormField(
                                        controller: _controller,
                                        keyboardType: TextInputType.emailAddress,
                                        onChanged: (val) {
                                          formKey.currentState!.validate();
                                        },
                                        decoration: InputDecoration(
                                          floatingLabelBehavior: FloatingLabelBehavior
                                              .always,
                                          labelStyle: Theme.of(context).textTheme.headlineMedium,
                                          label: Text(AppLocalizations.of(context)!
                                              .email_id_caps,
                                            style: TextStyle(
                                                color:
                                                const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: height * 0.025),
                                          ),
                                          helperText: AppLocalizations.of(context)!
                                              .email_helper_text,
                                          helperStyle: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016),
                                          suffixIconColor:
                                          MaterialStateColor.resolveWith((states) =>
                                          states.contains(MaterialState.focused)
                                          //   _controller.text.isEmpty
                                              ? const Color.fromRGBO(82, 165, 160, 1)
                                              : const Color.fromRGBO(153, 153, 153, 0.5)),
                                          suffixIcon: IconButton(
                                            iconSize: height * 0.05,
                                            icon: Icon(Icons.arrow_circle_right,
                                              color:
                                              (_controller.text.isNotEmpty)
                                                  ? const Color.fromRGBO(82, 165, 160, 1)
                                                  : const Color.fromRGBO(153, 153, 153, 0.5),
                                            ),
                                            onPressed: () async {
                                              bool valid = formKey.currentState!.validate();
                                              if (valid) {
                                                StaticResponse response = StaticResponse(
                                                    code: 0, message: 'Incorrect Email');
                                                response =
                                                await QnaService.sendOtp(_controller.text);
                                                if (response.code == 200) {
                                                  showAlertDialog(context);
                                                } else if (response.code != null &&
                                                    response.code != 200) {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.rightToLeft,
                                                      child: CustomDialog(
                                                        title: AppLocalizations.of(context)!
                                                            .alert_popup,
                                                        //'Wrong password',
                                                        content: response.message,
                                                        //'please enter the correct password',
                                                        button: AppLocalizations.of(context)!
                                                            .retry,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                          hintStyle: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.02),
                                          hintText: AppLocalizations.of(context)!
                                              .enter_here,
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
                                      )),
                                  SizedBox(
                                    height: height * 0.06,
                                  ),
                                ],
                              ),
                          ]))),
        )])));
      }
    }
    );}

  showAlertDialog(BuildContext context) {
    // set up the button
    double height = MediaQuery.of(context).size.height;
    Widget okButton = TextButton(
      child:
      Center(
        child:
      Text(
        "Verify OTP",
        style: TextStyle(
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: height * 0.018),
      )),
      onPressed: () {

        Navigator.pushNamed(context, '/verifyOtpPage',arguments: [widget.isFromStudent,_controller.text]);

        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.rightToLeft,
        //     child: VerifyOtpPage(
        //         email: _controller.text,
        //         isFromStudent: widget.isFromStudent,
        //         ),
        //   ),
        // );
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
        "You will receive an OTP if the email ID is registered with us",
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
