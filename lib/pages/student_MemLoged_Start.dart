
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'Student_Quest_ReviseAns.dart';
import 'hamBurger_menu.dart';




class StudentMemLogedStart extends StatefulWidget {
  const StudentMemLogedStart({
    Key? key,
    required this.regNumber
  }) : super(key: key);
  final String regNumber;

  @override
  StudentMemLogedStartState createState() => StudentMemLogedStartState();
}
class StudentMemLogedStartState extends State<StudentMemLogedStart> {
  TextEditingController assessmentID = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;
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
                          Icons.menu_outlined,
                          size: 40.0,
                          color: Color.fromRGBO(255, 255, 255, 0.8)
                        ), onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const HamBurgerMenu();
                          }),
                        );
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
                      const Align(alignment: Alignment.center,
                        child:
                        Text("WELCOME",
                          style: TextStyle(
                              color: Color.fromRGBO(28, 78, 80, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.02,
                              fontSize: 24),),
                      ),
                      SizedBox(
                        height: localHeight * 0.02,
                      ),
                Text("StudentName  ",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyText1
                      ?.merge(const TextStyle(
                      color: Color.fromRGBO(28, 78, 80, 1),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.02,
                      fontSize: 24)),),
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
                      const Align(
                        alignment: Alignment.topLeft,
                        child:
                        Text("ENTER TEST ASSESSMENT ID",
                          style: TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),),

                      ),
                      SizedBox(
                        height: localHeight * 0.02,
                      ),
                      Column(
                        children:  [
                          Align(alignment: Alignment.center,
                            child: TextFormField(
                              controller: assessmentID,
                                keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    helperStyle: TextStyle(color: Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 16),
                                      hintText: "Assessment ID",
                                    prefixIcon: Icon(
                                       Icons.event_note_outlined,color: Color.fromRGBO(82, 165, 160, 1)),
                                  )
                              )
                            ),
                        ],
                      ),
                    ]),

              ),
              SizedBox(
                height: localHeight * 0.08,
              ),
              Column(
                children: [
                  Align(alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                          minimumSize: const Size(280, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(39),
                          ),
                        ),
                        //shape: StadiumBorder(),
                        child: const Text('Start',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                          )
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: StudReviseQuest(),
                            ),
                          );
                        }
                        ),
                  )
                ],
              ),
              SizedBox(
                height: localHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Color.fromRGBO(141, 167, 167, 1),
                    ),
                    onPressed: () {},
                  ),
                  const Text("Search Library",
                      style: TextStyle(
                          color: Color.fromRGBO(48, 145, 139, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                ],
              ),
              SizedBox(
                height: localHeight * 0.03,
              ),
            ])));

  }
}