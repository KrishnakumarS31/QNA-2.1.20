import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/Teacher/get_assessment_header.dart';
import '../Entity/question_paper_model.dart';
import '../Entity/user_details.dart';
import '../EntityModel/user_data_model.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Providers/question_num_provider.dart';
import '../Services/qna_service.dart';
import '../pages/cookie_policy.dart';
import '../pages/privacy_policy_hamburger.dart';
import '../pages/terms_of_services.dart';
import '../pages/about_us.dart';
import '../pages/help_page.dart';
import 'package:qna_test/pages/settings_languages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DataSource/http_url.dart';
class StudentResultPage extends StatefulWidget {
  const StudentResultPage({Key? key,
    required this.totalMarks,
    required this.date,
    required this.time,
    required this.questions,
    required this.assessmentCode,
    required this.userName,
    required this.message,
    required this.endTime,
    required this.givenMark,
    required this.isMember,
    required this.assessmentHeaders
  })
      : super(key: key);
  final int totalMarks;
  final QuestionPaperModel questions;
  final String date;
  final String time;
  final String userName;
  final String assessmentCode;
  final String endTime;
  final String message;
  final int givenMark;
  final bool isMember;
  final GetAssessmentHeaderModel assessmentHeaders;

  @override
  StudentResultPageState createState() => StudentResultPageState();
}

class StudentResultPageState extends State<StudentResultPage> {
  TextEditingController assessmentID = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  late QuestionPaperModel values;
  UserDetails userdata=UserDetails();

  @override
  void initState() {
    super.initState();
    userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    values = widget.questions;
    print("INSIDE INIT");
    print(widget.assessmentHeaders.getAssessmentModelClass);
    print("IS WIDGET MEMBER INIT");
    print(widget.isMember);
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery
        .of(context)
        .size
        .width;
    double localHeight = MediaQuery
        .of(context)
        .size
        .height;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
          print("INSIDE TAB");
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                endDrawer: Drawer(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(0, 106, 100, 1),
                                Color.fromRGBO(82, 165, 160, 1),
                              ],
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: localHeight * 0.050),
                            Container(
                              alignment: Alignment.center,
                              height: localHeight / 6,
                              child: Row(children: [
                                CircleAvatar(
                                  backgroundColor:
                                  const Color.fromRGBO(0, 106, 100, 0),
                                  radius: MediaQuery.of(context).size.width * 0.15,
                                  child: Image.asset(
                                    "assets/images/ProfilePic_Avatar.png",
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  widget.userName,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge
                                      ?.merge(const TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,

                                      fontSize: 16)),
                                ),
                              ]),
                            ),
                            // const SizedBox(height: 0.022),
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

                                          fontSize: 12),
                                    )),
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
                                leading: const Icon(Icons.translate,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.language,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const SettingsLanguages(),
                                    ),
                                  );
                                }),
                            const Divider(
                              thickness: 2,
                            ),
                            ListTile(
                                leading: const Icon(Icons.verified_user_outlined,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.privacy_and_terms,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const PrivacyPolicyHamburger(
                                      ),
                                    ),
                                  );
                                }),
                            ListTile(
                                leading: const Icon(Icons.library_books_sharp,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.terms_of_services,
                                  //'Terms of Services',
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const TermsOfServiceHamburger(
                                      ),
                                    ),
                                  );
                                }),
                            ListTile(
                                leading: const Icon(Icons.note_alt_outlined,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.cookie_policy,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const CookiePolicy(),
                                    ),
                                  );
                                }),
                            const Divider(
                              thickness: 2,
                            ),
                            ListTile(
                                leading: const Icon(Icons.perm_contact_calendar_outlined,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.about_us,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge
                                      ?.merge(TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16)),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const AboutUs(),
                                    ),
                                  );
                                }),
                            ListTile(
                                leading: const Icon(Icons.help_outline,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.help,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const HelpPageHamburger(),
                                    ),
                                  );
                                }),
                            const Divider(
                              thickness: 2,
                            ),
                            ListTile(
                              leading: const Icon(Icons.power_settings_new,
                                  color: Color.fromRGBO(141, 167, 167, 1)),
                              title: Text(
                                AppLocalizations.of(context)!.logout,
                                style: const TextStyle(
                                    color: Color.fromRGBO(226, 68, 0, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,

                                    fontSize: 16),
                              ),
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    insetPadding: EdgeInsets.only(
                                        left: localWidth * 0.13, right: localWidth * 0.13),
                                    title: Row(children: [
                                      SizedBox(width: localHeight * 0.030),
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                        ),
                                        height: localHeight * 0.1,
                                        width: localWidth * 0.1,
                                        child: const Icon(
                                          Icons.info_outline_rounded,
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ),
                                      SizedBox(width: localHeight * 0.015),
                                      Text(
                                        AppLocalizations.of(context)!.confirm,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: localHeight * 0.024,
                                            color: const Color.fromRGBO(0, 106, 100, 1),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ]),
                                    content:
                                    const Text("Are you sure you want to logout ?"),
                                    actions: <Widget>[
                                      SizedBox(width: localWidth * 0.020),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          const Color.fromRGBO(255, 255, 255, 1),
                                          minimumSize: const Size(90, 30),
                                          side: const BorderSide(
                                            width: 1.5,
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                        ),
                                        child: Text(AppLocalizations.of(context)!.no,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: localHeight * 0.018,
                                                color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                                fontWeight: FontWeight.w500)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      SizedBox(width: localWidth * 0.005),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            const Color.fromRGBO(82, 165, 160, 1),
                                            minimumSize: const Size(90, 30),
                                          ),
                                          child: Text(AppLocalizations.of(context)!.yes,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: localHeight * 0.018,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                          onPressed: () async {
                                            SharedPreferences preferences =
                                            await SharedPreferences.getInstance();
                                            await preferences.clear();
                                            if(context.mounted) {
                                              Navigator.pushNamed(
                                                  context, '/');
                                            }
                                          }),
                                      SizedBox(width: localHeight * 0.030),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: localHeight * 0.03),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${AppLocalizations.of(context)!.version}: $version",
                                style: const TextStyle(
                                    color: Color.fromRGBO(180, 180, 180, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,

                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(height: localHeight * 0.03),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  centerTitle: true,
                  title:    Text(
                    AppLocalizations.of(context)!.result_card,
                    //"MY ASSESSMENTS",
                    style: TextStyle(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: localHeight * 0.0225,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ),
                // body: Stack(
                //   children: [
                body: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: localHeight * 0.0050),
                      child: Column(
                        children: [
                          SizedBox(
                            height: localHeight * 0.62,
                            width: localWidth * 1.5,
                            child: Card(
                              elevation: 12,
                              child: Column(children: [
                                SizedBox(height: localHeight * 0.03),
                                Text(widget.userName,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: localHeight * 0.03)),
                                //const SizedBox(height: 25.0),
                                Text('${widget.totalMarks}/${widget.givenMark}',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 153, 0, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: localHeight * 0.096)),
                                SizedBox(height:1.0),
                                Text(AppLocalizations.of(context)!.mark_scored,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.018)),
                                SizedBox(height: localHeight * 0.03),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                const SizedBox(height: 1.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left:localWidth * 0.06),
                                              child: Icon(Icons.timer,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            ),
                                            SizedBox(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  //"10:26:59",
                                                    widget.endTime.substring(0,7),
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.025)),
                                              ),
                                            ),],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(width:0.1),
                                            Text(widget.date,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.025)),],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              child: Padding(
                                                padding: EdgeInsets.only(right: localHeight * 0.06),
                                                child: Text(widget.time,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.025)),
                                              ),
                                            ),],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: localHeight * 0.05),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Assessment ID",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.080),
                                              SizedBox(
                                                child: Text(widget.assessmentCode,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            0, 106, 100, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Degree",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.14),
                                              SizedBox(
                                                child: Text("${widget.assessmentHeaders.getAssessmentModelClass ?? ""}",
                                                    //widget.assessmentHeaders.getAssessmentModelClass != null ? "${widget.assessmentHeaders.getAssessmentModelClass}" : "",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "SubTopic",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.14),
                                              SizedBox(
                                                child: Text("${widget.assessmentHeaders.subTopic ?? ""}",
                                                    //"${widget.assessmentHeaders.subTopic}",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Semester",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.14),
                                              SizedBox(
                                                child: Text("",
                                                    //"${widget.assessmentHeaders.getAssessmentModelClass}",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Topic",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.14),
                                              SizedBox(
                                                child: Text("${widget.assessmentHeaders.topic ?? ""}",
                                                    //"${widget.assessmentHeaders.topic}",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Align(
                                    alignment: Alignment.center,
                                    child:Text("Thank You",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.027))
                                )
                              ]),
                            ),
                          ),
                          SizedBox(height:localHeight * 0.07),
                          Column(
                            children: [
                              //SizedBox(height: localHeight * 0.27),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "For incorrect answers",
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.018)),
                              ),
                              SizedBox(height:0.5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MouseRegion(
                                      cursor: SystemMouseCursors
                                          .click,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                '/studMemAdvisor',
                                                arguments: [values,widget.assessmentCode]
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:25.0),
                                            child: Text(
                                                "View Advisor",
                                                style: Theme
                                                    .of(context)
                                                    .primaryTextTheme
                                                    .bodyLarge
                                                    ?.merge(TextStyle(
                                                    color: const Color
                                                        .fromRGBO(
                                                        48, 145, 139,
                                                        1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w500,
                                                    fontSize: localHeight *
                                                        0.023))),
                                          ))),
                                  IconButton(
                                    icon:
                                    Icon(
                                        size: localWidth * 0.040,
                                        weight:localWidth * 0.5,
                                        Icons.chevron_right,
                                        color: const Color
                                            .fromRGBO(
                                            48, 145, 139,
                                            1)
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context,
                                          '/studMemAdvisor',
                                          arguments: [values,widget.assessmentCode]
                                      );
                                    },
                                  ),

                                ],
                              ),
                              // SizedBox(height: localHeight * 0.010),
                              // ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: const Color.fromRGBO(
                              //           255, 255, 255, 1),
                              //       minimumSize: const Size(280, 48),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(
                              //             39),
                              //       ),
                              //       side: const BorderSide(
                              //         width: 1.5,
                              //         color: Color.fromRGBO(
                              //             82, 165, 160, 1),
                              //       ),
                              //     ),
                              //     child: Text(
                              //         AppLocalizations.of(context)!
                              //             .advisor,
                              //         style: TextStyle(
                              //             fontFamily: 'Inter',
                              //             fontSize: localHeight * 0.022,
                              //             color: const Color.fromRGBO(
                              //                 82, 165, 160, 1),
                              //             fontWeight: FontWeight.w500)),
                              //     onPressed: () {
                              //       Navigator.pushNamed(
                              //           context,
                              //           '/studMemAdvisor',
                              //           arguments: [values,widget.assessmentCode]
                              //       );
                              //     }),
                              SizedBox(height: localHeight * 0.09),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                                  minimumSize: Size(localWidth * 0.7, localHeight * 0.04),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        39),
                                  ),
                                ),
                                child: Text(
                                    AppLocalizations.of(context)!.exit,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: localHeight * 0.027,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                          insetPadding: EdgeInsets.only(
                                              left: localWidth * 0.13,
                                              right: localWidth * 0.13),
                                          title: Row(children: [
                                            SizedBox(width: localHeight *
                                                0.04),
                                            Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    82, 165, 160, 1),
                                              ),
                                              height: localHeight * 0.1,
                                              width: localWidth * 0.1,
                                              child: const Icon(
                                                Icons
                                                    .info_outline_rounded,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                              ),
                                            ),
                                            SizedBox(width: localHeight *
                                                0.018),
                                            Text(
                                              AppLocalizations.of(
                                                  context)!
                                                  .confirm,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: localHeight *
                                                      0.024,
                                                  color: const Color
                                                      .fromRGBO(
                                                      0, 106, 100, 1),
                                                  fontWeight: FontWeight
                                                      .w700),
                                            ),
                                          ]),
                                          content: const Text(
                                              "Are you sure you want to exit ?"),
                                          actions: <Widget>[
                                            SizedBox(width: localWidth *
                                                0.020),
                                            ElevatedButton(
                                              style: ElevatedButton
                                                  .styleFrom(
                                                backgroundColor:
                                                const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                minimumSize: const Size(
                                                    90, 30),
                                                side: const BorderSide(
                                                  width: 1.5,
                                                  color: Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                ),
                                              ),
                                              child: Text(
                                                  AppLocalizations.of(
                                                      context)!
                                                      .no,
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize:
                                                      localHeight * 0.018,
                                                      color: const Color
                                                          .fromRGBO(
                                                          82, 165, 160,
                                                          1),
                                                      fontWeight:
                                                      FontWeight.w500)),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop();
                                              },
                                            ),
                                            SizedBox(width: localWidth *
                                                0.005),
                                            ElevatedButton(
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                  const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  minimumSize: const Size(
                                                      90, 30),
                                                ),
                                                child: Text(
                                                    AppLocalizations.of(
                                                        context)!
                                                        .yes,
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize:
                                                        localHeight *
                                                            0.018,
                                                        color: Colors
                                                            .white,
                                                        fontWeight:
                                                        FontWeight.w500)),
                                                onPressed: () async {
                                                  Provider.of<Questions>(context, listen: false).updateAssessmentSubmit(false);
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return const Center(
                                                            child:
                                                            CircularProgressIndicator(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  48, 145,
                                                                  139, 1),
                                                            ));
                                                      });
                                                  // Navigator.pushNamed(
                                                  //     context,
                                                  //     '/studGuestAssessment',
                                                  //     arguments: widget.userName);
                                                  // Navigator.of(context)
                                                  //     .pop();
                                                  if(widget.isMember) {
                                                    SharedPreferences loginData = await SharedPreferences.getInstance();
                                                    UserDetails userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
                                                    UserDataModel userDataModel =
                                                    await QnaService
                                                        .getUserDataService(userdata.userId,userdata);
                                                    Navigator.pushNamed(
                                                        context,
                                                        '/studentAssessment',
                                                        arguments: [userdata.email,userDataModel]);
                                                  }
                                                  else {
                                                    Navigator.pushNamed(
                                                        context,
                                                        '/studGuestAssessment',
                                                        arguments: widget.userName);
                                                  }
                                                  // Navigator.push(
                                                  //   context,
                                                  //   PageTransition(
                                                  //     type: PageTransitionType
                                                  //         .rightToLeft,
                                                  //     child: StudentSelectionPage(
                                                  //         ),
                                                  //   ),
                                                  // );
                                                }),
                                            SizedBox(width: localHeight *
                                                0.030),
                                          ],
                                        ),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),

                //   ],
                // ),
              ));
        }
        else if(constraints.maxWidth > 600) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                endDrawer: Drawer(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(0, 106, 100, 1),
                                Color.fromRGBO(82, 165, 160, 1),
                              ],
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: localHeight * 0.050),
                            Container(
                              alignment: Alignment.center,
                              height: localHeight / 6,
                              child: Row(children: [
                                CircleAvatar(
                                  backgroundColor:
                                  const Color.fromRGBO(0, 106, 100, 0),
                                  radius: MediaQuery.of(context).size.width * 0.15,
                                  child: Image.asset(
                                    "assets/images/ProfilePic_Avatar.png",
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  widget.userName,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge
                                      ?.merge(const TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,

                                      fontSize: 16)),
                                ),
                              ]),
                            ),
                            // const SizedBox(height: 0.022),
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

                                          fontSize: 12),
                                    )),
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
                                leading: const Icon(Icons.translate,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.language,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const SettingsLanguages(),
                                    ),
                                  );
                                }),
                            const Divider(
                              thickness: 2,
                            ),
                            ListTile(
                                leading: const Icon(Icons.verified_user_outlined,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.privacy_and_terms,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const PrivacyPolicyHamburger(
                                      ),
                                    ),
                                  );
                                }),
                            ListTile(
                                leading: const Icon(Icons.library_books_sharp,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.terms_of_services,
                                  //'Terms of Services',
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const TermsOfServiceHamburger(
                                      ),
                                    ),
                                  );
                                }),
                            ListTile(
                                leading: const Icon(Icons.note_alt_outlined,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.cookie_policy,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const CookiePolicy(),
                                    ),
                                  );
                                }),
                            const Divider(
                              thickness: 2,
                            ),
                            ListTile(
                                leading: const Icon(Icons.perm_contact_calendar_outlined,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.about_us,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge
                                      ?.merge(TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16)),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const AboutUs(),
                                    ),
                                  );
                                }),
                            ListTile(
                                leading: const Icon(Icons.help_outline,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.help,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const HelpPageHamburger(),
                                    ),
                                  );
                                }),
                            const Divider(
                              thickness: 2,
                            ),
                            ListTile(
                              leading: const Icon(Icons.power_settings_new,
                                  color: Color.fromRGBO(141, 167, 167, 1)),
                              title: Text(
                                AppLocalizations.of(context)!.logout,
                                style: const TextStyle(
                                    color: Color.fromRGBO(226, 68, 0, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,

                                    fontSize: 16),
                              ),
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    insetPadding: EdgeInsets.only(
                                        left: localWidth * 0.13, right: localWidth * 0.13),
                                    title: Row(children: [
                                      SizedBox(width: localHeight * 0.030),
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                        ),
                                        height: localHeight * 0.1,
                                        width: localWidth * 0.1,
                                        child: const Icon(
                                          Icons.info_outline_rounded,
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ),
                                      SizedBox(width: localHeight * 0.015),
                                      Text(
                                        AppLocalizations.of(context)!.confirm,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: localHeight * 0.024,
                                            color: const Color.fromRGBO(0, 106, 100, 1),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ]),
                                    content:
                                    const Text("Are you sure you want to logout ?"),
                                    actions: <Widget>[
                                      SizedBox(width: localWidth * 0.020),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          const Color.fromRGBO(255, 255, 255, 1),
                                          minimumSize: const Size(90, 30),
                                          side: const BorderSide(
                                            width: 1.5,
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                        ),
                                        child: Text(AppLocalizations.of(context)!.no,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: localHeight * 0.018,
                                                color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                                fontWeight: FontWeight.w500)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      SizedBox(width: localWidth * 0.005),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            const Color.fromRGBO(82, 165, 160, 1),
                                            minimumSize: const Size(90, 30),
                                          ),
                                          child: Text(AppLocalizations.of(context)!.yes,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: localHeight * 0.018,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                          onPressed: () async {
                                            SharedPreferences preferences =
                                            await SharedPreferences.getInstance();
                                            await preferences.clear();
                                            if(context.mounted) {
                                              Navigator.pushNamed(
                                                  context, '/');
                                            }
                                          }),
                                      SizedBox(width: localHeight * 0.030),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: localHeight * 0.03),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${AppLocalizations.of(context)!.version}: $version",
                                style: const TextStyle(
                                    color: Color.fromRGBO(180, 180, 180, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,

                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(height: localHeight * 0.03),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  centerTitle: true,
                  title:    Text(
                    AppLocalizations.of(context)!.result_card,
                    //"MY ASSESSMENTS",
                    style: TextStyle(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: localHeight * 0.0225,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ),
                // body: Stack(
                //   children: [
                body: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: localHeight * 0.0050, left: localHeight * 0.5,right: localHeight * 0.5),
                      child: Column(
                        children: [
                          SizedBox(
                            height: localHeight * 0.62,
                            width: localWidth * 1.5,
                            child: Card(
                              elevation: 12,
                              child: Column(children: [
                                SizedBox(height: localHeight * 0.03),
                                Text(widget.userName,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: localHeight * 0.03)),
                                //const SizedBox(height: 25.0),
                                Text('${widget.totalMarks}/${widget.givenMark}',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 153, 0, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: localHeight * 0.096)),
                                SizedBox(height:1.0),
                                Text(AppLocalizations.of(context)!.mark_scored,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.018)),
                                SizedBox(height: localHeight * 0.03),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                const SizedBox(height: 1.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left:localWidth * 0.06),
                                              child: Icon(Icons.timer,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            ),
                                            SizedBox(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  //"10:26:59",
                                                    widget.endTime.substring(0,7),
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.025)),
                                              ),
                                            ),],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(width:0.1),
                                            Text(widget.date,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.025)),],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              child: Padding(
                                                padding: EdgeInsets.only(right: localHeight * 0.06),
                                                child: Text(widget.time,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.025)),
                                              ),
                                            ),],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: localHeight * 0.05),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Assessment ID",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.080),
                                              SizedBox(
                                                child: Text(widget.assessmentCode,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            0, 106, 100, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Degree",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.14),
                                              SizedBox(
                                                child: Text("${widget.assessmentHeaders.getAssessmentModelClass ?? ""}",
                                                    //widget.assessmentHeaders.getAssessmentModelClass != null ? "${widget.assessmentHeaders.getAssessmentModelClass}" : "",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "SubTopic",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.14),
                                              SizedBox(
                                                child: Text("${widget.assessmentHeaders.subTopic ?? ""}",
                                                    //"${widget.assessmentHeaders.subTopic}",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Semester",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.14),
                                              SizedBox(
                                                child: Text("",
                                                    //"${widget.assessmentHeaders.getAssessmentModelClass}",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Topic",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.14),
                                              SizedBox(
                                                child: Text("${widget.assessmentHeaders.topic ?? ""}",
                                                    //"${widget.assessmentHeaders.topic}",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Align(
                                    alignment: Alignment.center,
                                    child:Text("Thank You",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.027))
                                )
                              ]),
                            ),
                          ),
                          SizedBox(height:localHeight * 0.07),
                          Column(
                            children: [
                              //SizedBox(height: localHeight * 0.27),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "For incorrect answers",
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.018)),
                              ),
                              SizedBox(height:0.5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MouseRegion(
                                      cursor: SystemMouseCursors
                                          .click,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                '/studMemAdvisor',
                                                arguments: [values,widget.assessmentCode]
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:25.0),
                                            child: Text(
                                                "View Advisor",
                                                style: Theme
                                                    .of(context)
                                                    .primaryTextTheme
                                                    .bodyLarge
                                                    ?.merge(TextStyle(
                                                    color: const Color
                                                        .fromRGBO(
                                                        48, 145, 139,
                                                        1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w500,
                                                    fontSize: localHeight *
                                                        0.023))),
                                          ))),
                                  IconButton(
                                    icon:
                                    Icon(
                                        size: localHeight * 0.03,
                                        //weight:localWidth * 0.5,
                                        Icons.chevron_right,
                                        color: const Color
                                            .fromRGBO(
                                            48, 145, 139,
                                            1)
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context,
                                          '/studMemAdvisor',
                                          arguments: [values,widget.assessmentCode]
                                      );
                                    },
                                  ),

                                ],
                              ),
                              // SizedBox(height: localHeight * 0.010),
                              // ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: const Color.fromRGBO(
                              //           255, 255, 255, 1),
                              //       minimumSize: const Size(280, 48),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(
                              //             39),
                              //       ),
                              //       side: const BorderSide(
                              //         width: 1.5,
                              //         color: Color.fromRGBO(
                              //             82, 165, 160, 1),
                              //       ),
                              //     ),
                              //     child: Text(
                              //         AppLocalizations.of(context)!
                              //             .advisor,
                              //         style: TextStyle(
                              //             fontFamily: 'Inter',
                              //             fontSize: localHeight * 0.022,
                              //             color: const Color.fromRGBO(
                              //                 82, 165, 160, 1),
                              //             fontWeight: FontWeight.w500)),
                              //     onPressed: () {
                              //       Navigator.pushNamed(
                              //           context,
                              //           '/studMemAdvisor',
                              //           arguments: [values,widget.assessmentCode]
                              //       );
                              //     }),
                              SizedBox(height: localHeight * 0.09),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                                  minimumSize: Size(localWidth * 0.7, localHeight * 0.04),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        39),
                                  ),
                                ),
                                child: Text(
                                    AppLocalizations.of(context)!.exit,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: localHeight * 0.027,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                          insetPadding: EdgeInsets.only(
                                              left: localWidth * 0.13,
                                              right: localWidth * 0.13),
                                          title: Row(children: [
                                            SizedBox(width: localHeight *
                                                0.04),
                                            Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    82, 165, 160, 1),
                                              ),
                                              height: localHeight * 0.1,
                                              width: localWidth * 0.1,
                                              child: const Icon(
                                                Icons
                                                    .info_outline_rounded,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                              ),
                                            ),
                                            SizedBox(width: localHeight *
                                                0.018),
                                            Text(
                                              AppLocalizations.of(
                                                  context)!
                                                  .confirm,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: localHeight *
                                                      0.024,
                                                  color: const Color
                                                      .fromRGBO(
                                                      0, 106, 100, 1),
                                                  fontWeight: FontWeight
                                                      .w700),
                                            ),
                                          ]),
                                          content: const Text(
                                              "Are you sure you want to exit ?"),
                                          actions: <Widget>[
                                            SizedBox(width: localWidth *
                                                0.020),
                                            ElevatedButton(
                                              style: ElevatedButton
                                                  .styleFrom(
                                                backgroundColor:
                                                const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                minimumSize: const Size(
                                                    90, 30),
                                                side: const BorderSide(
                                                  width: 1.5,
                                                  color: Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                ),
                                              ),
                                              child: Text(
                                                  AppLocalizations.of(
                                                      context)!
                                                      .no,
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize:
                                                      localHeight * 0.018,
                                                      color: const Color
                                                          .fromRGBO(
                                                          82, 165, 160,
                                                          1),
                                                      fontWeight:
                                                      FontWeight.w500)),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop();
                                              },
                                            ),
                                            SizedBox(width: localWidth *
                                                0.005),
                                            ElevatedButton(
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                  const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  minimumSize: const Size(
                                                      90, 30),
                                                ),
                                                child: Text(
                                                    AppLocalizations.of(
                                                        context)!
                                                        .yes,
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize:
                                                        localHeight *
                                                            0.018,
                                                        color: Colors
                                                            .white,
                                                        fontWeight:
                                                        FontWeight.w500)),
                                                onPressed: () async {
                                                  Provider.of<Questions>(context, listen: false).updateAssessmentSubmit(false);
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return const Center(
                                                            child:
                                                            CircularProgressIndicator(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  48, 145,
                                                                  139, 1),
                                                            ));
                                                      });
                                                  // Navigator.pushNamed(
                                                  //     context,
                                                  //     '/studGuestAssessment',
                                                  //     arguments: widget.userName);
                                                  // Navigator.of(context)
                                                  //     .pop();
                                                  if(widget.isMember) {
                                                    SharedPreferences loginData = await SharedPreferences.getInstance();
                                                    UserDetails userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
                                                    UserDataModel userDataModel =
                                                    await QnaService
                                                        .getUserDataService(userdata.userId,userdata);
                                                    Navigator.pushNamed(
                                                        context,
                                                        '/studentAssessment',
                                                        arguments: [userdata.email,userDataModel]);
                                                  }
                                                  else {
                                                    Navigator.pushNamed(
                                                        context,
                                                        '/studGuestAssessment',
                                                        arguments: widget.userName);
                                                  }
                                                  // Navigator.push(
                                                  //   context,
                                                  //   PageTransition(
                                                  //     type: PageTransitionType
                                                  //         .rightToLeft,
                                                  //     child: StudentSelectionPage(
                                                  //         ),
                                                  //   ),
                                                  // );
                                                }),
                                            SizedBox(width: localHeight *
                                                0.030),
                                          ],
                                        ),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),

                //   ],
                // ),
              ));
        }
        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                endDrawer: Drawer(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(0, 106, 100, 1),
                                Color.fromRGBO(82, 165, 160, 1),
                              ],
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: localHeight * 0.050),
                            Container(
                              alignment: Alignment.center,
                              height: localHeight / 6,
                              child: Row(children: [
                                CircleAvatar(
                                  backgroundColor:
                                  const Color.fromRGBO(0, 106, 100, 0),
                                  radius: MediaQuery.of(context).size.width * 0.15,
                                  child: Image.asset(
                                    "assets/images/ProfilePic_Avatar.png",
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  widget.userName,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge
                                      ?.merge(const TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,

                                      fontSize: 16)),
                                ),
                              ]),
                            ),
                            // const SizedBox(height: 0.022),
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

                                          fontSize: 12),
                                    )),
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
                                leading: const Icon(Icons.translate,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.language,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const SettingsLanguages(),
                                    ),
                                  );
                                }),
                            const Divider(
                              thickness: 2,
                            ),
                            ListTile(
                                leading: const Icon(Icons.verified_user_outlined,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.privacy_and_terms,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const PrivacyPolicyHamburger(
                                      ),
                                    ),
                                  );
                                }),
                            ListTile(
                                leading: const Icon(Icons.library_books_sharp,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.terms_of_services,
                                  //'Terms of Services',
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const TermsOfServiceHamburger(
                                      ),
                                    ),
                                  );
                                }),
                            ListTile(
                                leading: const Icon(Icons.note_alt_outlined,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.cookie_policy,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const CookiePolicy(),
                                    ),
                                  );
                                }),
                            const Divider(
                              thickness: 2,
                            ),
                            ListTile(
                                leading: const Icon(Icons.perm_contact_calendar_outlined,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.about_us,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge
                                      ?.merge(TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16)),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const AboutUs(),
                                    ),
                                  );
                                }),
                            ListTile(
                                leading: const Icon(Icons.help_outline,
                                    color: Color.fromRGBO(141, 167, 167, 1)),
                                title: Text(
                                  AppLocalizations.of(context)!.help,
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,

                                      fontSize: 16),
                                ),
                                trailing: const Icon(Icons.navigate_next,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const HelpPageHamburger(),
                                    ),
                                  );
                                }),
                            const Divider(
                              thickness: 2,
                            ),
                            ListTile(
                              leading: const Icon(Icons.power_settings_new,
                                  color: Color.fromRGBO(141, 167, 167, 1)),
                              title: Text(
                                AppLocalizations.of(context)!.logout,
                                style: const TextStyle(
                                    color: Color.fromRGBO(226, 68, 0, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,

                                    fontSize: 16),
                              ),
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    insetPadding: EdgeInsets.only(
                                        left: localWidth * 0.13, right: localWidth * 0.13),
                                    title: Row(children: [
                                      SizedBox(width: localHeight * 0.030),
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                        ),
                                        height: localHeight * 0.1,
                                        width: localWidth * 0.1,
                                        child: const Icon(
                                          Icons.info_outline_rounded,
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ),
                                      SizedBox(width: localHeight * 0.015),
                                      Text(
                                        AppLocalizations.of(context)!.confirm,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: localHeight * 0.024,
                                            color: const Color.fromRGBO(0, 106, 100, 1),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ]),
                                    content:
                                    const Text("Are you sure you want to logout ?"),
                                    actions: <Widget>[
                                      SizedBox(width: localWidth * 0.020),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          const Color.fromRGBO(255, 255, 255, 1),
                                          minimumSize: const Size(90, 30),
                                          side: const BorderSide(
                                            width: 1.5,
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                        ),
                                        child: Text(AppLocalizations.of(context)!.no,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: localHeight * 0.018,
                                                color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                                fontWeight: FontWeight.w500)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      SizedBox(width: localWidth * 0.005),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            const Color.fromRGBO(82, 165, 160, 1),
                                            minimumSize: const Size(90, 30),
                                          ),
                                          child: Text(AppLocalizations.of(context)!.yes,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: localHeight * 0.018,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                          onPressed: () async {
                                            SharedPreferences preferences =
                                            await SharedPreferences.getInstance();
                                            await preferences.clear();
                                            if(context.mounted) {
                                              Navigator.pushNamed(
                                                  context, '/');
                                            }
                                          }),
                                      SizedBox(width: localHeight * 0.030),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: localHeight * 0.03),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${AppLocalizations.of(context)!.version}: $version",
                                style: const TextStyle(
                                    color: Color.fromRGBO(180, 180, 180, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,

                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(height: localHeight * 0.03),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  centerTitle: true,
                  title:    Text(
                    AppLocalizations.of(context)!.result_card,
                    //"MY ASSESSMENTS",
                    style: TextStyle(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: localHeight * 0.0225,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ),
                // body: Stack(
                //   children: [
                body: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: localHeight * 0.0050),
                      child: Column(
                        children: [
                          SizedBox(
                            height: localHeight * 0.62,
                            width: localWidth * 1.5,
                            child: Card(
                              elevation: 12,
                              child: Column(children: [
                                SizedBox(height: localHeight * 0.03),
                                Text(widget.userName,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: localHeight * 0.03)),
                                //const SizedBox(height: 25.0),
                                Text('${widget.totalMarks}/${widget.givenMark}',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 153, 0, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: localHeight * 0.096)),
                                SizedBox(height:1.0),
                                Text(AppLocalizations.of(context)!.mark_scored,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.018)),
                                SizedBox(height: localHeight * 0.03),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                const SizedBox(height: 1.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.timer,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  //"10:26:59",
                                                    widget.endTime.substring(0,7),
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.025)),
                                              ),
                                            ),],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(width:0.1),
                                            Text(widget.date,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.025)),],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(widget.time,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.025)),
                                              ),
                                            ),],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: localHeight * 0.05),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Assessment ID",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.050),
                                              SizedBox(
                                                child: Text(widget.assessmentCode,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            0, 106, 100, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Degree",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.11),
                                              SizedBox(
                                                child: Text("${widget.assessmentHeaders.getAssessmentModelClass ?? ""}",
                                                    //widget.assessmentHeaders.getAssessmentModelClass != null ? "${widget.assessmentHeaders.getAssessmentModelClass}" : "",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "SubTopic",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.026),
                                              SizedBox(
                                                child: Text("${widget.assessmentHeaders.subTopic ?? ""}",
                                                    //"${widget.assessmentHeaders.subTopic}",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Semester",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.026),
                                              SizedBox(
                                                child: Text("",
                                                    //"${widget.assessmentHeaders.getAssessmentModelClass}",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          ),
                                          Row(
                                            children: [
                                              //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              Text(
                                                //"10:26:59",
                                                  "Topic",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                              SizedBox(width:localHeight * 0.026),
                                              SizedBox(
                                                child: Text("${widget.assessmentHeaders.topic ?? ""}",
                                                    //"${widget.assessmentHeaders.topic}",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.022)),
                                              ),],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Align(
                                    alignment: Alignment.center,
                                    child:Text("Thank You",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.027))
                                )
                              ]),
                            ),
                          ),
                          SizedBox(height:30.0),
                          Column(
                            children: [
                              //SizedBox(height: localHeight * 0.27),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "For incorrect answers",
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.018)),
                              ),
                              SizedBox(height:0.5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MouseRegion(
                                      cursor: SystemMouseCursors
                                          .click,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                '/studMemAdvisor',
                                                arguments: [values,widget.assessmentCode]
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:25.0),
                                            child: Text(
                                                "View Advisor",
                                                style: Theme
                                                    .of(context)
                                                    .primaryTextTheme
                                                    .bodyLarge
                                                    ?.merge(TextStyle(
                                                    color: const Color
                                                        .fromRGBO(
                                                        48, 145, 139,
                                                        1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w500,
                                                    fontSize: localHeight *
                                                        0.023))),
                                          ))),
                                  SizedBox(width:0.0),
                                  IconButton(
                                    icon: const
                                    Icon(
                                        Icons.chevron_right,
                                        color: const Color
                                            .fromRGBO(
                                            48, 145, 139,
                                            1)
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context,
                                          '/studMemAdvisor',
                                          arguments: [values,widget.assessmentCode]
                                      );
                                    },
                                  ),

                                ],
                              ),
                              // SizedBox(height: localHeight * 0.010),
                              // ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: const Color.fromRGBO(
                              //           255, 255, 255, 1),
                              //       minimumSize: const Size(280, 48),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(
                              //             39),
                              //       ),
                              //       side: const BorderSide(
                              //         width: 1.5,
                              //         color: Color.fromRGBO(
                              //             82, 165, 160, 1),
                              //       ),
                              //     ),
                              //     child: Text(
                              //         AppLocalizations.of(context)!
                              //             .advisor,
                              //         style: TextStyle(
                              //             fontFamily: 'Inter',
                              //             fontSize: localHeight * 0.022,
                              //             color: const Color.fromRGBO(
                              //                 82, 165, 160, 1),
                              //             fontWeight: FontWeight.w500)),
                              //     onPressed: () {
                              //       Navigator.pushNamed(
                              //           context,
                              //           '/studMemAdvisor',
                              //           arguments: [values,widget.assessmentCode]
                              //       );
                              //     }),
                              SizedBox(height: localHeight * 0.03),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                                  minimumSize: const Size(280, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        39),
                                  ),
                                ),
                                child: Text(
                                    AppLocalizations.of(context)!.exit,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: localHeight * 0.027,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                          insetPadding: EdgeInsets.only(
                                              left: localWidth * 0.13,
                                              right: localWidth * 0.13),
                                          title: Row(children: [
                                            SizedBox(width: localHeight *
                                                0.04),
                                            Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    82, 165, 160, 1),
                                              ),
                                              height: localHeight * 0.1,
                                              width: localWidth * 0.1,
                                              child: const Icon(
                                                Icons
                                                    .info_outline_rounded,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                              ),
                                            ),
                                            SizedBox(width: localHeight *
                                                0.018),
                                            Text(
                                              AppLocalizations.of(
                                                  context)!
                                                  .confirm,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: localHeight *
                                                      0.024,
                                                  color: const Color
                                                      .fromRGBO(
                                                      0, 106, 100, 1),
                                                  fontWeight: FontWeight
                                                      .w700),
                                            ),
                                          ]),
                                          content: const Text(
                                              "Are you sure you want to exit ?"),
                                          actions: <Widget>[
                                            SizedBox(width: localWidth *
                                                0.020),
                                            ElevatedButton(
                                              style: ElevatedButton
                                                  .styleFrom(
                                                backgroundColor:
                                                const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                minimumSize: const Size(
                                                    90, 30),
                                                side: const BorderSide(
                                                  width: 1.5,
                                                  color: Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                ),
                                              ),
                                              child: Text(
                                                  AppLocalizations.of(
                                                      context)!
                                                      .no,
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize:
                                                      localHeight * 0.018,
                                                      color: const Color
                                                          .fromRGBO(
                                                          82, 165, 160,
                                                          1),
                                                      fontWeight:
                                                      FontWeight.w500)),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop();
                                              },
                                            ),
                                            SizedBox(width: localWidth *
                                                0.005),
                                            ElevatedButton(
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                  const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  minimumSize: const Size(
                                                      90, 30),
                                                ),
                                                child: Text(
                                                    AppLocalizations.of(
                                                        context)!
                                                        .yes,
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize:
                                                        localHeight *
                                                            0.018,
                                                        color: Colors
                                                            .white,
                                                        fontWeight:
                                                        FontWeight.w500)),
                                                onPressed: () async {
                                                  Provider.of<Questions>(context, listen: false).updateAssessmentSubmit(false);
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return const Center(
                                                            child:
                                                            CircularProgressIndicator(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  48, 145,
                                                                  139, 1),
                                                            ));
                                                      });
                                                  // Navigator.pushNamed(
                                                  //     context,
                                                  //     '/studGuestAssessment',
                                                  //     arguments: widget.userName);
                                                  // Navigator.of(context)
                                                  //     .pop();
                                                  if(widget.isMember) {
                                                    print("INSIDE IS WIDGET MEMBER");
                                                    SharedPreferences loginData = await SharedPreferences.getInstance();
                                                    UserDetails userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
                                                    print(userdata.userId);
                                                    print("BEFORE API CALL");
                                                    print(userdata.userId);
                                                    UserDataModel userDataModel =
                                                    await QnaService
                                                        .getUserDataService(userdata.userId,userdata);
                                                    print(userDataModel!.data!.email);
                                                    Navigator.pushNamed(
                                                        context,
                                                        '/studentAssessment',
                                                        arguments: [userDataModel,null,userdata.email]);
                                                  }
                                                  else {
                                                    Navigator.pushNamed(
                                                        context,
                                                        '/studGuestAssessment',
                                                        arguments: widget.userName);
                                                  }
                                                  // Navigator.push(
                                                  //   context,
                                                  //   PageTransition(
                                                  //     type: PageTransitionType
                                                  //         .rightToLeft,
                                                  //     child: StudentSelectionPage(
                                                  //         ),
                                                  //   ),
                                                  // );
                                                }),
                                            SizedBox(width: localHeight *
                                                0.030),
                                          ],
                                        ),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),

                //   ],
                // ),
              ));
        }
      },
    );
  }
}