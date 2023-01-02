import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/stud_guest_assessment.dart';

import '../Components/custom_incorrect_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TeacherSelectionPage extends StatefulWidget {
  const TeacherSelectionPage({
    Key? key,
    required this.name
  }) : super(key: key);

  final String name;

  @override
  TeacherSelectionPageState createState() => TeacherSelectionPageState();
}

class TeacherSelectionPageState extends State<TeacherSelectionPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height * 0.3625,
                  width: width,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).primaryColor,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(0, 106, 100, 1),
                        Color.fromRGBO(82, 165, 160, 1)
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            width ,
                            height * 0.40)
                    ),
                  ),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children : [
                      SizedBox(height:height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              size: height * 0.035,
                              color: Colors.white,
                            ), onPressed: () {
                            // Navigator.of(context).pop();
                          },
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child:
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          height: height * 0.16,
                          width: width * 0.30,
                          // decoration: BoxDecoration(
                          //     //color: Colors.yellow[100],
                          //     border: Border.all(
                          //       color: Colors.red,
                          //       width: 1,
                          //     )),
                          child: Image.asset("assets/images/question_mark_logo.png"),
                        ),
                      ),
                      Text(
                        'QNA',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.055,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        'TEST',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),

                SizedBox(height:height * 0.03),
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: TextStyle(
                    fontSize: height* 0.037,
                    color: Color.fromRGBO(28, 78, 80, 1),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height:height * 0.015),
                Text(
                  'Subash',
                  style: TextStyle(
                    fontSize: height* 0.04,
                    color: Color.fromRGBO(28, 78, 80, 1),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height:height * 0.037),
                Text(
                  'Create/view/edit',
                  style: TextStyle(
                    fontSize: height* 0.018,
                    color: Color.fromRGBO(209, 209, 209, 1),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                    minimumSize: const Size(280, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(39),
                    ),
                  ),
                  //shape: StadiumBorder(),
                  onPressed: () {

                    // if(agree){
                    //   if(formKey.currentState!.validate()) {
                    //     name = emailController.text;
                    //     Navigator.push(
                    //       context,
                    //       PageTransition(
                    //         type: PageTransitionType.rightToLeft,
                    //         child: StudGuestAssessment(name: name),
                    //       ),
                    //     );
                    //   }
                    // }
                    // else{
                    //   Navigator.push(
                    //     context,
                    //     PageTransition(
                    //       type: PageTransitionType.rightToLeft,
                    //       child: CustomDialog(title: AppLocalizations.of(context)!.agree_privacy_terms, content: AppLocalizations.of(context)!.error, button: AppLocalizations.of(context)!.retry),
                    //     ),
                    //   );
                    // }
                  },
                  child: Text(
                    'Create',
                    style: TextStyle(
                        fontSize: height * 0.032,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(height:height * 0.0375),
                Text(
                  'view results',
                  style: TextStyle(
                    fontSize: height* 0.018,
                    color: Color.fromRGBO(209, 209, 209, 1),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                    minimumSize: const Size(280, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(39),
                    ),
                  ),
                  //shape: StadiumBorder(),
                  onPressed: () {

                    // if(agree){
                    //   if(formKey.currentState!.validate()) {
                    //     name = emailController.text;
                    //     Navigator.push(
                    //       context,
                    //       PageTransition(
                    //         type: PageTransitionType.rightToLeft,
                    //         child: StudGuestAssessment(name: name),
                    //       ),
                    //     );
                    //   }
                    // }
                    // else{
                    //   Navigator.push(
                    //     context,
                    //     PageTransition(
                    //       type: PageTransitionType.rightToLeft,
                    //       child: CustomDialog(title: AppLocalizations.of(context)!.agree_privacy_terms, content: AppLocalizations.of(context)!.error, button: AppLocalizations.of(context)!.retry),
                    //     ),
                    //   );
                    // }
                  },
                  child: Text(
                    'Results',
                    style: TextStyle(
                        fontSize: height * 0.032,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w800),
                  ),
                ),





              ]),
        ));
  }
}


