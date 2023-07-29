import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher/result/teacher_result_assessment.dart';
import '../../../Components/custom_card.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import '../../../Entity/Teacher/response_entity.dart';
import '../../../Entity/user_details.dart';
import '../../../EntityModel/get_result_model.dart';
import '../../../Providers/LanguageChangeProvider.dart';
import '../../../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class TeacherResultLanding extends StatefulWidget {
  const TeacherResultLanding({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final int? userId;

  @override
  TeacherResultLandingState createState() => TeacherResultLandingState();
}

class TeacherResultLandingState extends State<TeacherResultLanding> {
  bool loading = true;
  ScrollController scrollController = ScrollController();
  int pageLimit = 1;
  List<GetResultModel> results = [];
  List<GetResultModel> allResults = [];
  int totalCount=0;
  late List<AssessmentResults> assessmentResults;
  UserDetails userDetails=UserDetails();

  int resultStart=0;
  @override
  void initState() {
    super.initState();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    Future.delayed(Duration.zero, (){getData();});
  }


  Future<int> getData() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(48, 145, 139, 1),
              ));
        });
    ResponseEntity response =
    await QnaService.getResultDataService(widget.userId, 10, pageLimit,userDetails);
    if(response.code == 200) {
      Navigator.pop(context);
      ResultsModelResponse resultsModelResponse=ResultsModelResponse.fromJson(response.data);
      print(resultsModelResponse);
      totalCount = resultsModelResponse.totalCount ?? 0;
      allResults = resultsModelResponse.data!;
      setState(() {
        results=allResults;
        loading = false;
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
          if (constraints.maxWidth <= 960 && constraints.maxWidth >=500){
            return
              Center(
                  child: SizedBox(
                      child: WillPopScope(
                          onWillPop: () async => false,
                          child: Scaffold(
                              resizeToAvoidBottomInset: true,
                              backgroundColor: Colors.white,
                              endDrawer: const EndDrawerMenuTeacher(),
                              appBar: AppBar(
                                elevation: 0,
                                iconTheme: const IconThemeData(color: Color.fromRGBO(28, 78, 80, 1),size: 40),
                                leading: IconButton(
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    size: 40.0,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                toolbarHeight: height * 0.100,
                                centerTitle: true,
                                title: Text(
                                  AppLocalizations.of(context)!.results_camelcase,
                                  //'RESULTS',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontSize: height * 0.0175,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                flexibleSpace: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              body: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.023,
                                      left: height * 0.013,
                                      right: height * 0.013),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1)),
                                            ),
                                            height: height * 0.8,
                                            child:Column(children: [
                                              Container(
                                                  padding: const EdgeInsets.all(8),
                                                  margin: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                    border: Border.all(
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.all(2),
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(5)),
                                                          border: Border.all(
                                                              color: const Color.fromRGBO(
                                                                  219, 35, 35, 1)),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Icon(
                                                              Icons.circle,
                                                              color: const Color.fromRGBO(219, 35, 35, 1),
                                                              size: MediaQuery
                                                                  .of(context)
                                                                  .copyWith()
                                                                  .size
                                                                  .height *
                                                                  0.02,
                                                            ),
                                                            Text(
                                                              //AppLocalizations.of(context)!.active,
                                                              "  LIVE ",
                                                              style: Theme
                                                                  .of(context)
                                                                  .primaryTextTheme
                                                                  .bodyLarge
                                                                  ?.merge(TextStyle(
                                                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: MediaQuery
                                                                      .of(context)
                                                                      .copyWith()
                                                                      .size
                                                                      .height *
                                                                      0.016)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.all(2),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.circle,
                                                              color: const Color.fromRGBO(42, 36, 186, 1),
                                                              size: height * 0.03,
                                                            ),
                                                            Text(
                                                              AppLocalizations.of(context)!.completed,
                                                              style: TextStyle(
                                                                  color: const Color.fromRGBO(102, 102, 102, 0.7),
                                                                  fontSize: height * 0.02,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w400),
                                                            ),
                                                          ],),
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.all(2),
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.circle,
                                                              color: const Color.fromRGBO(153, 153, 153, 1),
                                                              size: height * 0.03,
                                                            ),
                                                            Text(
                                                              AppLocalizations.of(context)!.yet_to_start,
                                                              style: TextStyle(
                                                                  color: const Color.fromRGBO(102, 102, 102, 0.7),
                                                                  fontSize: height * 0.02,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w400),
                                                            ),
                                                          ],),
                                                      )
                                                    ],
                                                  )),
                                              results.isEmpty
                                                  ? Column(
                                                children: [
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
                                                  : Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: SizedBox(
                                                      height: height * 0.6,
                                                      child: ListView.builder(
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: results.length,
                                                        itemBuilder: (context, index) => Column(
                                                          children: [
                                                            MouseRegion(
                                                                cursor: SystemMouseCursors.click,
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                      context,
                                                                      PageTransition(
                                                                        type: PageTransitionType.rightToLeft,
                                                                        child: TeacherResultAssessment(
                                                                            result: results[index],
                                                                            userId: widget.userId,
                                                                            userDetails:userDetails),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                                                                    child: CustomCard(
                                                                        height: height,
                                                                        width: width,
                                                                        result: results[index]
                                                                    ),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.02,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'Showing ${resultStart + 1} to ${resultStart+10 <totalCount?resultStart+10:totalCount} of $totalCount',
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                      ),
                                                      Wrap(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: (){
                                                                  if(pageLimit > 1){
                                                                    setState(() {
                                                                      pageLimit--;
                                                                      resultStart=resultStart-10;
                                                                      // results.removeRange(results.length-10, results.length);
                                                                    });
                                                                    getData();
                                                                    setState(() {

                                                                    });
                                                                  }
                                                                },
                                                                child: Container(
                                                                  height: height * 0.03,
                                                                  width: width * 0.1,
                                                                  decoration: BoxDecoration(
                                                                    border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                                    borderRadius: const BorderRadius.all(
                                                                        Radius.circular(5)),
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.keyboard_double_arrow_left,
                                                                    size: height * 0.015,
                                                                    color: const Color.fromRGBO(28, 78, 80, 1),),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(right: width * 0.005,left: width * 0.005),
                                                                child: Container(
                                                                  height: height * 0.03,
                                                                  width: width * 0.15,
                                                                  decoration: BoxDecoration(
                                                                    border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                                    borderRadius: const BorderRadius.all(
                                                                        Radius.circular(5)),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${resultStart==0?1:((resultStart/10)+1).toInt()}',
                                                                      style: TextStyle(
                                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: height * 0.016),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: (){
                                                                  if(totalCount-resultStart > 10){
                                                                    setState(() {
                                                                      resultStart=resultStart+10;
                                                                      pageLimit++;
                                                                    });
                                                                    getData();
                                                                  }
                                                                },
                                                                child: Container(
                                                                  height: height * 0.03,
                                                                  width: width * 0.1,
                                                                  decoration: BoxDecoration(
                                                                    border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                                    borderRadius: const BorderRadius.all(
                                                                        Radius.circular(5)),
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.keyboard_double_arrow_right,
                                                                    size: height * 0.015,
                                                                    color: const Color.fromRGBO(28, 78, 80, 1),),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],)

                                        ),

                                      ]),
                                ),
                              )))));
          }
          else if (constraints.maxWidth > 960) {
            return
              WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                      resizeToAvoidBottomInset: true,
                      backgroundColor: Colors.white,
                      endDrawer: const EndDrawerMenuTeacher(),
                      appBar: AppBar(
                        iconTheme: const IconThemeData(color: Color.fromRGBO(28, 78, 80, 1),size: 40),
                        elevation: 0,
                        leading: IconButton(
                          icon: const Icon(
                            Icons.chevron_left,
                            size: 40.0,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        toolbarHeight: height * 0.100,
                        centerTitle: true,
                        title: Text(
                          AppLocalizations.of(context)!.results_camelcase,
                          //'RESULTS',
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0225,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        flexibleSpace: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      body: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: height * 0.00500, left: height * 0.5,right: height * 0.5),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      const BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              82, 165, 160, 1)),
                                    ),
                                    height: height * 0.8,
                                    child:SingleChildScrollView(
                                      child: Column(children: [
                                        Container(
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                    border: Border.all(
                                                        color: const Color.fromRGBO(
                                                            219, 35, 35, 1)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        color: const Color.fromRGBO(219, 35, 35, 1),
                                                        size: MediaQuery
                                                            .of(context)
                                                            .copyWith()
                                                            .size
                                                            .height *
                                                            0.02,
                                                      ),
                                                      Text(
                                                        //AppLocalizations.of(context)!.active,
                                                        "  LIVE ",
                                                        style: Theme
                                                            .of(context)
                                                            .primaryTextTheme
                                                            .bodyLarge
                                                            ?.merge(TextStyle(
                                                            color: const Color.fromRGBO(51, 51, 51, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: MediaQuery
                                                                .of(context)
                                                                .copyWith()
                                                                .size
                                                                .height *
                                                                0.016)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(2),
                                                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        color: const Color.fromRGBO(42, 36, 186, 1),
                                                        size: height * 0.03,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(context)!.completed,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.7),
                                                            fontSize: height * 0.02,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(2),
                                                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        color: const Color.fromRGBO(153, 153, 153, 1),
                                                        size: height * 0.03,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(context)!.yet_to_start,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.7),
                                                            fontSize:height * 0.02,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],),
                                                )
                                              ],
                                            )),
                                        results.isEmpty
                                            ? Column(
                                          children: [
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
                                            : Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom:8.0),
                                          child: Column(
                                            children: [
                                              for(int index=0;index<results.length;index++)
                                                MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          PageTransition(
                                                            type: PageTransitionType.rightToLeft,
                                                            child: TeacherResultAssessment(
                                                                result: results[index],
                                                                userId: widget.userId,
                                                                userDetails:userDetails),
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                                                        child: CustomCard(
                                                            height: height,
                                                            width: width,

                                                            //subject: results[index].subject,
                                                            result: results[index]
                                                        ),
                                                      ),
                                                    )),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Showing ${resultStart + 1} to ${resultStart+10 <totalCount?resultStart+10:totalCount} of $totalCount',
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: height * 0.02),
                                                  ),
                                                  Wrap(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: (){
                                                              if(pageLimit > 1){
                                                                setState(() {
                                                                  pageLimit--;
                                                                  resultStart=resultStart-10;
                                                                });
                                                                getData();
                                                                setState(() {});
                                                              }
                                                            },
                                                            child: Container(
                                                              height: height * 0.03,
                                                              width: width * 0.03,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                                borderRadius: const BorderRadius.all(
                                                                    Radius.circular(5)),
                                                              ),
                                                              child: Icon(
                                                                Icons.keyboard_double_arrow_left,
                                                                size: height * 0.015,
                                                                color: const Color.fromRGBO(28, 78, 80, 1),),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(right: width * 0.005,left: width * 0.005),
                                                            child: Container(
                                                              height: height * 0.03,
                                                              width: width * 0.03,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                                borderRadius: const BorderRadius.all(
                                                                    Radius.circular(5)),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  '${resultStart==0?1:((resultStart/10)+1).toInt()}',
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.016),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: (){
                                                              if(totalCount-resultStart > 10){
                                                                setState(() {
                                                                  resultStart=resultStart+10;
                                                                  pageLimit++;
                                                                });
                                                                getData();
                                                              }
                                                            },
                                                            child: Container(
                                                              height: height * 0.03,
                                                              width: width * 0.03,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                                borderRadius: const BorderRadius.all(
                                                                    Radius.circular(5)),
                                                              ),
                                                              child: Icon(
                                                                Icons.keyboard_double_arrow_right,
                                                                size: height * 0.015,
                                                                color: const Color.fromRGBO(28, 78, 80, 1),),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],),
                                    )

                                ),
                              ]),
                        ),
                      )));
          }
          else {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.white,
                    endDrawer: const EndDrawerMenuTeacher(),
                    appBar: AppBar(
                      elevation: 0,
                      iconTheme: const IconThemeData(color: Color.fromRGBO(28, 78, 80, 1),size: 40),
                      leading: IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 40.0,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Text(
                        AppLocalizations.of(context)!.results_camelcase,
                        //'RESULTS',
                        style: TextStyle(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.023,
                            left: height * 0.013,
                            right: height * 0.013),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          82, 165, 160, 1)),
                                ),
                                height: height * 0.8,
                                child:SingleChildScrollView(
                                  child: Column(children: [
                                    Container(
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  82, 165, 160, 1)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                                border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        219, 35, 35, 1)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: const Color.fromRGBO(219, 35, 35, 1),
                                                    size: MediaQuery
                                                        .of(context)
                                                        .copyWith()
                                                        .size
                                                        .height *
                                                        0.02,
                                                  ),
                                                  Text(
                                                    //AppLocalizations.of(context)!.active,
                                                    "  LIVE ",
                                                    style: Theme
                                                        .of(context)
                                                        .primaryTextTheme
                                                        .bodyLarge
                                                        ?.merge(TextStyle(
                                                        color: const Color.fromRGBO(51, 51, 51, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: MediaQuery
                                                            .of(context)
                                                            .copyWith()
                                                            .size
                                                            .height *
                                                            0.016)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: const Color.fromRGBO(42, 36, 186, 1),
                                                    size: height * 0.03,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(context)!.completed,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 0.7),
                                                        fontSize: height * 0.02,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: const Color.fromRGBO(153, 153, 153, 1),
                                                    size: height * 0.03,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(context)!.yet_to_start,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(102, 102, 102, 0.7),
                                                        fontSize: height * 0.02,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],),
                                            )
                                          ],
                                        )),
                                    results.isEmpty
                                        ? Column(
                                      children: [
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
                                        : Padding(
                                      padding: const EdgeInsets.only(left:8.0,right:8.0,bottom:8.0),
                                      child: Column(
                                        children: [
                                          for(int index=0;index<results.length;index++)
                                            MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        type: PageTransitionType.rightToLeft,
                                                        child: TeacherResultAssessment(
                                                            result: results[index],
                                                            userId: widget.userId,
                                                            userDetails:userDetails),
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                                                    child: CustomCard(
                                                        height: height,
                                                        width: width,
                                                        result: results[index]
                                                    ),
                                                  ),
                                                )),
                                          // ListView.builder(
                                          //   scrollDirection: Axis.vertical,
                                          //   shrinkWrap: true,
                                          //   itemCount: results.length,
                                          //   itemBuilder: (context, index) => Column(
                                          //     children: [
                                          //
                                          //     ],
                                          //   ),
                                          // ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Showing ${resultStart + 1} to ${resultStart+10 <totalCount?resultStart+10:totalCount} of $totalCount',
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: height * 0.016),
                                              ),
                                              Wrap(
                                                children: [
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: (){
                                                          if(pageLimit > 1){
                                                            setState(() {
                                                              pageLimit--;
                                                              resultStart=resultStart-10;
                                                            });
                                                            getData();
                                                            setState(() {});
                                                          }
                                                        },
                                                        child: Container(
                                                          height: height * 0.03,
                                                          width: width * 0.1,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                            borderRadius: const BorderRadius.all(
                                                                Radius.circular(5)),
                                                          ),
                                                          child: Icon(
                                                            Icons.keyboard_double_arrow_left,
                                                            size: height * 0.015,
                                                            color: const Color.fromRGBO(28, 78, 80, 1),),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(right: width * 0.005,left: width * 0.005),
                                                        child: Container(
                                                          height: height * 0.03,
                                                          width: width * 0.15,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                            borderRadius: const BorderRadius.all(
                                                                Radius.circular(5)),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              '${resultStart==0?1:((resultStart/10)+1).toInt()}',
                                                              style: TextStyle(
                                                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: height * 0.016),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){
                                                          if(totalCount-resultStart > 10){
                                                            setState(() {
                                                              resultStart=resultStart+10;
                                                              pageLimit++;
                                                            });
                                                            getData();
                                                          }
                                                        },
                                                        child: Container(
                                                          height: height * 0.03,
                                                          width: width * 0.1,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                            borderRadius: const BorderRadius.all(
                                                                Radius.circular(5)),
                                                          ),
                                                          child: Icon(
                                                            Icons.keyboard_double_arrow_right,
                                                            size: height * 0.015,
                                                            color: const Color.fromRGBO(28, 78, 80, 1),),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],),
                                ),

                              ),
                            ]),
                      ),
                    )));
          }
        });}}
