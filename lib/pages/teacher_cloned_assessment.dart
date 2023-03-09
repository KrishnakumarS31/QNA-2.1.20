import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher_cloned_assessment_preview.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Providers/edit_assessment_provider.dart';
import '../EntityModel/get_assessment_model.dart' as assessment_model;
class TeacherClonedAssessment extends StatefulWidget {
  const TeacherClonedAssessment({
    Key? key,
    required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

  @override
  TeacherClonedAssessmentState createState() => TeacherClonedAssessmentState();
}

class TeacherClonedAssessmentState extends State<TeacherClonedAssessment> {
  bool additionalDetails = true;
  bool questionShirnk = true;
  assessment_model.Datum assessment =assessment_model.Datum();
  showAdditionalDetails() {
    setState(() {
      additionalDetails=!additionalDetails;
      print(additionalDetails);
    });
  }

  showQuestionDetails() {
    setState(() {
      questionShirnk=!questionShirnk;
      print(questionShirnk);
    });
  }

  @override
  void initState() {
    super.initState();
    //assessment=Provider.of<EditAssessmentProvider>(context, listen: false).getAssessment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      endDrawer: EndDrawerMenuTeacher(setLocale: widget.setLocale),
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
        title:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "CLONED",
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: height * 0.0225,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "ASSESSMENTS",
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
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.mail_outline_outlined,
                      color: Color.fromRGBO(82, 165, 160, 1),
                    ),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    const Icon(
                      Icons.print_outlined,
                      color: Color.fromRGBO(82, 165, 160, 1),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
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
                                  assessment.subject!,
                                  style: TextStyle(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "  |  ${assessment.datumClass!}",
                                  style: TextStyle(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
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
                                "${assessment.topic!} - ${assessment.subTopic!}",
                                style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.02),
                              child: const Icon(
                                Icons.circle,
                                color: Color.fromRGBO(60, 176, 0, 1),
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
                                    "50",
                                    style: TextStyle(
                                      color:
                                          const Color.fromRGBO(28, 78, 80, 1),
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
                                    "${assessment.questions!.length}",
                                    style: TextStyle(
                                      color:
                                          const Color.fromRGBO(28, 78, 80, 1),
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
                      "${assessment.assessmentId!}",
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
                      "ABC903857928",
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
                      "180 Minutes",
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
                    Text(
                      "14/01/2023      08:00 AM",
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
                    Text(
                      "17/01/2023      09:00 PM",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Additional Details",
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: height * 0.02,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.02),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Additional Details",
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: height * 0.02,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.02),
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
                additionalDetails?
                Column(
                  children: [
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
                          "Test/Practice",
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
                            "Retries",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "Allowed (3 Times)",
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
                            "Guest",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "Allowed",
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
                            "Answer Sheet",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "Viewable",
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
                            "Advisor",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "Subash",
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
                            "Email",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "No",
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
                            "Inactive",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.02,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "No",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ):const SizedBox(height: 0,),
                SizedBox(
                  height: height * 0.03,
                ),
                questionShirnk?Container(
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
                          child: IconButton(
                            onPressed: (){
                              showQuestionDetails();
                            },
                            icon: const Icon(
                              Icons.arrow_circle_up_outlined,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
                    :Container(
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
                          child: IconButton(
                            onPressed: (){
                              showQuestionDetails();
                            },
                            icon: const Icon(
                              Icons.arrow_circle_down_outlined,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                questionShirnk?
                SizedBox(
                  height: height * 0.4,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: assessment.questions!.length,
                      itemBuilder: (context,index)=>QuestionWidget(height: height, question: assessment.questions![index],)),
                )
                    :const SizedBox(height: 0,),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    GestureDetector(
                      onTap: (){
                        showQuestionDetails();
                      },
                      child: Text(
                        "  View All Questions  ",
                        style: TextStyle(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontSize: height * 0.02,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        showQuestionDetails();
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Color.fromRGBO(28, 78, 80, 1),
                      ),
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: TeacherClonedAssessmentPreview(
                                setLocale: widget.setLocale),
                          ),
                        );
                      },
                      child: Text(
                        'Edit',
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
    );
  }
}
class QuestionWidget extends StatefulWidget {
  QuestionWidget({
    Key? key,
    required this.height,
    required this.question
  }) : super(key: key);

  final double height;
  assessment_model.Question question;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String ans='';

  @override
  void initState() {
    for(int i=0;i<widget.question.choicesAnswer!.length;i++){
      ans='$ans, ${widget.question.choicesAnswer![i].choiceText}';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: const Color.fromRGBO(82, 165, 160, 0.08),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                    ans,
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
                        "Marks: ",
                        style: TextStyle(
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontSize: widget.height * 0.015,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${widget.question.questionMarks}",
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
          ),
        ),
      ),
    );
  }
}

