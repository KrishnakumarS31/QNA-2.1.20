import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_prepare_preview_qnBank.dart';
import 'package:qna_test/pages/teacher_assessment_settings_publish.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'about_us.dart';
import 'cookie_policy.dart';
import 'help_page.dart';
import 'settings_languages.dart';
import 'package:qna_test/Pages/privacy_policy_hamburger.dart';
import 'package:qna_test/Pages/terms_of_services.dart';
import 'package:qna_test/pages/reset_password_teacher.dart';
import 'teacher_prepare_qnBank.dart';


class TeacherClonedAssessmentPreview extends StatefulWidget {
  const TeacherClonedAssessmentPreview({
    Key? key, required this.setLocale,

  }) : super(key: key);
  final void Function(Locale locale) setLocale;


  @override
  TeacherClonedAssessmentPreviewState createState() => TeacherClonedAssessmentPreviewState();
}

class TeacherClonedAssessmentPreviewState extends State<TeacherClonedAssessmentPreview> {
  bool additionalDetails = true;

  showAdditionalDetails(){
    setState(() {
      !additionalDetails;
    });
  }


  @override
  void initState() {
    super.initState();
    //quesList = Provider.of<QuestionPrepareProvider>(context, listen: false).getAllQuestion;
  }



  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController teacherQuestionBankSearchController = TextEditingController();
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient:  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(0, 106, 100, 1),
                      Color.fromRGBO(82, 165, 160, 1),
                    ],
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.050),
                  Container(
                    alignment: Alignment.center,
                    height: height / 6,
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
                            "Teacher Name",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyLarge
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
                          padding: EdgeInsets.only(left: width * 0.09),
                          child: Text(
                            AppLocalizations.of(context)!.teacher,
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
                          padding: EdgeInsets.only(left: width * 0.09),
                          child: const Text(
                            "teacher@gmail.com",
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
              child:
              ListView(
                children: [
                  ListTile(
                      leading:
                      const Icon(
                          Icons.people_alt,
                          color: Color.fromRGBO(141, 167, 167, 1)),
                      title: Text(AppLocalizations.of(context)!.user_profile,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyLarge
                            ?.merge(TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16)),),
                      trailing:  const Icon(Icons.navigate_next,
                          color: Color.fromRGBO(153, 153, 153, 1)),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.rightToLeft,
                        //     child: TeacherUserProfile(userDataModel: userDataModel,),
                        //   ),
                        // );
                      }),
                  ListTile(
                      leading:
                      const Icon(
                          Icons.key_outlined,
                          color: Color.fromRGBO(141, 167, 167, 1)
                      ),
                      title: Text(AppLocalizations.of(context)!.change_password,
                        style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                      trailing:  const Icon(Icons.navigate_next,
                          color: Color.fromRGBO(153, 153, 153, 1)),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const ResetPassword(),
                          ),
                        );
                      }),
                  ListTile(
                      leading:
                      const Icon(
                          Icons.mail_outline_sharp,
                          color: Color.fromRGBO(141, 167, 167, 1)),
                      title: Text(AppLocalizations.of(context)!.change_emailId,
                        style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                      trailing:  const Icon(Icons.navigate_next,
                          color: Color.fromRGBO(153, 153, 153, 1)),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.rightToLeft,
                        //     child:  ChangeEmailTeacher(userId: userDataModel.data!.id),
                        //   ),
                        // );
                      }),
                  const Divider(
                    thickness: 2,
                  ),
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
                            .bodyLarge
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
                  const Divider(
                    thickness: 2,
                  ),
                  ListTile(
                      leading:
                      const Icon(
                          Icons.power_settings_new,
                          color: Color.fromRGBO(141, 167, 167, 1)),
                      title: Text(AppLocalizations.of(context)!.logout,style: const TextStyle(
                          color: Color.fromRGBO(226, 68, 0, 1),
                          //Color.fromRGBO(48, 145, 139, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.02,
                          fontSize: 16),),
                      onTap: () async {
                      }),
                  SizedBox(height: height * 0.03),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Version : 1.0.0",
                      style: TextStyle(
                          color: Color.fromRGBO(180, 180, 180, 1),
                          //Color.fromRGBO(48, 145, 139, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.02,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        
        leading: IconButton(
          icon:const Icon(
            Icons.chevron_left,
            size: 40.0,
            color: Colors.white,
          ), onPressed: () {
          Navigator.of(context).pop();
        },
        ),
        toolbarHeight: height * 0.100,
        centerTitle: true,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "CLONED",
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: height * 0.0225,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "ASSESSMENTS",
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
      body: Padding(
          padding: EdgeInsets.only(top: height * 0.023,left: height * 0.023,right: height * 0.023),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Total Questions: ',
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '20',
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(82, 165, 160, 1),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Total Marks: ',
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '100',
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(82, 165, 160, 1),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: height * 0.02,),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: height * 0.6,
                    width: width * 0.9,

                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // for ( DemoQuestionModel i in quesList )
                          //   QuestionPreview(height: height, width: width,question: i,),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),
                          QuestionWidget(height: height),


                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: height * 0.5,
                      left: width * 0.78,
                      child: FloatingActionButton(onPressed: (){
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: TeacherPrepareQnBank(setLocale: widget.setLocale),
                          ),
                        );
                      },
                        child: Icon(Icons.add),
                        backgroundColor: Color.fromRGBO(82, 165, 160, 1),
                      )
                  )
                ],
              ),
              SizedBox(height: height * 0.03,),
              Center(
                child: Container(
                  width: width * 0.888,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Color.fromRGBO(82, 165, 160, 1),
                        ),
                        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),

                    ),
                    //shape: StadiumBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: TeacherClonedAssessmentPreview(setLocale: widget.setLocale),
                        ),
                      );


                    },
                    child: Text(
                      'Save List',
                      style: TextStyle(
                          fontSize: height * 0.025,
                          fontFamily: "Inter",
                          color: Color.fromRGBO(82, 165, 160, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03,),
              Center(
                child: Container(
                  width: width * 0.888,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                        side: const BorderSide(
                          color: Color.fromRGBO(82, 165, 160, 1),
                        )
                    ),
                    //shape: StadiumBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: TeacherAssessmentSettingPublish(setLocale: widget.setLocale),
                        ),
                      );

//TeacherPublishedAssessment
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: height * 0.025,
                          fontFamily: "Inter",
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

}

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Q1',
                  style: TextStyle(
                      fontSize: height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(82, 165, 160, 1),
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '  MCQ',
                  style: TextStyle(
                      fontSize: height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.w400),
                ),

              ],
            ),
            Row(
              children: [
                Text(
                  'Marks: ',
                  style: TextStyle(
                      fontSize: height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '5',
                  style: TextStyle(
                      fontSize: height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(82, 165, 160, 1),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.close,color: Color.fromRGBO(51, 51, 51, 1),),
                Text(
                  ' Remove',
                  style: TextStyle(
                      fontSize: height * 0.017,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: height * 0.01,),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et nulla cursus, dictum risus sit amet, semper massa. Sed sit. Phasellus viverra, odio dignissim',
          style: TextStyle(
              fontSize: height * 0.015,
              fontFamily: "Inter",
              color: Color.fromRGBO(51, 51, 51, 1),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: height * 0.01,),
        Divider(),
        SizedBox(height: height * 0.01,),
      ],
    );
  }
}


