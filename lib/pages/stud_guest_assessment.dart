import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/reset_passwordStudent.dart';
import 'package:qna_test/Pages/settings_languages.dart';
import 'package:qna_test/Pages/stud_guest_question01.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Entity/question_paper_model.dart';
import '../EntityModel/user_data_model.dart';
import '../Services/qna_service.dart';
//AppLo, required setLocalecalizations.of(context)!.agree_privacy_terms
class StudGuestAssessment extends StatefulWidget {
  const StudGuestAssessment({
    Key? key,
    required this.name, required this.setLocale
  }) : super(key: key);
  final void Function(Locale locale) setLocale;
  final String name;
  @override
  StudGuestAssessmentState createState() => StudGuestAssessmentState();
}

class StudGuestAssessmentState extends State<StudGuestAssessment> {
  final formKey=GlobalKey<FormState>();
  TextEditingController assessmentIdController= TextEditingController();
  late QuestionPaperModel values;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    UserDataModel userDataModel=UserDataModel(code: 0, message: '');
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(constraints.maxWidth > 700){
            return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
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
                  backgroundColor: const Color.fromRGBO(0,106,100,1),
                ),
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
                            const SizedBox(height: 50),
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
                                    padding: EdgeInsets.only(left: width * 0.09),
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
                                    padding: EdgeInsets.only(left: width * 0.09),
                                    child: const Text(
                                      "Student@gmail.com",
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
                                    Icons.people_alt,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(AppLocalizations.of(context)!.user_profile,
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
                                onTap: () {
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
                                      child:  ResetPasswordStudent(userId: userDataModel.data!.id,),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                body: Column(
                    children: [
                      Container(
                        height: height * 0.26,
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
                                  width,
                                  height * 0.30)
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            SizedBox(
                              width: width * 0.03,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.chevron_left,
                                      size: 40.0,
                                      color: Colors.white,
                                    ), onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(0.0),
                                height: height * 0.22,
                                width: width * 0.22,
                                // decoration: BoxDecoration(
                                //     //color: Colors.yellow[100],
                                //     border: Border.all(
                                //       color: Colors.red,
                                //       width: 1,
                                //     )),
                                child: Image.asset(
                                    "assets/images/question_mark_logo.png"),
                              ),
                            ),
                            Container(
                              width: width * 0.03,
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Form(
                        key: formKey,
                        child: SizedBox(
                          height: height * 0.45,
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.welcome,
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.036,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              Text(
                                widget.name,
                                style: TextStyle(
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontSize: height * 0.033,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: height * 0.08),
                              SizedBox(
                                width: width * 0.2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child:
                                      Text(
                                        AppLocalizations.of(context)!.assessment_id,
                                        style: Theme
                                            .of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            ?.merge(TextStyle(
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
                                          controller: assessmentIdController,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            helperStyle: const TextStyle(
                                                color: Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                            hintText: AppLocalizations.of(context)!
                                                .enter_paper_id,
                                            prefixIcon: Icon(
                                              Icons.account_box_outlined,
                                              color: const Color.fromRGBO(82, 165, 160, 1),
                                              size: height * 0.04,),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(
                                                    value)) {
                                              return AppLocalizations.of(context)!
                                                  .assessment_id_not_found;
                                            }
                                            else {
                                              return null;
                                            }
                                          },
                                        )
                                    ),
                                    Container(height: height * 0.04,

                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.016,
                              ),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(82, 165, 160,
                                      1),
                                  minimumSize: Size(width * 0.2, height * 0.06),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39),
                                  ),
                                ),
                                onPressed: () async {

                                  if (assessmentIdController.text.length >= 8) {
                                    showDialog(context: context, builder: (context){
                                      return const Center(child: CircularProgressIndicator(
                                        color: Color.fromRGBO(48, 145, 139, 1),
                                      ));
                                    });
                                    values = await QnaService.getQuestion(assessmentId:assessmentIdController.text);
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: StudGuestQuestion(
                                          assessmentId: assessmentIdController.text,
                                          ques: values,),
                                      ),
                                    ).then((value) {
                                      assessmentIdController.clear();
                                    });

                                  }
                                  else {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: CustomDialog(
                                          title: AppLocalizations.of(context)!
                                              .invalid_assessment_iD,
                                          content: '',
                                          button: AppLocalizations.of(context)!
                                              .retry,),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.start,
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
                      SizedBox(
                        height: height * 0.06,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Color.fromRGBO(141, 167, 167, 1),
                            ),
                            onPressed: () {},
                          ),
                          Text(AppLocalizations.of(context)!.search_library,
                              style: Theme
                                  .of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  ?.merge(const TextStyle(
                                  color: Color.fromRGBO(48, 145, 139, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16))),
                        ],
                      ),
                    ]));
          }
          else{
            return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
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
                ),
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
                            const SizedBox(height: 50),
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
                                    padding: EdgeInsets.only(left: width * 0.09),
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
                                    padding: EdgeInsets.only(left: width * 0.09),
                                    child: const Text(
                                      "Student@gmail.com",
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
                                    Icons.people_alt,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(AppLocalizations.of(context)!.user_profile,
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
                                onTap: () {
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
                                      child:  ResetPasswordStudent(userId: userDataModel.data!.id,),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                body: Column(
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
                                  width,
                                  height * 0.30)
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            SizedBox(height: height* 0.0),
                            Center(
                              child: SizedBox(
                                height: height * 0.22,
                                width: width * 0.22,
                                // decoration: BoxDecoration(
                                //     //color: Colors.yellow[100],
                                //     border: Border.all(
                                //       color: Colors.red,
                                //       width: 1,
                                //     )),
                                child: Image.asset(
                                    "assets/images/question_mark_logo.png"),
                              ),
                            ),
                            Container(
                              width: width * 0.03,
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Form(
                        key: formKey,
                        child: SizedBox(
                          height: height * 0.45,
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.welcome,
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.036,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              Text(
                                widget.name,
                                style: TextStyle(
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontSize: height * 0.033,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: height * 0.08),
                              SizedBox(
                                width: width * 0.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child:
                                      Text(
                                        AppLocalizations.of(context)!.assessment_id,
                                        style: Theme
                                            .of(context)
                                            .primaryTextTheme
                                            .bodyText1
                                            ?.merge(TextStyle(
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
                                          controller: assessmentIdController,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            helperStyle: const TextStyle(
                                                color: Color.fromRGBO(
                                                    102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                            hintText: AppLocalizations.of(context)!
                                                .enter_paper_id,
                                            prefixIcon: Icon(
                                              Icons.account_box_outlined,
                                              color: const Color.fromRGBO(82, 165, 160, 1),
                                              size: height * 0.04,),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(
                                                    value)) {
                                              return AppLocalizations.of(context)!
                                                  .assessment_id_not_found;
                                            }
                                            else {
                                              return null;
                                            }
                                          },
                                        )
                                    ),
                                    Container(height: height * 0.04,

                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.016,
                              ),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(82, 165, 160,
                                      1),
                                  minimumSize: Size(width * 0.77, height * 0.06),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39),
                                  ),
                                ),
                                onPressed: () async {

                                  if (assessmentIdController.text.length >= 8) {
                                    showDialog(context: context, builder: (context){
                                      return const Center(child: CircularProgressIndicator(
                                        color: Color.fromRGBO(48, 145, 139, 1),
                                      ));
                                    });
                                    values = await QnaService.getQuestion(assessmentId:assessmentIdController.text);
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: StudGuestQuestion(
                                          assessmentId: assessmentIdController.text,
                                          ques: values,),
                                      ),
                                    );
                                  }
                                  else {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: CustomDialog(
                                          title: AppLocalizations.of(context)!
                                              .invalid_assessment_iD,
                                          content: '',
                                          button: AppLocalizations.of(context)!
                                              .retry,),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.start,
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
                      SizedBox(
                        height: height * 0.06,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //
                      //     IconButton(
                      //       icon: const Icon(
                      //         Icons.search,
                      //         color: Color.fromRGBO(141, 167, 167, 1),
                      //       ),
                      //       onPressed: () {},
                      //     ),
                      //     Text(AppLocalizations.of(context)!.search_library,
                      //         style: Theme
                      //             .of(context)
                      //             .primaryTextTheme
                      //             .bodyText1
                      //             ?.merge(const TextStyle(
                      //             color: Color.fromRGBO(48, 145, 139, 1),
                      //             fontFamily: 'Inter',
                      //             fontWeight: FontWeight.w500,
                      //             fontSize: 16))),
                      //   ],
                      // ),
                    ]));
          }
    },
    );
  }
}


