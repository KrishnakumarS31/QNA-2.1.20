import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/create_assessment_provider.dart';

//import '../Entity/question_paper_model.dart' as QuestionPaperModel;
import '../Entity/Teacher/question_entity.dart' as QuestionModel;

class TeacherPublishedAssessment extends StatefulWidget {
  TeacherPublishedAssessment(
      {Key? key,
      required this.assessmentCode,
      this.questionList})
      : super(key: key);
  String assessmentCode;
  List<QuestionModel.Question>? questionList;

  @override
  TeacherPublishedAssessmentState createState() =>
      TeacherPublishedAssessmentState();
}

class TeacherPublishedAssessmentState
    extends State<TeacherPublishedAssessment> {
  bool additionalDetails = true;
  bool _visible = true;
  int mark = 0;
  int questionTotal = 0;
  var startDate;
  var endDate;
  CreateAssessmentModel assessmentVal =
      CreateAssessmentModel(questions: [], removeQuestions: []);

  showAdditionalDetails() {
    setState(() {
      !additionalDetails;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    Future.delayed(const Duration(seconds: 3), () {
      //asynchronous delay
      if (mounted) {
        //checks if widget is still active and not disposed
        setState(() {
          //tells the widget builder to rebuild again because ui has updated
          _visible =
              false; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
        });
      }
    });
  }

  getData() async {
    //QuestionPaperModel.QuestionPaperModel value = await QnaService.getQuestion(assessmentId: widget.assessmentCode);
    setState(() {
      //values=value;
      assessmentVal =
          Provider.of<CreateAssessmentProvider>(context, listen: false)
              .getAssessment;
      questionTotal =
          widget.questionList == null ? 0 : widget.questionList!.length;
      if(widget.questionList==null){

      }else{
        for (int i = 0; i < widget.questionList!.length; i++) {
          mark = mark + widget.questionList![i].questionMark!;
        }
      }

      if(assessmentVal.assessmentStartdate == null){
        DateTime date1 = DateTime.now();
        date1 = DateTime(
            date1.year,
            date1.month,
            date1.day,
            date1.hour,
            date1.minute);
        startDate=DateTime.fromMicrosecondsSinceEpoch(date1.microsecondsSinceEpoch);
        //question.assessmentStartdate=;
      }else{
        startDate = DateTime.fromMicrosecondsSinceEpoch(
            assessmentVal.assessmentStartdate!);
      }
      endDate = DateTime.fromMicrosecondsSinceEpoch(
          assessmentVal.assessmentEnddate == null
              ? 0
              : assessmentVal.assessmentEnddate!);
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
          endDrawer: const EndDrawerMenuTeacher(),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                size: 40.0,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/teacherAssessmentLanding');
                //Navigator.pushNamedAndRemoveUntil(context, '/teacherAssessmentLanding',(route) => route.isFirst);
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     type: PageTransitionType.leftToRight,
                //     child:
                //         TeacherAssessmentLanding(),
                //   ),
                // );
              },
            ),
            toolbarHeight: height * 0.100,
            centerTitle: true,
            title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "PUBLISHED",
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: height * 0.0225,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "ASSESSMENT",
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
                    Visibility(
                      visible: _visible,
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.9,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Color.fromRGBO(28, 78, 80, 1),
                        ),
                        child: Center(
                          child: Text(
                            "Assessment Published Successfully",
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(
                            color: const Color.fromRGBO(217, 217, 217, 1),
                          ),
                          color: Colors.white,
                        ),
                        height: height * 0.1675,
                        width: width * 0.888,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: height * 0.037,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                                color: Color.fromRGBO(82, 165, 160, 1),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: width * 0.02),
                                child: Row(
                                  children: [
                                    Text(
                                      "${assessmentVal.subject}",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "  |  ${assessmentVal.createAssessmentModelClass}",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontSize: height * 0.015,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.02),
                                  child: Text(
                                    "${assessmentVal.topic} - ${assessmentVal.subTopic}",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1),
                                      fontSize: height * 0.015,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: width * 0.02),
                                  child: assessmentVal.assessmentStatus ==
                                          'active'
                                      ? const Icon(
                                          Icons.circle,
                                          color: Color.fromRGBO(60, 176, 0, 1),
                                        )
                                      : assessmentVal.assessmentStatus ==
                                              'inprogress'
                                          ? const Icon(
                                              Icons.circle,
                                              color: Color.fromRGBO(
                                                  255, 166, 0, 1),
                                            )
                                          : const Icon(
                                              Icons.circle,
                                              color: Color.fromRGBO(
                                                  136, 136, 136, 1),
                                            ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Color.fromRGBO(204, 204, 204, 1),
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  width: width * 0.44,
                                  height: height * 0.0875,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "$mark",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              28, 78, 80, 1),
                                          fontSize: height * 0.03,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "Marks",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.44,
                                  height: height * 0.0875,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "$questionTotal",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              28, 78, 80, 1),
                                          fontSize: height * 0.03,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "Questions",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontSize: height * 0.015,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            "Assessment ID:",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          widget.assessmentCode,
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            "Institute Test ID:",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          assessmentVal.assessmentId != null
                              ? "${assessmentVal.assessmentId}"
                              : "-",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    const Divider(),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            "Time Permitted:",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          assessmentVal.assessmentDuration == null
                              ? "00 Minutes"
                              : "${assessmentVal.assessmentDuration} Minutes",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            "Start Date & Time:",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        assessmentVal.assessmentStartdate == null
                            ? Text(
                                "----------------------",
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : Text(
                                "${startDate.toString().substring(0, startDate.toString().length - 13)}      ${startDate.toString().substring(11, startDate.toString().length - 7)}",
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            "End Date & Time:",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        assessmentVal.assessmentEnddate == null
                            ? Text(
                                "----------------------",
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : Text(
                                "${endDate.toString().substring(0, endDate.toString().length - 13)}      ${endDate.toString().substring(11, endDate.toString().length - 7)}",
                                style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    const Divider(),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    additionalDetails
                        ? Container(
                            height: height * 0.05,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                              color: Color.fromRGBO(82, 165, 160, 1),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Additional Details",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: width * 0.02),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_circle_up_outlined,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                      onPressed: () {
                                        showAdditionalDetails();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(
                            height: height * 0.05,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                              color: Color.fromRGBO(82, 165, 160, 1),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Additional Details",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: width * 0.02),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_circle_down_outlined,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                      onPressed: () {
                                        showAdditionalDetails();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            "Category",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "${assessmentVal.assessmentType}",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            "Number of Retries allowed",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          assessmentVal.assessmentSettings
                                      ?.allowedNumberOfTestRetries ==
                                  null
                              ? "Not Allowed"
                              : "Allowed (${assessmentVal.assessmentSettings!.allowedNumberOfTestRetries} Times)",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            "Allow Guest students",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          assessmentVal.assessmentSettings?.allowGuestStudent ==
                                  null
                              ? "Not Allowed"
                              : assessmentVal
                                      .assessmentSettings!.allowGuestStudent!
                                  ? "Allowed"
                                  : "Not Allowed",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            "Show answer Sheet after test",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          assessmentVal.assessmentSettings
                                      ?.showSolvedAnswerSheetInAdvisor ==
                                  null
                              ? "Not Viewable"
                              : assessmentVal.assessmentSettings!
                                      .showSolvedAnswerSheetInAdvisor!
                                  ? "Viewable"
                                  : "Not Viewable",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            "Show my name in Advisor",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          assessmentVal.assessmentSettings?.showAdvisorName ==
                                  null
                              ? "No"
                              : assessmentVal
                                      .assessmentSettings!.showAdvisorName!
                                  ? "Yes"
                                  : "No",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            "Show my Email in Advisor",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          assessmentVal.assessmentSettings?.showAdvisorEmail ==
                                  null
                              ? "No"
                              : assessmentVal
                                      .assessmentSettings!.showAdvisorEmail!
                                  ? "Yes"
                                  : "No",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Inactive",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Not available for student",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(
                                        153, 153, 153, 0.8),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                        ),
                        Text(
                          assessmentVal.assessmentSettings?.notAvailable == null
                              ? "No"
                              : assessmentVal.assessmentSettings!.notAvailable!
                                  ? "Yes"
                                  : "No",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Allow  Public access ",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Available to public for practice",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(
                                        153, 153, 153, 0.8),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                        ),
                        Text(
                          assessmentVal.assessmentSettings
                                      ?.avalabilityForPractice ==
                                  null
                              ? "No"
                              : assessmentVal.assessmentSettings!
                                      .avalabilityForPractice!
                                  ? "Yes"
                                  : "No",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      height: height * 0.05,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                        color: Color.fromRGBO(82, 165, 160, 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Questions",
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.02),
                              child: const Icon(
                                Icons.arrow_circle_up_outlined,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    widget.questionList == null
                        ? const SizedBox(
                            height: 0,
                          )
                        : widget.questionList!.isNotEmpty
                            ? SizedBox(
                                height: height * 0.4,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: widget.questionList!.length,
                                    itemBuilder: (context, index) =>
                                        QuestionWidget(
                                          height: height,
                                          question: widget.questionList![index],
                                        )),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Text(
                          "  View All Questions  ",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.02,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Color.fromRGBO(28, 78, 80, 1),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      children: [
                        Container(
                          height: height * 0.08,
                          width: width * 0.28,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(232, 232, 232, 1),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "WEB",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: const Color.fromRGBO(153, 153, 153, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: height * 0.08,
                            width: width * 0.3,
                            child: Center(
                              child: Text(
                                "Android App",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: const Color.fromRGBO(153, 153, 153, 1),
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.08,
                          width: width * 0.28,
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(232, 232, 232, 1),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "IOS App",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: const Color.fromRGBO(153, 153, 153, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Center(
                      child: SizedBox(
                        width: width * 0.888,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                              minimumSize: const Size(280, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(39),
                              ),
                              side: const BorderSide(
                                color: Color.fromRGBO(82, 165, 160, 1),
                              )),
                          //shape: StadiumBorder(),
                          onPressed: () {
                            Navigator.pushNamed(context, '/teacherAssessmentLanding');
                           // Navigator.pushNamedAndRemoveUntil(context, '/teacherAssessmentLanding',(route) => route.isFirst);
                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //         builder: (context) => TeacherAssessmentLanding(
                            //             )),
                            //         (route) => route.isFirst);
                          },
                          child: Text(
                            'Back to My Assessment',
                            style: TextStyle(
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                )),
          ),
        ));
  }
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key, required this.height, required this.question})
      : super(key: key);

  final double height;
  final QuestionModel.Question question;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String correctAns = '';

  @override
  void initState() {
    for (int i = 0; i < widget.question.choices!.length; i++) {
      if (widget.question.choices![i].rightChoice!) {
        correctAns = '${widget.question.choices![i].choiceText!},$correctAns';
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.height * 0.01,
        ),
        Text(
          widget.question.questionType!,
          style: TextStyle(
            color: const Color.fromRGBO(28, 78, 80, 1),
            fontSize: widget.height * 0.015,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: widget.height * 0.01,
        ),
        Text(
          widget.question.question!,
          style: TextStyle(
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontSize: widget.height * 0.015,
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: widget.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              correctAns,
              style: TextStyle(
                color: const Color.fromRGBO(82, 165, 160, 1),
                fontSize: widget.height * 0.015,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text(
                  'Marks : ',
                  style: TextStyle(
                    color: const Color.fromRGBO(102, 102, 102, 1),
                    fontSize: widget.height * 0.015,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${widget.question.questionMark}",
                  style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontSize: widget.height * 0.015,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Divider()
      ],
    );
  }
}
