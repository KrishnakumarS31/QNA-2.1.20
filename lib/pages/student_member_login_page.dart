import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Services/qna_service.dart';
import '../Components/custom_incorrect_popup.dart';
import 'forgot_password_email.dart';
import 'student_registration_page.dart';
import 'student_MemLoged_Start.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
//AppLocalizations.of(context)!.guest

class StudentMemberLoginPage extends StatefulWidget {
  const StudentMemberLoginPage({super.key, required this.setLocale});
  final void Function(Locale locale) setLocale;

  @override
  StudentMemberLoginPageState createState() => StudentMemberLoginPageState();
}

class StudentMemberLoginPageState extends State<StudentMemberLoginPage> {
  TextEditingController regNumberController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  String regNumber = "";
  String passWord = "";
  final formKey = GlobalKey<FormState>();
  bool agree = false;
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          //elevation: 10,
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
          backgroundColor: const Color.fromRGBO(0,106,100,1),
        ),
        endDrawer: Drawer(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient:  LinearGradient(
                      // begin: Alignment.topLeft,
                      // end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(0, 106, 100, 1),
                        Color.fromRGBO(82, 165, 160, 1),
                      ],
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      alignment: Alignment.center,
                      height: localHeight / 6,
                      child:
                      Row(
                          children:  [
                            CircleAvatar(
                              backgroundColor: const Color.fromRGBO(0,106,100,0),
                              radius: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.15,
                              child: Image.asset(
                                "assets/images/ProfilePic_Avatar.png",
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              "Student Name",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  ?.merge(const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.02,
                                  fontSize: 16)),
                            ),
                          ]),
                    ),
                    const SizedBox(height: 0.022),
                    Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: localWidth * 0.09),
                            child: Text(
                              AppLocalizations.of(context)!.student,
                              style: const TextStyle(
                                  color: Color.fromRGBO(221, 221, 221, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.02,
                                  fontSize: 12),
                            )
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: localWidth * 0.09),
                            child: const Text(
                              "student@gmail.com",
                              style: TextStyle(
                                  color: Color.fromRGBO(221, 221, 221, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.02,
                                  fontSize: 12),
                            )
                        ),
                      ],
                    ),
                    //    )
                  ],
                ),
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
                        }),
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
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.note_alt_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.cookie_policy,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                        }),
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
                        }),
                    const Divider(
                      thickness: 2,
                    ),
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
                        onTap: () async {
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(children: [
              Container(
                //height: localHeight * 0.43,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(0, 106, 100, 1),
                      Color.fromRGBO(82, 165, 160, 1),
                    ],
                  ),
                  borderRadius: BorderRadius.vertical(
                      bottom:
                      Radius.elliptical(localWidth, localHeight * 0.35)),
                ),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: localHeight * 0.050),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: IconButton(
                    //     icon: const Icon(Icons.chevron_left,
                    //         size: 40.0,
                    //         color: Color.fromRGBO(255, 255, 255, 0.8)),
                    //     onPressed: () {
                    //       Navigator.of(context).pop();
                    //     },
                    //   ),
                    // ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: localHeight * 0.20,
                        width: localWidth * 0.30,
                        // decoration:  const BoxDecoration(
                        //   image: DecorationImage(
                        //     fit: BoxFit.fill,
                        //     image: AssetImage(iconAsset),
                        //   ),
                        // ),
                        child:
                        Image.asset("assets/images/question_mark_logo.png"),
                        // decoration: BoxDecoration(
                        //     //color: Colors.yellow[100],
                        //     border: Border.all(
                        //       color: Colors.red,
                        //       width: 1,
                        //     )),
                        // child: Image.asset("assets/images\question_mark_logo.png"),
                      ),
                    ),
                    SizedBox(height: localHeight * 0.025),
                  ],
                ),
              ),

              //Column(
              // children: [
              // Align(
              //alignment: Alignment.center,
              // child:
              SizedBox(height: localHeight * 0.03),
              Text(
                AppLocalizations.of(context)!.member_student,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w800,
                ),
              ),
              //  ),
              //   SizedBox(
              //     height: localHeight * 0.03,
              //   ),
              //    ]

              //  ),
              SizedBox(height: localHeight * 0.06),
              Container(
                //margin: const EdgeInsets.only(left: 10,right: 50),
                padding: EdgeInsets.only(
                    left: localHeight * 0.030, right: localHeight * 0.030),
                child: Form(
                  key: formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppLocalizations.of(context)!.regId_emailId,
                            style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: localHeight * 0.014),
                          ),
                        ),
                        SizedBox(
                          height: localHeight * 0.02,
                        ),
                        Column(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: regNumberController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .error_regID;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      helperStyle: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 0.3),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: localHeight * 0.016),
                                      hintText: AppLocalizations.of(context)!
                                          .hint_regId,
                                      prefixIcon: const Icon(
                                          Icons.contacts_outlined,
                                          color:
                                          Color.fromRGBO(82, 165, 160, 1)),
                                    ))),
                          ],
                        ),
                      ]),
                ),
              ),
              //  demo.qna@viewwiser.com
              //password
              SizedBox(
                height: localHeight * 0.04,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: localHeight * 0.030, right: localHeight * 0.030),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppLocalizations.of(context)!.password_caps,
                          style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: localHeight * 0.014),
                        ),
                      ),
                      SizedBox(
                        height: localHeight * 0.02,
                      ),
                      Column(
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Registration ID or Roll Number not found";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: passWordController,
                                  decoration: InputDecoration(
                                    helperStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localWidth * 0.016),
                                    hintText: AppLocalizations.of(context)!
                                        .your_password,
                                    prefixIcon: const Icon(
                                        Icons.lock_outline_rounded,
                                        color: Color.fromRGBO(82, 165, 160, 1)),
                                  ))),
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                height: localHeight * 0.03,
              ),
              Container(
                //margin: const EdgeInsets.only(left: ),
                  padding: EdgeInsets.only(left: localHeight * 0.35),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ForgotPasswordEmail(),
                            ),
                          );
                        },
                        child: Text(
                            AppLocalizations.of(context)!.forgot_password,
                            style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: localHeight * 0.014)),
                      ),
                    ],
                  )),
              SizedBox(
                height: localHeight * 0.02,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                      //shape: StadiumBorder(),
                      child: Text(AppLocalizations.of(context)!.login,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: localHeight * 0.024,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          regNumber = regNumberController.text;
                          passWord = passWordController.text;
                          showDialog(context: context, builder: (context){
                            return Center(child: CircularProgressIndicator(
                              color: Color.fromRGBO(48, 145, 139, 1),
                            ));
                          });
                          int statusCode =
                          await QnaService.logInUser(regNumber, passWord);
                          Navigator.of(context).pop();
                          if (statusCode == 200) {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child:
                                StudentMemLogedStart(regNumber: regNumber,setLocale: widget.setLocale),
                              ),
                            ).then((value) {
                              regNumberController.clear();
                              passWordController.clear();
                            });
                          } else {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: CustomDialog(
                                  title: 'Incorrect Email Id / Password',
                                  content:
                                  'Entered Email ID or password is not valid',
                                  button: AppLocalizations.of(context)!.retry,
                                ),
                              ),
                            );
                          }
                        }
                      },

                      // {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const StudentMemLogedStart(),
                      //     ),
                      //   );},
                    ),
                  )
                ],
              ),
              SizedBox(
                height: localHeight * 0.02,
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentRegistrationPage(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit_note_sharp,
                          color: Color.fromRGBO(141, 167, 167, 1),
                        ),
                        onPressed: () {},
                      ),
                      Text(AppLocalizations.of(context)!.register,
                          style: TextStyle(
                              color: const Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: localHeight * 0.018)),
                    ],
                  )),
              SizedBox(
                height: localHeight * 0.03,
              ),
            ])));
  }
}