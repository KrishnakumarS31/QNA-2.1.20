import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Services/qna_service.dart';
import '../Entity/Teacher/response_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Entity/user_details.dart';
import '../Providers/LanguageChangeProvider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    this.userId,
    Key? key,
  }) : super(key: key);
  final int? userId;
  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController reNewPassword = TextEditingController();
  late String password;
  UserDetails userDetails=UserDetails();
  bool oldObscure = true;
  bool newObscure = true;
  bool reNewObscure = true;
  @override
 void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
      password = userDetails.password!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints)
    {
      if (constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
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
                          AppLocalizations.of(context)!.reset_password_caps,
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                  flexibleSpace: Container(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
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
                              SizedBox(height: height * 0.03),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025),
                                child: TextFormField(
                                  controller: oldPassword,
                                  keyboardType: TextInputType.text,
                                  obscureText: oldObscure,
                                  obscuringCharacter: "*",
                                  onChanged: (val) {
                                    formKey.currentState!.validate();
                                  },
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    labelStyle: Theme.of(context).textTheme.headlineSmall,
                                    suffixIcon: SizedBox(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children:[
                                              IconButton(
                                                  iconSize: height * 0.028,
                                                  icon: Icon(
                                                    oldObscure
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color:
                                                    const Color.fromRGBO(82, 165, 160, 1),


                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      oldObscure = !oldObscure;
                                                    });
                                                  }),
                                            ]
                                        )),
                                    label: Text(AppLocalizations.of(
                                        context)!
                                        .old_password,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: height * 0.02),

                                    ),
                                    hintText:
                                    AppLocalizations.of(context)!.enter_here,
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                  ),
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return "Old Password is required";
                                    }
                                    else if (value != password) {
                                      return "Wrong Password Entered";
                                    }
                                    else {
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
                                  obscureText: newObscure,
                                  obscuringCharacter: "*",
                                  onChanged: (val) {
                                    formKey.currentState!.validate();
                                  },
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    labelStyle: Theme.of(context).textTheme.headlineSmall,
                                    suffixIcon: SizedBox(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children:[
                                              IconButton(
                                                  iconSize: height * 0.028,
                                                  icon: Icon(
                                                    newObscure
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color:
                                                    const Color.fromRGBO(82, 165, 160, 1),


                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      newObscure = !newObscure;
                                                    });
                                                  }),
                                            ]
                                        )),
                                    label: Text(AppLocalizations.of(
                                        context)!
                                        .new_password,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: height * 0.02),
                                    ),
                                    hintText: AppLocalizations.of(context)!
                                        .enter_here,
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                  ),
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return "New Password is required(Password Should be 8 Characters)";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025),
                                child: TextFormField(
                                  controller: reNewPassword,
                                  keyboardType: TextInputType.text,
                                  obscureText: reNewObscure,
                                  obscuringCharacter: "*",
                                  onChanged: (val) {
                                    formKey.currentState!.validate();
                                  },
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    labelStyle: Theme.of(context).textTheme.headlineSmall,
                                    suffixIcon: SizedBox(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children:[
                                              IconButton(
                                                  iconSize: height * 0.028,
                                                  icon: Icon(
                                                    reNewObscure
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color:
                                                    const Color.fromRGBO(82, 165, 160, 1),


                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      reNewObscure = !reNewObscure;
                                                    });
                                                  }),
                                            ]
                                        )),
                                    label: Text(AppLocalizations.of(
                                        context)!
                                        .confirm_new_password,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: height * 0.02),
                                    ),
                                    hintText: AppLocalizations.of(context)!
                                        .enter_here,
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                  ),
                                  validator: (value) {
                                    if (newPassword.text !=
                                        reNewPassword.text) {
                                      return AppLocalizations.of(context)!
                                          .mis_match_password;
                                    } else if (value!.isEmpty) {
                                      return "New Password is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                      Center(
                        child: IconButton(
                          iconSize: height * 0.06,
                          icon: Icon(Icons.arrow_circle_right,
                            color:
                            (newPassword.text.isNotEmpty && reNewPassword.text.isNotEmpty && oldPassword.text.isNotEmpty)
                                ? const Color.fromRGBO(82, 165, 160, 1)
                                : const Color.fromRGBO(153, 153, 153, 0.5),
                          ),
                            onPressed: () async {
                              bool valid = formKey.currentState!.validate();
                              if (valid) {
                                ResponseEntity statusCode =
                                await QnaService.updatePassword(
                                    oldPassword.text,
                                    newPassword.text,
                                    widget.userId!, context, userDetails);
                                if (statusCode.code == 200) {
                                  if (context.mounted) {
                                    showAlertDialog(context);
                                  }
                                }
                              }
                            },
                          )),
                          SizedBox(height: height * 0.03),
                        ],
                      ),
                    ),
                  ))),
                ])));
      }
      else if(constraints.maxWidth > 960){
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
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
                          AppLocalizations.of(context)!.reset_password_caps,
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                  flexibleSpace: Container(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                body: Column(children: [
                  SizedBox(height: height * 0.07),
                  Center(
                      child:Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: kElevationToShadow[4],
                          ),
                          width: width * 0.7,
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
                                      SizedBox(height: height * 0.03),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: height * 0.025,
                                            right: height * 0.025),
                                        child: TextFormField(
                                          controller: oldPassword,
                                          keyboardType: TextInputType.text,
                                          obscureText: oldObscure,
                                          obscuringCharacter: "*",
                                          onChanged: (val) {
                                            formKey.currentState!.validate();
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                            labelStyle: Theme.of(context).textTheme.headlineSmall,
                                            suffixIcon: SizedBox(
                                                child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children:[
                                                      IconButton(
                                                          iconSize: height * 0.028,
                                                          icon: Icon(
                                                            oldObscure
                                                                ? Icons.visibility
                                                                : Icons.visibility_off,
                                                            color:
                                                            const Color.fromRGBO(82, 165, 160, 1),


                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              oldObscure = !oldObscure;
                                                            });
                                                          }),
                                                    ]
                                                )),
                                            label: Text(AppLocalizations.of(
                                                context)!
                                                .old_password,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: height * 0.02),

                                            ),
                                            hintText:
                                            AppLocalizations.of(context)!.enter_here,
                                            hintStyle: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.02),
                                          ),
                                          validator: (value) {
                                            if (value!.length < 8) {
                                              return "Old Password is required";
                                            }
                                            else if (value != password) {
                                              return "Wrong Password Entered";
                                            }
                                            else {
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
                                          obscureText: newObscure,
                                          obscuringCharacter: "*",
                                          onChanged: (val) {
                                            formKey.currentState!.validate();
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                            labelStyle: Theme.of(context).textTheme.headlineSmall,
                                            suffixIcon: SizedBox(
                                                child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children:[
                                                      IconButton(
                                                          iconSize: height * 0.028,
                                                          icon: Icon(
                                                            newObscure
                                                                ? Icons.visibility
                                                                : Icons.visibility_off,
                                                            color:
                                                            const Color.fromRGBO(82, 165, 160, 1),


                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              newObscure = !newObscure;
                                                            });
                                                          }),
                                                    ]
                                                )),
                                            label: Text(AppLocalizations.of(
                                                context)!
                                                .new_password,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: height * 0.02),
                                            ),
                                            hintText: AppLocalizations.of(context)!
                                                .enter_here,
                                            hintStyle: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.02),
                                          ),
                                          validator: (value) {
                                            if (value!.length < 8) {
                                              return "New Password is required(Password Should be 8 Characters)";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(height: height * 0.03),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: height * 0.025,
                                            right: height * 0.025),
                                        child: TextFormField(
                                          controller: reNewPassword,
                                          keyboardType: TextInputType.text,
                                          obscureText: reNewObscure,
                                          obscuringCharacter: "*",
                                          onChanged: (val) {
                                            formKey.currentState!.validate();
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                            labelStyle: Theme.of(context).textTheme.headlineSmall,
                                            suffixIcon: SizedBox(
                                                child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children:[
                                                      IconButton(
                                                          iconSize: height * 0.028,
                                                          icon: Icon(
                                                            reNewObscure
                                                                ? Icons.visibility
                                                                : Icons.visibility_off,
                                                            color:
                                                            const Color.fromRGBO(82, 165, 160, 1),


                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              reNewObscure = !reNewObscure;
                                                            });
                                                          }),
                                                    ]
                                                )),
                                            label: Text(AppLocalizations.of(
                                                context)!
                                                .confirm_new_password,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: height * 0.02),
                                            ),
                                            hintText: AppLocalizations.of(context)!
                                                .enter_here,
                                            hintStyle: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.02),
                                          ),
                                          validator: (value) {
                                            if (newPassword.text !=
                                                reNewPassword.text) {
                                              return AppLocalizations.of(context)!
                                                  .mis_match_password;
                                            } else if (value!.isEmpty) {
                                              return "New Password is required";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                      child: IconButton(
                                        iconSize: height * 0.06,
                                        icon: Icon(Icons.arrow_circle_right,
                                          color:
                                          (newPassword.text.isNotEmpty && reNewPassword.text.isNotEmpty && oldPassword.text.isNotEmpty)
                                              ? const Color.fromRGBO(82, 165, 160, 1)
                                              : const Color.fromRGBO(153, 153, 153, 0.5),
                                        ),
                                        onPressed: () async {
                                          bool valid = formKey.currentState!.validate();
                                          if (valid) {
                                            ResponseEntity statusCode =
                                            await QnaService.updatePassword(
                                                oldPassword.text,
                                                newPassword.text,
                                                widget.userId!, context, userDetails);
                                            if (statusCode.code == 200) {
                                              if (context.mounted) {
                                                showAlertDialog(context);
                                              }
                                            }
                                          }
                                        },
                                      )),
                                  SizedBox(height: height * 0.03),
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
                          AppLocalizations.of(context)!.reset_password_caps,
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
                                      SizedBox(height: height * 0.03),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: height * 0.025,
                                            right: height * 0.025),
                                        child: TextFormField(
                                          controller: oldPassword,
                                          keyboardType: TextInputType.text,
                                          obscureText: oldObscure,
                                          obscuringCharacter: "*",
                                          onChanged: (val) {
                                            formKey.currentState!.validate();
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                            labelStyle: Theme.of(context).textTheme.headlineSmall,
                                            suffixIcon: SizedBox(
                                                child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children:[
                                                      IconButton(
                                                          iconSize: height * 0.028,
                                                          icon: Icon(
                                                            oldObscure
                                                                ? Icons.visibility
                                                                : Icons.visibility_off,
                                                            color:
                                                            const Color.fromRGBO(82, 165, 160, 1),


                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              oldObscure = !oldObscure;
                                                            });
                                                          }),
                                                    ]
                                                )),
                                            label: Text(AppLocalizations.of(
                                                context)!
                                                .old_password,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: height * 0.02),

                                            ),
                                            hintText:
                                            AppLocalizations.of(context)!.enter_here,
                                            hintStyle: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.02),
                                          ),
                                          validator: (value) {
                                            if (value!.length < 8) {
                                              return "Old Password is required";
                                            }
                                            else if (value != password) {
                                              return "Wrong Password Entered";
                                            }
                                            else {
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
                                          obscureText: newObscure,
                                          obscuringCharacter: "*",
                                          onChanged: (val) {
                                            formKey.currentState!.validate();
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                            labelStyle: Theme.of(context).textTheme.headlineSmall,
                                            suffixIcon: SizedBox(
                                                child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children:[
                                                      IconButton(
                                                          iconSize: height * 0.028,
                                                          icon: Icon(
                                                            newObscure
                                                                ? Icons.visibility
                                                                : Icons.visibility_off,
                                                            color:
                                                            const Color.fromRGBO(82, 165, 160, 1),


                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              newObscure = !newObscure;
                                                            });
                                                          }),
                                                    ]
                                                )),
                                            label: Text(AppLocalizations.of(
                                                context)!
                                                .new_password,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: height * 0.02),
                                            ),
                                            hintText: AppLocalizations.of(context)!
                                                .enter_here,
                                            hintStyle: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.02),
                                          ),
                                          validator: (value) {
                                            if (value!.length < 8) {
                                              return "New Password is required(Password Should be 8 Characters)";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(height: height * 0.03),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: height * 0.025,
                                            right: height * 0.025),
                                        child: TextFormField(
                                          controller: reNewPassword,
                                          keyboardType: TextInputType.text,
                                          obscureText: reNewObscure,
                                          obscuringCharacter: "*",
                                          onChanged: (val) {
                                            formKey.currentState!.validate();
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                            labelStyle: Theme.of(context).textTheme.headlineSmall,
                                            suffixIcon: SizedBox(
                                                child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children:[
                                                      IconButton(
                                                          iconSize: height * 0.028,
                                                          icon: Icon(
                                                            reNewObscure
                                                                ? Icons.visibility
                                                                : Icons.visibility_off,
                                                            color:
                                                            const Color.fromRGBO(82, 165, 160, 1),


                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              reNewObscure = !reNewObscure;
                                                            });
                                                          }),
                                                    ]
                                                )),
                                            label: Text(AppLocalizations.of(
                                                context)!
                                                .confirm_new_password,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: height * 0.02),
                                            ),
                                            hintText: AppLocalizations.of(context)!
                                                .enter_here,
                                            hintStyle: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.02),
                                          ),
                                          validator: (value) {
                                            if (newPassword.text !=
                                                reNewPassword.text) {
                                              return AppLocalizations.of(context)!
                                                  .mis_match_password;
                                            } else if (value!.isEmpty) {
                                              return "New Password is required";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                      child: IconButton(
                                        iconSize: height * 0.06,
                                        icon: Icon(Icons.arrow_circle_right,
                                          color:
                                          (newPassword.text.isNotEmpty && reNewPassword.text.isNotEmpty && oldPassword.text.isNotEmpty)
                                              ? const Color.fromRGBO(82, 165, 160, 1)
                                              : const Color.fromRGBO(153, 153, 153, 0.5),
                                        ),
                                        onPressed: () async {
                                          bool valid = formKey.currentState!.validate();
                                          if (valid) {
                                            ResponseEntity statusCode =
                                            await QnaService.updatePassword(
                                                oldPassword.text,
                                                newPassword.text,
                                                widget.userId!, context, userDetails);
                                            if (statusCode.code == 200) {
                                              if (context.mounted) {
                                                showAlertDialog(context);
                                              }
                                            }
                                          }
                                        },
                                      )),
                                  SizedBox(height: height * 0.03),
                                ],
                              ),
                            ),
                          ))),
                ])));
      }
    }
    );}

  showAlertDialog(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Widget okButton =
    Center(
     child: TextButton(
      child: Text(
        AppLocalizations.of(context)!.login_loginPage,
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
          Navigator.popUntil(context, ModalRoute.withName('/teacherLoginPage'));
        }
      },
    ));
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
        "Your Password has been changed Successfully",
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
