import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_result_assessment.dart';
import '../Components/custom_card.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Entity/user_details.dart';
import '../EntityModel/get_result_model.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class TeacherResultLanding extends StatefulWidget {
  const TeacherResultLanding({
    Key? key,
    required this.userId,
    this.advisorName,
  }) : super(key: key);
  final int? userId;
  final String? advisorName;

  @override
  TeacherResultLandingState createState() => TeacherResultLandingState();
}

class TeacherResultLandingState extends State<TeacherResultLanding> {
  bool loading = true;
  ScrollController scrollController = ScrollController();
  int pageLimit = 1;
  GetResultModel getResultModel = GetResultModel(guestStudentAllowed: false);
  List<GetResultModel> results = [];
  List<GetResultModel> allResults = [];
  late List<AssessmentResults> inProgressResults;
  late List<AssessmentResults> submittedResults;
  late GetResultModel inProgress;
  late GetResultModel submitted;
  UserDetails userDetails=UserDetails();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((_) {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
          ),
          context: context,
          builder: (builder) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: MediaQuery.of(context).copyWith().size.height * 0.245,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).copyWith().size.width * 0.10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height:
                      MediaQuery.of(context).copyWith().size.height * 0.026,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).copyWith().size.width *
                              0.055),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            size: MediaQuery.of(context).copyWith().size.height * 0.05,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: const Color.fromRGBO(66, 194, 0, 1),
                          size: MediaQuery.of(context).copyWith().size.height *
                              0.02,
                        ),
                        Text(
                          AppLocalizations.of(context)!.completed_tests,
                          //"      Completed Tests",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                              color: const Color.fromRGBO(51, 51, 51, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context)
                                  .copyWith()
                                  .size
                                  .height *
                                  0.016)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.052,
                        ),
                      ],
                    ),
                    SizedBox(
                      height:
                      MediaQuery.of(context).copyWith().size.height * 0.026,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: const Color.fromRGBO(255, 157, 77, 1),
                          size: MediaQuery.of(context).copyWith().size.height *
                              0.02,
                        ),
                        Text(
                          AppLocalizations.of(context)!.inprogress_results,
                          //"      In Progress Tests",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                              color: const Color.fromRGBO(51, 51, 51, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context)
                                  .copyWith()
                                  .size
                                  .height *
                                  0.016)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.052,
                        ),
                      ],
                    ),
                    SizedBox(
                      height:
                      MediaQuery.of(context).copyWith().size.height * 0.026,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: const Color.fromRGBO(179, 179, 179, 1),
                          size: MediaQuery.of(context).copyWith().size.height *
                              0.02,
                        ),
                        Text(
                          AppLocalizations.of(context)!.not_started_tests,
                          //"      Not Started Tests",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                              color: const Color.fromRGBO(51, 51, 51, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context)
                                  .copyWith()
                                  .size
                                  .height *
                                  0.016)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.052,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    getData();
  }

  Future<int> getData() async {
    ResponseEntity response =
    await QnaService.getResultDataService(widget.userId, 5, pageLimit,userDetails);
    //widget.userId
    if(response.code == 200) {
      allResults = List<GetResultModel>.from(
          response.data.map((x) => GetResultModel.fromJson(x)));
      setState(() {
        results.addAll(allResults);
        loading = false;
        pageLimit++;
      });
    }
    else{
      return 400;
    }
    return response.code!;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 500) {
    return
      Center(
    child: SizedBox(
          width: 400,
      child: WillPopScope(
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
                  Navigator.of(context).pop();
                },
              ),
              toolbarHeight: height * 0.100,
              centerTitle: true,
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.results_caps,
                      //'RESULTS',
                      style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.my_assessments,
                      //"MY ASSESSMENTS",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.01,
                      ),
                      SizedBox(
                        height: height * 0.7,
                        child:
                        results.isEmpty
                            ? Column(
                              children: [
                                SizedBox(height: height * 0.3,),
                                Center(
                                  child: Text(
                          AppLocalizations.of(context)!.no_results_found,
                          //'NO RESULTS FOUND',
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
                            )
                            : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: results.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      inProgressResults = results[index].assessmentResults!.where((o) => o.attemptType == "InProgress").toList();
                                      submittedResults = results[index].assessmentResults!.where((o) => o.attemptType == "Completed").toList();
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: TeacherResultAssessment(
                                              inProgressResults: inProgressResults,
                                              submittedResults: submittedResults,
                                              result: results[index],
                                              userId: widget.userId,
                                              advisorName: widget.advisorName),
                                        ),
                                      );
                                    },
                                    child: CustomCard(
                                        height: height,
                                        width: width,
                                        //subject: results[index].subject,
                                        result: results[index]
                                    ),
                                  )),
                              SizedBox(
                                height: height * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: height * 0.03,
                      ),
                      results.isEmpty?
                      Align(
                        alignment: Alignment.center,
                        child:
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                                AppLocalizations.of(context)!.view_more,
                                //'View More',
                                style: TextStyle(
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontSize: height * 0.0187,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600)),
                            Icon(Icons.keyboard_arrow_down,
                              color: const Color.fromRGBO(141, 167, 167, 1),
                              size: height * 0.034,),
                          ],
                        ),
                      )
                          :Align(
                        alignment: Alignment.center,
                        child:
                        MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () async {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                              color: Color.fromRGBO(48, 145, 139, 1),
                                            ));
                                      });
                                  int res= await getData();
                                  if(res == 200){
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!.view_more,
                                      //'View More',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                            fontSize: height * 0.0187,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600)),
                                    Icon(Icons.keyboard_arrow_down,
                                      color: const Color.fromRGBO(141, 167, 167, 1),
                                      size: height * 0.034,),
                                  ],
                                )
                            )),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ]),
              ),
            )))));
  }
  else {
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
                      Navigator.of(context).pop();
                    },
                  ),
                  toolbarHeight: height * 0.100,
                  centerTitle: true,
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.results_caps,
                          //'RESULTS',
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.my_assessments,
                          //"MY ASSESSMENTS",
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SizedBox(
                            height: height * 0.7,
                            child:
                            results.isEmpty
                                ? Column(
                              children: [
                                SizedBox(height: height * 0.3,),
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.no_results_found,
                                    //'NO RESULTS FOUND',
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
                            )
                                : ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: results.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          inProgressResults = results[index].assessmentResults!.where((o) => o.attemptType == "InProgress").toList();
                                          submittedResults = results[index].assessmentResults!.where((o) => o.attemptType == "Completed").toList();
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: TeacherResultAssessment(
                                                  inProgressResults: inProgressResults,
                                                  submittedResults: submittedResults,
                                                  result: results[index],
                                                  userId: widget.userId,
                                                  advisorName: widget.advisorName),
                                            ),
                                          );
                                        },
                                        child: CustomCard(
                                            height: height,
                                            width: width,
                                            //subject: results[index].subject,
                                            result: results[index]
                                        ),
                                      )),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: height * 0.03,
                          ),
                          results.isEmpty?
                          Align(
                            alignment: Alignment.center,
                            child:
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!.view_more,
                                    //'View More',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontSize: height * 0.0187,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600)),
                                Icon(Icons.keyboard_arrow_down,
                                  color: const Color.fromRGBO(141, 167, 167, 1),
                                  size: height * 0.034,),
                              ],
                            ),
                          )
                              :Align(
                            alignment: Alignment.center,
                            child:
                            MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                                child: CircularProgressIndicator(
                                                  color: Color.fromRGBO(48, 145, 139, 1),
                                                ));
                                          });
                                      int res= await getData();
                                      if(res == 200){
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!.view_more,
                                            //'View More',
                                            style: TextStyle(
                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                fontSize: height * 0.0187,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600)),
                                        Icon(Icons.keyboard_arrow_down,
                                          color: const Color.fromRGBO(141, 167, 167, 1),
                                          size: height * 0.034,),
                                      ],
                                    )
                                )),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                        ]),
                  ),
                )));
  }
  });}}
