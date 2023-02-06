import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/settings_languages.dart';
import 'package:qna_test/Pages/teacher_login.dart';
import 'student_selection_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'cookie_policy.dart';
import 'privacy_policy_hamburger.dart';
import 'terms_of_services.dart';
import 'about_us.dart';
import 'help_page.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key,required this.setLocale}) : super(key: key);
  final void Function(Locale locale) setLocale;
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {


  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;
    double localWidth = MediaQuery.of(context).size.width;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    const iconAsset = "assets/images/welcome.png";
    print(localWidth);
    print("localWidth");
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
                  height: localHeight * 0.055),
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
      body:
      SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
      child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
       SizedBox(
        height: localHeight,
        width: localWidth,
        child: Column(
          children: [
            Center(
              child:
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(iconAsset),
                  ),
                ),
              ),
            ),
            //Container(
            //width: localWidth * 0.149,
            //margin: EdgeInsets.all(localWidth * 0.15),
            // padding: const EdgeInsets.only(
            //     left: 106,
            //     top: 320),
            // child: Column(
            //     children: [
            //       Align(alignment: Alignment.center,
            //         child:
            SizedBox(
              height: localHeight * 0.06,
            ),
            Text(AppLocalizations.of(context)!.welcome,
                style:  TextStyle(
                    color: const Color.fromRGBO(28, 78, 80, 1),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: localHeight * 0.030)),
            // ),
            SizedBox(
              height: localHeight * 0.03,
            ),
            // ]),

            //),
            // Container(
            //   //margin: const EdgeInsets.only(left: 10,right: 50),
            //   padding:  const EdgeInsets.only(left: 70, right: 70),
            //   alignment: Alignment.center,
            //   child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //          Align(
            //           alignment: Alignment.topLeft,
            //           child:
            //           Text("LEARNER/APPLICANT",
            //             style: Theme.of(context)
            //                 .primaryTextTheme
            //                 .bodyText1
            //                 ?.merge(const TextStyle(
            //                 color: Color.fromRGBO(102, 102, 102, 1),
            //                 fontFamily: 'Inter',
            //                 fontWeight: FontWeight.w600,
            //                 fontSize: 14)),),
            //
            //         ),
            //         SizedBox(
            //           height: localHeight * 0.02,
            //         ),
            //         Column(
            //           children: [
            //             Align(alignment: Alignment.center,
            //             child: Expanded(
            //               child: ElevatedButton(
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
            //                   minimumSize: const Size(280, 48),
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(39),
            //                   ),
            //                 ),
            //                 //shape: StadiumBorder(),
            //                 child: const Text('Student',
            //                     style: TextStyle(
            //                         fontFamily: 'Inter',
            //                         fontSize: 24,
            //                         color: Colors.white
            //                     )),
            //                 onPressed: () async {
            //                   Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                       builder: (context) => const StudentSelectionPage(),
            //                     ),
            //                   );},
            //               ),
            //             ),
            //             )
            //           ],
            //         ),
            //       ]),
            //
            // ),
            Container(
              padding:   EdgeInsets.only(left:localWidth/15,right:localWidth/15),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.only(left: localWidth/15,right:localWidth/15),
                      child:  Align(
                        alignment: Alignment.centerLeft,
                        child:
                        Text(AppLocalizations.of(context)!.learner_applicant,
                            style:  TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: localHeight * 0.014)),

                      ),
                    ),
                    SizedBox(
                      height: localHeight * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: localWidth/15,right: localWidth/15),
                      child:Align(alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                            minimumSize: const Size(280, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(39),
                            ),
                          ),
                          //shape: StadiumBorder(),
                          child:  Text(AppLocalizations.of(context)!.student,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: localHeight * 0.024,
                                  color: Colors.white
                              )),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child:StudentSelectionPage(setLocale: widget.setLocale),
                              ),
                            );
                            },
                        ),
                      ),
                    )]),
            ),
            SizedBox(
              height: localHeight * 0.07,
            ),
            Container(
              padding:   EdgeInsets.only(left:localWidth/15,right:localWidth/15),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.only(left: localWidth/15,right:localWidth/15),
                      child:  Align(
                        alignment: Alignment.centerLeft,
                        child:
                        Text(AppLocalizations.of(context)!.instructor_examiner,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                ?.merge( TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: localHeight * 0.014))),

                      ),
                    ),
                    SizedBox(
                      height: localHeight * 0.02,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: localWidth/15,right: localWidth/15),
                        child:Align(alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                              minimumSize: const Size(280, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(39),
                              ),
                            ),
                            //shape: StadiumBorder(),
                            child: Text(AppLocalizations.of(context)!.teacher,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: localHeight * 0.024,
                                    color: Colors.white
                                )),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TeacherLogin(setLocale: widget.setLocale),
                                ),
                              );
                            },
                          ),
                        )
                    ),
                  ]),
            ),
            SizedBox(
              height: localHeight * 0.05,
            ),
            MaterialButton(

                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: SettingsLanguages(setLocale: widget.setLocale),
                    ),
                  );
                },
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    IconButton(
                      icon: const Icon(
                        Icons.translate,
                        color: Color.fromRGBO(141, 167, 167, 1),
                      ), onPressed: () {
                    },
                    ),
                    Text(AppLocalizations.of(context)!.select_language,
                      style: TextStyle(
                          color: const Color.fromRGBO(48, 145, 139, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: localHeight * 0.016),
                    )],
                )


            ),
            // SizedBox(
            //   height:localHeight * 0.05,
            // ),
          ],
        ))])
          ));
   // ));
  }
}