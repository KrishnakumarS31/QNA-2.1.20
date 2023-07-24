import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class PrivacyPolicyHamburger extends StatefulWidget {
  const PrivacyPolicyHamburger({
    Key? key,

  }) : super(key: key);


  @override
  PrivacyPolicyHamburgerState createState() => PrivacyPolicyHamburgerState();
}

class PrivacyPolicyHamburgerState extends State<PrivacyPolicyHamburger> {
  bool agree = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(constraints.maxWidth <= 960 && constraints.maxWidth >=500){
            return Scaffold(
              resizeToAvoidBottomInset: true,
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
                toolbarHeight: height * 0.100,
                centerTitle: true,
                title: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.privacy_policy_caps,
                        //"PRIVACY POLICY",
                        style: TextStyle(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontSize: height * 0.0225,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white
                  ),
                ),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.023,
                        left: height * 0.023,
                        right: height * 0.023),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.01),
                        Center(
                          child: Image.asset("assets/images/privacyImage.png"),
                        ),
                        SizedBox(height: height * 0.03),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            AppLocalizations.of(context)!.privacy_text,
                            //"ITNEducation Inc., builds range of IT in Education products and services that help millions of students / learners  and \n teachers / instructors to learn digitally and freely."
                            style: TextStyle(
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(153, 153, 153, 1),
                                fontFamily: "Inter"),
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        Align(
                         alignment: Alignment.topCenter,
                          child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _launchUrl,
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .read_qna,
                                          //"Read QNATest\t\t",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.018)),
                                      TextSpan(
                                          text:
                                          AppLocalizations.of(context)!
                                              .privacy_Policy,
                                          //"Privacy Policy",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = _launchUrl,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  0, 107, 232, 1),
                                              fontFamily: 'Inter',
                                              decoration: TextDecoration
                                                  .underline,
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.018)),
                                    ])),
                              )),
                        ),
                      ],
                    )),
              ),
            );
          }
          else if(constraints.maxWidth > 960) {
            return Scaffold(
                      resizeToAvoidBottomInset: true,
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
                        toolbarHeight: height * 0.100,
                        centerTitle: true,
                        title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.privacy_policy_caps,
                                //"PRIVACY POLICY",
                                style: TextStyle(
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontSize: height * 0.025,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ]),
                        flexibleSpace: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white
                          ),
                        ),
                      ),
                      body: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.01),
                                Center(
                                  child: Image.asset("assets/images/privacyImage.png"),
                                ),
                                SizedBox(height: height * 0.03),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    AppLocalizations.of(context)!.privacy_text,
                                    //"ITNEducation Inc., builds range of IT in Education products and services that help millions of students / learners  and \n teachers / instructors to learn digitally and freely."
                                    style: TextStyle(
                                        fontSize: height * 0.018,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromRGBO(153, 153, 153, 1),
                                        fontFamily: "Inter"),
                                  ),
                                ),
                                SizedBox(height: height * 0.05),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: _launchUrl,
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: AppLocalizations.of(context)!
                                                      .read_qna,
                                                  //"Read QNATest\t\t",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.018)),
                                              TextSpan(
                                                  text:
                                                  AppLocalizations.of(context)!
                                                      .privacy_Policy,
                                                  //"Privacy Policy",
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = _launchUrl,
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          0, 107, 232, 1),
                                                      fontFamily: 'Inter',
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.018)),
                                            ])),
                                      )),
                                ),
                              ],
                            )),
                      ),
                    );
          }
        else {
            return Scaffold(
              resizeToAvoidBottomInset: true,
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
                toolbarHeight: height * 0.100,
                centerTitle: true,
                title: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.privacy_policy_caps,
                        //"PRIVACY POLICY",
                        style: TextStyle(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontSize: height * 0.0225,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white
                  ),
                ),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.023,
                        left: height * 0.023,
                        right: height * 0.023),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.01),
                        Center(
                          child: Image.asset("assets/images/privacyImage.png"),
                        ),
                        SizedBox(height: height * 0.03),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(AppLocalizations.of(context)!.privacy_text,
                            //"ITNEducation Inc., builds range of IT in\nEducation products and services that help \n millions of students / learners  and \n teachers / instructors to learn digitally and freely.",
                            style: TextStyle(
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(153, 153, 153, 1),
                                fontFamily: "Inter"),
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        Align(
                          alignment: Alignment.topCenter,
                          child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _launchUrl,
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .read_qna,
                                          //"Read QNATest\t\t",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.018)),
                                      TextSpan(
                                          text:
                                          AppLocalizations.of(context)!
                                              .privacy_Policy,
                                          //"Privacy Policy",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = _launchUrl,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  0, 107, 232, 1),
                                              fontFamily: 'Inter',
                                              decoration: TextDecoration
                                                  .underline,
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.018)),
                                    ])),
                              )),
                        ),
                      ],
                    )),
              ),
            );
          }
        });
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://www.itneducation.com/privacypolicy');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
