import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TermsOfServiceHamburger extends StatefulWidget {
  const TermsOfServiceHamburger({
    Key? key,

  }) : super(key: key);


  @override
  TermsOfServiceHamburgerState createState() => TermsOfServiceHamburgerState();
}

class TermsOfServiceHamburgerState extends State<TermsOfServiceHamburger> {
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
          if (constraints.maxWidth > 500) {
            return Center(
                child: SizedBox(
                width: 500,
                child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40.0,
                    color: Colors.white,
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
                        AppLocalizations.of(context)!.terms_caps,
                        //"TERMS OF SERVICE",
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
                          child:
                          Image.asset("assets/images/termsOfServicesImage.png"),
                        ),
                        SizedBox(height: height * 0.05),
                        Center(
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .terms_of_services,
                                    //"Terms of Service",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _launchUrl,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            0, 107, 232, 1),
                                        fontFamily: 'Inter',
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.018)),
                                TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .terms_page_web,
                                    //" \t\t defines ITNEDCUATION relationship with you as you interact with QNATEST app services"
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.018)),
                              ])),
                        ),
                      ],
                    )),
              ),
            )));
          }
          else{
            return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40.0,
                    color: Colors.white,
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
                        AppLocalizations.of(context)!.terms_caps,
                        //"TERMS OF SERVICE",
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
                          child:
                          Image.asset("assets/images/termsOfServicesImage.png"),
                        ),
                        SizedBox(height: height * 0.05),
                        Center(
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .terms_of_services,
                                    //"Terms of Service",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _launchUrl,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            0, 107, 232, 1),
                                        fontFamily: 'Inter',
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.018)),
                                TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .terms_page,
                                    //" \t\t defines ITNEDCUATION \n relationship with you as you interact with \nQNATEST app services",
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.018)),
                              ])),
                        ),
                      ],
                    )),
              ),
            );
          }
          });
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://www.itneducation.com/termsofservice');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
