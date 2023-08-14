import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher/result/teacher_result_landing_page.dart';
import '../Entity/user_details.dart';
import '../EntityModel/user_data_model.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Providers/question_prepare_provider_final.dart';
import '../Components/end_drawer_menu_teacher.dart';

class TeacherSelectionPage extends StatefulWidget {
  const TeacherSelectionPage(
      {Key? key,
      required this.userData,
     })
      : super(key: key);

  final UserDataModel userData;

  @override
  TeacherSelectionPageState createState() => TeacherSelectionPageState();
}

class TeacherSelectionPageState extends State<TeacherSelectionPage> {
  UserDataModel userDataModel = UserDataModel(code: 0, message: '');
  UserDetails userdata= UserDetails();
  int userId=0;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    userdata=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    setState(() {
      userId=userdata.userId!;
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      iconTheme: IconThemeData(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          size: height * 0.05
                      ),
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                    ),
                    endDrawer: const EndDrawerMenuTeacher(),
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child:
                      Container(
                        padding:EdgeInsets.only(left: height * 0.1,right: height * 0.1),
                        child:
                        Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: height * 0.06,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.userData.data!.organisationName,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                  ),
                                ),
                                SizedBox(height: height * 0.1),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      SizedBox(width: width * 0.1),
                                      Text(
                                        AppLocalizations.of(context)!.welcome,
                                        style: TextStyle(
                                          fontSize: height * 0.035,
                                          color: const Color.fromRGBO(82, 165, 160, 1),
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ]),
                                SizedBox(height: height * 0.015),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      SizedBox(width: width * 0.1),
                                      Text(
                                        widget.userData.data!.firstName.toString(),
                                        style: TextStyle(
                                          fontSize: height * 0.04,
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                                SizedBox(height: height * 0.14),
                                ElevatedButton(
                                  style:
                                  ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(
                                        width: 1, // the thickness
                                        color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                    ),
                                    minimumSize:const Size(181, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          39),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Provider.of<QuestionPrepareProviderFinal>(context,
                                        listen: false)
                                        .reSetQuestionList();
                                    Navigator.pushNamed(context, '/teacherQuestionBank');
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.qn_bank,
                                      //'Questions',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight
                                              .w500,
                                          fontSize:
                                          height *
                                              0.03,
                                          color: const Color.fromRGBO(82, 165, 160, 1))
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                ElevatedButton(
                                  style:
                                  ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(
                                        width: 1, // the thickness
                                        color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                    ),
                                    minimumSize:const Size(181, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          39),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/assessmentLandingPage');

                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.assessment_button,
                                      //'Assessments',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight
                                              .w500,
                                          fontSize:
                                          height *
                                              0.03,
                                          color: const Color.fromRGBO(82, 165, 160, 1))
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                ElevatedButton(
                                  style:
                                  ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(
                                        width: 1, // the thickness
                                        color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                    ),
                                    minimumSize:const Size(181, 58),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          39),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: TeacherResultLanding(
                                            userId: userId),
                                      ),
                                    );
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.results_button,
                                      //'Results',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight
                                              .w500,
                                          fontSize:
                                          height *
                                              0.03,
                                          color: const Color.fromRGBO(82, 165, 160, 1))
                                  ),
                                ),
                              ])),
                    ))));
          }
          else if(constraints.maxWidth > 960) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      iconTheme: IconThemeData(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          size: height * 0.05
                      ),
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                    ),
                    endDrawer: const EndDrawerMenuTeacher(),
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child:
                      Container(
                          padding:EdgeInsets.only(left: height * 0.5,right: height * 0.5),
                          child:
                          Center(
          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: height * 0.1,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.userData.data!.organisationName,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.1,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      SizedBox(width: width * 0.1),
                                      Text(
                                        AppLocalizations.of(context)!.welcome,
                                        style: TextStyle(
                                          fontSize: height * 0.035,
                                          color: const Color.fromRGBO(82, 165, 160, 1),
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ]),
                                SizedBox(height: height * 0.015),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      SizedBox(width: width * 0.1),
                                      Text(
                                        widget.userData.data!.firstName.toString(),
                                        style: TextStyle(
                                          fontSize: height * 0.04,
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                                SizedBox(height: height * 0.16),
                                ElevatedButton(
                                  style:
                                  ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(
                                        width: 1, // the thickness
                                        color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                    ),
                                    minimumSize:const Size(181, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          39),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Provider.of<QuestionPrepareProviderFinal>(context,
                                        listen: false)
                                        .reSetQuestionList();
                                    Navigator.pushNamed(context, '/teacherQuestionBank');
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.qn_bank,
                                      //'Questions',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight
                                              .w500,
                                          fontSize:
                                          height *
                                              0.03,
                                          color: const Color.fromRGBO(82, 165, 160, 1))
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                ElevatedButton(
                                  style:
                                  ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(
                                        width: 1, // the thickness
                                        color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                    ),
                                    minimumSize:const Size(181, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          39),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/assessmentLandingPage');

                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.assessment_button,
                                      //'Assessments',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight
                                              .w500,
                                          fontSize:
                                          height *
                                              0.03,
                                          color: const Color.fromRGBO(82, 165, 160, 1))
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                ElevatedButton(
                                  style:
                                  ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(
                                        width: 1, // the thickness
                                        color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                                    ),
                                    minimumSize:const Size(181, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          39),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: TeacherResultLanding(
                                            userId: userId),
                                      ),
                                    );
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.results_button,
                                      //'Results',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight
                                              .w500,
                                          fontSize:
                                          height *
                                              0.03,
                                          color: const Color.fromRGBO(82, 165, 160, 1))
                                  ),
                                ),
                              ])),
                    ))));
          }
      else{
      return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                iconTheme: IconThemeData(
                    color: const Color.fromRGBO(28, 78, 80, 1),
                    size: height * 0.05
                ),
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
              ),
              endDrawer: const EndDrawerMenuTeacher(),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child:
                Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.06,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.userData.data!.organisationName,
                          style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: height * 0.02),
                        ),
                      ),
                      SizedBox(height: height * 0.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          SizedBox(width: width * 0.1),
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: TextStyle(
                          fontSize: height * 0.035,
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),
                      )
                          ]),
                      SizedBox(height: height * 0.015),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            SizedBox(width: width * 0.1),
                            Text(
                              widget.userData.data!.firstName.toString(),
                              style: TextStyle(
                                fontSize: height * 0.04,
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      SizedBox(height: height * 0.16),
                      ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                              width: 1, // the thickness
                              color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                          ),
                          minimumSize:const Size(181, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                39),
                          ),
                        ),
                        onPressed: () async {
                          Provider.of<QuestionPrepareProviderFinal>(context,
                              listen: false)
                              .reSetQuestionList();
                          Navigator.pushNamed(context, '/teacherQuestionBank');
                        },
                        child: Text(
                          AppLocalizations.of(context)!.qn_bank,
                          //'Questions',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight
                                    .w500,
                                fontSize:
                                height *
                                    0.03,
                                color: const Color.fromRGBO(82, 165, 160, 1))
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                              width: 1, // the thickness
                              color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                          ),
                          minimumSize:const Size(181, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                39),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/assessmentLandingPage');

                        },
                        child: Text(
                          AppLocalizations.of(context)!.assessment_button,
                          //'Assessments',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight
                                    .w500,
                                fontSize:
                                height *
                                    0.03,
                                color: const Color.fromRGBO(82, 165, 160, 1))
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                              width: 1, // the thickness
                              color: Color.fromRGBO(82, 165, 160, 1) // the color of the border
                          ),
                          minimumSize:const Size(181, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                39),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: TeacherResultLanding(
                                  userId: userId),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.results_button,
                          //'Results',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight
                                    .w500,
                                fontSize:
                                height *
                                    0.03,
                                color: const Color.fromRGBO(82, 165, 160, 1))
                        ),
                      ),
                    ])),
              )));
        }});
  }
}
