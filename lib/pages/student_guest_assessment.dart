import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/Teacher/get_assessment_header.dart';
import 'package:qna_test/Entity/Teacher/response_entity.dart';
import 'package:qna_test/pages/privacy_policy_hamburger.dart';
import 'package:qna_test/pages/settings_languages.dart';
import 'package:qna_test/pages/about_us.dart';
import 'package:qna_test/pages/cookie_policy.dart';
import 'package:qna_test/pages/help_page.dart';
import 'package:qna_test/pages/teacher/question/create_new_question.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Components/today_date.dart';
import '../DataSource/http_url.dart';
import '../Entity/question_paper_model.dart';
import '../Entity/user_details.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Services/qna_service.dart';
import 'terms_of_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudGuestAssessment extends StatefulWidget {
  const StudGuestAssessment({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  StudGuestAssessmentState createState() => StudGuestAssessmentState();
}

class StudGuestAssessmentState extends State<StudGuestAssessment> {
  final formKey = GlobalKey<FormState>();
  TextEditingController assessmentIdController = TextEditingController();
  ResponseEntity assessmentvalues = ResponseEntity();
  late QuestionPaperModel values;
  GetAssessmentHeaderModel assessmentHeaderValues = GetAssessmentHeaderModel();
  String assessmentId = '';
  int x = 2;
  bool _notPressedYes = false;
  bool _notPressedNo = false;
  bool _searchPressed = false;
  UserDetails userDetails = UserDetails();
  @override
  void initState() {
    userDetails =
        Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 960 && constraints.maxWidth >= 500) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  //extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    toolbarHeight: height * 0.100,
                    iconTheme:
                        IconThemeData(color: Colors.black, size: width * 0.08),
                  ),
                  endDrawer: Drawer(
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.050),
                              Container(
                                alignment: Alignment.topLeft,
                                // height: localHeight / 10,
                                child: Row(children: [
                                  // SizedBox(width: width * 0.015),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                      backgroundColor:
                                          const Color.fromRGBO(0, 106, 100, 0),
                                      child: Image.asset(
                                        "assets/images/ProfilePic_Avatar.png",
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.name,
                                        style: const TextStyle(
                                            color:
                                                Color.fromRGBO(82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.student,
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ]),
                              ),
                              // Center(
                              //     child: ),
                              // SizedBox(height: localHeight * 0.020),
                              //    )
                            ],
                          ),
                        ),
                        Flexible(
                          child: ListView(
                            children: [
                              const Divider(
                                thickness: 2,
                              ),
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
                                  leading: const Icon(
                                      Icons.verified_user_outlined,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .privacy_and_terms,
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const PrivacyPolicyHamburger(),
                                      ),
                                    );
                                  }),
                              ListTile(
                                  leading: const Icon(Icons.library_books_sharp,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .terms_of_services,
                                    //'Terms of Services',
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const TermsOfServiceHamburger(),
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
                                  leading: const Icon(
                                      Icons.perm_contact_calendar_outlined,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!.about_us,
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
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
                                          left: width * 0.13,
                                          right: width * 0.13),
                                      title: Row(children: [
                                        SizedBox(width: height * 0.030),
                                        Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                          height: height * 0.1,
                                          width: width * 0.1,
                                          child: const Icon(
                                            Icons.info_outline_rounded,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ),
                                        ),
                                        SizedBox(width: height * 0.015),
                                        Text(
                                          AppLocalizations.of(context)!.confirm,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: height * 0.024,
                                              color: const Color.fromRGBO(
                                                  0, 106, 100, 1),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ]),
                                      content: const Text(
                                          "Are you sure you want to logout ?"),
                                      actions: <Widget>[
                                        SizedBox(width: width * 0.020),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                            minimumSize: const Size(90, 30),
                                            side: const BorderSide(
                                              width: 1.5,
                                              color: Color.fromRGBO(
                                                  82, 165, 160, 1),
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!.no,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: height * 0.018,
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontWeight: FontWeight.w500)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        SizedBox(width: width * 0.005),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                              minimumSize: const Size(90, 30),
                                            ),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .yes,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: height * 0.018,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            onPressed: () async {
                                              SharedPreferences preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await preferences.clear();
                                              Navigator.pushNamed(context, '/');
                                            }),
                                        SizedBox(width: height * 0.030),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: height * 0.03),
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
                              SizedBox(height: height * 0.03),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.050,
                              left: height * 0.040,
                              right: height * 0.040),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context)!.welcome,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.035),
                                  ),
                                ),
                                SizedBox(
                                  width: width,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(widget.name,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                28, 78, 80, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.03)),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.08,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .enter_assId,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: height * 0.020),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.0016,
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: height * 0.045),
                                              child: Form(
                                                  key: formKey,
                                                  autovalidateMode:
                                                      AutovalidateMode.disabled,
                                                  child: SizedBox(
                                                    width: width * 0.9,
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          return value!.length <
                                                                  8
                                                              ? AppLocalizations
                                                                      .of(context)!
                                                                  .valid_assId
                                                              : null;
                                                        },
                                                        controller:
                                                            assessmentIdController,
                                                        onChanged: (val) {
                                                          formKey.currentState!
                                                              .validate();
                                                        },
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  '[a-zA-Z0-9]')),
                                                        ],
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                          labelStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineMedium,
                                                          helperStyle: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: height *
                                                                  0.016),
                                                          hintText:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .assessment_id,
                                                          suffixIcon:
                                                              ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              assessmentvalues =
                                                                  await QnaService.getAssessmentHeader(
                                                                      assessmentIdController
                                                                          .text,
                                                                      userDetails);
                                                              if (assessmentvalues
                                                                          .code ==
                                                                      200 &&
                                                                  assessmentvalues
                                                                              .data[
                                                                          "allow_guest_student"] ==
                                                                      false) {
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .rightToLeft,
                                                                    child:
                                                                        CustomDialog(
                                                                      title: AppLocalizations.of(
                                                                              context)!
                                                                          .alert_popup,
                                                                      content:
                                                                          'Guest Students Not Allowed',
                                                                      button: AppLocalizations.of(
                                                                              context)!
                                                                          .retry,
                                                                    ),
                                                                  ),
                                                                );
                                                              } else if (assessmentvalues
                                                                          .code ==
                                                                      200 &&
                                                                  assessmentvalues
                                                                              .data[
                                                                          "allow_guest_student"] ==
                                                                      true) {
                                                                setState(() {
                                                                  assessmentHeaderValues =
                                                                      GetAssessmentHeaderModel.fromJson(
                                                                          assessmentvalues
                                                                              .data);
                                                                  _searchPressed =
                                                                      true;
                                                                });
                                                              } else if (assessmentvalues
                                                                      .code ==
                                                                  400) {
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .rightToLeft,
                                                                    child:
                                                                        CustomDialog(
                                                                      title: AppLocalizations.of(
                                                                              context)!
                                                                          .alert_popup,
                                                                      content:
                                                                          '${assessmentvalues.message}',
                                                                      button: AppLocalizations.of(
                                                                              context)!
                                                                          .retry,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            child: const Icon(
                                                                Icons
                                                                    .search_outlined,
                                                                color: Colors
                                                                    .white),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              fixedSize:
                                                                  const Size(
                                                                      8, 8),
                                                              side:
                                                                  const BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        82,
                                                                        165,
                                                                        160,
                                                                        1),
                                                              ),
                                                              shape:
                                                                  const CircleBorder(),
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1), // <-- Button color
                                                            ),
                                                          ),
                                                          // prefixIcon:
                                                          // const Icon(
                                                          //     Icons.event_note_outlined,
                                                          //     color: Color.fromRGBO(
                                                          //         82, 165, 160, 1)),
                                                        )),
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ]),
                                SizedBox(
                                  height: width * 0.1,
                                ),
                                _searchPressed
                                    ? Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                            width: width * 0.79,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 0.2)),
                                            ),
                                            child: Column(children: [
                                              Container(
                                                height: height * 0.1087,
                                                width: width * 0.79,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 0.15),
                                                  ),
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 0.1),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.02,
                                                          right: width * 0.02),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                assessmentHeaderValues
                                                                        .subject ??
                                                                    "",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.0175,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                " | ${assessmentHeaderValues.topic ?? " "}",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.0175,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.02,
                                                          right: width * 0.02),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                assessmentHeaderValues
                                                                        .subTopic ??
                                                                    "",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.0175,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                              Text(
                                                                " | ${assessmentHeaderValues.getAssessmentModelClass}",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.0175,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.02,
                                                          right: width * 0.02),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .assessment_id_caps,
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                            .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontSize:
                                                                        height *
                                                                            0.015,
                                                                    fontFamily:
                                                                        "Inter",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  assessmentIdController
                                                                      .text,
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                            .fromRGBO(
                                                                        82,
                                                                        165,
                                                                        160,
                                                                        1),
                                                                    fontSize:
                                                                        height *
                                                                            0.015,
                                                                    fontFamily:
                                                                        "Inter",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              assessmentHeaderValues
                                                                              .assessmentStartdate !=
                                                                          0 &&
                                                                      assessmentHeaderValues
                                                                              .assessmentStartdate !=
                                                                          null
                                                                  ? convertDate(
                                                                      assessmentHeaderValues
                                                                          .assessmentStartdate)
                                                                  : " ",
                                                              style: TextStyle(
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                    height *
                                                                        0.015,
                                                                fontFamily:
                                                                    "Inter",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: width * 0.05),
                                              Column(
                                                children: [
                                                  Padding(
                                                      //alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          left: height * 0.01),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            width: width,
                                                            child: Text(
                                                              "Is this the assessment you want to take?",
                                                              style: TextStyle(
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                    height *
                                                                        0.0195,
                                                                fontFamily:
                                                                    "Inter",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                      height: width * 0.05),
                                                  SizedBox(
                                                    width: width,
                                                    child: Padding(
                                                      //alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          left: height * 0.01),
                                                      child: Text(
                                                        "Please note, once you start a test, you",
                                                        style: TextStyle(
                                                          color: const Color
                                                                  .fromRGBO(
                                                              28, 78, 80, 1),
                                                          fontSize:
                                                              height * 0.0195,
                                                          fontFamily: "Inter",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width,
                                                    child: Padding(
                                                      //alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          left: height * 0.01),
                                                      child: Text(
                                                        "must complete it.",
                                                        style: TextStyle(
                                                          color: const Color
                                                                  .fromRGBO(
                                                              28, 78, 80, 1),
                                                          fontSize:
                                                              height * 0.0195,
                                                          fontFamily: "Inter",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.03),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              _notPressedNo
                                                                  ? const Color
                                                                          .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1)
                                                                  : Colors
                                                                      .white,
                                                          minimumSize:
                                                              const Size(
                                                                  90, 35),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        39),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            _notPressedNo =
                                                                true;
                                                            _notPressedYes =
                                                                false;
                                                            _searchPressed =
                                                                false;
                                                          });
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .no,
                                                          style: TextStyle(
                                                              color: _notPressedNo
                                                                  ? Colors.white
                                                                  : const Color
                                                                          .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1),
                                                              fontSize:
                                                                  height * 0.02,
                                                              fontFamily:
                                                                  "Inter",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              _notPressedYes
                                                                  ? const Color
                                                                          .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1)
                                                                  : Colors
                                                                      .white,
                                                          minimumSize:
                                                              const Size(
                                                                  90, 35),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        39),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          setState(() {
                                                            _notPressedYes =
                                                                true;
                                                            _notPressedNo =
                                                                false;
                                                          });
                                                          values = await QnaService
                                                              .getQuestionGuest(
                                                                  assessmentIdController
                                                                      .text,
                                                                  widget.name);
                                                          if (assessmentIdController
                                                                  .text
                                                                  .length >=
                                                              8) {
                                                            if (values.code ==
                                                                200) {


                                                                if(values.data!.questions!.isEmpty|| values.data?.questions == [] )
                                                                {
                                                                  Navigator.push(
                                                                    context,
                                                                    PageTransition(
                                                                      type: PageTransitionType
                                                                          .rightToLeft,
                                                                      child:
                                                                      CustomDialog(
                                                                        title: AppLocalizations.of(
                                                                            context)!
                                                                            .alert_popup,
                                                                        content: "No questions available for this assessment",
                                                                        button: AppLocalizations.of(
                                                                            context)!
                                                                            .ok_caps,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                else {
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      '/studQuestion',
                                                                      arguments: [
                                                                        assessmentIdController
                                                                            .text,
                                                                        values,
                                                                        widget.name,
                                                                        null,
                                                                        false,
                                                                        assessmentHeaderValues,
                                                                        ""
                                                                      ]);
                                                                }

                                                            }
                                                          }
                                                          else {
                                                            Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType
                                                                    .rightToLeft,
                                                                child:
                                                                    CustomDialog(
                                                                  title: AppLocalizations.of(
                                                                          context)!
                                                                      .alert_popup,
                                                                  content:
                                                                      '${values.message}',
                                                                  button: AppLocalizations.of(
                                                                          context)!
                                                                      .retry,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .yes,
                                                          style: TextStyle(
                                                              color: _notPressedYes
                                                                  ? Colors.white
                                                                  : const Color
                                                                          .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1),
                                                              fontSize:
                                                                  height * 0.02,
                                                              fontFamily:
                                                                  "Inter",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: height * 0.09)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ])),
                                      )
                                    : const SizedBox(),
                              ])))));
        } else if (constraints.maxWidth > 960) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  //extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    toolbarHeight: height * 0.100,
                    iconTheme:
                        const IconThemeData(color: Colors.black, size: 40.0),
                  ),
                  endDrawer: Drawer(
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.050),
                              Container(
                                alignment: Alignment.topLeft,
                                // height: localHeight / 10,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // const SizedBox(width: 20),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          backgroundColor: const Color.fromRGBO(
                                              0, 106, 100, 0),
                                          child: Image.asset(
                                            "assets/images/ProfilePic_Avatar.png",
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.name,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .student,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                              // SizedBox(height: localHeight * 0.020),
                              //    )
                            ],
                          ),
                        ),
                        Flexible(
                          child: ListView(
                            children: [
                              const Divider(
                                thickness: 2,
                              ),
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
                                  leading: const Icon(
                                      Icons.verified_user_outlined,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .privacy_and_terms,
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const PrivacyPolicyHamburger(),
                                      ),
                                    );
                                  }),
                              ListTile(
                                  leading: const Icon(Icons.library_books_sharp,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .terms_of_services,
                                    //'Terms of Services',
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const TermsOfServiceHamburger(),
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
                                  leading: const Icon(
                                      Icons.perm_contact_calendar_outlined,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!.about_us,
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
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
                                          left: width * 0.13,
                                          right: width * 0.13),
                                      title: Row(children: [
                                        SizedBox(width: height * 0.030),
                                        Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                          height: height * 0.1,
                                          width: width * 0.1,
                                          child: const Icon(
                                            Icons.info_outline_rounded,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ),
                                        ),
                                        SizedBox(width: height * 0.015),
                                        Text(
                                          AppLocalizations.of(context)!.confirm,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: height * 0.024,
                                              color: const Color.fromRGBO(
                                                  0, 106, 100, 1),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ]),
                                      content: const Text(
                                          "Are you sure you want to logout ?"),
                                      actions: <Widget>[
                                        SizedBox(width: width * 0.020),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                            minimumSize: const Size(90, 30),
                                            side: const BorderSide(
                                              width: 1.5,
                                              color: Color.fromRGBO(
                                                  82, 165, 160, 1),
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!.no,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: height * 0.018,
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontWeight: FontWeight.w500)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        SizedBox(width: width * 0.005),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                              minimumSize: const Size(90, 30),
                                            ),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .yes,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: height * 0.018,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            onPressed: () async {
                                              SharedPreferences preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await preferences.clear();
                                              Navigator.pushNamed(context, '/');
                                            }),
                                        SizedBox(width: height * 0.030),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: height * 0.03),
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
                              SizedBox(height: height * 0.03),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.050,
                                  left: height * 0.040,
                                  right: height * 0.040),
                              width: width * 0.4,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: width * 0.4),
                                    // Container(
                                    //   width: width,
                                    //   margin: EdgeInsets.only(left: width * 0.1),
                                    //child: Column(children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppLocalizations.of(context)!.welcome,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.035),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: height * 0.001,
                                    // ),
                                    SizedBox(
                                      width: width,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            widget.name,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyLarge
                                                ?.merge(TextStyle(
                                                    color: const Color.fromRGBO(
                                                        28, 78, 80, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.03)),
                                          )),
                                    ),
                                    SizedBox(
                                      height: height * 0.08,
                                    ),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .enter_assId,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: height * 0.020),
                                              ),
                                            ])),
                                          ),
                                          SizedBox(
                                            height: height * 0.0016,
                                          ),
                                          Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: height * 0.045),
                                                  child: Form(
                                                      key: formKey,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .disabled,
                                                      child: SizedBox(
                                                        width: width * 0.9,
                                                        child: TextFormField(
                                                            validator: (value) {
                                                              return value!
                                                                          .length <
                                                                      8
                                                                  ? AppLocalizations.of(
                                                                          context)!
                                                                      .valid_assId
                                                                  : null;
                                                            },
                                                            controller:
                                                                assessmentIdController,
                                                            onChanged: (val) {
                                                              formKey
                                                                  .currentState!
                                                                  .validate();
                                                            },
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      '[a-zA-Z0-9]')),
                                                            ],
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                              labelStyle: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .headlineMedium,
                                                              helperStyle: TextStyle(
                                                                  color:
                                                                      const Color
                                                                              .fromRGBO(
                                                                          102,
                                                                          102,
                                                                          102,
                                                                          0.3),
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      height *
                                                                          0.016),
                                                              hintText: AppLocalizations
                                                                      .of(context)!
                                                                  .assessment_id,
                                                              suffixIcon:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  assessmentvalues = await QnaService.getAssessmentHeader(
                                                                      assessmentIdController
                                                                          .text,
                                                                      userDetails);
                                                                  if (assessmentvalues
                                                                              .code ==
                                                                          200 &&
                                                                      assessmentvalues.data[
                                                                              "allow_guest_student"] ==
                                                                          false) {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      PageTransition(
                                                                        type: PageTransitionType
                                                                            .rightToLeft,
                                                                        child:
                                                                            CustomDialog(
                                                                          title:
                                                                              AppLocalizations.of(context)!.alert_popup,
                                                                          content:
                                                                              'Guest Student Not Allowed',
                                                                          button:
                                                                              AppLocalizations.of(context)!.retry,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  } else if (assessmentvalues
                                                                              .code ==
                                                                          200 &&
                                                                      assessmentvalues.data[
                                                                              "allow_guest_student"] ==
                                                                          true) {
                                                                    //print(assessmentValues.data);
                                                                    setState(
                                                                        () {
                                                                      assessmentHeaderValues =
                                                                          GetAssessmentHeaderModel.fromJson(
                                                                              assessmentvalues.data);
                                                                      _searchPressed =
                                                                          true;
                                                                    });
                                                                  } else if (assessmentvalues
                                                                          .code ==
                                                                      400) {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      PageTransition(
                                                                        type: PageTransitionType
                                                                            .rightToLeft,
                                                                        child:
                                                                            CustomDialog(
                                                                          title:
                                                                              AppLocalizations.of(context)!.alert_popup,
                                                                          content:
                                                                              '${assessmentvalues.message}',
                                                                          button:
                                                                              AppLocalizations.of(context)!.retry,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                                child: const Icon(
                                                                    Icons
                                                                        .search_outlined,
                                                                    color: Colors
                                                                        .white),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  fixedSize:
                                                                      const Size(
                                                                          8, 8),
                                                                  side:
                                                                      const BorderSide(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1),
                                                                  ),
                                                                  shape:
                                                                      const CircleBorder(),
                                                                  backgroundColor:
                                                                      const Color
                                                                              .fromRGBO(
                                                                          82,
                                                                          165,
                                                                          160,
                                                                          1), // <-- Button color
                                                                ),
                                                              ),
                                                              // prefixIcon:
                                                              // const Icon(
                                                              //     Icons.event_note_outlined,
                                                              //     color: Color.fromRGBO(
                                                              //         82, 165, 160, 1)),
                                                            )),
                                                      )),
                                                ),
                                              )
                                            ],
                                          ),
                                        ]),
                                    SizedBox(height: width * 0.05),
                                    _searchPressed
                                        ? Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                                width: width * 0.48,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromRGBO(
                                                              82,
                                                              165,
                                                              160,
                                                              0.2)),
                                                ),
                                                child: Column(children: [
                                                  Container(
                                                    height: height * 0.1087,
                                                    width: width * 0.48,
                                                    decoration: BoxDecoration(
                                                      //borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                                      border: Border.all(
                                                        color: const Color
                                                                .fromRGBO(
                                                            82, 165, 160, 0.15),
                                                      ),
                                                      color:
                                                          const Color.fromRGBO(
                                                              82,
                                                              165,
                                                              160,
                                                              0.1),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: width *
                                                                      0.01,
                                                                  right: width *
                                                                      0.01),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    assessmentHeaderValues
                                                                            .subject ??
                                                                        "",
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          28,
                                                                          78,
                                                                          80,
                                                                          1),
                                                                      fontSize:
                                                                          height *
                                                                              0.0175,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    " | ${assessmentHeaderValues.topic ?? " "}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          28,
                                                                          78,
                                                                          80,
                                                                          1),
                                                                      fontSize:
                                                                          height *
                                                                              0.0175,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: width *
                                                                      0.01,
                                                                  right: width *
                                                                      0.01),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    assessmentHeaderValues
                                                                            .subTopic ??
                                                                        "",
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          28,
                                                                          78,
                                                                          80,
                                                                          1),
                                                                      fontSize:
                                                                          height *
                                                                              0.0175,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    " | ${assessmentHeaderValues.getAssessmentModelClass}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          28,
                                                                          78,
                                                                          80,
                                                                          1),
                                                                      fontSize:
                                                                          height *
                                                                              0.0175,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: width *
                                                                      0.01,
                                                                  right: width *
                                                                      0.01),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .assessment_id_caps,
                                                                      style:
                                                                          TextStyle(
                                                                        color: const Color.fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontSize:
                                                                            height *
                                                                                0.015,
                                                                        fontFamily:
                                                                            "Inter",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      assessmentIdController
                                                                          .text,
                                                                      style:
                                                                          TextStyle(
                                                                        color: const Color.fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1),
                                                                        fontSize:
                                                                            height *
                                                                                0.015,
                                                                        fontFamily:
                                                                            "Inter",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  assessmentHeaderValues.assessmentStartdate !=
                                                                              0 &&
                                                                          assessmentHeaderValues.assessmentStartdate !=
                                                                              null
                                                                      ? convertDate(
                                                                          assessmentHeaderValues
                                                                              .assessmentStartdate)
                                                                      : " ",
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                            .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontSize:
                                                                        height *
                                                                            0.015,
                                                                    fontFamily:
                                                                        "Inter",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: width * 0.02),
                                                  Column(
                                                    children: [
                                                      Padding(
                                                          //alignment: Alignment.centerLeft,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: height *
                                                                      0.01),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                width: width,
                                                                child: Text(
                                                                  "Is this the assessment you want to take?",
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                            .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontSize:
                                                                        height *
                                                                            0.0195,
                                                                    fontFamily:
                                                                        "Inter",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                      SizedBox(
                                                          height: width * 0.02),
                                                      SizedBox(
                                                        width: width,
                                                        child: Padding(
                                                          //alignment: Alignment.centerLeft,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: height *
                                                                      0.01),
                                                          child: Text(
                                                            "Please note, once you start a test, you",
                                                            style: TextStyle(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  28,
                                                                  78,
                                                                  80,
                                                                  1),
                                                              fontSize: height *
                                                                  0.0195,
                                                              fontFamily:
                                                                  "Inter",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width,
                                                        child: Padding(
                                                          //alignment: Alignment.centerLeft,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: height *
                                                                      0.01),
                                                          child: Text(
                                                            "must complete it.",
                                                            style: TextStyle(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  28,
                                                                  78,
                                                                  80,
                                                                  1),
                                                              fontSize: height *
                                                                  0.0195,
                                                              fontFamily:
                                                                  "Inter",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              height * 0.02),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  _notPressedNo
                                                                      ? const Color
                                                                              .fromRGBO(
                                                                          82,
                                                                          165,
                                                                          160,
                                                                          1)
                                                                      : Colors
                                                                          .white,
                                                              minimumSize:
                                                                  const Size(
                                                                      90, 35),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            39),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                _notPressedNo =
                                                                    true;
                                                                _notPressedYes =
                                                                    false;
                                                                _searchPressed =
                                                                    false;
                                                              });
                                                            },
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .no,
                                                              style: TextStyle(
                                                                  color: _notPressedNo
                                                                      ? Colors
                                                                          .white
                                                                      : const Color
                                                                              .fromRGBO(
                                                                          82,
                                                                          165,
                                                                          160,
                                                                          1),
                                                                  fontSize:
                                                                      height *
                                                                          0.02,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  _notPressedYes
                                                                      ? const Color
                                                                              .fromRGBO(
                                                                          82,
                                                                          165,
                                                                          160,
                                                                          1)
                                                                      : Colors
                                                                          .white,
                                                              minimumSize:
                                                                  const Size(
                                                                      90, 35),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            39),
                                                              ),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              setState(() {
                                                                _notPressedYes =
                                                                    true;
                                                                _notPressedNo =
                                                                    false;
                                                              });
                                                              values = await QnaService
                                                                  .getQuestionGuest(
                                                                      assessmentIdController
                                                                          .text,
                                                                      widget
                                                                          .name);
                                                              if (assessmentIdController
                                                                      .text
                                                                      .length >=
                                                                  8) {

                                                                if (values.code ==
                                                                    200) {


                                                                  if(values.data!.questions!.isEmpty|| values.data?.questions == [] )
                                                                  {
                                                                    Navigator.push(
                                                                      context,
                                                                      PageTransition(
                                                                        type: PageTransitionType
                                                                            .rightToLeft,
                                                                        child:
                                                                        CustomDialog(
                                                                          title: AppLocalizations.of(
                                                                              context)!
                                                                              .alert_popup,
                                                                          content: "No questions available for this assessment",
                                                                          button: AppLocalizations.of(
                                                                              context)!
                                                                              .ok_caps,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  else {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/studQuestion',
                                                                        arguments: [
                                                                          assessmentIdController
                                                                              .text,
                                                                          values,
                                                                          widget.name,
                                                                          null,
                                                                          false,
                                                                          assessmentHeaderValues,
                                                                          ""
                                                                        ]);
                                                                  }

                                                                }
                                                              }

                                                                else {
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .rightToLeft,
                                                                    child:
                                                                        CustomDialog(
                                                                      title: AppLocalizations.of(
                                                                              context)!
                                                                          .alert_popup,
                                                                      content:
                                                                          '${values.message}',
                                                                      button: AppLocalizations.of(
                                                                              context)!
                                                                          .retry,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .yes,
                                                              style: TextStyle(
                                                                  color: _notPressedYes
                                                                      ? Colors
                                                                          .white
                                                                      : const Color
                                                                              .fromRGBO(
                                                                          82,
                                                                          165,
                                                                          160,
                                                                          1),
                                                                  fontSize:
                                                                      height *
                                                                          0.02,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  width * 0.05),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ])),
                                          )
                                        : const SizedBox(),
                                  ]),
                            ),
                          ),
                        ],
                      ))));
        } else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  //extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    toolbarHeight: height * 0.100,
                    iconTheme:
                        IconThemeData(color: Colors.black, size: width * 0.08),
                  ),
                  endDrawer: Drawer(
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.050),
                              Container(
                                alignment: Alignment.topLeft,
                                // height: localHeight / 10,
                                child: Row(children: [
                                  // SizedBox(width: width * 0.015),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.08,
                                      backgroundColor:
                                          const Color.fromRGBO(0, 106, 100, 0),
                                      child: Image.asset(
                                        "assets/images/ProfilePic_Avatar.png",
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.name,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: width * 0.05),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.student,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                153, 153, 153, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: width * 0.04),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: ListView(
                            children: [
                              const Divider(
                                thickness: 2,
                              ),
                              ListTile(
                                  leading: const Icon(Icons.translate,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!.language,
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: width * 0.05),
                                  ),
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
                                  leading: const Icon(
                                      Icons.verified_user_outlined,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .privacy_and_terms,
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: width * 0.05),
                                  ),
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const PrivacyPolicyHamburger(),
                                      ),
                                    );
                                  }),
                              ListTile(
                                  leading: const Icon(Icons.library_books_sharp,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .terms_of_services,
                                    //'Terms of Services',
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: width * 0.05),
                                  ),
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const TermsOfServiceHamburger(),
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
                                        fontSize: width * 0.05),
                                  ),
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
                                  leading: const Icon(
                                      Icons.perm_contact_calendar_outlined,
                                      color: Color.fromRGBO(141, 167, 167, 1)),
                                  title: Text(
                                    AppLocalizations.of(context)!.about_us,
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: width * 0.05),
                                  ),
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
                                        fontSize: width * 0.05),
                                  ),
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
                                  style: TextStyle(
                                      color:
                                          const Color.fromRGBO(226, 68, 0, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * 0.05),
                                ),
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      insetPadding: EdgeInsets.only(
                                          left: width * 0.13,
                                          right: width * 0.13),
                                      title: Row(children: [
                                        SizedBox(width: height * 0.030),
                                        Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                          height: height * 0.1,
                                          width: width * 0.1,
                                          child: const Icon(
                                            Icons.info_outline_rounded,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ),
                                        ),
                                        SizedBox(width: height * 0.015),
                                        Text(
                                          AppLocalizations.of(context)!.confirm,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: height * 0.024,
                                              color: const Color.fromRGBO(
                                                  0, 106, 100, 1),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ]),
                                      content: const Text(
                                          "Are you sure you want to logout ?"),
                                      actions: <Widget>[
                                        SizedBox(width: width * 0.020),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                            minimumSize: const Size(90, 30),
                                            side: const BorderSide(
                                              width: 1.5,
                                              color: Color.fromRGBO(
                                                  82, 165, 160, 1),
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!.no,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: height * 0.018,
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  fontWeight: FontWeight.w500)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        SizedBox(width: width * 0.005),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                              minimumSize: const Size(90, 30),
                                            ),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .yes,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: height * 0.018,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            onPressed: () async {
                                              SharedPreferences preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await preferences.clear();
                                              Navigator.pushNamed(context, '/');
                                            }),
                                        SizedBox(width: height * 0.030),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: height * 0.03),
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
                              SizedBox(height: height * 0.03),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.050,
                              left: height * 0.040,
                              right: height * 0.040),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: width * 0.4),
                                // Container(
                                //   width: width,
                                //   margin: EdgeInsets.only(left: width * 0.1),
                                //child: Column(children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context)!.welcome,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.035),
                                  ),
                                ),
                                // SizedBox(
                                //   height: height * 0.001,
                                // ),
                                SizedBox(
                                  width: width,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.name,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyLarge
                                            ?.merge(TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: height * 0.03)),
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.08,
                                ),
                                //]),
                                // ),
                                // Container(
                                //   //margin: const EdgeInsets.only(left: 10,right: 50),
                                //   padding: const EdgeInsets.only(left: 30, right: 30),
                                //child:
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .enter_assId,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: height * 0.020),
                                          ),
                                        ])),
                                      ),
                                      SizedBox(
                                        height: height * 0.0016,
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: height * 0.045),
                                              child: Form(
                                                  key: formKey,
                                                  autovalidateMode:
                                                      AutovalidateMode.disabled,
                                                  child: SizedBox(
                                                    width: width * 0.9,
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          return value!.length <
                                                                  8
                                                              ? AppLocalizations
                                                                      .of(context)!
                                                                  .valid_assId
                                                              : null;
                                                        },
                                                        controller:
                                                            assessmentIdController,
                                                        onChanged: (val) {
                                                          formKey.currentState!
                                                              .validate();
                                                        },
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  '[a-zA-Z0-9]')),
                                                        ],
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                          labelStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineMedium,
                                                          helperStyle: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: height *
                                                                  0.016),
                                                          hintText:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .assessment_id,
                                                          suffixIcon:
                                                              ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              assessmentvalues =
                                                                  await QnaService.getAssessmentHeader(
                                                                      assessmentIdController
                                                                          .text,
                                                                      userDetails);
                                                              if (assessmentvalues
                                                                          .code ==
                                                                      200 &&
                                                                  assessmentvalues
                                                                              .data[
                                                                          "allow_guest_student"] ==
                                                                      false) {
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .rightToLeft,
                                                                    child:
                                                                        CustomDialog(
                                                                      title: AppLocalizations.of(
                                                                              context)!
                                                                          .alert_popup,
                                                                      content:
                                                                          'Guest Students Not Allowed',
                                                                      button: AppLocalizations.of(
                                                                              context)!
                                                                          .retry,
                                                                    ),
                                                                  ),
                                                                );
                                                              } else if (assessmentvalues
                                                                          .code ==
                                                                      200 &&
                                                                  assessmentvalues
                                                                              .data[
                                                                          "allow_guest_student"] ==
                                                                      true) {
                                                                setState(() {
                                                                  assessmentHeaderValues =
                                                                      GetAssessmentHeaderModel.fromJson(
                                                                          assessmentvalues
                                                                              .data);
                                                                  _searchPressed =
                                                                      true;
                                                                });
                                                              } else if (assessmentvalues
                                                                      .code ==
                                                                  400) {
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .rightToLeft,
                                                                    child:
                                                                        CustomDialog(
                                                                      title: AppLocalizations.of(
                                                                              context)!
                                                                          .alert_popup,
                                                                      content:
                                                                          '${assessmentvalues.message}',
                                                                      button: AppLocalizations.of(
                                                                              context)!
                                                                          .retry,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            child: const Icon(
                                                                Icons
                                                                    .search_outlined,
                                                                color: Colors
                                                                    .white),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              fixedSize:
                                                                  const Size(
                                                                      8, 8),
                                                              side:
                                                                  const BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        82,
                                                                        165,
                                                                        160,
                                                                        1),
                                                              ),
                                                              shape:
                                                                  const CircleBorder(),
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1), // <-- Button color
                                                            ),
                                                          ),
                                                          // prefixIcon:
                                                          // const Icon(
                                                          //     Icons.event_note_outlined,
                                                          //     color: Color.fromRGBO(
                                                          //         82, 165, 160, 1)),
                                                        )),
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ]),
                                SizedBox(
                                  height: width * 0.1,
                                ),
                                _searchPressed
                                    ? Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                            width: width * 0.79,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 0.2)),
                                            ),
                                            child: Column(children: [
                                              Container(
                                                height: height * 0.1087,
                                                width: width * 0.79,
                                                decoration: BoxDecoration(
                                                  //borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                                  border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 0.15),
                                                  ),
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 0.1),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.02,
                                                          right: width * 0.02),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                assessmentHeaderValues
                                                                        .subject ??
                                                                    "",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.0175,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                " | ${assessmentHeaderValues.topic ?? " "}",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.0175,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.02,
                                                          right: width * 0.02),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                assessmentHeaderValues
                                                                        .subTopic ??
                                                                    "",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.0175,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                              Text(
                                                                " | ${assessmentHeaderValues.getAssessmentModelClass}",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.0175,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.02,
                                                          right: width * 0.02),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .assessment_id_caps,
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                            .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontSize:
                                                                        height *
                                                                            0.015,
                                                                    fontFamily:
                                                                        "Inter",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  assessmentIdController
                                                                      .text,
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                            .fromRGBO(
                                                                        82,
                                                                        165,
                                                                        160,
                                                                        1),
                                                                    fontSize:
                                                                        height *
                                                                            0.015,
                                                                    fontFamily:
                                                                        "Inter",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              assessmentHeaderValues
                                                                              .assessmentStartdate !=
                                                                          0 &&
                                                                      assessmentHeaderValues
                                                                              .assessmentStartdate !=
                                                                          null
                                                                  ? convertDate(
                                                                      assessmentHeaderValues
                                                                          .assessmentStartdate)
                                                                  : " ",
                                                              style: TextStyle(
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                    height *
                                                                        0.015,
                                                                fontFamily:
                                                                    "Inter",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: width * 0.05),
                                              Column(
                                                children: [
                                                  Padding(
                                                      //alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          left: height * 0.01),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            width: width,
                                                            child: Text(
                                                              "Is this the assessment you want to take?",
                                                              style: TextStyle(
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                    height *
                                                                        0.0195,
                                                                fontFamily:
                                                                    "Inter",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                      height: width * 0.05),
                                                  SizedBox(
                                                    width: width,
                                                    child: Padding(
                                                      //alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          left: height * 0.01),
                                                      child: Text(
                                                        "Please note, once you start a test, you",
                                                        style: TextStyle(
                                                          color: const Color
                                                                  .fromRGBO(
                                                              28, 78, 80, 1),
                                                          fontSize:
                                                              height * 0.0195,
                                                          fontFamily: "Inter",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width,
                                                    child: Padding(
                                                      //alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          left: height * 0.01),
                                                      child: Text(
                                                        "must complete it.",
                                                        style: TextStyle(
                                                          color: const Color
                                                                  .fromRGBO(
                                                              28, 78, 80, 1),
                                                          fontSize:
                                                              height * 0.0195,
                                                          fontFamily: "Inter",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.03),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              _notPressedNo
                                                                  ? const Color
                                                                          .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1)
                                                                  : Colors
                                                                      .white,
                                                          minimumSize:
                                                              const Size(
                                                                  90, 35),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        39),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            _notPressedNo =
                                                                true;
                                                            _notPressedYes =
                                                                false;
                                                            _searchPressed =
                                                                false;
                                                          });
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .no,
                                                          style: TextStyle(
                                                              color: _notPressedNo
                                                                  ? Colors.white
                                                                  : const Color
                                                                          .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1),
                                                              fontSize:
                                                                  height * 0.02,
                                                              fontFamily:
                                                                  "Inter",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              _notPressedYes
                                                                  ? const Color
                                                                          .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1)
                                                                  : Colors
                                                                      .white,
                                                          minimumSize:
                                                              const Size(
                                                                  90, 35),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        39),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          setState(() {
                                                            _notPressedYes =
                                                                true;
                                                            _notPressedNo =
                                                                false;
                                                          });
                                                          values = await QnaService
                                                              .getQuestionGuest(
                                                                  assessmentIdController
                                                                      .text,
                                                                  widget.name);
                                                          if (assessmentIdController
                                                                  .text
                                                                  .length >=
                                                              8) {
                                                            if (values.code ==
                                                                200) {


                                                              if(values.data!.questions!.isEmpty|| values.data?.questions == [] )
                                                              {
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .rightToLeft,
                                                                    child:
                                                                    CustomDialog(
                                                                      title: AppLocalizations.of(
                                                                          context)!
                                                                          .alert_popup,
                                                                      content: "No questions available for this assessment",
                                                                      button: AppLocalizations.of(
                                                                          context)!
                                                                          .ok_caps,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              else {
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    '/studQuestion',
                                                                    arguments: [
                                                                      assessmentIdController
                                                                          .text,
                                                                      values,
                                                                      widget.name,
                                                                      null,
                                                                      false,
                                                                      assessmentHeaderValues,
                                                                      ""
                                                                    ]);
                                                              }

                                                            }
                                                          }

                                                          else {
                                                            Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType
                                                                    .rightToLeft,
                                                                child:
                                                                    CustomDialog(
                                                                  title: AppLocalizations.of(
                                                                          context)!
                                                                      .alert_popup,
                                                                  content:
                                                                      '${values.message}',
                                                                  button: AppLocalizations.of(
                                                                          context)!
                                                                      .retry,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .yes,
                                                          style: TextStyle(
                                                              color: _notPressedYes
                                                                  ? Colors.white
                                                                  : const Color
                                                                          .fromRGBO(
                                                                      82,
                                                                      165,
                                                                      160,
                                                                      1),
                                                              fontSize:
                                                                  height * 0.02,
                                                              fontFamily:
                                                                  "Inter",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: height * 0.09)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ])),
                                      )
                                    : const SizedBox(),
                              ])))));
        }
      },
    );
  }
}
