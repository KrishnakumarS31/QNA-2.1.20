import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher_assessment_landing.dart';
import 'package:qna_test/pages/teacher_published_assessment.dart';

import '../Entity/Teacher/response_entity.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/user_data_model.dart';
import '../Providers/create_assessment_provider.dart';
import '../Services/qna_service.dart';

class TeacherAssessmentSettingPublish extends StatefulWidget {
  const TeacherAssessmentSettingPublish({
    Key? key,
    required this.setLocale
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

  @override
  TeacherAssessmentSettingPublishState createState() =>
      TeacherAssessmentSettingPublishState();
}

class TeacherAssessmentSettingPublishState
    extends State<TeacherAssessmentSettingPublish> {
  bool testAgree = false;
  bool practiseAgree = false;
  bool mcqAgree = false;
  bool surveyAgree = false;
  bool descriptiveAgree = false;
  bool numOfRetriesStatus = false;
  bool allowedGuestStatus = false;
  bool showAnsAfterTest = false;
  bool showAnsDuringPractice = false;
  bool showNameStatus = false;
  bool showEmailStatus = false;
  bool activeStatus = false;
  bool publicAccessStatus = false;
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();
  bool _value = false;
  int val = -1;
  CreateAssessmentModel assessment=CreateAssessmentModel(questions: []);
  TextEditingController retriesController=TextEditingController();
  TextEditingController timePermitHoursController=TextEditingController();
  TextEditingController timePermitMinutesController=TextEditingController();
  List<Question> quesList=[];
  Question ques=Question();
  TextEditingController timeinput = TextEditingController();
  int totalQues=0;
  int totalMark=0;
  DateTime startDate=DateTime.now();
  DateTime startTime=DateTime.now();
  DateTime endDate=DateTime.now();
  DateTime endTime=DateTime.now();
  int hours=0;
  int minutes=0;
  @override
  void initState() {
    super.initState();
    timeinput.text = "";
    assessment=Provider.of<CreateAssessmentProvider>(context, listen: false).getAssessment;
    for(int i =0;i< assessment.questions!.length;i++){
      totalMark=totalMark + assessment.questions![i].questionMarks!;
    }
    totalQues=assessment.questions!.length;
    assessment.totalQuestions=totalQues;
    assessment.totalScore=totalMark;


  }

  final MaskTextInputFormatter timeMaskFormatter =
  MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'\d')});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isChecked = false;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                size: 40.0,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
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
            "ASSESSMENT SETTINGS",
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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: height * 0.025,
          ),
          Center(
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
                    padding: EdgeInsets.only(
                        left: width * 0.02, right: width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Maths\t |\t Class IX",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: const Color.fromRGBO(255, 166, 0, 1),
                          size: MediaQuery.of(context).copyWith().size.height *
                              0.02,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: width * 0.02),
                      child: Row(children: [
                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Topic:",
                                style: TextStyle(
                                    fontSize: height * 0.018,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter"),
                              ),
                              TextSpan(
                                text: "\tCalculus",
                                style: TextStyle(
                                    fontSize: height * 0.018,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter"),
                              ),
                            ])),
                        Text(
                          "\t\t\t|\t\t\t",
                          style: TextStyle(
                            color: const Color.fromRGBO(209, 209, 209, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Sub Topic:",
                                style: TextStyle(
                                    fontSize: height * 0.018,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter"),
                              ),
                              TextSpan(
                                text: "\tN/A",
                                style: TextStyle(
                                    fontSize: height * 0.018,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter"),
                              ),
                            ])),
                      ])),
                  Padding(
                      padding: EdgeInsets.only(left: width * 0.02),
                      child: Row(children: [
                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Total Questions:",
                                style: TextStyle(
                                    fontSize: height * 0.018,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter"),
                              ),
                              TextSpan(
                                text: "\t 05",
                                style: TextStyle(
                                    fontSize: height * 0.018,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromRGBO(82, 165, 160, 1),
                                    fontFamily: "Inter"),
                              ),
                            ])),
                        SizedBox(width: width * 0.2),
                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Total Marks:",
                                style: TextStyle(
                                    fontSize: height * 0.018,
                                    fontWeight: FontWeight.w500,
                                    color:
                                    const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter"),
                              ),
                              TextSpan(
                                text: "\t 50",
                                style: TextStyle(
                                    fontSize: height * 0.018,
                                    fontWeight: FontWeight.w500,
                                    color:
                                    const Color.fromRGBO(82, 165, 160, 1),
                                    fontFamily: "Inter"),
                              ),
                            ])),
                      ])),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                // color: Colors.red,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    //Text('Red container should be scrollable'),
                    SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.025,
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: height * 0.015,
                                        ),
                                        Text(
                                          "Category",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontSize: height * 0.025,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        // ),
                                        SizedBox(
                                          height: height * 0.015,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Test",
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontSize: height * 0.0175,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //),
                                        Row(children: [
                                          Text(
                                            "Results visible only to teacher",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  153, 153, 153, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(width: width * 0.3),
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Radio(
                                              value: 1,
                                              groupValue: val,
                                              onChanged: (value) {
                                                setState(() {
                                                  val = value!;
                                                });
                                              },
                                              activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                            ),
                                          ),
                                        ]),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.01,
                                              right: width * 0.15),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Practice",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      28, 78, 80, 1),
                                                  fontSize: height * 0.0175,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(children: [
                                          Text(
                                            "No results provided to teacher",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  153, 153, 153, 1),
                                              fontSize: height * 0.015,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(width: width * 0.3),
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Radio(
                                              value: 2,
                                              groupValue: val,
                                              onChanged: (value) {
                                                setState(() {
                                                  val = value!;
                                                });
                                              },
                                              activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                            ),
                                          ),
                                        ])
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                // height: height * 0.1087,
                                // width: width * 0.888,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: height * 0.015,
                                        ),
                                        Text(
                                          "Test Schedule",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontSize: height * 0.025,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        // ),
                                        SizedBox(
                                          height: height * 0.002,
                                        ),
                                        Text(
                                          "Leave blank if not required",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                153, 153, 153, 1),
                                            fontSize: height * 0.015,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.025,
                                        ),
                                        Row(children: [
                                          Text(
                                            "Duration",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                              fontSize: height * 0.0175,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: width * 0.4),
                                          SizedBox(
                                            width: width * 0.1,
                                            child: TextField(
                                              controller: timePermitHoursController,
                                              keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                  decimal: false),
                                              decoration: InputDecoration(
                                                hintText: "HH",
                                                hintStyle: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 0.3),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: height * 0.020),
                                              ),
                                              onChanged: (val){
                                                setState(() {
                                                  hours=int.parse(val);
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: height * 0.020,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Text(
                                            " : ",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                              fontSize: height * 0.0175,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.1,
                                            child: TextField(
                                              onChanged: (val){
                                                setState(() {
                                                  minutes=int.parse(val);
                                                });
                                              },
                                              controller: timePermitMinutesController,
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                  decimal: false),
                                              decoration: InputDecoration(
                                                hintText: "MM",
                                                hintStyle: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 0.3),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: height * 0.020),
                                              ),
                                              style: TextStyle(
                                                  fontSize: height * 0.020,
                                                  color: Colors.black),
                                            ),
                                          )
                                        ]),
                                        SizedBox(height: height * 0.03),
                                        Row(children: [
                                          SizedBox(
                                            height: height * 0.12,
                                            width: height * 0.18,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Start Date",
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        28, 78, 80, 1),
                                                    fontSize: height * 0.0175,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    var pickedDate =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2100),
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data:
                                                          Theme.of(context).copyWith(
                                                            colorScheme: const ColorScheme.light(primary: Color.fromRGBO(82, 165, 160, 1),
                                                              onPrimary:
                                                                  Colors.white,
                                                              onSurface: Colors
                                                                  .black, // <-- SEE HERE
                                                            ),
                                                            textButtonTheme:
                                                                TextButtonThemeData(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                foregroundColor:
                                                                    const Color
                                                                            .fromRGBO(
                                                                        82,
                                                                        165,
                                                                        160,
                                                                        1),
                                                              ),
                                                            ),
                                                          ),
                                                          child: child!,
                                                        );
                                                      },
                                                    );
                                                    final DateFormat formatter =
                                                        DateFormat(
                                                            'dd/MM/yyyy');
                                                    final String formatted =
                                                        formatter.format(
                                                            pickedDate!);
                                                    startDate=pickedDate!;
                                                    startDateController.text =
                                                        formatted;
                                                  },
                                                  child: AbsorbPointer(
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "DD/MM/YYYY",
                                                          hintStyle: TextStyle(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  102,
                                                                  102,
                                                                  102,
                                                                  0.3),
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: height *
                                                                  0.020)),
                                                      controller:
                                                          startDateController,
                                                      keyboardType:
                                                          TextInputType
                                                              .datetime,
                                                      enabled: true,
                                                      onChanged: (value) {},
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: width * 0.25),
                                          SizedBox(
                                            height: height * 0.12,
                                            width: height * 0.10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Start Time",
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        28, 78, 80, 1),
                                                    fontSize: height * 0.0175,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                      hintText: "00:00",
                                                      hintStyle: TextStyle(
                                                          color: const Color
                                                              .fromRGBO(
                                                              102,
                                                              102,
                                                              102,
                                                              0.3),
                                                          fontFamily:
                                                          'Inter',
                                                          fontWeight:
                                                          FontWeight
                                                              .w400,
                                                          fontSize: height *
                                                              0.020)),
                                                  keyboardType: TextInputType.datetime,
                                                  enabled: true,
                                                  controller: startTimeController, //editing controller of this TextField
                                                  onTap: () async {
                                                    TimeOfDay? pickedTime =  await showTimePicker(
                                                      initialTime: TimeOfDay.now(),
                                                      context: context,
                                                      initialEntryMode: TimePickerEntryMode.dial
                                                    );

                                                    if(pickedTime != null ){

                                                      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                      startTime=parsedTime;
                                                      //converting to DateTime so that we can further format on different pattern.
                                                     // print(parsedTime); //output 1970-01-01 22:53:00.000
                                                      String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                      //print(formattedTime); //output 14:59:00
                                                      //DateFormat() is from intl package, you can format the time on any pattern you need.
                                                      setState(() {
                                                        startTimeController.text = formattedTime.toString(); //set the value of text field.
                                                      });
                                                    }else{
                                                      print("Time is not selected");
                                                    }
                                                  },
                                                )
                                            // GestureDetector(
                                            //       onTap: () async {
                                            //         TimeOfDay? pickedTime =  await showTimePicker(
                                            //           initialTime: TimeOfDay.now(),
                                            //           context: context,
                                            //         );
                                            //
                                            //         if(pickedTime != null ){
                                            //           print(pickedTime.format(context));   //output 10:51 PM
                                            //           DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            //           //converting to DateTime so that we can further format on different pattern.
                                            //           print(parsedTime); //output 1970-01-01 22:53:00.000
                                            //           String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                                            //           print(formattedTime); //output 14:59:00
                                            //           //DateFormat() is from intl package, you can format the time on any pattern you need.
                                            //
                                            //           setState(() {
                                            //             timeinput.text = formattedTime; //set the value of text field.
                                            //           });
                                            //         }else{
                                            //           print("Time is not selected");
                                            //         }
                                            //       },
                                            //
                                            //       // {
                                            //       //   TimeOfDay? selectedTime = TimeOfDay.now();
                                            //       //   final TimeOfDay? timeOfDay = await showTimePicker(
                                            //       //       context: context,
                                            //       //       initialTime: selectedTime,
                                            //       //       initialEntryMode: TimePickerEntryMode.input);
                                            //       //  //setState(() {
                                            //       //    // print(selectedTime);
                                            //       //     selectedTime = timeOfDay;
                                            //       //   //});
                                            //       //   // _selectTime(context);
                                            //       // },
                                            //       child: AbsorbPointer(
                                            //         child:
                                            //         TextFormField(
                                            //           decoration: InputDecoration(
                                            //               hintText: "00:00 AM",
                                            //               hintStyle: TextStyle(
                                            //                   color: const Color
                                            //                           .fromRGBO(
                                            //                       102,
                                            //                       102,
                                            //                       102,
                                            //                       0.3),
                                            //                   fontFamily:
                                            //                       'Inter',
                                            //                   fontWeight:
                                            //                       FontWeight
                                            //                           .w400,
                                            //                   fontSize: height *
                                            //                       0.020)),
                                            //           controller:
                                            //               startTimeController,
                                            //           keyboardType:
                                            //               TextInputType
                                            //                   .datetime,
                                            //           enabled: true,
                                            //           onChanged: (value) {},
                                            //         ),
                                            //       ),
                                            //     ),
                                              ],
                                            ),
                                          )
                                        ]),
                                        SizedBox(height: height * 0.001),
                                        Row(children: [
                                          SizedBox(
                                            height: height * 0.12,
                                            width: height * 0.18,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "End Date",
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        28, 78, 80, 1),
                                                    fontSize: height * 0.0175,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    var pickedDate =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                      DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2100),
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data:
                                                          Theme.of(context)
                                                              .copyWith(
                                                            colorScheme:
                                                            const ColorScheme
                                                                .light(
                                                              primary: Color
                                                                  .fromRGBO(
                                                                  82,
                                                                  165,
                                                                  160,
                                                                  1),
                                                              onPrimary:
                                                              Colors.white,
                                                              onSurface: Colors
                                                                  .black, // <-- SEE HERE
                                                            ),
                                                            textButtonTheme:
                                                            TextButtonThemeData(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                foregroundColor:
                                                                const Color
                                                                    .fromRGBO(
                                                                    82,
                                                                    165,
                                                                    160,
                                                                    1),
                                                              ),
                                                            ),
                                                          ),
                                                          child: child!,
                                                        );
                                                      },
                                                    );
                                                    final DateFormat formatter =
                                                    DateFormat(
                                                        'dd/MM/yyyy');
                                                    final String formatted =
                                                    formatter.format(
                                                        pickedDate!);
                                                    endDate=pickedDate;
                                                    endDateController.text =
                                                        formatted;
                                                  },
                                                  child: AbsorbPointer(
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          hintText:
                                                          "DD/MM/YYYY",
                                                          hintStyle: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  102,
                                                                  102,
                                                                  102,
                                                                  0.3),
                                                              fontFamily:
                                                              'Inter',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              fontSize: height *
                                                                  0.020)),
                                                      controller:
                                                      endDateController,
                                                      keyboardType:
                                                      TextInputType
                                                          .datetime,
                                                      enabled: true,
                                                      onChanged: (value) {},
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: width * 0.25),
                                          SizedBox(
                                            height: height * 0.12,
                                            width: height * 0.10,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "End Time",
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        28, 78, 80, 1),
                                                    fontSize: height * 0.0175,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    _selectTime(context);
                                                  },
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                          hintText: "00:00",
                                                          hintStyle: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  102,
                                                                  102,
                                                                  102,
                                                                  0.3),
                                                              fontFamily:
                                                              'Inter',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              fontSize: height *
                                                                  0.020)),
                                                      keyboardType: TextInputType.datetime,
                                                      enabled: true,
                                                      controller: endTimeController, //editing controller of this TextField
                                                      onTap: () async {
                                                        TimeOfDay? pickedTime =  await showTimePicker(
                                                          initialTime: TimeOfDay.now(),
                                                          context: context,
                                                        );

                                                        if(pickedTime != null ){
                                                          //print(pickedTime.format(context));   //output 10:51 PM
                                                          DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                          endTime=parsedTime;
                                                          //converting to DateTime so that we can further format on different pattern.
                                                          // print(parsedTime); //output 1970-01-01 22:53:00.000
                                                          String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                          //print(formattedTime); //output 14:59:00
                                                          //DateFormat() is from intl package, you can format the time on any pattern you need.
                                                          setState(() {
                                                            endTimeController.text = formattedTime.toString(); //set the value of text field.
                                                          });
                                                        }else{
                                                          print("Time is not selected");
                                                        }
                                                      },
                                                    )
                                                    // TextFormField(
                                                    //   decoration: InputDecoration(
                                                    //       hintText: "00:00 AM",
                                                    //       hintStyle: TextStyle(
                                                    //           color: const Color
                                                    //               .fromRGBO(
                                                    //               102,
                                                    //               102,
                                                    //               102,
                                                    //               0.3),
                                                    //           fontFamily:
                                                    //           'Inter',
                                                    //           fontWeight:
                                                    //           FontWeight
                                                    //               .w400,
                                                    //           fontSize: height *
                                                    //               0.020)),
                                                    //   controller:
                                                    //   endTimeController,
                                                    //   keyboardType:
                                                    //   TextInputType
                                                    //       .datetime,
                                                    //   enabled: true,
                                                    //   onChanged: (value) {},
                                                    // ),
                                                  ),
                                              ],
                                            ),
                                          )
                                        ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: height * 0.015,
                                        ),
                                        Text(
                                          "Available for Practice",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontSize: height * 0.025,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.002,
                                        ),
                                        Text(
                                          "For institution students only",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                153, 153, 153, 1),
                                            fontSize: height * 0.015,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.025,
                                        ),
                                        Row(children: [
                                          Text(
                                            "Number of days after test",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                              fontSize: height * 0.0175,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: width * 0.2),
                                          SizedBox(
                                            width: width * 0.2,
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: "# day/s",
                                                hintStyle: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 0.3),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: height * 0.020),
                                              ),
                                              style: TextStyle(
                                                  fontSize: height * 0.020,
                                                  color: Colors.black),
                                            ),
                                          )
                                        ]),
                                        SizedBox(height: height * 0.02),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "MCQ",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      153, 153, 153, 0.8),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Checkbox(
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        153, 153, 153, 0.8),
                                                fillColor: MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (states) {
                                                  if (states.contains(
                                                      MaterialState.selected)) {
                                                    return const Color.fromRGBO(
                                                        82,
                                                        165,
                                                        160,
                                                        1); // Disabled color
                                                  }
                                                  return const Color.fromRGBO(
                                                      82,
                                                      165,
                                                      160,
                                                      1); // Regular color
                                                }),
                                                value: mcqAgree,
                                                onChanged: (val) {
                                                  setState(() {
                                                    mcqAgree = val!;
                                                    if (mcqAgree) {}
                                                  });
                                                },
                                              ),
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Survey",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      153, 153, 153, 0.8),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Checkbox(
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                fillColor: MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (states) {
                                                  if (states.contains(
                                                      MaterialState.selected)) {
                                                    return const Color.fromRGBO(
                                                        82,
                                                        165,
                                                        160,
                                                        1); // Disabled color
                                                  }
                                                  return const Color.fromRGBO(
                                                      82,
                                                      165,
                                                      160,
                                                      1); // Regular color
                                                }),
                                                value: surveyAgree,
                                                onChanged: (val) {
                                                  setState(() {
                                                    surveyAgree = val!;
                                                    if (surveyAgree) {}
                                                  });
                                                },
                                              ),
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Descriptive",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      153, 153, 153, 0.8),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Checkbox(
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                fillColor: MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (states) {
                                                  if (states.contains(
                                                      MaterialState.selected)) {
                                                    return const Color.fromRGBO(
                                                        82,
                                                        165,
                                                        160,
                                                        1); // Disabled color
                                                  }
                                                  return const Color.fromRGBO(
                                                      82,
                                                      165,
                                                      160,
                                                      1); // Regular color
                                                }),
                                                value: descriptiveAgree,
                                                onChanged: (val) {
                                                  setState(() {
                                                    descriptiveAgree = val!;
                                                    if (descriptiveAgree) {}
                                                  });
                                                },
                                              ),
                                            ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                // height: height * 0.1087,
                                // width: width * 0.888,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: height * 0.015,
                                        ),
                                        Text(
                                          "Institution / Organisation",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontSize: height * 0.025,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        // ),
                                        SizedBox(
                                          height: height * 0.002,
                                        ),
                                        Text(
                                          "Leave blank if not required",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                153, 153, 153, 1),
                                            fontSize: height * 0.015,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.025,
                                        ),
                                        Row(children: [
                                          Text(
                                            "Institute Test ID",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                              fontSize: height * 0.0175,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: width * 0.2),
                                          SizedBox(
                                            width: width * 0.4,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: "UCE1122334455",
                                                hintStyle: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 0.3),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: height * 0.020),
                                              ),
                                              style: TextStyle(
                                                  fontSize: height * 0.020,
                                                  color: Colors.black),
                                            ),
                                          )
                                        ]),
                                        SizedBox(height: height * 0.02),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(230, 230, 230, 1),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: height * 0.015,
                                        ),
                                        Text(
                                          "Access Control",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontSize: height * 0.025,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.025,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Number of Retries allowed",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      28, 78, 80, 1),
                                                  fontSize: height * 0.0175,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              //SizedBox(width: width * 0.2),
                                              SizedBox(
                                                width: width * 0.1,
                                                child: TextField(
                                                  controller: retriesController,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  decoration: InputDecoration(
                                                    hintText: "1",
                                                    hintStyle: TextStyle(
                                                        color: const Color
                                                                .fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize:
                                                            height * 0.025),
                                                  ),
                                                  style: TextStyle(
                                                      fontSize: height * 0.020,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              // SizedBox(width: width * 0.3),
                                              FlutterSwitch(
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                inactiveColor:
                                                    const Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                width: 65.0,
                                                height: 35.0,
                                                value: numOfRetriesStatus,
                                                borderRadius: 30.0,
                                                onToggle: (val) {
                                                  setState(() {
                                                    numOfRetriesStatus = val;
                                                  });
                                                },
                                              ),
                                            ]),
                                        SizedBox(height: height * 0.01),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Allow guest students",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              FlutterSwitch(
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                inactiveColor:
                                                    const Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                width: 65.0,
                                                height: 35.0,
                                                value: allowedGuestStatus,
                                                borderRadius: 30.0,
                                                onToggle: (val) {
                                                  setState(() {
                                                    print("Value of val");
                                                    print(val);
                                                    allowedGuestStatus = val;
                                                  });
                                                },
                                              ),
                                            ]),
                                        SizedBox(height: height * 0.01),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Show answer sheet after test",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              FlutterSwitch(
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                inactiveColor:
                                                    const Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                width: 65.0,
                                                height: 35.0,
                                                value: showAnsAfterTest,
                                                borderRadius: 30.0,
                                                onToggle: (val) {
                                                  setState(() {
                                                    showAnsAfterTest = val;
                                                  });
                                                },
                                              ),
                                            ]),
                                        SizedBox(height: height * 0.01),
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Show answer sheet during Practice",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              FlutterSwitch(
                                                activeColor:
                                                const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                inactiveColor:
                                                const Color.fromRGBO(
                                                    217, 217, 217, 1),
                                                width: 65.0,
                                                height: 35.0,
                                               value: showAnsDuringPractice,
                                                borderRadius: 30.0,
                                                onToggle: (val) {
                                                  setState(() {
                                                showAnsDuringPractice = val;
                                                  });
                                                },
                                              ),
                                            ]),
                                        SizedBox(height: height * 0.01),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Show my name in Advisor",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              FlutterSwitch(
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                inactiveColor:
                                                    const Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                width: 65.0,
                                                height: 35.0,
                                                value: showNameStatus,
                                                borderRadius: 30.0,
                                                onToggle: (val) {
                                                  setState(() {
                                                    showNameStatus = val;
                                                  });
                                                },
                                              ),
                                            ]),
                                        SizedBox(height: height * 0.01),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Show my Email in Advisor",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              FlutterSwitch(
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                inactiveColor:
                                                    const Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                width: 65.0,
                                                height: 35.0,
                                                value: showEmailStatus,
                                                borderRadius: 30.0,
                                                onToggle: (val) {
                                                  setState(() {
                                                    showEmailStatus = val;
                                                  });
                                                },
                                              ),
                                            ]),
                                        SizedBox(height: height * 0.01),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                "Show assessment Inactive",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
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

                                              FlutterSwitch(
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                inactiveColor:
                                                    const Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                width: 65.0,
                                                height: 35.0,
                                                value: activeStatus,
                                                borderRadius: 30.0,
                                                onToggle: (val) {
                                                  setState(() {
                                                    activeStatus = val;
                                                  });
                                                },
                                              ),
                                            ]),
                                        SizedBox(height: height * 0.01),
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Allow  Public access ",
                                                      style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            51, 51, 51, 1),
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

                                              FlutterSwitch(
                                                activeColor:
                                                const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                inactiveColor:
                                                const Color.fromRGBO(
                                                    217, 217, 217, 1),
                                                width: 65.0,
                                                height: 35.0,
                                                value: publicAccessStatus,
                                                borderRadius: 30.0,
                                                onToggle: (val) {
                                                  setState(() {
                                                    publicAccessStatus = val;
                                                  });
                                                },
                                              ),
                                            ]),
                                        SizedBox(height: height * 0.05),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.05),
                            Column(children: [
                              Center(
                                child: SizedBox(
                                  width: width * 0.6,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      backgroundColor: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      minimumSize: const Size(280, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(39),
                                      ),
                                    ),
                                    //shape: StadiumBorder(),
                                    onPressed: () async
                                    {
                                      if(val==1){
                                        assessment.assessmentType='test';
                                      }
                                      else{
                                        assessment.assessmentType='practice';
                                      }
                                      assessment.assessmentStatus='inprogress';
                                      AssessmentSettings assessmentSettings=AssessmentSettings();
                                      assessmentSettings.notAvailable=activeStatus;
                                      assessmentSettings.notAvailable=publicAccessStatus;
                                      assessmentSettings.showAdvisorEmail=showEmailStatus;
                                      assessmentSettings.showAdvisorName=showNameStatus;
                                      assessmentSettings.showSolvedAnswerSheetInAdvisor=showAnsAfterTest;
                                      assessmentSettings.showSolvedAnswerSheetDuringPractice = showAnsDuringPractice;
                                      assessmentSettings.allowGuestStudent=allowedGuestStatus;
                                      assessmentSettings.avalabilityForPractice=false;
                                      assessmentSettings.allowedNumberOfTestRetries=retriesController.text==''?0:int.parse(retriesController.text);
                                      assessment.assessmentSettings=assessmentSettings;
                                      startDate=DateTime(startDate.year,startDate.month,startDate.day,startTime.hour,startTime.minute);
                                      assessment.assessmentStartdate=startDate.microsecondsSinceEpoch;
                                      endDate=DateTime(endDate.year,endDate.month,endDate.day,endTime.hour,endTime.minute);
                                      assessment.assessmentEnddate=endDate.microsecondsSinceEpoch;
                                      assessment.assessmentDuration=(hours*60) + minutes;
                                      ResponseEntity statusCode=ResponseEntity();
                                      if(assessment.assessmentId!=null){
                                        statusCode = await QnaService.editAssessmentTeacherService(assessment,assessment.assessmentId!);
                                      }
                                      else{
                                        statusCode = await QnaService.createAssessmentTeacherService(assessment);
                                      }
                                      if(statusCode.code==200){
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            child: TeacherAssessmentLanding(
                                                setLocale: widget.setLocale),
                                          ),
                                        );
                                      }

                                    },
                                    child: Text(
                                      'Publish Later',
                                      style: TextStyle(
                                          fontSize: height * 0.025,
                                          fontFamily: "Inter",
                                          color:
                                              const Color.fromRGBO(82, 165, 160, 1),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Center(
                                child: SizedBox(
                                  width: width * 0.6,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            82, 165, 160, 1),
                                        minimumSize: const Size(280, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(39),
                                        ),
                                        side: const BorderSide(
                                          color:
                                              Color.fromRGBO(82, 165, 160, 1),
                                        )),
                                    //shape: StadiumBorder(),
                                    onPressed: () async {
                                      if(val==1){
                                        assessment.assessmentType='test';
                                      }
                                      else{
                                        assessment.assessmentType='practice';
                                      }
                                      assessment.assessmentStatus='active';
                                      //assessment.assessmentSettings?.allowedNumberOfTestRetries= int.parse(retriesController.text);
                                      //assessment.assessmentSettings?.avalabilityForPractice=true;
                                      AssessmentSettings assessmentSettings=AssessmentSettings();
                                      assessmentSettings.notAvailable=activeStatus;
                                      assessmentSettings.notAvailable=publicAccessStatus;
                                      assessmentSettings.showAdvisorEmail=showEmailStatus;
                                      assessmentSettings.showAdvisorName=showNameStatus;
                                      assessmentSettings.showSolvedAnswerSheetInAdvisor=showAnsAfterTest;
                                      assessmentSettings.showSolvedAnswerSheetDuringPractice=showAnsDuringPractice;
                                      assessmentSettings.allowGuestStudent=allowedGuestStatus;
                                      assessmentSettings.avalabilityForPractice=true;
                                      assessmentSettings.allowedNumberOfTestRetries=retriesController.text==''?0:int.parse(retriesController.text);
                                      assessment.assessmentSettings=assessmentSettings;

                                      // String tod='11:11';
                                      // TimeOfDay stringToTimeOfDay(String tod) {
                                      //   final format = DateFormat.Hm(); //"6:00 AM"
                                      //   return TimeOfDay.fromDateTime(format.parse(tod));
                                      // }
                                      // TimeOfDay a =stringToTimeOfDay(tod);
                                      // print(a.toString().substring(10,a.toString().length-1));
                                      // DateTime time = DateTime(1,1,1,a.hour,a.minute);
                                      // DateTime tempdate =DateTime(1,1,1);
                                      // print(time.toString());
                                      // print(tempdate.toString());
                                      // int timeEpoch = time.millisecondsSinceEpoch;
                                      // int tempDateEpoch = tempdate.millisecondsSinceEpoch;
                                      // print(timeEpoch-tempDateEpoch);
                                      startDate=DateTime(startDate.year,startDate.month,startDate.day,startTime.hour,startTime.minute);
                                      assessment.assessmentStartdate=startDate.microsecondsSinceEpoch;
                                      endDate=DateTime(endDate.year,endDate.month,endDate.day,endTime.hour,endTime.minute);
                                      assessment.assessmentEnddate=endDate.microsecondsSinceEpoch;
                                      assessment.assessmentDuration=(hours*60) + minutes;



                                      print(assessment.toString());
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                                child: CircularProgressIndicator(
                                                  color: Color.fromRGBO(48, 145, 139, 1),
                                                ));
                                          });
                                      ResponseEntity statusCode=ResponseEntity();
                                      if(assessment.assessmentId!=null){
                                        statusCode = await QnaService.editAssessmentTeacherService(assessment,assessment.assessmentId!);
                                      }
                                      else{
                                        statusCode = await QnaService.createAssessmentTeacherService(assessment);
                                      }
                                      Navigator.of(context).pop();
                                      if (statusCode.code == 200) {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            child: TeacherPublishedAssessment(
                                                setLocale: widget.setLocale),
                                          ),
                                        );
                                      }

                                    },
                                    child: Text(
                                      'Publish Now',
                                      style: TextStyle(
                                          fontSize: height * 0.025,
                                          fontFamily: "Inter",
                                          color:
                                              const Color.fromRGBO(255, 255, 255, 1),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = TimeOfDay.now();
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input);
      setState(() {
        print(selectedTime);
        selectedTime = timeOfDay;
      });
  }
}
