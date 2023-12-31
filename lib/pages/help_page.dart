import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:url_launcher/url_launcher.dart';
class HelpPageHamburger extends StatefulWidget {
  const HelpPageHamburger({
    Key? key,

  }) : super(key: key);


  @override
  HelpPageHamburgerState createState() => HelpPageHamburgerState();
}

class HelpPageHamburgerState extends State<HelpPageHamburger> {
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
                    color: const Color.fromRGBO(28, 78, 80, 1),
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
                        AppLocalizations.of(context)!.help,
                        //"HELP",
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
                          child: Image.asset("assets/images/help.png"),
                        ),
                        SizedBox(height: height * 0.03),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.can_help,
                            //"How can we help you ?",
                            style: TextStyle(
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: "Inter"),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Center(
                          child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _launchUrl,
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .find_answers_web,
                                          style: TextStyle(
                                              color:
                                              const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.018)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .email_help,
                                          //"email",
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
                        )
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
                    color: const Color.fromRGBO(28, 78, 80, 1),
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
                        AppLocalizations.of(context)!.help,
                        //"HELP",
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
                          child: Image.asset("assets/images/help.png"),
                        ),
                        SizedBox(height: height * 0.03),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.can_help,
                            //"How can we help you ?",
                            style: TextStyle(
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: "Inter"),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Center(
                          child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _launchUrl,
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .find_answers,
                                          // "If you are unable to find answers to your\n queries related to the QNATest App,please\n feel free to\t\t",
                                          style: TextStyle(
                                              color:
                                              const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.018)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .email_help,
                                          //"email",
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
                        )
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
                    color: const Color.fromRGBO(28, 78, 80, 1),
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
                        AppLocalizations.of(context)!.help,
                        //"HELP",
                        style: TextStyle(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontSize: height * 0.023,
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
                          child: Image.asset("assets/images/help.png"),
                        ),
                        SizedBox(height: height * 0.03),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.can_help,
                            //"How can we help you ?",
                            style: TextStyle(
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: "Inter"),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Center(
                          child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _launchUrl,
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .find_answers,
                                          // "If you are unable to find answers to your\n queries related to the QNATest App,please\n feel free to\t\t",
                                          style: TextStyle(
                                              color:
                                              const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.018)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .email_help,
                                          //"email",
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
                        )
                      ],
                    )),
              ),
            );
          }
          });
  }

  Future<void> _launchUrl() async {
    String email = Uri.encodeComponent("help@itneducation.com");
    String subject = Uri.encodeComponent("Need Help");
    String body = Uri.encodeComponent("Hi Team!");
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
    } else {}
  }
}
