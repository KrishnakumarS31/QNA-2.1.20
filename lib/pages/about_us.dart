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
    double width = MediaQuery.of(context).size.width;
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
                color: Colors.black,
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
                      color: Colors.black,
                      fontSize: height * 0.0225,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
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
                      child: Image.asset("assets/images/aboutUs.png"),
                    ),
                    SizedBox(height: height * 0.03),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(AppLocalizations.of(context)!
                          .about_us_description,
                        style: TextStyle(
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: "Inter"),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.2),
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
                    color: Colors.black,
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
                          color: Colors.black,
                          fontSize: height * 0.0225,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
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
                          child: Image.asset("assets/images/aboutUs.png"),
                        ),
                        SizedBox(height: height * 0.03),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(AppLocalizations.of(context)!
                              .about_us_description,
                            // "ITNEducation Inc., builds range of IT in\nEducation products and services that help\n millions of students / learners  and\n teachers / instructors to learn digitally and\n freely. QNATest is an Intelligent Learning\nEvaluation, Assessment & Advisor\n platform, which is:",
                            style: TextStyle(
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: "Inter"),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.4
                          ),
                          child: Column(
                            children: str.map((list) {
                              return Row(
                                  children: [
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
      else{
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
                color: Colors.black,
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
                      color: Colors.black,
                      fontSize: height * 0.0225,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
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
                      child: Image.asset("assets/images/aboutUs.png"),
                    ),
                    SizedBox(height: height * 0.03),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(AppLocalizations.of(context)!
                            .about_us_description,
                        // "ITNEducation Inc., builds range of IT in\nEducation products and services that help\n millions of students / learners  and\n teachers / instructors to learn digitally and\n freely. QNATest is an Intelligent Learning\nEvaluation, Assessment & Advisor\n platform, which is:",
                        style: TextStyle(
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: "Inter"),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Padding(
                      padding: EdgeInsets.only(left: height * 0.065
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
  }
    );}}
