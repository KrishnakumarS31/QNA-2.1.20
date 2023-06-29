import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Components/custom_result_submit_card.dart';
import 'package:qna_test/Pages/teacher_result_individual_student.dart';
import '../Components/custom_card.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Components/today_date.dart';
import '../EntityModel/get_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TeacherResultSubmitted extends StatefulWidget {
  TeacherResultSubmitted({
    Key? key,
    required this.result,
    this.advisorName,
    this.userId,
    this.submittedArray,
    this.advisorEmail
  }) : super(key: key);
  final GetResultModel result;
  final int? userId;
  final String? advisorName;
  final String? advisorEmail;
  List<AssessmentResults>? submittedArray;

  @override
  TeacherResultSubmittedState createState() => TeacherResultSubmittedState();
}

class TeacherResultSubmittedState extends State<TeacherResultSubmitted> {
  IconData showIcon = Icons.expand_circle_down_outlined;
  int resultStart=0;
  int pageLimit = 1;
  int resultLength=0;

  @override
  void initState() {
    resultLength = widget.submittedArray!.length >=10 ? 10: widget.submittedArray!.length;
    super.initState();
  }

  changeIcon(IconData pramIcon) {
    if (pramIcon == Icons.expand_circle_down_outlined) {
      setState(() {
        showIcon = Icons.arrow_circle_up_outlined;
      });
    } else {
      setState(() {
        showIcon = Icons.expand_circle_down_outlined;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int? assessmentStartDate = widget.result.assessmentStartDate;
    int? assessmentEndDate = widget.result.assessmentEndDate;
    int? assessmentDuration = widget.result.assessmentDuration;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 960) {
        return
          Center(
            child: SizedBox(
            child:  WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                endDrawer: const EndDrawerMenuTeacher(),
                appBar: AppBar(
                  iconTheme: IconThemeData(color: const Color.fromRGBO(28, 78, 80, 1),size: height * 0.05),
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
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context)!.assessment_result,
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
                    padding: EdgeInsets.only(bottom: height * 0.005, left: height * 0.5,right: height * 0.5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                            child: CustomCard(
                              height: height,
                              width: width,
                              //subject: results[index].subject,
                              result: widget.result,
                              isShowTotal: true,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.018,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              showIcon == Icons.expand_circle_down_outlined
                                  ? Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromRGBO(153, 153, 153, 0.25),),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)
                                      )),
                                  // height: height * 0.31,
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          AppLocalizations.of(context)!.assessment_details,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(102, 102, 102, 1),
                                              fontSize: height * 0.022,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          showIcon,
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          size: height * 0.04,
                                        ),
                                        onPressed: () {
                                          changeIcon(showIcon);
                                        },
                                      ),
                                    ],
                                  ))
                                  : Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          233, 233, 233, 1),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                // height: height * 0.7812,
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color.fromRGBO(153, 153, 153, 0.25),),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(5)
                                            )),
                                        // height: height * 0.31,
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                AppLocalizations.of(context)!.assessment_details,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                showIcon,
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                size: height * 0.04,
                                              ),
                                              onPressed: () {
                                                changeIcon(showIcon);
                                              },
                                            ),
                                          ],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.time_limit,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            assessmentDuration != null
                                                ? convertDuration(
                                                assessmentDuration)
                                                : "0",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.start_date_time,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            assessmentStartDate != null
                                                ? '${convertDate(
                                                assessmentStartDate)}, ${convertTime(
                                                assessmentStartDate)} IST'
                                                : " ",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.end_date_time,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            assessmentEndDate != null
                                                ? '${convertDate(
                                                assessmentEndDate)}, ${convertTime(
                                                assessmentEndDate)} IST'
                                                : " ",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.category}: ",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            " ${widget.result.assessmentType}",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.number_of_attempts,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.result.totalAttempts != null ? "${widget.result.totalAttempts} " : "0",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.guest_students,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.result.guestStudentAllowed == true
                                                ? AppLocalizations.of(
                                                context)!.allowed
                                            //"Allowed"
                                                : AppLocalizations.of(
                                                context)!.not_allowed,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.answer_in_practice,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Text(
                                            "-",
                                            style: TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.published_looq,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Text(
                                            "-",
                                            style: TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.advisor_name,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.advisorName ?? "",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.advisor_email,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.advisorEmail??"",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.whatsapp_link,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.result.url ?? "" ,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .completed_parti_list,
                                    //'Total Participants List (${widget.submittedArray!.length})',
                                    style: TextStyle(
                                        fontSize: height * 0.0187,
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(onPressed: (){}, icon: Icon(Icons.mail_outline,color: const Color.fromRGBO(
                                        82, 165, 160, 1),
                                      size: height * 0.04,), ),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.print_outlined,color: const Color.fromRGBO(
                                        82, 165, 160, 1),
                                      size: height * 0.04,), )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right :8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .tap_to_student_details,
                                //'Tap on respective student for details',
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    color: const Color.fromRGBO(148, 148, 148, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          for (int index=resultStart;index<resultLength;index++)
                            Column(
                              children: [
                                MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .rightToLeft,
                                            child: TeacherResultIndividualStudent(
                                              result: widget.result,
                                              comingFrom: "submit",
                                              index: index,),
                                          ),
                                        );
                                      },
                                      child: ResultSubmitCard(
                                          height: height,
                                          width: width,
                                          submittedArray: widget
                                              .submittedArray,
                                          results: widget.result,
                                          index: index
                                      ),
                                    )),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Showing ${resultStart + 1} to ${resultStart+10 <widget.submittedArray!.length ? resultStart+10:resultLength} of ${widget.submittedArray?.length ?? 0}',
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
                                          if(resultLength>10){
                                            setState(() {
                                              resultLength=widget.submittedArray!.length-resultStart < 10 ? 10 :resultLength - 10;
                                              resultStart=resultStart-10;
                                            });}
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
                                          if(resultLength<widget.submittedArray!.length){
                                            setState(() {
                                              resultLength=widget.submittedArray!.length-resultStart > 0 ?widget.submittedArray!.length-resultStart :resultLength;
                                              resultStart=resultStart+10;
                                            });
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
                          SizedBox(
                            height: height * 0.02,
                          ),
                        ]),
                  ),
                )))));
      }
      else
      {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                endDrawer: const EndDrawerMenuTeacher(),
                appBar: AppBar(
                  iconTheme: IconThemeData(color: const Color.fromRGBO(28, 78, 80, 1),size: height * 0.05),
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
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context)!.assessment_result,
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
                        left: height * 0.023,
                        right: height * 0.023),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                            child: CustomCard(
                              height: height,
                              width: width,
                              //subject: results[index].subject,
                              result: widget.result,
                              isShowTotal: true,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.018,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              showIcon == Icons.expand_circle_down_outlined
                                  ? Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromRGBO(153, 153, 153, 0.25),),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)
                                      )),
                                  // height: height * 0.31,
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          AppLocalizations.of(context)!.assessment_details,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(102, 102, 102, 1),
                                              fontSize: height * 0.022,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          showIcon,
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          size: height * 0.04,
                                        ),
                                        onPressed: () {
                                          changeIcon(showIcon);
                                        },
                                      ),
                                    ],
                                  ))
                                  : Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          233, 233, 233, 1),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                // height: height * 0.4812,
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color.fromRGBO(153, 153, 153, 0.25),),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(5)
                                            )),
                                        // height: height * 0.31,
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                AppLocalizations.of(context)!.assessment_details,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                showIcon,
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                size: height * 0.04,
                                              ),
                                              onPressed: () {
                                                changeIcon(showIcon);
                                              },
                                            ),
                                          ],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.time_limit,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            assessmentDuration != null
                                                ? convertDuration(
                                                assessmentDuration)
                                                : "0",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.start_date_time,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            assessmentStartDate != null
                                                ? '${convertDate(
                                                assessmentStartDate)}, ${convertTime(
                                                assessmentStartDate)} IST'
                                                : " ",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.end_date_time,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            assessmentEndDate != null
                                                ? '${convertDate(
                                                assessmentEndDate)}, ${convertTime(
                                                assessmentEndDate)} IST'
                                                : " ",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.category}: ",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            " ${widget.result.assessmentType}",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.number_of_attempts,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.result.totalAttempts != null ? "${widget.result.totalAttempts} " : "0",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.guest_students,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.result.guestStudentAllowed == true
                                                ? AppLocalizations.of(
                                                context)!.allowed
                                            //"Allowed"
                                                : AppLocalizations.of(
                                                context)!.not_allowed,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.answer_in_practice,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Text(
                                            "-",
                                            style: TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.published_looq,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Text(
                                            "-",
                                            style: TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.advisor_name,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.advisorName ?? "",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.advisor_email,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.advisorEmail??"",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.whatsapp_link,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.result.url ?? "" ,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(102, 102, 102, 1),
                                                // fontSize: widget.height * 0.013,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .completed_parti_list,
                                    //'Total Participants List (${widget.submittedArray!.length})',
                                    style: TextStyle(
                                        fontSize: height * 0.0187,
                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Row(
                                children: [
                                  IconButton(onPressed: (){}, icon: Icon(Icons.mail_outline,color: const Color.fromRGBO(
                                      82, 165, 160, 1),
                                    size: height * 0.04,), ),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.print_outlined,color: const Color.fromRGBO(
                                      82, 165, 160, 1),
                                    size: height * 0.04,), )
                                ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right :8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .tap_to_student_details,
                                //'Tap on respective student for details',
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    color: const Color.fromRGBO(148, 148, 148, 1),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          for (int index=resultStart;index<resultLength;index++)
                            Column(
                              children: [
                                MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .rightToLeft,
                                            child: TeacherResultIndividualStudent(
                                              result: widget.result,
                                              comingFrom: "submit",
                                              index: index),
                                          ),
                                        );
                                      },
                                      child: ResultSubmitCard(
                                          height: height,
                                          width: width,
                                          submittedArray: widget
                                              .submittedArray,
                                          results: widget.result,
                                          index: index
                                      ),
                                    )),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Showing ${resultStart + 1} to ${resultStart+10 <widget.submittedArray!.length ? resultStart+10:resultLength} of ${widget.submittedArray?.length ?? 0}',
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
                                          if(resultLength>10){
                                            setState(() {
                                              resultLength=widget.submittedArray!.length-resultStart < 10 ? 10 :resultLength - 10;
                                              resultStart=resultStart-10;
                                            });}
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
                                          if(resultLength<widget.submittedArray!.length){
                                            setState(() {
                                              resultLength=widget.submittedArray!.length-resultStart > 0 ?widget.submittedArray!.length-resultStart :resultLength;
                                              resultStart=resultStart+10;
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
                          SizedBox(
                            height: height * 0.02,
                          ),
                        ]),

                  ),
                )));
      }
    }
    );}
}
