import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({
    Key? key,

  }) : super(key: key);


  @override
  AboutUsState createState() => AboutUsState();
}

class AboutUsState extends State<AboutUs> {
  bool agree = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<String> str = [
      AppLocalizations.of(context)!.globally_collaborative,
      //"Globally Collaborative",
      AppLocalizations.of(context)!.light_weight,
      //"Light Weight",
      AppLocalizations.of(context)!.anonymous,
      //"Anonymous"
    ];
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
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
                AppLocalizations.of(context)!.about_us_caps,
                // "ABOUT US",
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
                  child: Image.asset("assets/images/aboutUs.png"),
                ),
                SizedBox(height: height * 0.03),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                      constraints.maxWidth > 700
                   ? AppLocalizations.of(context)!.about_us_description_web
                          : AppLocalizations.of(context)!.about_us_description,
                    // "ITNEducation Inc., builds range of IT in\nEducation products and services that help\nmillions of students / learners  and\nteachers / instructors to learn digitally and\nfreely. QNATest is an Intelligent Learning\nEvaluation, Assessment & Advisor\nplatform, which is:",
                    style: TextStyle(
                        fontSize: height * 0.018,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontFamily: "Inter"),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Padding(
                  padding: EdgeInsets.only(left:
                  constraints.maxWidth > 700
                  ? height * 0.9
                          : height * 0.065
                  ),
                  child: Column(
                    children: str.map((list) {
                      return Row(children: [
                        Text(
                          "\u2022",
                          style: TextStyle(
                              fontSize: height * 0.018,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: "Inter"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            list,
                            style: TextStyle(
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: "Inter"),
                          ), //text
                        )
                      ]);
                    }).toList(),
                  ),
                )
              ],
            )),
      ),
    );
  }
    );}}
