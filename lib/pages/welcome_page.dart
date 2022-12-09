import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_project/pages/student_member_login_page.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    var localHeight = MediaQuery.of(context).size.height;
    var localWidth = MediaQuery.of(context).size.width;
    const iconAsset = "assets/images/welcome.png";
    return Scaffold(
        body:
        SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          height: localHeight,
          width: localWidth,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            children: [
             Center(
               child:
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(iconAsset),
                  ),
                ),
              ),
              ),
              Container(
                  width: 149,
                  margin: const EdgeInsets.all(15),
                  // padding: const EdgeInsets.only(
                  //     left: 106,
                  //     top: 320),
                  child: Column(
                      children: [
                        Align(alignment: Alignment.center,
                        child:
                        Text("WELCOME",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(const TextStyle(
                              color: Color.fromRGBO(28, 78, 80, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.02,
                              fontSize: 30)),),
                          ),
                        SizedBox(
                          height: localHeight * 0.03,
                        ),
                      ]),

      ),
              Container(
                //margin: const EdgeInsets.only(left: 10,right: 50),
                padding: const EdgeInsets.only(
                    left: 65),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Align(
                        alignment: Alignment.topLeft,
                        child:
                        Text("LEARNER/APPLICANT",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(const TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),),

                      ),
                      SizedBox(
                        height: localHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Align(alignment: Alignment.center,
                          child: Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: const Size(280, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              //shape: StadiumBorder(),
                              child: Text('Student',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 24),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const StudentMemberLoginPage(),
                                  ),
                                );},
                            ),
                          ),
                          )
                        ],
                      ),
                    ]),

              ),
              SizedBox(
                height: localHeight * 0.06,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 65),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        Text("INSTRUCTOR/EXAMINER",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(const TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),),

                      ),
                      SizedBox(
                        height: localHeight * 0.02,
                      ),
                      Column(
                        children: [
                          Align(alignment: Alignment.topLeft,
                            child: Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                  minimumSize: const Size(280, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39),
                                  ),
                                ),
                                //shape: StadiumBorder(),
                                child: Text('Teacher',
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 24),
                                ),
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("Alert"),
                                      content: const Text("You are navigating to teachers page"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("okay"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                height: localHeight * 0.05,
              ),
              Container(
                // margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.only(
                    left: 100),
                child:  Row(
                  children:  [
                    IconButton(
                        icon: const Icon(
                          Icons.g_translate_sharp,
                          color: Color.fromRGBO(141, 167, 167, 1),
                        ), onPressed: () {
                    },
                    ),
                    Text("Select Language",
                      style: Theme.of(context).primaryTextTheme.bodyText1
                          ?.merge(const TextStyle(
                          color: Color.fromRGBO(48, 145, 139, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 16))),
                  ],
                )
                // ListTile(
                //   // leading: SvgPicture.asset(
                //   //   iconAsset,
                //   //   height: MediaQuery.of(context).size.height * 0.03,
                //   //   color: Colors.black,
                //   // ),
                //   leading:
                //   const Icon(Icons.g_translate_sharp,color: Color.fromRGBO(141, 167, 167, 1)),
                //   title: Text("Select Language",
                //       style: GoogleFonts.inter(
                //           color: const Color.fromRGBO(48, 145, 139, 1),
                //           fontSize: MediaQuery.of(context).size.height * 0.018)),
                // ),

                // Column(
                //     children: [
                //       Align(alignment: Alignment.center,
                //         child:
                //         Text("Select Language",
                //           style: Theme.of(context)
                //               .primaryTextTheme
                //               .bodyText1
                //               ?.merge(const TextStyle(
                //               color: Color.fromRGBO(48, 145, 139, 1),
                //               fontFamily: 'Inter',
                //               fontWeight: FontWeight.w500,
                //               fontSize: 16)),),
                //       ),
                //       SizedBox(
                //         height: localHeight * 0.03,
                //       ),
                //     ]),

              ),
              SizedBox(
                height:localHeight * 0.05,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                    children: [
                      Align(alignment: Alignment.center,
                        child:
                        Text("Version 2.0.59",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(const TextStyle(
                              color: Color.fromRGBO(180, 180, 180, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14)),),
                      ),
                      SizedBox(
                        height: localHeight * 0.03,
                      ),
                    ]),

              ),
            ],
          ),
        ),
      ]),
    )
    );}
}