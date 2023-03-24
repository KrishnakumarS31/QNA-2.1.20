import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfServiceHamburger extends StatefulWidget {
  const TermsOfServiceHamburger({
    Key? key,
    required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

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
    return WillPopScope(
        onWillPop: () async => false,
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
                    "TERMS OF SERVICE",
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
                      child: GestureDetector(
                        onTap: _launchUrl,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(
                                  color: const Color.fromRGBO(0, 107, 232, 1),
                                  fontFamily: 'Inter',
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w400,
                                  fontSize: height * 0.018)),
                          TextSpan(
                              text:
                                  " \t\tdefines ITNEDCUATION \nrelationship with you as you interact with \nQNATEST app services",
                              style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: height * 0.018)),
                        ])),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('Https://www.ITNEDUCATION.com/privacypolicy');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
