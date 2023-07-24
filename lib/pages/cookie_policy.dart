import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class CookiePolicy extends StatefulWidget {
  const CookiePolicy({
    Key? key,

  }) : super(key: key);


  @override
  CookiePolicyState createState() => CookiePolicyState();
}

class CookiePolicyState extends State<CookiePolicy> {
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
                    AppLocalizations.of(context)!.cookie_policy_caps,
                    //"COOKIE POLICY",
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
                      child: Image.asset("assets/images/cookiePolicyImage.png"),
                    ),
                    SizedBox(height: height * 0.03),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppLocalizations.of(context)!.not_use_cookies,
//                    "QNATest App does not use Cookies.",
                        style: TextStyle(
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: "Inter"),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(AppLocalizations.of(context)!
                            .cookie_policy_description_web,
                        //"QNATest apps will not request cookies to\nbe set on your device. We do not use\n cookies, when you visit QNATEST web\n site or deploy the app.  There are no\n settings related to cookie preferences.",
                        style: TextStyle(
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: "Inter"),
                      ),
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
                        AppLocalizations.of(context)!.cookie_policy_caps,
                        //"COOKIE POLICY",
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
                          child: Image.asset("assets/images/cookiePolicyImage.png"),
                        ),
                        SizedBox(height: height * 0.03),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            AppLocalizations.of(context)!.not_use_cookies,
//                    "QNATest App does not use Cookies.",
                            style: TextStyle(
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: "Inter"),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(AppLocalizations.of(context)!
                              .cookie_policy_description,
                            //"QNATest apps will not request cookies to\nbe set on your device. We do not use\n cookies, when you visit QNATEST web\n site or deploy the app.  There are no\n settings related to cookie preferences.",
                            style: TextStyle(
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: "Inter"),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          }
      else
      {
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
                    AppLocalizations.of(context)!.cookie_policy_caps,
                    //"COOKIE POLICY",
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
                      child: Image.asset("assets/images/cookiePolicyImage.png"),
                    ),
                    SizedBox(height: height * 0.03),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppLocalizations.of(context)!.not_use_cookies,
//                    "QNATest App does not use Cookies.",
                        style: TextStyle(
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: "Inter"),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(AppLocalizations.of(context)!
                            .cookie_policy_description,
                        //"QNATest apps will not request cookies to\nbe set on your device. We do not use\n cookies, when you visit QNATEST web\n site or deploy the app.  There are no\n settings related to cookie preferences.",
                        style: TextStyle(
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: "Inter"),
                      ),
                    ),
                  ],
                )),
          ),
        );
      }
  }
    );}}
