import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Components/today_date.dart';
import 'package:qna_test/Entity/Teacher/get_assessment_header.dart';
import '../Entity/question_paper_model.dart';
import '../Entity/user_details.dart';
import '../EntityModel/user_data_model.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Providers/question_num_provider.dart';
import '../Services/qna_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
class StudentResultPage extends StatefulWidget {
  const StudentResultPage({Key? key,
    required this.totalMarks,
    required this.date,
    required this.time,
    required this.questions,
    required this.assessmentCode,
    required this.userName,
    required this.message,
    required this.endTime,
    required this.givenMark,
    required this.isMember,
    required this.assessmentHeaders,
    required this.organisationName
  })
      : super(key: key);
  final int totalMarks;
  final QuestionPaperModel questions;
  final String date;
  final String time;
  final String userName;
  final String assessmentCode;
  final String endTime;
  final String message;
  final int givenMark;
  final bool isMember;
  final GetAssessmentHeaderModel assessmentHeaders;
  final String organisationName;

  @override
  StudentResultPageState createState() => StudentResultPageState();
}

class StudentResultPageState extends State<StudentResultPage> {
  TextEditingController assessmentID = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  late QuestionPaperModel values;
  UserDetails userdata=UserDetails();

  @override
  void initState() {
    super.initState();
    userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    values = widget.questions;
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery
        .of(context)
        .size
        .width;
    double localHeight = MediaQuery
        .of(context)
        .size
        .height;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  centerTitle: true,
                  title:    Text(
                    AppLocalizations.of(context)!.result_card,
                    //"MY ASSESSMENTS",
                    style: TextStyle(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: localHeight * 0.0225,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ),
                body:
                    widget.totalMarks == 0
                        ? Container(
                        padding:EdgeInsets.only(left: localWidth * 0.025,right: localWidth * 0.025),
                        child:
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: localHeight * 0.0050),
                              child: Column(
                                children: [
                                  Text(
                                    widget.organisationName,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.02),
                                  ),
                                  SizedBox(height: localHeight * 0.1),
                                  SizedBox(
                                    height: localHeight * 0.45,
                                    width: localWidth * 1.5,
                                    child: Card(
                                      elevation: 12,
                                      child: Column(children: [
                                        SizedBox(height: localHeight * 0.005),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children:[
                                              Text(
                                                  "${widget.questions.data!.assessmentType}" == "practice"
                                                      ? "Practice"
                                                      : '',
                                                  //"Practice",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(255, 153, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: localHeight * 0.025)),
                                              SizedBox(width: localWidth * 0.02)
                                            ]
                                        ),
                                        Text(widget.userName,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.03)),
                                        Divider(
                                            thickness: 0.1,
                                            indent: localWidth * 0.05,
                                            endIndent: localWidth * 0.04,
                                            color: Colors.black
                                        ),
                                        const SizedBox(height: 1.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left:localWidth * 0.06),
                                                  child: Icon(Icons.timer,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                ),
                                                SizedBox(width:localWidth * 0.02),
                                                SizedBox(
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      //"10:26:59",
                                                        widget.endTime.substring(0,7),
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: localHeight * 0.025)),
                                                  ),
                                                ),],
                                            ),
                                            SizedBox(width:localWidth * 0.02),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.calendar_today_outlined,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                SizedBox(width:localWidth * 0.02),
                                                Text(convertDateFromString(widget.date),
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.025)),],
                                            ),
                                            SizedBox(width:localWidth * 0.02),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                SizedBox(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(right: localHeight * 0.06),
                                                    child: Text(widget.time,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: localHeight * 0.025)),
                                                  ),
                                                ),],
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            thickness: 0.1,
                                            indent: localWidth * 0.05,
                                            endIndent: localWidth * 0.04,
                                            color: Colors.black
                                        ),
                                        SizedBox(height: localHeight * 0.03),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                    SizedBox(width: localWidth * 0.3),
                                                    SizedBox(
                                                      width:localHeight * 0.15,
                                                      child: Text(
                                                        //"10:26:59",
                                                          "Assessment ID",
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(161, 161, 161, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: localHeight * 0.016)),
                                                    ),
                                                    SizedBox(
                                                      child: Text(widget.assessmentCode,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(
                                                                  0, 106, 100, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: localHeight * 0.022)),
                                                    ),],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: localWidth * 0.3),
                                                    // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                    SizedBox(
                                                      width:localHeight * 0.15,
                                                      child: Text(
                                                        //"10:26:59",
                                                          "Degree",
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(161, 161, 161, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: localHeight * 0.016)),
                                                    ),
                                                    SizedBox(
                                                      child: Text(widget.assessmentHeaders.getAssessmentModelClass ?? " - ",
                                                          //widget.assessmentHeaders.getAssessmentModelClass != null ? "${widget.assessmentHeaders.getAssessmentModelClass}" : "",
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: localHeight * 0.022)),
                                                    ),],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: localWidth * 0.3),
                                                    //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                    SizedBox(
                                                      width:localHeight * 0.15,
                                                      child: Text(
                                                        //"10:26:59",
                                                          "Semester",
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(161, 161, 161, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: localHeight * 0.016)),
                                                    ),
                                                    Text(widget.assessmentHeaders.subTopic ?? " - ",
                                                        //"${widget.assessmentHeaders.subTopic}",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: localHeight * 0.022)),],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: localWidth * 0.3),
                                                    //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                    SizedBox(
                                                      width:localHeight * 0.15,
                                                      child: Text(
                                                        //"10:26:59",
                                                          "Subject",
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(161, 161, 161, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: localHeight * 0.016)),
                                                    ),
                                                    Text(widget.assessmentHeaders.subject ?? " - ",
                                                        //"${widget.assessmentHeaders.topic}",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: localHeight * 0.022)),],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: localWidth * 0.3),
                                                    //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                    SizedBox(
                                                      width:localHeight * 0.15,
                                                      child: Text(
                                                        //"10:26:59",
                                                          "Topic",
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(161, 161, 161, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: localHeight * 0.016)),
                                                    ),
                                                    Text(widget.assessmentHeaders.topic ?? " - ",
                                                        //"${widget.assessmentHeaders.topic}",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: localHeight * 0.022)),],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: localHeight * 0.03),
                                        Divider(
                                            thickness: 0.1,
                                            indent: localWidth * 0.05,
                                            endIndent: localWidth * 0.04,
                                            color: Colors.black
                                        ),
                                        SizedBox(height: localHeight * 0.03),
                                        Align(
                                            alignment: Alignment.center,
                                            child:Text("Thank You",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: localHeight * 0.027))
                                        )
                                      ]),
                                    ),
                                  ),
                                  SizedBox(height:localHeight * 0.07),
                                  Column(
                                    children: [
                                      //SizedBox(height: localHeight * 0.27),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                            "For incorrect answers",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: localHeight * 0.018)),
                                      ),
                                      const SizedBox(height:0.5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          MouseRegion(
                                              cursor: SystemMouseCursors
                                                  .click,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        '/studMemAdvisor',
                                                        arguments: [values,widget.assessmentCode]
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:25.0),
                                                    child: Text(
                                                        "View Advisor",
                                                        style: Theme
                                                            .of(context)
                                                            .primaryTextTheme
                                                            .bodyLarge
                                                            ?.merge(TextStyle(
                                                            color: const Color
                                                                .fromRGBO(
                                                                48, 145, 139,
                                                                1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: localHeight *
                                                                0.023))),
                                                  ))),
                                          IconButton(
                                            icon:
                                            Icon(
                                                size: localWidth * 0.040,
                                                weight:localWidth * 0.5,
                                                Icons.chevron_right,
                                                color: const Color
                                                    .fromRGBO(
                                                    48, 145, 139,
                                                    1)
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  '/studMemAdvisor',
                                                  arguments: [values,widget.assessmentCode]
                                              );
                                            },
                                          ),

                                        ],
                                      ),
                                      // SizedBox(height: localHeight * 0.010),
                                      // ElevatedButton(
                                      //     style: ElevatedButton.styleFrom(
                                      //       backgroundColor: const Color.fromRGBO(
                                      //           255, 255, 255, 1),
                                      //       minimumSize: const Size(280, 48),
                                      //       shape: RoundedRectangleBorder(
                                      //         borderRadius: BorderRadius.circular(
                                      //             39),
                                      //       ),
                                      //       side: const BorderSide(
                                      //         width: 1.5,
                                      //         color: Color.fromRGBO(
                                      //             82, 165, 160, 1),
                                      //       ),
                                      //     ),
                                      //     child: Text(
                                      //         AppLocalizations.of(context)!
                                      //             .advisor,
                                      //         style: TextStyle(
                                      //             fontFamily: 'Inter',
                                      //             fontSize: localHeight * 0.022,
                                      //             color: const Color.fromRGBO(
                                      //                 82, 165, 160, 1),
                                      //             fontWeight: FontWeight.w500)),
                                      //     onPressed: () {
                                      //       Navigator.pushNamed(
                                      //           context,
                                      //           '/studMemAdvisor',
                                      //           arguments: [values,widget.assessmentCode]
                                      //       );
                                      //     }),
                                      SizedBox(height: localHeight * 0.05),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                          // minimumSize: Size(localWidth * 0.7, localHeight * 0.04),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                39),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              AppLocalizations.of(context)!.exit,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: localHeight * 0.027,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AlertDialog(
                                                  // insetPadding: EdgeInsets.only(
                                                  //     left: localWidth * 0.13,
                                                  //     right: localWidth * 0.13),
                                                  title: Padding(
                                                    padding: EdgeInsets.only(left: localHeight * 0.04),
                                                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Color.fromRGBO(
                                                                  82, 165, 160, 1),
                                                            ),
                                                            height: localHeight * 0.1,
                                                            width: localWidth * 0.1,
                                                            child: const Icon(
                                                              Icons
                                                                  .info_outline_rounded,
                                                              color: Color.fromRGBO(
                                                                  255, 255, 255, 1),
                                                            ),
                                                          ),
                                                          SizedBox(width: localHeight *
                                                              0.018),
                                                          Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .confirm,
                                                            style: TextStyle(
                                                                fontFamily: 'Inter',
                                                                fontSize: localHeight *
                                                                    0.024,
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    0, 106, 100, 1),
                                                                fontWeight: FontWeight
                                                                    .w700),
                                                          ),
                                                        ]),
                                                  ),
                                                  content: Padding(
                                                    padding: EdgeInsets.only(left: localHeight * 0.04,right: localHeight * 0.04),
                                                    child: const Text(
                                                        "Are you sure you want to exit from this Assessment."),
                                                  ),
                                                  actions: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: localHeight * 0.04),
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children:[
                                                            ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                  backgroundColor:
                                                                  const Color.fromRGBO(
                                                                      255, 255, 255, 1),
                                                                  minimumSize: const Size(
                                                                      90, 30),
                                                                  side: const BorderSide(
                                                                    width: 1.5,
                                                                    color: Color.fromRGBO(
                                                                        82, 165, 160, 1),

                                                                  ),
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.all(
                                                                          Radius.circular(17)))
                                                              ),
                                                              child: Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .no,
                                                                  style: TextStyle(
                                                                      fontFamily: 'Inter',
                                                                      fontSize:
                                                                      localHeight * 0.018,
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          82, 165, 160,
                                                                          1),
                                                                      fontWeight:
                                                                      FontWeight.w500)),
                                                              onPressed: () {
                                                                Navigator.of(context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            SizedBox(width: localWidth * 0.05),
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                    backgroundColor:
                                                                    const Color.fromRGBO(
                                                                        82, 165, 160, 1),
                                                                    minimumSize: const Size(
                                                                        90, 30),
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(
                                                                            Radius.circular(17)))
                                                                ),
                                                                child: Text(
                                                                    AppLocalizations.of(
                                                                        context)!
                                                                        .yes,
                                                                    style: TextStyle(
                                                                        fontFamily: 'Inter',
                                                                        fontSize:
                                                                        localHeight *
                                                                            0.018,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                        FontWeight.w500)),
                                                                onPressed: () async {
                                                                  Provider.of<Questions>(context, listen: false).updateAssessmentSubmit(false);
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (context) {
                                                                        return const Center(
                                                                            child:
                                                                            CircularProgressIndicator(
                                                                              color: Color
                                                                                  .fromRGBO(
                                                                                  48, 145,
                                                                                  139, 1),
                                                                            ));
                                                                      });
                                                                  // Navigator.pushNamed(
                                                                  //     context,
                                                                  //     '/studGuestAssessment',
                                                                  //     arguments: widget.userName);
                                                                  // Navigator.of(context)
                                                                  //     .pop();
                                                                  if(widget.isMember) {
                                                                    SharedPreferences loginData = await SharedPreferences.getInstance();
                                                                    UserDetails userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
                                                                    UserDataModel userDataModel =
                                                                    await QnaService
                                                                        .getUserDataService(userdata.userId,userdata);
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/studentAssessment',
                                                                        arguments: [userDataModel,null,userdata.email]);
                                                                  }
                                                                  else {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/studGuestAssessment',
                                                                        arguments: widget.userName);
                                                                  }
                                                                }
                                                            ),
                                                          ]
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ],
                        ))
                        : Container(
                    padding:EdgeInsets.only(left: localWidth * 0.025,right: localWidth * 0.025),
                    child:
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: localHeight * 0.0050),
                          child: Column(
                            children: [
                              Text(
                                widget.organisationName,
                                style: TextStyle(
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: localHeight * 0.02),
                              ),
                              SizedBox(height: localHeight * 0.01),
                              SizedBox(
                                height: localHeight * 0.62,
                                width: localWidth * 1.5,
                                child: Card(
                                  elevation: 12,
                                  child: Column(children: [
                                    SizedBox(height: localHeight * 0.005),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children:[
                                          Text(
                                              "${widget.questions.data!.assessmentType}" == "practice"
                                                  ? "Practice"
                                                  : '',
                                              //"Practice",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(255, 153, 0, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: localHeight * 0.025)),
                                          SizedBox(width: localWidth * 0.02)
                                        ]
                                    ),
                                    Text(widget.userName,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.03)),
                                    //const SizedBox(height: 25.0),
                                    Text('${widget.totalMarks}/${widget.givenMark}',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                255, 153, 0, 1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.096)),
                                    const SizedBox(height:1.0),
                                    Text(AppLocalizations.of(context)!.mark_scored,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.018)),
                                    SizedBox(height: localHeight * 0.03),
                                    Divider(
                                        thickness: 0.1,
                                        indent: localWidth * 0.05,
                                        endIndent: localWidth * 0.04,
                                        color: Colors.black
                                    ),
                                    const SizedBox(height: 1.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left:localWidth * 0.06),
                                              child: Icon(Icons.timer,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            ),
                                            SizedBox(width:localWidth * 0.02),
                                            SizedBox(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  //"10:26:59",
                                                    widget.endTime.substring(0,7),
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.025)),
                                              ),
                                            ),],
                                        ),
                                        SizedBox(width:localWidth * 0.02),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.calendar_today_outlined,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(width:localWidth * 0.02),
                                            Text(convertDateFromString(widget.date),
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.025)),],
                                        ),
                                        SizedBox(width:localWidth * 0.02),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              child: Padding(
                                                padding: EdgeInsets.only(right: localHeight * 0.06),
                                                child: Text(widget.time,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.025)),
                                              ),
                                            ),],
                                        ),
                                      ],
                                    ),
                                    Divider(
                                        thickness: 0.1,
                                        indent: localWidth * 0.05,
                                        endIndent: localWidth * 0.04,
                                        color: Colors.black
                                    ),
                                    SizedBox(height: localHeight * 0.03),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                       Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(width: localWidth * 0.3),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Assessment ID",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  SizedBox(
                                                    child: Text(widget.assessmentCode,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                0, 106, 100, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: localHeight * 0.022)),
                                                  ),],
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: localWidth * 0.3),
                                                  // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Degree",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  SizedBox(
                                                    child: Text(widget.assessmentHeaders.getAssessmentModelClass ?? " - ",
                                                        //widget.assessmentHeaders.getAssessmentModelClass != null ? "${widget.assessmentHeaders.getAssessmentModelClass}" : "",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: localHeight * 0.022)),
                                                  ),],
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: localWidth * 0.3),
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Semester",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  Text(widget.assessmentHeaders.subTopic ?? " - ",
                                                      //"${widget.assessmentHeaders.subTopic}",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.022)),],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: localWidth * 0.3),
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Subject",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  Text(widget.assessmentHeaders.subject ?? " - ",
                                                      //"${widget.assessmentHeaders.topic}",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.022)),],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: localWidth * 0.3),
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Topic",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  Text(widget.assessmentHeaders.topic ?? " - ",
                                                      //"${widget.assessmentHeaders.topic}",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.022)),],
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: localHeight * 0.03),
                                    Divider(
                                        thickness: 0.1,
                                        indent: localWidth * 0.05,
                                        endIndent: localWidth * 0.04,
                                        color: Colors.black
                                    ),
                                    SizedBox(height: localHeight * 0.03),
                                    Align(
                                        alignment: Alignment.center,
                                        child:Text("Thank You",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(82, 165, 160, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.027))
                                    )
                                  ]),
                                ),
                              ),
                              SizedBox(height:localHeight * 0.07),
                              Column(
                                children: [
                                  //SizedBox(height: localHeight * 0.27),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                        "For incorrect answers",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.018)),
                                  ),
                                  const SizedBox(height:0.5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      MouseRegion(
                                          cursor: SystemMouseCursors
                                              .click,
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    '/studMemAdvisor',
                                                    arguments: [values,widget.assessmentCode]
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(left:25.0),
                                                child: Text(
                                                    "View Advisor",
                                                    style: Theme
                                                        .of(context)
                                                        .primaryTextTheme
                                                        .bodyLarge
                                                        ?.merge(TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            48, 145, 139,
                                                            1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: localHeight *
                                                            0.023))),
                                              ))),
                                      IconButton(
                                        icon:
                                        Icon(
                                            size: localWidth * 0.040,
                                            weight:localWidth * 0.5,
                                            Icons.chevron_right,
                                            color: const Color
                                                .fromRGBO(
                                                48, 145, 139,
                                                1)
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              '/studMemAdvisor',
                                              arguments: [values,widget.assessmentCode]
                                          );
                                        },
                                      ),

                                    ],
                                  ),
                                  // SizedBox(height: localHeight * 0.010),
                                  // ElevatedButton(
                                  //     style: ElevatedButton.styleFrom(
                                  //       backgroundColor: const Color.fromRGBO(
                                  //           255, 255, 255, 1),
                                  //       minimumSize: const Size(280, 48),
                                  //       shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(
                                  //             39),
                                  //       ),
                                  //       side: const BorderSide(
                                  //         width: 1.5,
                                  //         color: Color.fromRGBO(
                                  //             82, 165, 160, 1),
                                  //       ),
                                  //     ),
                                  //     child: Text(
                                  //         AppLocalizations.of(context)!
                                  //             .advisor,
                                  //         style: TextStyle(
                                  //             fontFamily: 'Inter',
                                  //             fontSize: localHeight * 0.022,
                                  //             color: const Color.fromRGBO(
                                  //                 82, 165, 160, 1),
                                  //             fontWeight: FontWeight.w500)),
                                  //     onPressed: () {
                                  //       Navigator.pushNamed(
                                  //           context,
                                  //           '/studMemAdvisor',
                                  //           arguments: [values,widget.assessmentCode]
                                  //       );
                                  //     }),
                                  SizedBox(height: localHeight * 0.05),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color.fromRGBO(82, 165, 160, 1),
                                      // minimumSize: Size(localWidth * 0.7, localHeight * 0.04),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            39),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          AppLocalizations.of(context)!.exit,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: localHeight * 0.027,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            AlertDialog(
                                              // insetPadding: EdgeInsets.only(
                                              //     left: localWidth * 0.13,
                                              //     right: localWidth * 0.13),
                                              title: Padding(
                                                padding: EdgeInsets.only(left: localHeight * 0.04),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        decoration: const BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Color.fromRGBO(
                                                              82, 165, 160, 1),
                                                        ),
                                                        height: localHeight * 0.1,
                                                        width: localWidth * 0.1,
                                                        child: const Icon(
                                                          Icons
                                                              .info_outline_rounded,
                                                          color: Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                        ),
                                                      ),
                                                      SizedBox(width: localHeight *
                                                          0.018),
                                                      Text(
                                                        AppLocalizations.of(
                                                            context)!
                                                            .confirm,
                                                        style: TextStyle(
                                                            fontFamily: 'Inter',
                                                            fontSize: localHeight *
                                                                0.024,
                                                            color: const Color
                                                                .fromRGBO(
                                                                0, 106, 100, 1),
                                                            fontWeight: FontWeight
                                                                .w700),
                                                      ),
                                                    ]),
                                              ),
                                              content: Padding(
                                                padding: EdgeInsets.only(left: localHeight * 0.04,right: localHeight * 0.04),
                                                child: const Text(
                                                    "Are you sure you want to exit from this Assessment."),
                                              ),
                                              actions: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: localHeight * 0.04),
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:[
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                              backgroundColor:
                                                              const Color.fromRGBO(
                                                                  255, 255, 255, 1),
                                                              minimumSize: const Size(
                                                                  90, 30),
                                                              side: const BorderSide(
                                                                width: 1.5,
                                                                color: Color.fromRGBO(
                                                                    82, 165, 160, 1),

                                                              ),
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(17)))
                                                          ),
                                                          child: Text(
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .no,
                                                              style: TextStyle(
                                                                  fontFamily: 'Inter',
                                                                  fontSize:
                                                                  localHeight * 0.018,
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      82, 165, 160,
                                                                      1),
                                                                  fontWeight:
                                                                  FontWeight.w500)),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                        ),
                                                        SizedBox(width: localWidth * 0.05),
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                backgroundColor:
                                                                const Color.fromRGBO(
                                                                    82, 165, 160, 1),
                                                                minimumSize: const Size(
                                                                    90, 30),
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.all(
                                                                        Radius.circular(17)))
                                                            ),
                                                            child: Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .yes,
                                                                style: TextStyle(
                                                                    fontFamily: 'Inter',
                                                                    fontSize:
                                                                    localHeight *
                                                                        0.018,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight.w500)),
                                                            onPressed: () async {
                                                              Provider.of<Questions>(context, listen: false).updateAssessmentSubmit(true);
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return const Center(
                                                                        child:
                                                                        CircularProgressIndicator(
                                                                          color: Color
                                                                              .fromRGBO(
                                                                              48, 145,
                                                                              139, 1),
                                                                        ));
                                                                  });
                                                              // Navigator.pushNamed(
                                                              //     context,
                                                              //     '/studGuestAssessment',
                                                              //     arguments: widget.userName);
                                                              // Navigator.of(context)
                                                              //     .pop();
                                                              if(widget.isMember) {
                                                                SharedPreferences loginData = await SharedPreferences.getInstance();
                                                                UserDetails userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
                                                                UserDataModel userDataModel =
                                                                await QnaService
                                                                    .getUserDataService(userdata.userId,userdata);
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    '/studentAssessment',
                                                                    arguments: [userDataModel,null,userdata.email]);
                                                              }
                                                              else {
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    '/studGuestAssessment',
                                                                    arguments: widget.userName);
                                                              }
                                                            }
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                              ],
                                            ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                      ],
                    )),

                //   ],
                // ),
              ));
        }
        else if(constraints.maxWidth > 960) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  centerTitle: true,
                  title:    Text(
                    AppLocalizations.of(context)!.result_card,
                    //"MY ASSESSMENTS",
                    style: TextStyle(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: localHeight * 0.0225,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),


                ),
                body:
                widget.totalMarks == 0
                    ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: localHeight * 0.00500, left: localHeight * 0.1,right: localHeight * 0.1),
                      child: Column(
                        children: [
                          Text(
                            widget.organisationName,
                            style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: localHeight * 0.02),
                          ),
                          SizedBox(height: localHeight * 0.01),
                          SizedBox(
                            height: localHeight * 0.52,
                            width: localWidth * 1.5,
                            child: Card(
                              elevation: 12,
                              child: Column(children: [
                                SizedBox(height: localHeight * 0.005),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:[
                                      Text(
                                          "${widget.questions.data!.assessmentType}" == "practice"
                                              ? "Practice"
                                              : '',
                                          //"Practice",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(255, 153, 0, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.025)),
                                      SizedBox(width: localWidth * 0.02)
                                    ]
                                ),
                                Text(widget.userName,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: localHeight * 0.03)),
                                SizedBox(height: localHeight * 0.03),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                const SizedBox(height: 1.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left:localWidth * 0.06),
                                          child: Icon(Icons.timer,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                        ),
                                        SizedBox(width: localWidth * 0.008),
                                        SizedBox(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              //"10:26:59",
                                                widget.endTime.substring(0,7),
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.025)),
                                          ),
                                        ),],
                                    ),
                                    SizedBox(width:localWidth * 0.03),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.calendar_today_outlined,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                        SizedBox(width: localWidth * 0.008),
                                        Text(convertDateFromString(widget.date),
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: localHeight * 0.025)),],
                                    ),
                                    SizedBox(width:localWidth * 0.03),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                        SizedBox(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: localHeight * 0.06),
                                            child: Text(widget.time,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.025)),
                                          ),
                                        ),],
                                    ),
                                  ],
                                ),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: localWidth * 0.4),
                                            //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              width:localHeight * 0.15,
                                              child: Text(
                                                //"10:26:59",
                                                  "Assessment ID",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                            ),
                                            SizedBox(
                                              child: Text(widget.assessmentCode,
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          0, 106, 100, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: localHeight * 0.022)),
                                            ),],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: localWidth * 0.4),
                                            //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              width:localHeight * 0.15,
                                              child: Text(
                                                //"10:26:59",
                                                  "Degree",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                            ),
                                            SizedBox(
                                              child: Text(widget.assessmentHeaders.getAssessmentModelClass ?? " - ",
                                                  //widget.assessmentHeaders.getAssessmentModelClass != null ? "${widget.assessmentHeaders.getAssessmentModelClass}" : "",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(102, 102, 102, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: localHeight * 0.022)),
                                            ),],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: localWidth * 0.4),
                                            //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              width:localHeight * 0.15,
                                              child: Text(
                                                //"10:26:59",
                                                  "Semester",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                            ),
                                            Text(widget.assessmentHeaders.subTopic ?? " - ",
                                                //"${widget.assessmentHeaders.subTopic}",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.022)),],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: localWidth * 0.4),
                                            //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              width:localHeight * 0.15,
                                              child: Text(
                                                //"10:26:59",
                                                  "Subject",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                            ),
                                            Text(widget.assessmentHeaders.subject ?? " - ",
                                                //"${widget.assessmentHeaders.topic}",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.022)),],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: localWidth * 0.4),
                                            //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              width:localHeight * 0.15,
                                              child: Text(
                                                //"10:26:59",
                                                  "Topic",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                            ),
                                            Text(widget.assessmentHeaders.topic ?? " - ",
                                                //"${widget.assessmentHeaders.topic}",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.022)),],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Align(
                                    alignment: Alignment.center,
                                    child:Text("Thank You",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.027))
                                )
                              ]),
                            ),
                          ),
                          SizedBox(height:localHeight * 0.07),
                          Column(
                            children: [
                              //SizedBox(height: localHeight * 0.27),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "For incorrect answers",
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.018)),
                              ),
                              const SizedBox(height:0.5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MouseRegion(
                                      cursor: SystemMouseCursors
                                          .click,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                '/studMemAdvisor',
                                                arguments: [values,widget.assessmentCode]
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:25.0),
                                            child: Text(
                                                "View Advisor",
                                                style: Theme
                                                    .of(context)
                                                    .primaryTextTheme
                                                    .bodyLarge
                                                    ?.merge(TextStyle(
                                                    color: const Color
                                                        .fromRGBO(
                                                        48, 145, 139,
                                                        1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w500,
                                                    fontSize: localHeight *
                                                        0.023))),
                                          ))),
                                  IconButton(
                                    icon:
                                    Icon(
                                        size: localHeight * 0.03,
                                        //weight:localWidth * 0.5,
                                        Icons.chevron_right,
                                        color: const Color
                                            .fromRGBO(
                                            48, 145, 139,
                                            1)
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context,
                                          '/studMemAdvisor',
                                          arguments: [values,widget.assessmentCode]
                                      );
                                    },
                                  ),

                                ],
                              ),
                              // SizedBox(height: localHeight * 0.010),
                              // ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: const Color.fromRGBO(
                              //           255, 255, 255, 1),
                              //       minimumSize: const Size(280, 48),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(
                              //             39),
                              //       ),
                              //       side: const BorderSide(
                              //         width: 1.5,
                              //         color: Color.fromRGBO(
                              //             82, 165, 160, 1),
                              //       ),
                              //     ),
                              //     child: Text(
                              //         AppLocalizations.of(context)!
                              //             .advisor,
                              //         style: TextStyle(
                              //             fontFamily: 'Inter',
                              //             fontSize: localHeight * 0.022,
                              //             color: const Color.fromRGBO(
                              //                 82, 165, 160, 1),
                              //             fontWeight: FontWeight.w500)),
                              //     onPressed: () {
                              //       Navigator.pushNamed(
                              //           context,
                              //           '/studMemAdvisor',
                              //           arguments: [values,widget.assessmentCode]
                              //       );
                              //     }),
                              SizedBox(height: localHeight * 0.02),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                                  // minimumSize: Size(localWidth * 0.7, localHeight * 0.04),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        39),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      AppLocalizations.of(context)!.exit,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: localHeight * 0.027,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                          // insetPadding: EdgeInsets.only(
                                          //     left: localWidth * 0.13,
                                          //     right: localWidth * 0.13),
                                          title: Padding(
                                            padding: EdgeInsets.only(left: localHeight * 0.04),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                    ),
                                                    height: localHeight * 0.1,
                                                    width: localWidth * 0.1,
                                                    child: const Icon(
                                                      Icons
                                                          .info_outline_rounded,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ),
                                                  ),
                                                  SizedBox(width: localHeight *
                                                      0.018),
                                                  Text(
                                                    AppLocalizations.of(
                                                        context)!
                                                        .confirm,
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize: localHeight *
                                                            0.024,
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 106, 100, 1),
                                                        fontWeight: FontWeight
                                                            .w700),
                                                  ),
                                                ]),
                                          ),
                                          content: Padding(
                                            padding: EdgeInsets.only(left: localHeight * 0.04,right: localHeight * 0.04),
                                            child: const Text(
                                                "Are you sure you want to exit from this Assessment."),
                                          ),
                                          actions: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(bottom: localHeight * 0.04),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:[
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                          backgroundColor:
                                                          const Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          minimumSize: const Size(
                                                              90, 30),
                                                          side: const BorderSide(
                                                            width: 1.5,
                                                            color: Color.fromRGBO(
                                                                82, 165, 160, 1),
                                                          ),
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(17)))
                                                      ),
                                                      child: Text(
                                                          AppLocalizations.of(
                                                              context)!
                                                              .no,
                                                          style: TextStyle(
                                                              fontFamily: 'Inter',
                                                              fontSize:
                                                              localHeight * 0.018,
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  82, 165, 160,
                                                                  1),
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    SizedBox(width: localWidth * 0.05),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                            backgroundColor:
                                                            const Color.fromRGBO(
                                                                82, 165, 160, 1),
                                                            minimumSize: const Size(
                                                                90, 30),
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(17)))
                                                        ),
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .yes,
                                                            style: TextStyle(
                                                                fontFamily: 'Inter',
                                                                fontSize:
                                                                localHeight *
                                                                    0.018,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                FontWeight.w500)),
                                                        onPressed: () async {
                                                          Provider.of<Questions>(context, listen: false).updateAssessmentSubmit(false);
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return const Center(
                                                                    child:
                                                                    CircularProgressIndicator(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                          48, 145,
                                                                          139, 1),
                                                                    ));
                                                              });
                                                          // Navigator.pushNamed(
                                                          //     context,
                                                          //     '/studGuestAssessment',
                                                          //     arguments: widget.userName);
                                                          // Navigator.of(context)
                                                          //     .pop();
                                                          if(widget.isMember) {
                                                            SharedPreferences loginData = await SharedPreferences.getInstance();
                                                            UserDetails userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
                                                            UserDataModel userDataModel =
                                                            await QnaService
                                                                .getUserDataService(userdata.userId,userdata);
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/studentAssessment',
                                                                arguments: [userDataModel,null,userdata.email]);
                                                          }
                                                          else {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/studGuestAssessment',
                                                                arguments: widget.userName);
                                                          }
                                                        }
                                                    ),
                                                  ]
                                              ),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                )
                    : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: localHeight * 0.00500, left: localHeight * 0.1,right: localHeight * 0.1),
                      child: Column(
                        children: [
                          Text(
                            widget.organisationName,
                            style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: localHeight * 0.02),
                          ),
                          SizedBox(height: localHeight * 0.01),
                          SizedBox(
                            height: localHeight * 0.64,
                            width: localWidth * 1.5,
                            child: Card(
                              elevation: 12,
                              child: Column(children: [
                                SizedBox(height: localHeight * 0.005),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:[
                                      Text(
                                          "${widget.questions.data!.assessmentType}" == "practice"
                                              ? "Practice"
                                              : '',
                                          //"Practice",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(255, 153, 0, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.025)),
                                      SizedBox(width: localWidth * 0.02)
                                    ]
                                ),
                                Text(widget.userName,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: localHeight * 0.03)),
                                //const SizedBox(height: 25.0),
                                Text('${widget.totalMarks}/${widget.givenMark}',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 153, 0, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: localHeight * 0.096)),
                                const SizedBox(height:1.0),
                                Text(AppLocalizations.of(context)!.mark_scored,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.018)),
                                SizedBox(height: localHeight * 0.03),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                const SizedBox(height: 1.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left:localWidth * 0.06),
                                          child: Icon(Icons.timer,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                        ),
                                        SizedBox(width: localWidth * 0.008),
                                        SizedBox(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              //"10:26:59",
                                                widget.endTime.substring(0,7),
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.025)),
                                          ),
                                        ),],
                                    ),
                                    SizedBox(width:localWidth * 0.03),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.calendar_today_outlined,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                        SizedBox(width: localWidth * 0.008),
                                        Text(convertDateFromString(widget.date),
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: localHeight * 0.025)),],
                                    ),
                                    SizedBox(width:localWidth * 0.03),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                        SizedBox(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: localHeight * 0.06),
                                            child: Text(widget.time,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.025)),
                                          ),
                                        ),],
                                    ),
                                  ],
                                ),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: localWidth * 0.4),
                                            //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              width:localHeight * 0.15,
                                              child: Text(
                                                //"10:26:59",
                                                  "Assessment ID",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                            ),
                                            SizedBox(
                                              child: Text(widget.assessmentCode,
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          0, 106, 100, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: localHeight * 0.022)),
                                            ),],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: localWidth * 0.4),
                                            //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              width:localHeight * 0.15,
                                              child: Text(
                                                //"10:26:59",
                                                  "Degree",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                            ),
                                            SizedBox(
                                              child: Text(widget.assessmentHeaders.getAssessmentModelClass ?? " - ",
                                                  //widget.assessmentHeaders.getAssessmentModelClass != null ? "${widget.assessmentHeaders.getAssessmentModelClass}" : "",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(102, 102, 102, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: localHeight * 0.022)),
                                            ),],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: localWidth * 0.4),
                                            //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              width:localHeight * 0.15,
                                              child: Text(
                                                //"10:26:59",
                                                  "Semester",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                            ),
                                            Text(widget.assessmentHeaders.subTopic ?? " - ",
                                                //"${widget.assessmentHeaders.subTopic}",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.022)),],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: localWidth * 0.4),
                                            //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              width:localHeight * 0.15,
                                              child: Text(
                                                //"10:26:59",
                                                  "Subject",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                            ),
                                            Text(widget.assessmentHeaders.subject ?? " - ",
                                                //"${widget.assessmentHeaders.topic}",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.022)),],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: localWidth * 0.4),
                                            //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              width:localHeight * 0.15,
                                              child: Text(
                                                //"10:26:59",
                                                  "Topic",
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(161, 161, 161, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: localHeight * 0.016)),
                                            ),
                                            Text(widget.assessmentHeaders.topic ?? " - ",
                                                //"${widget.assessmentHeaders.topic}",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.022)),],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Divider(
                                    thickness: 0.1,
                                    indent: localWidth * 0.05,
                                    endIndent: localWidth * 0.04,
                                    color: Colors.black
                                ),
                                SizedBox(height: localHeight * 0.03),
                                Align(
                                    alignment: Alignment.center,
                                    child:Text("Thank You",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.027))
                                )
                              ]),
                            ),
                          ),
                          SizedBox(height:localHeight * 0.07),
                          Column(
                            children: [
                              //SizedBox(height: localHeight * 0.27),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "For incorrect answers",
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.018)),
                              ),
                              const SizedBox(height:0.5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MouseRegion(
                                      cursor: SystemMouseCursors
                                          .click,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                '/studMemAdvisor',
                                                arguments: [values,widget.assessmentCode]
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:25.0),
                                            child: Text(
                                                "View Advisor",
                                                style: Theme
                                                    .of(context)
                                                    .primaryTextTheme
                                                    .bodyLarge
                                                    ?.merge(TextStyle(
                                                    color: const Color
                                                        .fromRGBO(
                                                        48, 145, 139,
                                                        1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w500,
                                                    fontSize: localHeight *
                                                        0.023))),
                                          ))),
                                  IconButton(
                                    icon:
                                    Icon(
                                        size: localHeight * 0.03,
                                        //weight:localWidth * 0.5,
                                        Icons.chevron_right,
                                        color: const Color
                                            .fromRGBO(
                                            48, 145, 139,
                                            1)
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context,
                                          '/studMemAdvisor',
                                          arguments: [values,widget.assessmentCode]
                                      );
                                    },
                                  ),

                                ],
                              ),
                              // SizedBox(height: localHeight * 0.010),
                              // ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: const Color.fromRGBO(
                              //           255, 255, 255, 1),
                              //       minimumSize: const Size(280, 48),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(
                              //             39),
                              //       ),
                              //       side: const BorderSide(
                              //         width: 1.5,
                              //         color: Color.fromRGBO(
                              //             82, 165, 160, 1),
                              //       ),
                              //     ),
                              //     child: Text(
                              //         AppLocalizations.of(context)!
                              //             .advisor,
                              //         style: TextStyle(
                              //             fontFamily: 'Inter',
                              //             fontSize: localHeight * 0.022,
                              //             color: const Color.fromRGBO(
                              //                 82, 165, 160, 1),
                              //             fontWeight: FontWeight.w500)),
                              //     onPressed: () {
                              //       Navigator.pushNamed(
                              //           context,
                              //           '/studMemAdvisor',
                              //           arguments: [values,widget.assessmentCode]
                              //       );
                              //     }),
                              SizedBox(height: localHeight * 0.05),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                                  // minimumSize: Size(localWidth * 0.7, localHeight * 0.04),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        39),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      AppLocalizations.of(context)!.exit,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: localHeight * 0.027,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                          // insetPadding: EdgeInsets.only(
                                          //     left: localWidth * 0.13,
                                          //     right: localWidth * 0.13),
                                          title: Padding(
                                            padding: EdgeInsets.only(left: localHeight * 0.04),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                    ),
                                                    height: localHeight * 0.1,
                                                    width: localWidth * 0.1,
                                                    child: const Icon(
                                                      Icons
                                                          .info_outline_rounded,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ),
                                                  ),
                                                  SizedBox(width: localHeight *
                                                      0.018),
                                                  Text(
                                                    AppLocalizations.of(
                                                        context)!
                                                        .confirm,
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize: localHeight *
                                                            0.024,
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 106, 100, 1),
                                                        fontWeight: FontWeight
                                                            .w700),
                                                  ),
                                                ]),
                                          ),
                                          content: Padding(
                                            padding: EdgeInsets.only(left: localHeight * 0.04,right: localHeight * 0.04),
                                            child: const Text(
                                                "Are you sure you want to exit from this Assessment."),
                                          ),
                                          actions: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(bottom: localHeight * 0.04),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:[
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                          backgroundColor:
                                                          const Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          minimumSize: const Size(
                                                              90, 30),
                                                          side: const BorderSide(
                                                            width: 1.5,
                                                            color: Color.fromRGBO(
                                                                82, 165, 160, 1),
                                                          ),
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(17)))
                                                      ),
                                                      child: Text(
                                                          AppLocalizations.of(
                                                              context)!
                                                              .no,
                                                          style: TextStyle(
                                                              fontFamily: 'Inter',
                                                              fontSize:
                                                              localHeight * 0.018,
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  82, 165, 160,
                                                                  1),
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    SizedBox(width: localWidth * 0.05),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                            backgroundColor:
                                                            const Color.fromRGBO(
                                                                82, 165, 160, 1),
                                                            minimumSize: const Size(
                                                                90, 30),
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(17)))
                                                        ),
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .yes,
                                                            style: TextStyle(
                                                                fontFamily: 'Inter',
                                                                fontSize:
                                                                localHeight *
                                                                    0.018,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                FontWeight.w500)),
                                                        onPressed: () async {
                                                          Provider.of<Questions>(context, listen: false).updateAssessmentSubmit(true);
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return const Center(
                                                                    child:
                                                                    CircularProgressIndicator(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                          48, 145,
                                                                          139, 1),
                                                                    ));
                                                              });
                                                          // Navigator.pushNamed(
                                                          //     context,
                                                          //     '/studGuestAssessment',
                                                          //     arguments: widget.userName);
                                                          // Navigator.of(context)
                                                          //     .pop();
                                                          if(widget.isMember) {
                                                            SharedPreferences loginData = await SharedPreferences.getInstance();
                                                            UserDetails userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
                                                            UserDataModel userDataModel =
                                                            await QnaService
                                                                .getUserDataService(userdata.userId,userdata);
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/studentAssessment',
                                                                arguments: [userDataModel,null,userdata.email]);
                                                          }
                                                          else {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/studGuestAssessment',
                                                                arguments: widget.userName);
                                                          }
                                                        }
                                                    ),
                                                  ]
                                              ),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),

                //   ],
                // ),
              ));
        }
        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    iconTheme: IconThemeData(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        size: localHeight * 0.05
                    ),
                    elevation: 0,
                    centerTitle: true,
                    title:    Text(
                      AppLocalizations.of(context)!.result_card,
                      //"MY ASSESSMENTS",
                      style: TextStyle(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontSize: localHeight * 0.0225,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  ),
                  body:
                  widget.totalMarks == 0
                      ? Container(
                      padding:EdgeInsets.only(left: localWidth * 0.025,right: localWidth * 0.025),
                      child:
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: localHeight * 0.0050),
                            child: Column(
                              children: [
                                Text(
                                  widget.organisationName,
                                  style: TextStyle(
                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: localHeight * 0.02),
                                ),
                                SizedBox(height: localHeight * 0.1),
                                SizedBox(
                                  height: localHeight * 0.45,
                                  width: localWidth * 1.5,
                                  child: Card(
                                    elevation: 12,
                                    child: Column(children: [
                                      SizedBox(height: localHeight * 0.005),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children:[
                                            Text(
                                                "${widget.questions.data!.assessmentType}" == "practice"
                                                    ? "Practice"
                                                    : '',
                                                //"Practice",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(255, 153, 0, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: localHeight * 0.025)),
                                            SizedBox(width: localWidth * 0.02)
                                          ]
                                      ),
                                      Text(widget.userName,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.03)),
                                      Divider(
                                          thickness: 0.1,
                                          indent: localWidth * 0.05,
                                          endIndent: localWidth * 0.04,
                                          color: Colors.black
                                      ),
                                      const SizedBox(height: 1.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left:localWidth * 0.06),
                                                child: Icon(Icons.timer,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              ),
                                              SizedBox(width:localWidth * 0.02),
                                              SizedBox(
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    //"10:26:59",
                                                      widget.endTime.substring(0,7),
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.025)),
                                                ),
                                              ),],
                                          ),
                                          SizedBox(width:localWidth * 0.02),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.calendar_today_outlined,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              SizedBox(width:localWidth * 0.02),
                                              Text(convertDateFromString(widget.date),
                                                  style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: localHeight * 0.025)),],
                                          ),
                                          SizedBox(width:localWidth * 0.02),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                              SizedBox(
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: localHeight * 0.06),
                                                  child: Text(widget.time,
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.025)),
                                                ),
                                              ),],
                                          ),
                                        ],
                                      ),
                                      Divider(
                                          thickness: 0.1,
                                          indent: localWidth * 0.05,
                                          endIndent: localWidth * 0.04,
                                          color: Colors.black
                                      ),
                                      SizedBox(height: localHeight * 0.03),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(width: localWidth * 0.3),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Assessment ID",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  SizedBox(
                                                    child: Text(widget.assessmentCode,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                0, 106, 100, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: localHeight * 0.022)),
                                                  ),],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: localWidth * 0.3),
                                                  // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Degree",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  SizedBox(
                                                    child: Text(widget.assessmentHeaders.getAssessmentModelClass ?? " - ",
                                                        //widget.assessmentHeaders.getAssessmentModelClass != null ? "${widget.assessmentHeaders.getAssessmentModelClass}" : "",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: localHeight * 0.022)),
                                                  ),],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: localWidth * 0.3),
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Semester",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  Text(widget.assessmentHeaders.subTopic ?? " - ",
                                                      //"${widget.assessmentHeaders.subTopic}",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.022)),],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: localWidth * 0.3),
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Subject",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  Text(widget.assessmentHeaders.subject ?? " - ",
                                                      //"${widget.assessmentHeaders.topic}",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.022)),],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: localWidth * 0.3),
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Topic",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  Text(widget.assessmentHeaders.topic ?? " - ",
                                                      //"${widget.assessmentHeaders.topic}",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.022)),],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: localHeight * 0.03),
                                      Divider(
                                          thickness: 0.1,
                                          indent: localWidth * 0.05,
                                          endIndent: localWidth * 0.04,
                                          color: Colors.black
                                      ),
                                      SizedBox(height: localHeight * 0.03),
                                      Align(
                                          alignment: Alignment.center,
                                          child:Text("Thank You",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: localHeight * 0.027))
                                      )
                                    ]),
                                  ),
                                ),
                                SizedBox(height:localHeight * 0.07),
                                Column(
                                  children: [
                                    //SizedBox(height: localHeight * 0.27),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                          "For incorrect answers",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: localHeight * 0.018)),
                                    ),
                                    const SizedBox(height:0.5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        MouseRegion(
                                            cursor: SystemMouseCursors
                                                .click,
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      '/studMemAdvisor',
                                                      arguments: [values,widget.assessmentCode]
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left:25.0),
                                                  child: Text(
                                                      "View Advisor",
                                                      style: Theme
                                                          .of(context)
                                                          .primaryTextTheme
                                                          .bodyLarge
                                                          ?.merge(TextStyle(
                                                          color: const Color
                                                              .fromRGBO(
                                                              48, 145, 139,
                                                              1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          fontSize: localHeight *
                                                              0.023))),
                                                ))),
                                        IconButton(
                                          icon:
                                          Icon(
                                              size: localWidth * 0.040,
                                              weight:localWidth * 0.5,
                                              Icons.chevron_right,
                                              color: const Color
                                                  .fromRGBO(
                                                  48, 145, 139,
                                                  1)
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context,
                                                '/studMemAdvisor',
                                                arguments: [values,widget.assessmentCode]
                                            );
                                          },
                                        ),

                                      ],
                                    ),
                                    // SizedBox(height: localHeight * 0.010),
                                    // ElevatedButton(
                                    //     style: ElevatedButton.styleFrom(
                                    //       backgroundColor: const Color.fromRGBO(
                                    //           255, 255, 255, 1),
                                    //       minimumSize: const Size(280, 48),
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(
                                    //             39),
                                    //       ),
                                    //       side: const BorderSide(
                                    //         width: 1.5,
                                    //         color: Color.fromRGBO(
                                    //             82, 165, 160, 1),
                                    //       ),
                                    //     ),
                                    //     child: Text(
                                    //         AppLocalizations.of(context)!
                                    //             .advisor,
                                    //         style: TextStyle(
                                    //             fontFamily: 'Inter',
                                    //             fontSize: localHeight * 0.022,
                                    //             color: const Color.fromRGBO(
                                    //                 82, 165, 160, 1),
                                    //             fontWeight: FontWeight.w500)),
                                    //     onPressed: () {
                                    //       Navigator.pushNamed(
                                    //           context,
                                    //           '/studMemAdvisor',
                                    //           arguments: [values,widget.assessmentCode]
                                    //       );
                                    //     }),
                                    SizedBox(height: localHeight * 0.05),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        const Color.fromRGBO(82, 165, 160, 1),
                                        // minimumSize: Size(localWidth * 0.7, localHeight * 0.04),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              39),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            AppLocalizations.of(context)!.exit,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: localHeight * 0.027,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AlertDialog(
                                                // insetPadding: EdgeInsets.only(
                                                //     left: localWidth * 0.13,
                                                //     right: localWidth * 0.13),
                                                title: Padding(
                                                  padding: EdgeInsets.only(left: localHeight * 0.04),
                                                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Color.fromRGBO(
                                                                82, 165, 160, 1),
                                                          ),
                                                          height: localHeight * 0.1,
                                                          width: localWidth * 0.1,
                                                          child: const Icon(
                                                            Icons
                                                                .info_outline_rounded,
                                                            color: Color.fromRGBO(
                                                                255, 255, 255, 1),
                                                          ),
                                                        ),
                                                        SizedBox(width: localHeight *
                                                            0.018),
                                                        Text(
                                                          AppLocalizations.of(
                                                              context)!
                                                              .confirm,
                                                          style: TextStyle(
                                                              fontFamily: 'Inter',
                                                              fontSize: localHeight *
                                                                  0.024,
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  0, 106, 100, 1),
                                                              fontWeight: FontWeight
                                                                  .w700),
                                                        ),
                                                      ]),
                                                ),
                                                content: Padding(
                                                  padding: EdgeInsets.only(left: localHeight * 0.04,right: localHeight * 0.04),
                                                  child: const Text(
                                                      "Are you sure you want to exit from this Assessment."),
                                                ),
                                                actions: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(bottom: localHeight * 0.04),
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children:[
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                backgroundColor:
                                                                const Color.fromRGBO(
                                                                    255, 255, 255, 1),
                                                                minimumSize: const Size(
                                                                    90, 30),
                                                                side: const BorderSide(
                                                                  width: 1.5,
                                                                  color: Color.fromRGBO(
                                                                      82, 165, 160, 1),

                                                                ),
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.all(
                                                                        Radius.circular(17)))
                                                            ),
                                                            child: Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .no,
                                                                style: TextStyle(
                                                                    fontFamily: 'Inter',
                                                                    fontSize:
                                                                    localHeight * 0.018,
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        82, 165, 160,
                                                                        1),
                                                                    fontWeight:
                                                                    FontWeight.w500)),
                                                            onPressed: () {
                                                              Navigator.of(context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          SizedBox(width: localWidth * 0.05),
                                                          ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                  backgroundColor:
                                                                  const Color.fromRGBO(
                                                                      82, 165, 160, 1),
                                                                  minimumSize: const Size(
                                                                      90, 30),
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.all(
                                                                          Radius.circular(17)))
                                                              ),
                                                              child: Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .yes,
                                                                  style: TextStyle(
                                                                      fontFamily: 'Inter',
                                                                      fontSize:
                                                                      localHeight *
                                                                          0.018,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                      FontWeight.w500)),
                                                              onPressed: () async {
                                                                Provider.of<Questions>(context, listen: false).updateAssessmentSubmit(false);
                                                                showDialog(
                                                                    context: context,
                                                                    builder: (context) {
                                                                      return const Center(
                                                                          child:
                                                                          CircularProgressIndicator(
                                                                            color: Color
                                                                                .fromRGBO(
                                                                                48, 145,
                                                                                139, 1),
                                                                          ));
                                                                    });
                                                                // Navigator.pushNamed(
                                                                //     context,
                                                                //     '/studGuestAssessment',
                                                                //     arguments: widget.userName);
                                                                // Navigator.of(context)
                                                                //     .pop();
                                                                if(widget.isMember) {
                                                                  SharedPreferences loginData = await SharedPreferences.getInstance();
                                                                  UserDetails userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
                                                                  UserDataModel userDataModel =
                                                                  await QnaService
                                                                      .getUserDataService(userdata.userId,userdata);
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      '/studentAssessment',
                                                                      arguments: [userDataModel,null,userdata.email]);
                                                                }
                                                                else {
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      '/studGuestAssessment',
                                                                      arguments: widget.userName);
                                                                }
                                                              }
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                        ],
                      ))
                      :
                  Container(
                    padding:EdgeInsets.only(left: localWidth * 0.025,right: localWidth * 0.025),
                    child:
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: localHeight * 0.0050),
                          child: Column(
                            children: [
                              Text(
                                widget.organisationName,
                                style: TextStyle(
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: localHeight * 0.02),
                              ),
                              SizedBox(height: localHeight * 0.01),
                              SizedBox(
                                height: localHeight * 0.58,
                                width: localWidth * 1.5,
                                child: Card(
                                  elevation: 12,
                                  child: Column(children: [
                                    SizedBox(height: localHeight * 0.005),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children:[
                                          Text(
                                              "${widget.questions.data!.assessmentType}" == "practice"
                                                  ? "Practice"
                                                  : '',
                                              //"Practice",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(255, 153, 0, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: localHeight * 0.025)),
                                          SizedBox(width: localWidth * 0.02)
                                        ]
                                    ),
                                    SizedBox(height: localHeight * 0.005),
                                    Text(widget.userName,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.03)),
                                    //const SizedBox(height: 25.0),
                                    Text('${widget.totalMarks}/${widget.givenMark}',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                255, 153, 0, 1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: localHeight * 0.096)),
                                    SizedBox(height: localHeight * 0.01),
                                    Text(AppLocalizations.of(context)!.mark_scored,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.018)),
                                    SizedBox(height: localHeight * 0.01),
                                    Divider(
                                        thickness: 0.1,
                                        indent: localWidth * 0.05,
                                        endIndent: localWidth * 0.04,
                                        color: Colors.black
                                    ),
                                    const SizedBox(height: 1.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.timer,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            const SizedBox(width:2),
                                            SizedBox(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  //"10:26:59",
                                                    widget.endTime.substring(0,7),
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.025)),
                                              ),
                                            ),],
                                        ),
                                        const SizedBox(width:3),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.calendar_today_outlined,color:const Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            const SizedBox(width:2),
                                            Text(convertDateFromString(widget.date),
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: localHeight * 0.025)),],
                                        ),
                                        const SizedBox(width:3),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                            SizedBox(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(widget.time,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: localHeight * 0.025)),
                                              ),
                                            ),],
                                        ),
                                      ],
                                    ),
                                    Divider(
                                        thickness: 0.1,
                                        indent: localWidth * 0.05,
                                        endIndent: localWidth * 0.04,
                                        color: Colors.black
                                    ),
                                    SizedBox(height: localHeight * 0.01),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: localHeight * 0.05),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Assessment ID",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  Text(widget.assessmentCode,
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              0, 106, 100, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.022)),],
                                              ),
                                              Row(
                                                children: [
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Degree",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  Text(widget.assessmentHeaders.getAssessmentModelClass ?? " - ",
                                                      //widget.assessmentHeaders.getAssessmentModelClass != null ? "${widget.assessmentHeaders.getAssessmentModelClass}" : "",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.022)),],
                                              ),
                                              Row(
                                                children: [
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Semester",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  Text(widget.assessmentHeaders.subTopic ?? " - ",
                                                      //"${widget.assessmentHeaders.getAssessmentModelClass}",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.022)),],
                                              ),
                                              Row(
                                                children: [
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Subject",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  Text(widget.assessmentHeaders.subject ?? " - ",
                                                      //"${widget.assessmentHeaders.topic}",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.022)),],
                                              ),
                                              Row(
                                                children: [
                                                  //Icon(Icons.calendar_today_outlined,color:Color.fromRGBO(82, 165, 160, 1),size: localHeight *0.03,),
                                                  SizedBox(
                                                    width:localHeight * 0.15,
                                                    child: Text(
                                                      //"10:26:59",
                                                        "Topic",
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(161, 161, 161, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.016)),
                                                  ),
                                                  Text(widget.assessmentHeaders.topic ?? " - ",
                                                      //"${widget.assessmentHeaders.topic}",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: localHeight * 0.022)),],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: localHeight * 0.01),
                                    Divider(
                                        thickness: 0.1,
                                        indent: localWidth * 0.05,
                                        endIndent: localWidth * 0.04,
                                        color: Colors.black
                                    ),
                                    SizedBox(height: localHeight * 0.01),
                                    Align(
                                        alignment: Alignment.center,
                                        child:Text("Thank You",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(82, 165, 160, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.027))
                                    )
                                  ]),
                                ),
                              ),
                              SizedBox(height: localHeight * 0.01),
                              Column(
                                children: [
                                  //SizedBox(height: localHeight * 0.27),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                        "For incorrect answers",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: localHeight * 0.018)),
                                  ),
                                  const SizedBox(height:0.5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      MouseRegion(
                                          cursor: SystemMouseCursors
                                              .click,
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    '/studMemAdvisor',
                                                    arguments: [values,widget.assessmentCode]
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(left:25.0),
                                                child: Text(
                                                    "View Advisor",
                                                    style: Theme
                                                        .of(context)
                                                        .primaryTextTheme
                                                        .bodyLarge
                                                        ?.merge(TextStyle(
                                                        color: const Color
                                                            .fromRGBO(
                                                            48, 145, 139,
                                                            1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: localHeight *
                                                            0.023))),
                                              ))),
                                      const SizedBox(width:0.0),
                                      IconButton(
                                        icon: const
                                        Icon(
                                            Icons.chevron_right,
                                            color: Color
                                                .fromRGBO(
                                                48, 145, 139,
                                                1)
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              '/studMemAdvisor',
                                              arguments: [values,widget.assessmentCode]
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color.fromRGBO(82, 165, 160, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            39),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                          AppLocalizations.of(context)!.exit,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: localHeight * 0.027,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            AlertDialog(
                                              title: Padding(
                                                padding: EdgeInsets.only(left: localHeight * 0.04),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        decoration: const BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Color.fromRGBO(
                                                              82, 165, 160, 1),
                                                        ),
                                                        height: localHeight * 0.1,
                                                        width: localWidth * 0.1,
                                                        child: const Icon(
                                                          Icons
                                                              .info_outline_rounded,
                                                          color: Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                        ),
                                                      ),
                                                      SizedBox(width: localHeight *
                                                          0.018),
                                                      Text(
                                                        AppLocalizations.of(
                                                            context)!
                                                            .confirm,
                                                        style: TextStyle(
                                                            fontFamily: 'Inter',
                                                            fontSize: localHeight *
                                                                0.024,
                                                            color: const Color
                                                                .fromRGBO(
                                                                0, 106, 100, 1),
                                                            fontWeight: FontWeight
                                                                .w700),
                                                      ),
                                                    ]),
                                              ),
                                              content: Padding(
                                                padding: EdgeInsets.only(left: localHeight * 0.04,right: localHeight * 0.04),
                                                child: const Text(
                                                    "Are you sure you want to exit from this Assessment."),
                                              ),
                                              actions: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: localHeight * 0.04),
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:[
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                              backgroundColor:
                                                              const Color.fromRGBO(
                                                                  255, 255, 255, 1),
                                                              minimumSize: const Size(
                                                                  90, 30),
                                                              side: const BorderSide(
                                                                width: 1.5,
                                                                color: Color.fromRGBO(
                                                                    82, 165, 160, 1),
                                                              ),
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(17)))
                                                          ),
                                                          child: Text(
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .no,
                                                              style: TextStyle(
                                                                  fontFamily: 'Inter',
                                                                  fontSize:
                                                                  localHeight * 0.018,
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      82, 165, 160,
                                                                      1),
                                                                  fontWeight:
                                                                  FontWeight.w500)),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                        ),
                                                        SizedBox(width: localWidth * 0.05),
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                backgroundColor:
                                                                const Color.fromRGBO(
                                                                    82, 165, 160, 1),
                                                                minimumSize: const Size(
                                                                    90, 30),
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.all(
                                                                        Radius.circular(17)))
                                                            ),
                                                            child: Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .yes,
                                                                style: TextStyle(
                                                                    fontFamily: 'Inter',
                                                                    fontSize:
                                                                    localHeight *
                                                                        0.018,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight.w500)),
                                                            onPressed: () async {
                                                              Provider.of<Questions>(context, listen: false).updateAssessmentSubmit(true);
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return const Center(
                                                                        child:
                                                                        CircularProgressIndicator(
                                                                          color: Color
                                                                              .fromRGBO(
                                                                              48, 145,
                                                                              139, 1),
                                                                        ));
                                                                  });
                                                              // Navigator.pushNamed(
                                                              //     context,
                                                              //     '/studGuestAssessment',
                                                              //     arguments: widget.userName);
                                                              // Navigator.of(context)
                                                              //     .pop();
                                                              if(widget.isMember) {
                                                                SharedPreferences loginData = await SharedPreferences.getInstance();
                                                                UserDetails userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
                                                                UserDataModel userDataModel =
                                                                await QnaService
                                                                    .getUserDataService(userdata.userId,userdata);
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    '/studentAssessment',
                                                                    arguments: [userDataModel,null,userdata.email]);
                                                              }
                                                              else {
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    '/studGuestAssessment',
                                                                    arguments: widget.userName);
                                                              }
                                                            }
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                              ],
                                            ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: localHeight * 0.01),
                                ],
                              )
                            ],
                          ),
                        ),

                      ],
                    ),

                    //   ],
                    // ),
                  )));
        }
      },
    );
  }
}