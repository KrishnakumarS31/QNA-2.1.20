import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_result_assessment.dart';
import '../Components/custom_card.dart';
import '../Entity/Teacher/response_entity.dart';
import '../EntityModel/get_result_model.dart';
import '../Services/qna_service.dart';

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
                            size: MediaQuery.of(context).copyWith().size.width *
                                0.07,
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
                          "      Completed Tests",
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
                          "      In Progress Tests",
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
                          "      Not Started Tests",
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
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
    getData();
  }

  getData() async {
    ResponseEntity response =
        await QnaService.getResultDataService(widget.userId, 1, pageLimit);
    //widget.userId
    allResults = List<GetResultModel>.from(
        response.data.map((x) => GetResultModel.fromJson(x)));
    setState(() {
      results.addAll(allResults);
      loading = false;
      pageLimit++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
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
                      'RESULTS',
                      style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "MY ASSESSMENTS",
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
                      // Row(children: <Widget>[
                      //   const Expanded(
                      //       child: Divider(
                      //     color: Color.fromRGBO(233, 233, 233, 1),
                      //     thickness: 2,
                      //   )),
                      //   Padding(
                      //     padding: const EdgeInsets.only(right: 10, left: 10),
                      //     child: Text(
                      //       'DEC 2022',
                      //       style: TextStyle(
                      //           fontSize: height * 0.0187,
                      //           fontFamily: "Inter",
                      //           fontWeight: FontWeight.w700),
                      //     ),
                      //   ),
                      //   const Expanded(
                      //       child: Divider(
                      //     color: Color.fromRGBO(233, 233, 233, 1),
                      //     thickness: 2,
                      //   )),
                      // ]),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: results.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: TeacherResultAssessment(
                                        result: results[index],
                                        userId: widget.userId,
                                        advisorName: widget.advisorName),
                                  ),
                                );
                              },
                              child: CustomCard(
                                height: height,
                                width: width,
                                index: results.length,
                                subject: results[index].subject,
                                result: results[index],
                                title: results[index].topic,
                                date: results[index].assessmentStartDate,
                                subTopic: results[index].subTopic,
                                std: results[index].studentClass,
                                status: const Color.fromRGBO(255, 157, 77, 1),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            getData();
                          },
                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     PageTransition(
                          //       type: PageTransitionType.rightToLeft,
                          //       child: TeacherResultMonth(result: results),
                          //     ),
                          //   );
                          // },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'View More',
                                style: TextStyle(
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontSize: height * 0.0187,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: const Color.fromRGBO(141, 167, 167, 1),
                                  size: height * 0.034,
                                ),
                                onPressed: () {
                                  getData();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(255, 255, 255, 1),
                          minimumSize: const Size(280, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(39),
                          ),
                        ),
                        //shape: StadiumBorder(),
                        onPressed: () {
                          getData();
                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     type: PageTransitionType.rightToLeft,
                          //     child: LooqQuestionEdit(question: widget.question,),
                          //   ),
                          // );
                        },
                        child: Text(
                          'Load More',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                    ]),
              ),
            )));
  }
}
