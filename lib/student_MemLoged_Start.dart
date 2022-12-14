import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class StudentMemberLoginPage extends StatefulWidget {
  const StudentMemberLoginPage({super.key});


  @override
  StudentMemberLoginPageState createState() => StudentMemberLoginPageState();
}
class StudentMemberLoginPageState extends State<StudentMemberLoginPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;
    const iconAsset = "assets/images/question_mark_logo.png";
    return Scaffold(
        body:
        SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child:
        Column(
            children: [
              Container(
                //height: localHeight * 0.43,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(0, 106, 100, 1),
                        Color.fromRGBO(82, 165, 160, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            localWidth,
                            localHeight * 0.35)
                    ),
                  ),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children : [
                    const SizedBox(height:50.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon:const Icon(
                          Icons.chevron_left,
                          size: 40.0,
                          color: Color.fromRGBO(255, 255, 255, 0.8)
                        ), onPressed: () {
                        Navigator.of(context).pop();
                      },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child:
                      Container(
                        padding: const EdgeInsets.all(0.0),
                        height: localHeight * 0.20,
                        width: localWidth * 0.30,
                        // decoration:  const BoxDecoration(
                        //   image: DecorationImage(
                        //     fit: BoxFit.fill,
                        //     image: AssetImage(iconAsset),
                        //   ),
                        // ),
                        child: Image.asset("assets/images/question_mark_logo.png"),
                        // decoration: BoxDecoration(
                        //     //color: Colors.yellow[100],
                        //     border: Border.all(
                        //       color: Colors.red,
                        //       width: 1,
                        //     )),
                        // child: Image.asset("assets/images\question_mark_logo.png"),
                      ),
                    ),
                    const SizedBox(height: 25.0),

                  ],
                ),
              ),
              Container(
                width: 149,
                margin: const EdgeInsets.all(15),
                child: Column(
                    children: [
                      Align(alignment: Alignment.center,
                        child:
                        Text("STUDENT MEMBER",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(const TextStyle(
                              color: Color.fromRGBO(28, 78, 80, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
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
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        Text("REGISTRATION ID OR EMAIL ID",
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
                        children: const [
                          Align(alignment: Alignment.center,
                            child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    helperStyle: TextStyle(color: Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 16),
                                      hintText: "Your Reg ID / Email ID",
                                    prefixIcon: Icon(
                                       Icons.contacts_outlined,color: Color.fromRGBO(82, 165, 160, 1)),
                                  )
                              )
                            ),
                        ],
                      ),
                    ]),

              ),
              SizedBox(
                height: localHeight * 0.02,
              ),
              Container(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        Text("PASSWORD",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(const TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),),

                      ),
                      Column(
                        children: const [
                          Align(alignment: Alignment.center,
                                child: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        helperStyle: TextStyle(color: Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 16),
                                        hintText: "Your Password",
                                        prefixIcon: Icon(
                                            Icons.lock_outline_rounded,color: Color.fromRGBO(82, 165, 160, 1)),
                                    )
                                )
                            ),
                        ],
                      ),

                    ]),

              ),
              SizedBox(
                height: localHeight * 0.02,
              ),
              Container(
                // margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.only(
                      left: 230),
                  child:  Row(
                    children:  [
                      Text("Forget password?",
                          style: Theme.of(context).primaryTextTheme.bodyText1
                              ?.merge(const TextStyle(
                              color: Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14))),
                    ],
                  )
              ),
              SizedBox(
                height: localHeight * 0.02,
              ),
              Column(
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
                        child: Text('Login',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
              SizedBox(
                height: localHeight * 0.02,
              ),
              Container(
                // margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.only(
                      left: 130),
                  child:  Row(
                    children:  [
                      IconButton(
                        icon: const Icon(
                          Icons.edit_note_sharp,
                          color: Color.fromRGBO(141, 167, 167, 1),
                        ), onPressed: () {
                      },
                      ),
                      Text("Register",
                          style: Theme.of(context).primaryTextTheme.bodyText1
                              ?.merge(const TextStyle(
                              color: Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 18))),
                    ],
                  )
              ),
              SizedBox(
                height: localHeight * 0.03,
              ),
            ])));

  }
}