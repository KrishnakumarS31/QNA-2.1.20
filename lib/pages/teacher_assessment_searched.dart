import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Components/today_date.dart';
import '../Entity/Teacher/get_assessment_model.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Entity/user_details.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Providers/create_assessment_provider.dart';
import '../Providers/edit_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Entity/Teacher/question_entity.dart' as questions;
import '../Services/qna_service.dart';

class TeacherAssessmentSearched extends StatefulWidget {
  TeacherAssessmentSearched(
      {Key? key, required this.search})
      : super(key: key);

  String search;

  @override
  TeacherAssessmentSearchedState createState() =>
      TeacherAssessmentSearchedState();
}

class TeacherAssessmentSearchedState extends State<TeacherAssessmentSearched> {
  bool agree = false;
  List<GetAssessmentModel> assessments = [];
  List<GetAssessmentModel> allAssessment = [];
  bool loading = true;
  ScrollController scrollController = ScrollController();
  int pageLimit = 1;
  String searchValue = '';
  TextEditingController teacherQuestionBankSearchController =
  TextEditingController();
  bool assessmentPresent= false;
  UserDetails userDetails=UserDetails();

  @override
  void initState() {
    teacherQuestionBankSearchController.text = widget.search;
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    initialData();
    super.initState();
  }

  initialData() async {
    //Provider.of<QuestionPrepareProviderFinal>(context, listen: false).reSetQuestionList();
    ResponseEntity response =
    await QnaService.getSearchAssessment(5, pageLimit, widget.search,userDetails);
    if(response.data != null){
      allAssessment = List<GetAssessmentModel>.from(
          response.data.map((x) => GetAssessmentModel.fromJson(x)));
    }
    setState(() {
      allAssessment.isEmpty?assessmentPresent=false:assessmentPresent=true;
      searchValue = widget.search;
      assessments.addAll(allAssessment);
      loading = false;
      pageLimit++;
    });
  }

  getData(String searchVal) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(48, 145, 139, 1),
              ));
        });
    pageLimit = 1;

    ResponseEntity response =
    await QnaService.getSearchAssessment(5, pageLimit, searchVal,userDetails);
    if(response.data==null){
      Navigator.of(context).pop();
      // Navigator.push(
      //   context,
      //   PageTransition(
      //     type: PageTransitionType.rightToLeft,
      //     child: CustomDialog(
      //       title: 'Alert',
      //       content: 'No Assessment Found.',
      //       button: AppLocalizations.of(context)!.retry,
      //     ),
      //   ),
      // );
      setState(() {
        assessmentPresent=false;
      });
    }
    else{
      allAssessment = List<GetAssessmentModel>.from(
          response.data.map((x) => GetAssessmentModel.fromJson(x)));
      Navigator.of(context).pop();
      setState(() {
        assessmentPresent=true;
        searchValue = searchVal;
        assessments.addAll(allAssessment);
        loading = false;
        pageLimit++;
      });
    }
  }

  loadMore(String searchValue) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(48, 145, 139, 1),
              ));
        });
    ResponseEntity response =
    await QnaService.getSearchAssessment(5, pageLimit, searchValue,userDetails);
    allAssessment = List<GetAssessmentModel>.from(
        response.data.map((x) => GetAssessmentModel.fromJson(x)));
    Navigator.of(context).pop();
    setState(() {
      assessments.addAll(allAssessment);
      loading = false;
      pageLimit++;
    });
    if(allAssessment.isEmpty) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: CustomDialog(
            title:
            AppLocalizations.of(context)!.alert_popup,
            //'Alert',
            content:
            AppLocalizations.of(context)!.alert_popup,
            //'No more assessment are found.',
            button: AppLocalizations.of(context)!.retry,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // if(constraints.maxWidth > 900)
        // {
        //   print("INSIDE WEB");
        //   print(constraints.maxWidth);
        //   return WillPopScope(
        //       onWillPop: () async => false,
        //       child: Scaffold(
        //         resizeToAvoidBottomInset: true,
        //         backgroundColor: Colors.white,
        //         endDrawer: const EndDrawerMenuTeacher(),
        //         appBar: AppBar(
        //           leading: IconButton(
        //             icon: const Icon(
        //               Icons.chevron_left,
        //               size: 40.0,
        //               color: Colors.white,
        //             ),
        //             onPressed: () {
        //               Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));
        //
        //               //Navigator.of(context).pop();
        //             },
        //           ),
        //           toolbarHeight: height * 0.100,
        //           centerTitle: true,
        //           title: Column(
        //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //               children: [
        //                 Text(
        //                   AppLocalizations.of(context)!.assessment_caps,
        //                   // "ASSESSMENTS",
        //                   style: TextStyle(
        //                     color: const Color.fromRGBO(255, 255, 255, 1),
        //                     fontSize: height * 0.0225,
        //                     fontFamily: "Inter",
        //                     fontWeight: FontWeight.w400,
        //                   ),
        //                 ),
        //                 Text(
        //                   AppLocalizations.of(context)!.search_results_caps,
        //                   //"SEARCH RESULTS",
        //                   style: TextStyle(
        //                     color: const Color.fromRGBO(255, 255, 255, 1),
        //                     fontSize: height * 0.0225,
        //                     fontFamily: "Inter",
        //                     fontWeight: FontWeight.w400,
        //                   ),
        //                 ),
        //               ]),
        //           flexibleSpace: Container(
        //             decoration: const BoxDecoration(
        //                 gradient: LinearGradient(
        //                     end: Alignment.bottomCenter,
        //                     begin: Alignment.topCenter,
        //                     colors: [
        //                       Color.fromRGBO(0, 106, 100, 1),
        //                       Color.fromRGBO(82, 165, 160, 1),
        //                     ])),
        //           ),
        //         ),
        //         body: SingleChildScrollView(
        //           scrollDirection: Axis.vertical,
        //           child: Padding(
        //               padding: EdgeInsets.only(
        //                   top: height * 0.023,
        //                   left: height * 0.023,
        //                   right: height * 0.023),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     AppLocalizations.of(context)!.search,
        //                     //"Search",
        //                     style: TextStyle(
        //                       color: const Color.fromRGBO(82, 165, 160, 1),
        //                       fontSize: height * 0.02,
        //                       fontFamily: "Inter",
        //                       fontWeight: FontWeight.w700,
        //                     ),
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text(
        //                         AppLocalizations.of(context)!.lib_of_assessments,
        //                         //"Library of Assessments",
        //                         style: TextStyle(
        //                           color: const Color.fromRGBO(153, 153, 153, 1),
        //                           fontSize: height * 0.015,
        //                           fontFamily: "Inter",
        //                           fontWeight: FontWeight.w400,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   SizedBox(height: height * 0.02),
        //                   TextField(
        //                     controller: teacherQuestionBankSearchController,
        //                     keyboardType: TextInputType.text,
        //                     decoration: InputDecoration(
        //                       floatingLabelBehavior: FloatingLabelBehavior.always,
        //                       hintStyle: TextStyle(
        //                           color: const Color.fromRGBO(102, 102, 102, 0.3),
        //                           fontFamily: 'Inter',
        //                           fontWeight: FontWeight.w400,
        //                           fontSize: height * 0.016),
        //                       hintText:  AppLocalizations.of(context)!.sub_hint_text,
        //                       //"Maths, 10th, 2022, CBSE, Science",
        //                       suffixIcon: Column(children: [
        //                         Container(
        //                             height: height * 0.073,
        //                             width: width * 0.13,
        //                             decoration: const BoxDecoration(
        //                               borderRadius:
        //                               BorderRadius.all(Radius.circular(8.0)),
        //                               color: Color.fromRGBO(82, 165, 160, 1),
        //                             ),
        //                             child: IconButton(
        //                               iconSize: height * 0.04,
        //                               color: const Color.fromRGBO(255, 255, 255, 1),
        //                               onPressed: () {
        //                                 setState(() {
        //                                   assessments = [];
        //                                 });
        //                                 getData(
        //                                     teacherQuestionBankSearchController.text);
        //                               },
        //                               icon: const Icon(Icons.search),
        //                             )),
        //                       ]),
        //                       focusedBorder: OutlineInputBorder(
        //                           borderSide: const BorderSide(
        //                               color: Color.fromRGBO(82, 165, 160, 1)),
        //                           borderRadius: BorderRadius.circular(15)),
        //                       border: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(15)),
        //                     ),
        //                     enabled: true,
        //                     onChanged: (val) {
        //                       setState(() {
        //                         assessments = [];
        //                       });
        //                     },
        //                     onSubmitted: (value) {
        //                       setState(() {
        //                         assessments = [];
        //                       });
        //                       getData(value);
        //                     },
        //                   ),
        //                   SizedBox(height: height * 0.04),
        //                   Text(
        //                     AppLocalizations.of(context)!.search_results_small,
        //                     //"Search Results",
        //                     style: TextStyle(
        //                       color: const Color.fromRGBO(82, 165, 160, 1),
        //                       fontSize: height * 0.02,
        //                       fontFamily: "Inter",
        //                       fontWeight: FontWeight.w700,
        //                     ),
        //                   ),
        //                   Text(
        //                     AppLocalizations.of(context)!.tap_to_see,
        //                     //"Tap to See Details/Clone",
        //                     style: TextStyle(
        //                       color: const Color.fromRGBO(153, 153, 153, 1),
        //                       fontSize: height * 0.015,
        //                       fontFamily: "Inter",
        //                       fontWeight: FontWeight.w400,
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: height * 0.02,
        //                   ),
        //                   assessmentPresent?
        //                   SizedBox(
        //                     height: height * 0.45,
        //                     child: ListView.builder(
        //                       itemCount: assessments.length,
        //                       itemBuilder: (context, index) => Column(
        //                         children: [
        //                           CardInfo(
        //                             height: height,
        //                             width: width,
        //                             status: 'Active',
        //                             assessment: assessments[index],
        //                           ),
        //                           SizedBox(
        //                             height: height * 0.02,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ):
        //                   Column(
        //                     children: [
        //                       SizedBox(height: height * 0.04),
        //                       Center(
        //                         child: Text(
        //                           AppLocalizations.of(context)!.no_assessment_found_caps,
        //                           //'NO ASSESSMENT FOUND',
        //                           textAlign: TextAlign.center,
        //                           style: TextStyle(
        //                             color: const Color.fromRGBO(28, 78, 80, 1),
        //                             fontSize: height * 0.0175,
        //                             fontFamily: "Inter",
        //                             fontWeight: FontWeight.w700,
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     height: height * 0.02,
        //                   ),
        //                   MouseRegion(
        //                       cursor: SystemMouseCursors.click,
        //                       child: GestureDetector(
        //                         onTap: () {
        //                           assessments.isEmpty?Navigator.push(
        //                             context,
        //                             PageTransition(
        //                               type: PageTransitionType.rightToLeft,
        //                               child: CustomDialog(
        //                                 title:
        //                                 AppLocalizations.of(context)!.alert_popup,
        //                                 //'Alert',
        //                                 content: AppLocalizations.of(context)!.no_more_assessment,
        //                                 //'No Assessment Found.',
        //                                 button: AppLocalizations.of(context)!.retry,
        //                               ),
        //                             ),
        //                           ):
        //                           loadMore(teacherQuestionBankSearchController.text);
        //                         },
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             Text(
        //                               AppLocalizations.of(context)!.load_more,
        //                               // "Load More",
        //                               style: TextStyle(
        //                                 color: const Color.fromRGBO(82, 165, 160, 1),
        //                                 fontSize: height * 0.0175,
        //                                 fontFamily: "Inter",
        //                                 fontWeight: FontWeight.w600,
        //                               ),
        //                             ),
        //                             const Icon(
        //                               Icons.expand_more_outlined,
        //                               color: Color.fromRGBO(82, 165, 160, 1),
        //                             )
        //                           ],
        //                         ),
        //                       )),
        //                   SizedBox(
        //                     height: height * 0.02,
        //                   ),
        //                 ],
        //               )),
        //         ),
        //       ));
        // }
        if(constraints.maxWidth > 500)
        {
          print("INSIDE TABLET");
          print(constraints.maxWidth);
          return Center(
            child: WillPopScope(
                onWillPop: () async => false,
                child: Container(
                  width: 400.0,
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.white,
                    endDrawer: const EndDrawerMenuTeacher(),
                    appBar: AppBar(
                      leading: IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 40.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));

                          //Navigator.of(context).pop();
                        },
                      ),
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.assessment_caps,
                              // "ASSESSMENTS",
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontSize: height * 0.0225,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.search_results_caps,
                              //"SEARCH RESULTS",
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
                              Text(
                                AppLocalizations.of(context)!.search,
                                //"Search",
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.02,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.lib_of_assessments,
                                    //"Library of Assessments",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(153, 153, 153, 1),
                                      fontSize: height * 0.015,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.02),
                              TextField(
                                controller: teacherQuestionBankSearchController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  hintStyle: TextStyle(
                                      color: const Color.fromRGBO(102, 102, 102, 0.3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * 0.016),
                                  hintText:  AppLocalizations.of(context)!.sub_hint_text,
                                  //"Maths, 10th, 2022, CBSE, Science",
                                  suffixIcon: Column(children: [
                                    Container(
                                        height: height * 0.073,
                                        width: width * 0.13,
                                        decoration: const BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(8.0)),
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                        ),
                                        child: IconButton(
                                          iconSize: height * 0.04,
                                          color: const Color.fromRGBO(255, 255, 255, 1),
                                          onPressed: () {
                                            setState(() {
                                              assessments = [];
                                            });
                                            getData(
                                                teacherQuestionBankSearchController.text);
                                          },
                                          icon: const Icon(Icons.search),
                                        )),
                                  ]),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(82, 165, 160, 1)),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                enabled: true,
                                onChanged: (val) {
                                  setState(() {
                                    assessments = [];
                                  });
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    assessments = [];
                                  });
                                  getData(value);
                                },
                              ),
                              SizedBox(height: height * 0.04),
                              Text(
                                AppLocalizations.of(context)!.search_results_small,
                                //"Search Results",
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.02,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.tap_to_see,
                                //"Tap to See Details/Clone",
                                style: TextStyle(
                                  color: const Color.fromRGBO(153, 153, 153, 1),
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              assessmentPresent?
                              SizedBox(
                                height: height * 0.45,
                                child: ListView.builder(
                                  itemCount: assessments.length,
                                  itemBuilder: (context, index) => Column(
                                    children: [
                                      CardInfo(
                                        height: height,
                                        width: width,
                                        status: 'Active',
                                        assessment: assessments[index],
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                    ],
                                  ),
                                ),
                              ):
                              Column(
                                children: [
                                  SizedBox(height: height * 0.04),
                                  Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.no_assessment_found_caps,
                                      //'NO ASSESSMENT FOUND',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontSize: height * 0.0175,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      assessments.isEmpty?Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title:
                                            AppLocalizations.of(context)!.alert_popup,
                                            //'Alert',
                                            content: AppLocalizations.of(context)!.no_more_assessment,
                                            //'No Assessment Found.',
                                            button: AppLocalizations.of(context)!.retry,
                                          ),
                                        ),
                                      ):
                                      loadMore(teacherQuestionBankSearchController.text);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.load_more,
                                          // "Load More",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0175,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.expand_more_outlined,
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                        )
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: height * 0.02,
                              ),
                            ],
                          )),
                    ),
                  ),
                )),
          );
        }
        else {
          print("INSIDE MOBILE");
          print(constraints.maxWidth);
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                endDrawer: const EndDrawerMenuTeacher(),
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 40.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/teacherAssessmentLanding', ModalRoute.withName('/teacherSelectionPage'));

                      //Navigator.of(context).pop();
                    },
                  ),
                  toolbarHeight: height * 0.100,
                  centerTitle: true,
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.assessment_caps,
                          // "ASSESSMENTS",
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: height * 0.0225,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.search_results_caps,
                          //"SEARCH RESULTS",
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
                          Text(
                            AppLocalizations.of(context)!.search,
                            //"Search",
                            style: TextStyle(
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.lib_of_assessments,
                                //"Library of Assessments",
                                style: TextStyle(
                                  color: const Color.fromRGBO(153, 153, 153, 1),
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.02),
                          TextField(
                            controller: teacherQuestionBankSearchController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintStyle: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 0.3),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: height * 0.016),
                              hintText:  AppLocalizations.of(context)!.sub_hint_text,
                              //"Maths, 10th, 2022, CBSE, Science",
                              suffixIcon: Column(children: [
                                Container(
                                    height: height * 0.073,
                                    width: width * 0.13,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                      color: Color.fromRGBO(82, 165, 160, 1),
                                    ),
                                    child: IconButton(
                                      iconSize: height * 0.04,
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      onPressed: () {
                                        setState(() {
                                          assessments = [];
                                        });
                                        getData(
                                            teacherQuestionBankSearchController.text);
                                      },
                                      icon: const Icon(Icons.search),
                                    )),
                              ]),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(15)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            enabled: true,
                            onChanged: (val) {
                              setState(() {
                                assessments = [];
                              });
                            },
                            onSubmitted: (value) {
                              setState(() {
                                assessments = [];
                              });
                              getData(value);
                            },
                          ),
                          SizedBox(height: height * 0.04),
                          Text(
                            AppLocalizations.of(context)!.search_results_small,
                            //"Search Results",
                            style: TextStyle(
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.tap_to_see,
                            //"Tap to See Details/Clone",
                            style: TextStyle(
                              color: const Color.fromRGBO(153, 153, 153, 1),
                              fontSize: height * 0.015,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          assessmentPresent?
                          SizedBox(
                            height: height * 0.45,
                            child: ListView.builder(
                              itemCount: assessments.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  CardInfo(
                                    height: height,
                                    width: width,
                                    status: 'Active',
                                    assessment: assessments[index],
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ):
                          Column(
                            children: [
                              SizedBox(height: height * 0.04),
                              Center(
                                child: Text(
                                  AppLocalizations.of(context)!.no_assessment_found_caps,
                                  //'NO ASSESSMENT FOUND',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontSize: height * 0.0175,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  assessments.isEmpty?Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: CustomDialog(
                                        title:
                                        AppLocalizations.of(context)!.alert_popup,
                                        //'Alert',
                                        content: AppLocalizations.of(context)!.no_more_assessment,
                                        //'No Assessment Found.',
                                        button: AppLocalizations.of(context)!.retry,
                                      ),
                                    ),
                                  ):
                                  loadMore(teacherQuestionBankSearchController.text);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.load_more,
                                      // "Load More",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontSize: height * 0.0175,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.expand_more_outlined,
                                      color: Color.fromRGBO(82, 165, 160, 1),
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: height * 0.02,
                          ),
                        ],
                      )),
                ),
              ));
        }
      },);

  }
}

class CardInfo extends StatelessWidget {
  const CardInfo(
      {Key? key,
        required this.height,
        required this.width,
        required this.status,

        required this.assessment})
      : super(key: key);

  final double height;
  final double width;
  final String status;
  final GetAssessmentModel assessment;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              Provider.of<QuestionPrepareProviderFinal>(
                  context,
                  listen: false).reSetQuestionList();
              Provider.of<EditAssessmentProvider>(context, listen: false)
                  .updateAssessment(assessment);

              SharedPreferences loginData = await SharedPreferences.getInstance();
              CreateAssessmentModel editAssessment = CreateAssessmentModel(
                  questions: [], removeQuestions: [], addQuestion: []);
              editAssessment.userId = loginData.getInt('userId');
              editAssessment.subject = assessment.subject;
              editAssessment.assessmentType =
                  assessment.assessmentType ?? 'Not Mentioned';
              editAssessment.createAssessmentModelClass =
                  assessment.getAssessmentModelClass;
              assessment.topic == null
                  ? 0
                  : editAssessment.topic = assessment.topic;
              assessment.subTopic == null
                  ? 0
                  : editAssessment.subTopic = assessment.subTopic;
              assessment.totalScore == null
                  ? 0
                  : editAssessment.totalScore = assessment.totalScore;
              assessment.questions!.isEmpty
                  ? 0
                  : editAssessment.totalQuestions = assessment.questions!.length;
              assessment.assessmentDuration == null
                  ? ''
                  : editAssessment.totalScore = assessment.totalScore;
              if (assessment.questions!.isEmpty) {
              } else {
                for (int i = 0; i < assessment.questions!.length; i++) {
                  questions.Question question = questions.Question();
                  question = assessment.questions![i];
                  editAssessment.addQuestion?.add(question);
                  Provider.of<QuestionPrepareProviderFinal>(context,
                      listen: false)
                      .addQuestion(assessment.questions![i]);
                }
              }

              Provider.of<CreateAssessmentProvider>(context, listen: false)
                  .updateAssessment(editAssessment);
              Navigator.pushNamed(
                  context,
                  '/teacherActiveAssessment',
                  arguments: [assessment,'GlobalAssessment']
              );
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.rightToLeft,
              //     child: TeacherActiveAssessment(
              //       assessment: assessment,
              //     ),
              //   ),
              // );

            },
            child: Container(
              height: height * 0.1087,
              width: width * 0.888,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(
                  color: const Color.fromRGBO(82, 165, 160, 0.15),
                ),
                color: const Color.fromRGBO(82, 165, 160, 0.1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              assessment.subject!,
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.0175,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " | ${assessment.topic}",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.0175,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.circle_rounded,
                          color: assessment.assessmentStatus == 'inprogress'
                              ? const Color.fromRGBO(255, 166, 0, 1)
                              : assessment.assessmentType == 'practice'
                              ? const Color.fromRGBO(42, 36, 186, 1)
                              : assessment.assessmentStatus == 'active' && assessment.assessmentType == 'test'
                              ? const Color.fromRGBO(60, 176, 0, 1)
                              : assessment.assessmentStatus == 'inactive' && assessment.assessmentType == 'test'
                              ? const Color.fromRGBO(136, 136, 136, 1)
                              : const Color.fromRGBO(136, 136, 136, 1),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              assessment.subTopic!,
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.0175,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              " | ${assessment.getAssessmentModelClass}",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.0175,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(AppLocalizations.of(context)!.assessment_id_caps,
                                style: TextStyle(
                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text("${assessment.assessmentCode}",
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],),
                          Text(
                            assessment.assessmentStartdate != null ? convertDate(assessment.assessmentStartdate) : " ",
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.015,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ]),),
                ],
              ),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding:
              //       EdgeInsets.only(left: width * 0.02, right: width * 0.02),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Row(
              //             children: [
              //               Text(
              //                 assessment.subject!,
              //                 style: TextStyle(
              //                   color: const Color.fromRGBO(28, 78, 80, 1),
              //                   fontSize: height * 0.0175,
              //                   fontFamily: "Inter",
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //               ),
              //               Text(
              //                 " | ${assessment.getAssessmentModelClass}",
              //                 style: TextStyle(
              //                   color: const Color.fromRGBO(28, 78, 80, 1),
              //                   fontSize: height * 0.0175,
              //                   fontFamily: "Inter",
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Icon(
              //             Icons.circle_rounded,
              //             color: assessment.assessmentStatus == 'inprogress'
              //                 ? const Color.fromRGBO(255, 166, 0, 1)
              //                 : assessment.assessmentStatus == 'active'
              //                 ? const Color.fromRGBO(60, 176, 0, 1)
              //                 : const Color.fromRGBO(136, 136, 136, 1),
              //           )
              //         ],
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.only(left: width * 0.02),
              //       child: Row(
              //         children: [
              //           // Text(
              //           //   AppLocalizations.of(context)!.assessment_id_caps,
              //           //   //"Assessment ID: ",
              //           //   style: TextStyle(
              //           //     color: const Color.fromRGBO(102, 102, 102, 1),
              //           //     fontSize: height * 0.015,
              //           //     fontFamily: "Inter",
              //           //     fontWeight: FontWeight.w400,
              //           //   ),
              //           // ),
              //           Text(
              //             " ${assessment.assessmentCode}",
              //             style: TextStyle(
              //               color: const Color.fromRGBO(82, 165, 160, 1),
              //               fontSize: height * 0.015,
              //               fontFamily: "Inter",
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Padding(
              //       padding:
              //       EdgeInsets.only(left: width * 0.02, right: width * 0.02),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           // Row(
              //           //   children: [
              //           //     Text(
              //           //       AppLocalizations.of(context)!.institute_test_id,
              //           //       // "Institute Test ID: ",
              //           //       style: TextStyle(
              //           //         color: const Color.fromRGBO(102, 102, 102, 1),
              //           //         fontSize: height * 0.015,
              //           //         fontFamily: "Inter",
              //           //         fontWeight: FontWeight.w400,
              //           //       ),
              //           //     ),
              //           //     Text(
              //           //       " ----------",
              //           //       style: TextStyle(
              //           //         color: const Color.fromRGBO(82, 165, 160, 1),
              //           //         fontSize: height * 0.015,
              //           //         fontFamily: "Inter",
              //           //         fontWeight: FontWeight.w500,
              //           //       ),
              //           //     ),
              //           //   ],
              //           // ),
              //           Text(
              //             assessment.assessmentStartdate != null ? convertDate(assessment.assessmentStartdate) : " ",
              //             style: TextStyle(
              //               color: const Color.fromRGBO(28, 78, 80, 1),
              //               fontSize: height * 0.015,
              //               fontFamily: "Inter",
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ),
          )),
    );
  }
}
