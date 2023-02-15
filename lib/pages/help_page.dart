import 'package:flutter/material.dart';

class HelpPageHamburger extends StatefulWidget {
  const HelpPageHamburger({
    Key? key,
    required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

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
        title:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "HELP",
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
                  child: Image.asset("assets/images/help.png"),
                ),
                SizedBox(height: height * 0.03),
                Padding(
                  padding: EdgeInsets.only(left: height * 0.03),
                  child: Text(
                    "How can we help you ?",
                    style: TextStyle(
                        fontSize: height * 0.018,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontFamily: "Inter"),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: height * 0.03),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Please first check out the\t\t",
                        style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: height * 0.018)),
                    TextSpan(
                        text: "FAQs",
                        style: TextStyle(
                            color: const Color.fromRGBO(0, 107, 232, 1),
                            fontFamily: 'Inter',
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                            fontSize: height * 0.018)),
                  ])),
                ),
                SizedBox(height: height * 0.04),
                Padding(
                  padding: EdgeInsets.only(left: height * 0.03),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            "If you are unable to find answers to your\nqueries related to the QNATest App,please\nfeel free to\t\t",
                        style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: height * 0.018)),
                    TextSpan(
                        text: "email",
                        style: TextStyle(
                            color: const Color.fromRGBO(0, 107, 232, 1),
                            fontFamily: 'Inter',
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                            fontSize: height * 0.018)),
                  ])),
                ),
              ],
            )),
      ),
    );
  }
}
