import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/settings_languages.dart';
import 'package:qna_test/Pages/stud_guest_assessment.dart';
import 'package:qna_test/pages/cookie_policy.dart';
import '../Components/custom_incorrect_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'about_us.dart';
import 'help_page.dart';
import 'privacy_policy_hamburger.dart';
import 'terms_of_services.dart';

class StudentGuestLogin extends StatefulWidget {
  const StudentGuestLogin({super.key, required this.setLocale});
  final void Function(Locale locale) setLocale;

  @override
  StudentGuestLoginState createState() => StudentGuestLoginState();
}

enum SingingCharacter { guest, member }

class StudentGuestLoginState extends State<StudentGuestLogin> {
  final formKey=GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController reNameController=TextEditingController();
  TextEditingController rollNumController=TextEditingController();
  bool agree = false;
  String name='';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.transparent,
          //backgroundColor: const Color.fromRGBO(0,106,100,1),
        ),
        endDrawer: Drawer(
          child: Column(
            children: [
              Container(
                  color: const Color.fromRGBO(0,106,100,1),
                  height: 55),
              Image.asset(
                "assets/images/rectangle_qna.png",
              ),
              Flexible(
                child: ListView(
                  children: [
                    ListTile(
                        leading:
                        const Icon(
                            Icons.translate,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.language,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: SettingsLanguages(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.verified_user_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.privacy_and_terms,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: PrivacyPolicyHamburger(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.verified_user_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text('Terms of Services',style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: TermsOfServiceHamburger(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.note_alt_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.cookie_policy,style: TextStyle(
                            color: textColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: CookiePolicy(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.perm_contact_calendar_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.about_us,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16)),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: AboutUs(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.help_outline,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.help,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: HelpPageHamburger(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height * 0.3,
                  width: width,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).primaryColor,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(0, 106, 100, 1),
                        Color.fromRGBO(82, 165, 160, 1)
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            width ,
                            height * 0.30)
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children : [
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          height: height * 0.25,
                          width: width * 0.22,
                          child: Image.asset("assets/images/question_mark_logo.png"),
                        ),
                      ),
                      Container(
                        width: width * 0.03,
                      )

                    ],
                  ),
                ),

                SizedBox(height:height * 0.03),
                Text(
                  '${AppLocalizations.of(context)!.guestCaps} ${AppLocalizations.of(context)!.studentCaps}',
                  style: TextStyle(
                    fontSize: height* 0.03,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height:height * 0.07),
                SizedBox(
                  width: width * 0.8,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: AppLocalizations.of(context)!.name,
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
                                  controller: nameController,
                                  onChanged: (val)
                                  {
                                    formKey.currentState!.validate();
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!.your_name,
                                    hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.02),
                                    prefixIcon: Icon(
                                      Icons.account_box_outlined,color: const Color.fromRGBO(82, 165, 160, 1),size: height * 0.03,),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                                      return AppLocalizations.of(context)!.enter_your_name;
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                )
                            ),
                          ],
                        ),
                        SizedBox(height:height * 0.06),
                        //SizedBox(height:height * 0.04),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child:
                              Text(AppLocalizations.of(context)!.registrationIdRollNum,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1
                                    ?.merge( TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.017)),),

                            ),
                            SizedBox(
                              height: height * 0.0001,
                            ),
                            Align(alignment: Alignment.center,
                                child: TextFormField(
                                  controller: rollNumController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!.enter_id,
                                    hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.02),

                                    prefixIcon: Icon(
                                        Icons.assignment_ind_outlined,color: const Color.fromRGBO(82, 165, 160, 1),size: height * 0.03),
                                  ),
                                  // validator: (value){
                                  //   if(value!.isEmpty){
                                  //     return AppLocalizations.of(context)!.enter_registrationId;
                                  //   }
                                  //   else{
                                  //     return null;
                                  //   }
                                  // },
                                )
                            ),
                          ],
                        ),
                        SizedBox(height:height * 0.07),
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!.privacy_terms,
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
                          // Text(AppLocalizations.of(context)!.privacy_terms,
                          //   style: Theme.of(context)
                          //       .primaryTextTheme
                          //       .bodyText1
                          //       ?.merge( TextStyle(
                          //       color: const Color.fromRGBO(102, 102, 102, 1),
                          //       fontFamily: 'Inter',
                          //       fontWeight: FontWeight.w600,
                          //       fontSize: height * 0.015)),),
                        ),
                        SizedBox(height:height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor: const Color.fromRGBO(82, 165, 160, 1),
                              fillColor: MaterialStateProperty
                                  .resolveWith<Color>((states) {
                                if (states.contains(
                                    MaterialState.selected)) {
                                  return const Color.fromRGBO(82, 165, 160, 1); // Disabled color
                                }
                                return const Color.fromRGBO(82, 165, 160, 1); // Regular color
                              }),
                              value: agree,
                              onChanged: (val) {
                                setState(() {
                                  agree = val!;
                                  if (agree) {
                                  }
                                });
                              },
                            ),
                            const SizedBox(width: 5,),
                            RichText(
                                text:  TextSpan(children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.agree_msg,
                                    style: const TextStyle(fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: "Inter"),
                                  ),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.privacy_Policy,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        decoration:
                                        TextDecoration.underline,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: "Inter"),
                                  ),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.and,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: "Inter"),),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.terms,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        decoration:
                                        TextDecoration.underline,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: "Inter"),
                                  ),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.services,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: "Inter"),),
                                ])
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height:height * 0.05),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                    minimumSize: const Size(280, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(39),
                    ),
                  ),
                  //shape: StadiumBorder(),
                  onPressed: () {
                    if(agree){
                      if(formKey.currentState!.validate()) {
                        name = nameController.text;
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: StudGuestAssessment(setLocale: widget.setLocale,name: name),
                          ),
                        );
                      }
                    }
                    else{
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: CustomDialog(title: AppLocalizations.of(context)!.agree_privacy_terms, content: AppLocalizations.of(context)!.error, button: AppLocalizations.of(context)!.retry),
                        ),
                      );
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                        fontSize: height * 0.032,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w800),
                  ),
                ),



              ]),
        ));
  }
}


