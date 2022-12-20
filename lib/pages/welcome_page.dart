import 'package:flutter/material.dart';
import 'student_selection_page.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;
    double localWidth = MediaQuery.of(context).size.width;
    const iconAsset = "assets/images/welcome.png";
    print(localWidth);
    print("localWidth");
    return Scaffold(
        body:
        // SingleChildScrollView(
        //   physics: const ClampingScrollPhysics(),
         // child: Row(
         //      mainAxisAlignment: MainAxisAlignment.center,
         //      children: [
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
                      //Container(
                        //width: localWidth * 0.149,
                        //margin: EdgeInsets.all(localWidth * 0.15),
                        // padding: const EdgeInsets.only(
                        //     left: 106,
                        //     top: 320),
                        // child: Column(
                        //     children: [
                        //       Align(alignment: Alignment.center,
                        //         child:
                      SizedBox(
                        height: localHeight * 0.06,
                      ),
                                Text("WELCOME",
                                  style:  TextStyle(
                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: localHeight * 0.030)),
                             // ),
                              SizedBox(
                                height: localHeight * 0.03,
                              ),
                           // ]),

      //),
              // Container(
              //   //margin: const EdgeInsets.only(left: 10,right: 50),
              //   padding:  const EdgeInsets.only(left: 70, right: 70),
              //   alignment: Alignment.center,
              //   child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //          Align(
              //           alignment: Alignment.topLeft,
              //           child:
              //           Text("LEARNER/APPLICANT",
              //             style: Theme.of(context)
              //                 .primaryTextTheme
              //                 .bodyText1
              //                 ?.merge(const TextStyle(
              //                 color: Color.fromRGBO(102, 102, 102, 1),
              //                 fontFamily: 'Inter',
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 14)),),
              //
              //         ),
              //         SizedBox(
              //           height: localHeight * 0.02,
              //         ),
              //         Column(
              //           children: [
              //             Align(alignment: Alignment.center,
              //             child: Expanded(
              //               child: ElevatedButton(
              //                 style: ElevatedButton.styleFrom(
              //                   backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
              //                   minimumSize: const Size(280, 48),
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(39),
              //                   ),
              //                 ),
              //                 //shape: StadiumBorder(),
              //                 child: const Text('Student',
              //                     style: TextStyle(
              //                         fontFamily: 'Inter',
              //                         fontSize: 24,
              //                         color: Colors.white
              //                     )),
              //                 onPressed: () async {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                       builder: (context) => const StudentSelectionPage(),
              //                     ),
              //                   );},
              //               ),
              //             ),
              //             )
              //           ],
              //         ),
              //       ]),
              //
              // ),
                      Container(
                        padding:   EdgeInsets.only(left:localWidth/15,right:localWidth/15),
                        child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:EdgeInsets.only(left: localWidth/15,right:localWidth/15),
                            child:  Align(
                                alignment: Alignment.centerLeft,
                                child:
                                Text("LEARNER/APPLICANT",
                                  style:  TextStyle(
                                      color: const Color.fromRGBO(102, 102, 102, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: localHeight * 0.014)),

                              ),
                              ),
                              SizedBox(
                                height: localHeight * 0.02,
                              ),
                                  Container(
                                    padding: EdgeInsets.only(left: localWidth/15,right: localWidth/15),
                                  child:Align(alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                          minimumSize: const Size(280, 48),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(39),
                                          ),
                                        ),
                                        //shape: StadiumBorder(),
                                        child:  Text('Student',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: localHeight * 0.024,
                                                color: Colors.white
                                            )),
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const StudentSelectionPage(),
                                            ),
                                          );},
                                      ),
    ),
                                  )]),
                      ),
              SizedBox(
                height: localHeight * 0.07,
              ),
                      Container(
                        padding:   EdgeInsets.only(left:localWidth/15,right:localWidth/15),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:EdgeInsets.only(left: localWidth/15,right:localWidth/15),
                                child:  Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                  Text("INSTRUCTOR/EXAMINER",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        ?.merge( TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: localHeight * 0.014))),

                                ),
                              ),
                              SizedBox(
                                height: localHeight * 0.02,
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: localWidth/15,right: localWidth/15),
                                  child:Align(alignment: Alignment.center,
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
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: localHeight * 0.024,
                                                color: Colors.white
                                            )),
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
                                                    padding: EdgeInsets.all(localHeight * 0.014),
                                                    child: const Text("okay"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                  )
                              ),
                            ]),
                      ),
              SizedBox(
                height: localHeight * 0.05,
              ),
              MaterialButton(
                // margin: const EdgeInsets.all(15),
                //   padding:  const EdgeInsets.only(left: 40, right: 40),
                onPressed: () {  },
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    IconButton(
                        icon: const Icon(
                          Icons.translate,
                          color: Color.fromRGBO(141, 167, 167, 1),
                        ), onPressed: () {
                    },
                    ),
                    Text("Select Language",
                      style: TextStyle(
                          color: const Color.fromRGBO(48, 145, 139, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: localHeight * 0.016),
    )],
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
            ],
          ),
        ),
      //]),
    );
  }
}