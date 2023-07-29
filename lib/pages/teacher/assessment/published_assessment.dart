import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/Teacher/response_entity.dart';
import '../../../Components/custom_incorrect_popup.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import '../../../Entity/Teacher/assessment_settings_model.dart';
import '../../../Entity/Teacher/get_assessment_model.dart';
import '../../../Entity/user_details.dart';
import '../../../EntityModel/CreateAssessmentModel.dart';
import '../../../Providers/LanguageChangeProvider.dart';
import '../../../Providers/create_assessment_provider.dart';
import '../../../Providers/edit_assessment_provider.dart';
import '../../../Providers/question_prepare_provider_final.dart';
import '../../../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Components/today_date.dart';
import '../../../DataSource/http_url.dart';
import 'package:qna_test/Entity/Teacher/question_entity.dart' as questionModel;
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PublishedAssessment extends StatefulWidget {
  PublishedAssessment({
    Key? key,
  }) : super(key: key);

  bool assessment = false;




  @override
  PublishedAssessmentState createState() =>
      PublishedAssessmentState();
}

class PublishedAssessmentState extends State<PublishedAssessment> {
  //List<Question> finalQuesList = [];
  UserDetails userDetails=UserDetails();
  final formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  //CreateAssessmentModel assessment =CreateAssessmentModel(questions: []);
  TextEditingController questionSearchController = TextEditingController();

  List<questionModel.Question> questionList = [];
  int pageNumber=1;
  int questionStart=0;
  List<List<String>> temp = [];

  //-----------------------------------------------------------
  String category='Test';
  DateTime timeLimit = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TextEditingController timeLimitController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  int numberOfAttempts=1;
  bool allowGuestStudent=false;
  bool showAnswerSheetPractice=false;
  bool allowPublishPublic=false;
  bool showName=false;
  bool showEmail=false;
  bool showWhatsappGroup=false;
  GetAssessmentModel assessment=GetAssessmentModel();
  CreateAssessmentModel createAssessment=CreateAssessmentModel(questions: []);
  int totalMarks=0;
  String startDateTime='';
  String endDateTime='';



  @override
  void initState() {
    super.initState();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    assessment =Provider.of<EditAssessmentProvider>(context, listen: false).getAssessment;
    questionList=Provider.of<QuestionPrepareProviderFinal>(context, listen: false).getAllQuestion;
    createAssessment=Provider.of<CreateAssessmentProvider>(context, listen: false).getAssessment;
    DateTime tsDate = DateTime.fromMicrosecondsSinceEpoch(createAssessment.assessmentStartdate!);
    startDateTime = "${tsDate.day}/${tsDate.month}/${tsDate.year} ${tsDate.hour>12?tsDate.hour-12:tsDate.hour}:${tsDate.minute} ${tsDate.hour>12?"PM":"AM"}";
    DateTime teDate = DateTime.fromMicrosecondsSinceEpoch(createAssessment.assessmentEnddate!);
    endDateTime = "${teDate.day}/${teDate.month}/${teDate.year} ${teDate.hour>12?teDate.hour-12:teDate.hour}:${teDate.minute} ${teDate.hour>12?"PM":"AM"}";
    for(int i=0;i<createAssessment.questions!.length;i++){
      totalMarks=totalMarks+createAssessment.questions![i].questionMarks!;
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth<= 960 && constraints.maxWidth>=500) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    endDrawer: const EndDrawerMenuTeacher(),
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: Colors.black,size: height * 0.05),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      // leading: IconButton(
                      //   icon: Icon(
                      //     Icons.chevron_left,
                      //     size: height * 0.06,
                      //     color: Colors.black,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                      automaticallyImplyLeading: false,
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              //AppLocalizations.of(context)!.my_qns,
                              "Published Assessment",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white
                        ),
                      ),
                    ),
                    body: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(left: height * 0.045,
                            right: height * 0.045,
                            bottom: height * 0.045),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height : height * 0.15,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(82, 165, 160, 0.08),
                                  border: Border.all(
                                    color: const Color.fromRGBO(28, 78, 80, 0.08),
                                  ),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(5))
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.02, right: width * 0.02,top: height*0.01,bottom: height*0.01),
                                child: SizedBox(
                                  width: width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${createAssessment.subject} | ${createAssessment.topic}",
                                            style: TextStyle(
                                                fontSize: height * 0.02,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(28, 78, 80, 1),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          (createAssessment.assessmentType=="test" && createAssessment.assessmentStatus=="active")?
                                          Container(
                                            height: height * 0.04,
                                            width: width * 0.16,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Color.fromRGBO(219, 35, 35, 1),),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
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
                                          ):
                                          createAssessment.assessmentStatus=="inactive"?
                                          Icon(
                                            Icons.circle_outlined,
                                            color: Colors.black,
                                            size: MediaQuery
                                                .of(context)
                                                .copyWith()
                                                .size
                                                .height *
                                                0.02,
                                          ):
                                          createAssessment.assessmentStatus=="inprogress"?
                                          Icon(
                                            Icons.circle,
                                            color: const Color.fromRGBO(153, 153, 153, 1),
                                            size: MediaQuery
                                                .of(context)
                                                .copyWith()
                                                .size
                                                .height *
                                                0.02,
                                          ):
                                          Icon(
                                            Icons.circle,
                                            color: const Color.fromRGBO(255, 153, 0, 1),
                                            size: MediaQuery
                                                .of(context)
                                                .copyWith()
                                                .size
                                                .height *
                                                0.02,
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${createAssessment.subject} | ${createAssessment.topic}",
                                          style: TextStyle(
                                              fontSize: height * 0.016,
                                              fontFamily: "Inter",
                                              color:
                                              const Color.fromRGBO(28, 78, 80, 1),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(height: height*0.01,),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(AppLocalizations.of(context)!.assessment_id_caps,
                                                  style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      color:
                                                      const Color.fromRGBO(28, 78, 80, 1),
                                                      fontWeight: FontWeight.w400),
                                                ),
                                                Text(createAssessment.assessmentCode!,
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(82, 165, 160, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],),
                                            Text(
                                              startDateTime,
                                              style: TextStyle(
                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ]),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Total Marks: ",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(51, 51, 51, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              Text(
                                                "$totalMarks",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Total Questions: ",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(51, 51, 51, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              Text(
                                                "${createAssessment.questions!.length}",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01,),
                            Container(
                              height: height * 0.55,
                              width: width * 0.93,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Container(
                                    //     height: height * 0.1,
                                    //     decoration: BoxDecoration(
                                    //       border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(5)),
                                    //     ),
                                    //     child: Row(
                                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //       children: [
                                    //         Padding(
                                    //           padding: EdgeInsets.only(left: width*0.03),
                                    //           child: SizedBox(
                                    //             width: width * 0.2,
                                    //             child: Text(
                                    //               "Category",
                                    //               style: TextStyle(
                                    //                   fontSize: height * 0.022,
                                    //                   fontFamily: "Inter",
                                    //                   color:
                                    //                   const Color.fromRGBO(28, 78, 80, 1),
                                    //                   fontWeight: FontWeight.w700),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(right: width*0.03),
                                    //           child: SizedBox(
                                    //             width: width * 0.55,
                                    //             child: Row(
                                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //               children: [
                                    //                 ElevatedButton(
                                    //                   style: ElevatedButton.styleFrom(
                                    //                     minimumSize: Size(width* 0.25, height*0.04),
                                    //                     side: const BorderSide(
                                    //                         color: Color.fromRGBO(153, 153, 153, 0.5)
                                    //                     ),
                                    //                     backgroundColor:
                                    //                     category=="Test"? Color.fromRGBO(82, 165, 160, 1):Color.fromRGBO(255, 255, 255, 1),
                                    //                     //minimumSize: const Size(280, 48),
                                    //                     shape: RoundedRectangleBorder(
                                    //                       borderRadius: BorderRadius.circular(5),
                                    //                     ),
                                    //                   ),
                                    //                   //shape: StadiumBorder(),
                                    //                   onPressed: () {
                                    //                     setState(() {
                                    //                       if(category=="Practice") {
                                    //                         category="Test";
                                    //                       }
                                    //                       else{
                                    //                         category="Practice";
                                    //                       }
                                    //                     });
                                    //                   },
                                    //                   child: Text(
                                    //                     //AppLocalizations.of(context)!.edit_button,
                                    //                     'Test',
                                    //                     style: TextStyle(
                                    //                         fontSize: height * 0.02,
                                    //                         fontFamily: "Inter",
                                    //                         color: category=="Test"?Colors.white:Color.fromRGBO(102, 102, 102, 1),
                                    //                         fontWeight: FontWeight.w400),
                                    //                   ),
                                    //                 ),
                                    //                 ElevatedButton(
                                    //                   style: ElevatedButton.styleFrom(
                                    //                     minimumSize: Size(width* 0.025, height*0.04),
                                    //                     side: const BorderSide(
                                    //                         color: Color.fromRGBO(153, 153, 153, 0.5)
                                    //                     ),
                                    //                     backgroundColor:
                                    //                     category=="Practice"? Color.fromRGBO(82, 165, 160, 1):Color.fromRGBO(255, 255, 255, 1),
                                    //                     //minimumSize: const Size(280, 48),
                                    //                     shape: RoundedRectangleBorder(
                                    //                       borderRadius: BorderRadius.circular(5),
                                    //                     ),
                                    //                   ),
                                    //                   //shape: StadiumBorder(),
                                    //                   onPressed: () {
                                    //                     setState(() {
                                    //                       if(category=="Practice") {
                                    //                         category="Test";
                                    //                       }
                                    //                       else{
                                    //                         category="Practice";
                                    //                       }
                                    //                     });
                                    //                   },
                                    //                   child: Text(
                                    //                     //AppLocalizations.of(context)!.edit_button,
                                    //                     'Practice',
                                    //                     style: TextStyle(
                                    //                         fontSize: height * 0.02,
                                    //                         fontFamily: "Inter",
                                    //                         color: category=="Practice"?Colors.white:Color.fromRGBO(102, 102, 102, 1),
                                    //                         fontWeight: FontWeight.w400),
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),
                                    //
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    createAssessment.assessmentType=="test"?
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.23,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Test Schedule",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                            //   child: Text(
                                            //     "Please note, Test paper will automatically become Practice paper after End Date & Time.",
                                            //     style: TextStyle(
                                            //         fontSize: height * 0.014,
                                            //         fontFamily: "Inter",
                                            //         color: const Color.fromRGBO(102, 102, 102, 1),
                                            //         fontWeight: FontWeight.w400),
                                            //   ),
                                            // ),
                                            Divider(
                                              thickness: 2,
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Time Limit: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${createAssessment.assessmentDuration} Minutes",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Start Date & Time: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    startDateTime,
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "End Date & Time: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    endDateTime,
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                      ),
                                    ):
                                    SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.4,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Additional Details",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                            //   child: Text(
                                            //     "Please note, Test paper will automatically become Practice paper after End Date & Time.",
                                            //     style: TextStyle(
                                            //         fontSize: height * 0.014,
                                            //         fontFamily: "Inter",
                                            //         color: const Color.fromRGBO(102, 102, 102, 1),
                                            //         fontWeight: FontWeight.w400),
                                            //   ),
                                            // ),
                                            Divider(
                                              thickness: 2,
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Category: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${createAssessment.assessmentType}",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Number of Attempts: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${createAssessment.assessmentSettings?.allowedNumberOfTestRetries}",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Guest Students: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    createAssessment.assessmentSettings!.allowGuestStudent!?"Allowed":"Not Allowed",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Answer Sheet in Practice: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    createAssessment.assessmentSettings!.showAnswerSheetDuringPractice!?"Viewable":"Not Viewable",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Published in LOOQ: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    createAssessment.assessmentSettings!.avalabilityForPractice! ?"Yes":"No",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Advisor Name: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    createAssessment.assessmentSettings!.showAdvisorName!?createAssessment.assessmentSettings!.advisorName!:"-",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Advisor Email: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    createAssessment.assessmentSettings!.showAdvisorEmail!?createAssessment.assessmentSettings!.advisorEmail!:"-",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Whatsapp Group Link: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "-",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.08,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Questions",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    for(int i=0;i<questionList!.length;i++)
                                      QuestionCard(width: width, height: height, question: questionList![i],index: i,)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.05),
                            Padding(
                              padding: EdgeInsets.only(right:width * 0.02,left: width * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                      minimumSize: Size(width * 0.025, height * 0.05),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(39),
                                      ),
                                    ),
                                    onPressed: () async {
                                      Provider.of<QuestionPrepareProviderFinal>(context,
                                          listen: false)
                                          .reSetQuestionList();
                                      Provider.of<EditAssessmentProvider>(context,
                                          listen: false)
                                          .resetAssessment();
                                      Provider.of<CreateAssessmentProvider>(context,
                                          listen: false)
                                          .resetAssessment();
                                      Navigator.of(context).pushNamedAndRemoveUntil('/assessmentLandingPage', ModalRoute.withName('/teacherSelectionPage'));

                                    },
                                    child: Text(

                                      //AppLocalizations.of(context)!.qn_button,
                                      'Go to My Assessment',
                                      style: TextStyle(
                                          fontSize: height * 0.032,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )));
          }
          else if(constraints.maxWidth > 960) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    endDrawer: const EndDrawerMenuTeacher(),
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: Colors.black,size: height * 0.05),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      // leading: IconButton(
                      //   icon: Icon(
                      //     Icons.chevron_left,
                      //     size: height * 0.06,
                      //     color: Colors.black,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                      automaticallyImplyLeading: false,
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              //AppLocalizations.of(context)!.my_qns,
                              "Published Assessment",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white
                        ),
                      ),
                    ),
                    body: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.023,
                            left: height * 0.5,
                            right: height * 0.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height : height * 0.16,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(82, 165, 160, 0.08),
                                  border: Border.all(
                                    color: const Color.fromRGBO(28, 78, 80, 0.08),
                                  ),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(5))
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.02, right: width * 0.02,top: height*0.01,bottom: height*0.01),
                                child: SizedBox(
                                  width: width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${createAssessment.subject} | ${createAssessment.topic}",
                                            style: TextStyle(
                                                fontSize: height * 0.02,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(28, 78, 80, 1),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          (createAssessment.assessmentType == "test" && createAssessment.assessmentStatus == "active")?
                                          Container(
                                            height: height * 0.04,
                                            width: width * 0.05,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Color.fromRGBO(219, 35, 35, 1),),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
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
                                          ):
                                          createAssessment.assessmentStatus=="inactive"?
                                          Icon(
                                            Icons.circle_outlined,
                                            color: Colors.black,
                                            size: MediaQuery
                                                .of(context)
                                                .copyWith()
                                                .size
                                                .height *
                                                0.02,
                                          ):
                                          createAssessment.assessmentStatus=="inprogress"?
                                          Icon(
                                            Icons.circle,
                                            color: const Color.fromRGBO(153, 153, 153, 1),
                                            size: MediaQuery
                                                .of(context)
                                                .copyWith()
                                                .size
                                                .height *
                                                0.02,
                                          ):
                                          Icon(
                                            Icons.circle,
                                            color: const Color.fromRGBO(255, 153, 0, 1),
                                            size: MediaQuery
                                                .of(context)
                                                .copyWith()
                                                .size
                                                .height *
                                                0.02,
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${createAssessment.createAssessmentModelClass} | ${createAssessment.subTopic}",
                                          style: TextStyle(
                                              fontSize: height * 0.016,
                                              fontFamily: "Inter",
                                              color:
                                              const Color.fromRGBO(28, 78, 80, 1),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(height: height*0.01,),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(AppLocalizations.of(context)!.assessment_id_caps,
                                                  style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      color:
                                                      const Color.fromRGBO(28, 78, 80, 1),
                                                      fontWeight: FontWeight.w400),
                                                ),
                                                Text(createAssessment.assessmentCode!,
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(82, 165, 160, 1),
                                                    fontSize: height * 0.015,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],),
                                            Text(
                                              startDateTime,
                                              style: TextStyle(
                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                fontSize: height * 0.015,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ]),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Total Marks: ",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(51, 51, 51, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              Text(
                                                "$totalMarks",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Total Questions: ",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(51, 51, 51, 1),
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              Text(
                                                "${createAssessment.questions!.length}",
                                                style: TextStyle(
                                                    fontSize: height * 0.016,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01,),
                            Container(
                              height: height * 0.55,
                              width: width * 0.93,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Container(
                                    //     height: height * 0.1,
                                    //     decoration: BoxDecoration(
                                    //       border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(5)),
                                    //     ),
                                    //     child: Row(
                                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //       children: [
                                    //         Padding(
                                    //           padding: EdgeInsets.only(left: width*0.03),
                                    //           child: SizedBox(
                                    //             width: width * 0.2,
                                    //             child: Text(
                                    //               "Category",
                                    //               style: TextStyle(
                                    //                   fontSize: height * 0.022,
                                    //                   fontFamily: "Inter",
                                    //                   color:
                                    //                   const Color.fromRGBO(28, 78, 80, 1),
                                    //                   fontWeight: FontWeight.w700),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(right: width*0.03),
                                    //           child: SizedBox(
                                    //             width: width * 0.55,
                                    //             child: Row(
                                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //               children: [
                                    //                 ElevatedButton(
                                    //                   style: ElevatedButton.styleFrom(
                                    //                     minimumSize: Size(width* 0.25, height*0.04),
                                    //                     side: const BorderSide(
                                    //                         color: Color.fromRGBO(153, 153, 153, 0.5)
                                    //                     ),
                                    //                     backgroundColor:
                                    //                     category=="Test"? Color.fromRGBO(82, 165, 160, 1):Color.fromRGBO(255, 255, 255, 1),
                                    //                     //minimumSize: const Size(280, 48),
                                    //                     shape: RoundedRectangleBorder(
                                    //                       borderRadius: BorderRadius.circular(5),
                                    //                     ),
                                    //                   ),
                                    //                   //shape: StadiumBorder(),
                                    //                   onPressed: () {
                                    //                     setState(() {
                                    //                       if(category=="Practice") {
                                    //                         category="Test";
                                    //                       }
                                    //                       else{
                                    //                         category="Practice";
                                    //                       }
                                    //                     });
                                    //                   },
                                    //                   child: Text(
                                    //                     //AppLocalizations.of(context)!.edit_button,
                                    //                     'Test',
                                    //                     style: TextStyle(
                                    //                         fontSize: height * 0.02,
                                    //                         fontFamily: "Inter",
                                    //                         color: category=="Test"?Colors.white:Color.fromRGBO(102, 102, 102, 1),
                                    //                         fontWeight: FontWeight.w400),
                                    //                   ),
                                    //                 ),
                                    //                 ElevatedButton(
                                    //                   style: ElevatedButton.styleFrom(
                                    //                     minimumSize: Size(width* 0.025, height*0.04),
                                    //                     side: const BorderSide(
                                    //                         color: Color.fromRGBO(153, 153, 153, 0.5)
                                    //                     ),
                                    //                     backgroundColor:
                                    //                     category=="Practice"? Color.fromRGBO(82, 165, 160, 1):Color.fromRGBO(255, 255, 255, 1),
                                    //                     //minimumSize: const Size(280, 48),
                                    //                     shape: RoundedRectangleBorder(
                                    //                       borderRadius: BorderRadius.circular(5),
                                    //                     ),
                                    //                   ),
                                    //                   //shape: StadiumBorder(),
                                    //                   onPressed: () {
                                    //                     setState(() {
                                    //                       if(category=="Practice") {
                                    //                         category="Test";
                                    //                       }
                                    //                       else{
                                    //                         category="Practice";
                                    //                       }
                                    //                     });
                                    //                   },
                                    //                   child: Text(
                                    //                     //AppLocalizations.of(context)!.edit_button,
                                    //                     'Practice',
                                    //                     style: TextStyle(
                                    //                         fontSize: height * 0.02,
                                    //                         fontFamily: "Inter",
                                    //                         color: category=="Practice"?Colors.white:Color.fromRGBO(102, 102, 102, 1),
                                    //                         fontWeight: FontWeight.w400),
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),
                                    //
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    createAssessment.assessmentType=="test"?
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.23,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Test Schedule",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                            //   child: Text(
                                            //     "Please note, Test paper will automatically become Practice paper after End Date & Time.",
                                            //     style: TextStyle(
                                            //         fontSize: height * 0.014,
                                            //         fontFamily: "Inter",
                                            //         color: const Color.fromRGBO(102, 102, 102, 1),
                                            //         fontWeight: FontWeight.w400),
                                            //   ),
                                            // ),
                                            Divider(
                                              thickness: 2,
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Time Limit: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${createAssessment.assessmentDuration} Minutes",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Start Date & Time: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    startDateTime,
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "End Date & Time: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    endDateTime,
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                      ),
                                    )
                                        :SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.4,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Additional Details",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                            //   child: Text(
                                            //     "Please note, Test paper will automatically become Practice paper after End Date & Time.",
                                            //     style: TextStyle(
                                            //         fontSize: height * 0.014,
                                            //         fontFamily: "Inter",
                                            //         color: const Color.fromRGBO(102, 102, 102, 1),
                                            //         fontWeight: FontWeight.w400),
                                            //   ),
                                            // ),
                                            Divider(
                                              thickness: 2,
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Category: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${createAssessment.assessmentType}",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Number of Attempts: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${createAssessment.assessmentSettings?.allowedNumberOfTestRetries}",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Guest Students: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    createAssessment.assessmentSettings!.allowGuestStudent!?"Allowed":"Not Allowed",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Answer Sheet in Practice: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    createAssessment.assessmentSettings!.showAnswerSheetDuringPractice!?"Viewable":"Not Viewable",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Published in LOOQ: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    createAssessment.assessmentSettings!.avalabilityForPractice!?"Yes":"No",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Advisor Name: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    createAssessment.assessmentSettings!.showAdvisorName!?createAssessment.assessmentSettings!.advisorName!:"-",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Advisor Email: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    createAssessment.assessmentSettings!.showAdvisorEmail!?createAssessment.assessmentSettings!.advisorEmail!:"-",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Whatsapp Group Link: ",
                                                    style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w700,
                                                      color:
                                                      const Color.fromRGBO(102, 102, 102, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "-",
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color: const Color.fromRGBO(102, 102, 102, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.08,
                                        width: width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                              child: Text(
                                                "Questions",
                                                style: TextStyle(
                                                    fontSize: height * 0.022,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(28, 78, 80, 1),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    for(int i=0;i<questionList!.length;i++)
                                      QuestionCard(width: width, height: height, question: questionList![i],index: i,)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.05),
                            Padding(
                              padding: EdgeInsets.only(right:width * 0.02,left: width * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                      minimumSize: Size(width * 0.025, height * 0.05),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(39),
                                      ),
                                    ),
                                    onPressed: () async {
                                      Provider.of<QuestionPrepareProviderFinal>(context,
                                          listen: false)
                                          .reSetQuestionList();
                                      Provider.of<EditAssessmentProvider>(context,
                                          listen: false)
                                          .resetAssessment();
                                      Provider.of<CreateAssessmentProvider>(context,
                                          listen: false)
                                          .resetAssessment();
                                      Navigator.of(context).pushNamedAndRemoveUntil('/assessmentLandingPage', ModalRoute.withName('/teacherSelectionPage'));

                                    },
                                    child: Text(

                                      //AppLocalizations.of(context)!.qn_button,
                                      'Go to My Assessments',
                                      style: TextStyle(
                                          fontSize: height * 0.032,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )));
          }
          else{
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    endDrawer: const EndDrawerMenuTeacher(),
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: Colors.black,size: height * 0.05),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      // leading: IconButton(
                      //   icon: Icon(
                      //     Icons.chevron_left,
                      //     size: height * 0.06,
                      //     color: Colors.black,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                      automaticallyImplyLeading: false,
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              //AppLocalizations.of(context)!.my_qns,
                              "Published Assessment",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white
                        ),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(right:width * 0.04,left:width * 0.04),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height : height * 0.15,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(82, 165, 160, 0.08),
                                    border: Border.all(
                                      color: const Color.fromRGBO(28, 78, 80, 0.08),
                                    ),
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(5))
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.02, right: width * 0.02,top: height*0.01,bottom: height*0.01),
                                  child: SizedBox(
                                    width: width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${createAssessment.subject} | ${createAssessment.topic}",
                                              style: TextStyle(
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  color:
                                                  const Color.fromRGBO(28, 78, 80, 1),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                           (createAssessment.assessmentType=="test" && createAssessment.assessmentStatus=="active")?
                                            Container(
                                              height: height * 0.04,
                                              width: width * 0.16,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Color.fromRGBO(219, 35, 35, 1),),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
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
                                            ):
                                            createAssessment.assessmentStatus=="inactive"?
                                            Icon(
                                              Icons.circle_outlined,
                                              color: Colors.black,
                                              size: MediaQuery
                                                  .of(context)
                                                  .copyWith()
                                                  .size
                                                  .height *
                                                  0.02,
                                            ):
                                            createAssessment.assessmentStatus=="inprogress"?
                                            Icon(
                                              Icons.circle,
                                              color: const Color.fromRGBO(153, 153, 153, 1),
                                              size: MediaQuery
                                                  .of(context)
                                                  .copyWith()
                                                  .size
                                                  .height *
                                                  0.02,
                                            ):
                                            Icon(
                                              Icons.circle,
                                              color: const Color.fromRGBO(255, 153, 0, 1),
                                              size: MediaQuery
                                                  .of(context)
                                                  .copyWith()
                                                  .size
                                                  .height *
                                                  0.02,
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${createAssessment.createAssessmentModelClass} | ${createAssessment.subTopic}",
                                            style: TextStyle(
                                                fontSize: height * 0.016,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(28, 78, 80, 1),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(height: height*0.01,),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(AppLocalizations.of(context)!.assessment_id_caps,
                                                    style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        color:
                                                        const Color.fromRGBO(28, 78, 80, 1),
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                  Text(createAssessment.assessmentCode!,
                                                    style: TextStyle(
                                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                                      fontSize: height * 0.015,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],),
                                              Text(
                                                startDateTime,
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                                  fontSize: height * 0.015,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ]),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Total Marks: ",
                                                  style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      color:
                                                      const Color.fromRGBO(51, 51, 51, 1),
                                                      fontWeight: FontWeight.w400),
                                                ),
                                                Text(
                                                  "$totalMarks",
                                                  style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      color:
                                                      const Color.fromRGBO(82, 165, 160, 1),
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Total Questions: ",
                                                  style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      color:
                                                      const Color.fromRGBO(51, 51, 51, 1),
                                                      fontWeight: FontWeight.w400),
                                                ),
                                                Text(
                                                  "${createAssessment.questions!.length}",
                                                  style: TextStyle(
                                                      fontSize: height * 0.016,
                                                      fontFamily: "Inter",
                                                      color:
                                                      const Color.fromRGBO(82, 165, 160, 1),
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.01,),
                              Container(
                                height: height * 0.55,
                                width: width * 0.93,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    //mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Container(
                                      //     height: height * 0.1,
                                      //     decoration: BoxDecoration(
                                      //       border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                      //       borderRadius: BorderRadius.all(
                                      //           Radius.circular(5)),
                                      //     ),
                                      //     child: Row(
                                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //       children: [
                                      //         Padding(
                                      //           padding: EdgeInsets.only(left: width*0.03),
                                      //           child: SizedBox(
                                      //             width: width * 0.2,
                                      //             child: Text(
                                      //               "Category",
                                      //               style: TextStyle(
                                      //                   fontSize: height * 0.022,
                                      //                   fontFamily: "Inter",
                                      //                   color:
                                      //                   const Color.fromRGBO(28, 78, 80, 1),
                                      //                   fontWeight: FontWeight.w700),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         Padding(
                                      //           padding: EdgeInsets.only(right: width*0.03),
                                      //           child: SizedBox(
                                      //             width: width * 0.55,
                                      //             child: Row(
                                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //               children: [
                                      //                 ElevatedButton(
                                      //                   style: ElevatedButton.styleFrom(
                                      //                     minimumSize: Size(width* 0.25, height*0.04),
                                      //                     side: const BorderSide(
                                      //                         color: Color.fromRGBO(153, 153, 153, 0.5)
                                      //                     ),
                                      //                     backgroundColor:
                                      //                     category=="Test"? Color.fromRGBO(82, 165, 160, 1):Color.fromRGBO(255, 255, 255, 1),
                                      //                     //minimumSize: const Size(280, 48),
                                      //                     shape: RoundedRectangleBorder(
                                      //                       borderRadius: BorderRadius.circular(5),
                                      //                     ),
                                      //                   ),
                                      //                   //shape: StadiumBorder(),
                                      //                   onPressed: () {
                                      //                     setState(() {
                                      //                       if(category=="Practice") {
                                      //                         category="Test";
                                      //                       }
                                      //                       else{
                                      //                         category="Practice";
                                      //                       }
                                      //                     });
                                      //                   },
                                      //                   child: Text(
                                      //                     //AppLocalizations.of(context)!.edit_button,
                                      //                     'Test',
                                      //                     style: TextStyle(
                                      //                         fontSize: height * 0.02,
                                      //                         fontFamily: "Inter",
                                      //                         color: category=="Test"?Colors.white:Color.fromRGBO(102, 102, 102, 1),
                                      //                         fontWeight: FontWeight.w400),
                                      //                   ),
                                      //                 ),
                                      //                 ElevatedButton(
                                      //                   style: ElevatedButton.styleFrom(
                                      //                     minimumSize: Size(width* 0.025, height*0.04),
                                      //                     side: const BorderSide(
                                      //                         color: Color.fromRGBO(153, 153, 153, 0.5)
                                      //                     ),
                                      //                     backgroundColor:
                                      //                     category=="Practice"? Color.fromRGBO(82, 165, 160, 1):Color.fromRGBO(255, 255, 255, 1),
                                      //                     //minimumSize: const Size(280, 48),
                                      //                     shape: RoundedRectangleBorder(
                                      //                       borderRadius: BorderRadius.circular(5),
                                      //                     ),
                                      //                   ),
                                      //                   //shape: StadiumBorder(),
                                      //                   onPressed: () {
                                      //                     setState(() {
                                      //                       if(category=="Practice") {
                                      //                         category="Test";
                                      //                       }
                                      //                       else{
                                      //                         category="Practice";
                                      //                       }
                                      //                     });
                                      //                   },
                                      //                   child: Text(
                                      //                     //AppLocalizations.of(context)!.edit_button,
                                      //                     'Practice',
                                      //                     style: TextStyle(
                                      //                         fontSize: height * 0.02,
                                      //                         fontFamily: "Inter",
                                      //                         color: category=="Practice"?Colors.white:Color.fromRGBO(102, 102, 102, 1),
                                      //                         fontWeight: FontWeight.w400),
                                      //                   ),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      createAssessment.assessmentType=="test"?
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * 0.23,
                                          width: width,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                                child: Text(
                                                  "Test Schedule",
                                                  style: TextStyle(
                                                      fontSize: height * 0.022,
                                                      fontFamily: "Inter",
                                                      color:
                                                      const Color.fromRGBO(28, 78, 80, 1),
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                              // Padding(
                                              //   padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              //   child: Text(
                                              //     "Please note, Test paper will automatically become Practice paper after End Date & Time.",
                                              //     style: TextStyle(
                                              //         fontSize: height * 0.014,
                                              //         fontFamily: "Inter",
                                              //         color: const Color.fromRGBO(102, 102, 102, 1),
                                              //         fontWeight: FontWeight.w400),
                                              //   ),
                                              // ),
                                              Divider(
                                                thickness: 2,
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Time Limit: ",
                                                      style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color.fromRGBO(102, 102, 102, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${createAssessment.assessmentDuration} Minutes",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Start Date & Time: ",
                                                      style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color.fromRGBO(102, 102, 102, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      startDateTime,
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "End Date & Time: ",
                                                      style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color.fromRGBO(102, 102, 102, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      endDateTime,
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),


                                            ],
                                          ),
                                        ),
                                      )
                                          :SizedBox(),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * 0.4,
                                          width: width,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                                child: Text(
                                                  "Additional Details",
                                                  style: TextStyle(
                                                      fontSize: height * 0.022,
                                                      fontFamily: "Inter",
                                                      color:
                                                      const Color.fromRGBO(28, 78, 80, 1),
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                              // Padding(
                                              //   padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                              //   child: Text(
                                              //     "Please note, Test paper will automatically become Practice paper after End Date & Time.",
                                              //     style: TextStyle(
                                              //         fontSize: height * 0.014,
                                              //         fontFamily: "Inter",
                                              //         color: const Color.fromRGBO(102, 102, 102, 1),
                                              //         fontWeight: FontWeight.w400),
                                              //   ),
                                              // ),
                                              Divider(
                                                thickness: 2,
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Category: ",
                                                      style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color.fromRGBO(102, 102, 102, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${createAssessment.assessmentType}",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Number of Attempts: ",
                                                      style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color.fromRGBO(102, 102, 102, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${createAssessment.assessmentSettings?.allowedNumberOfTestRetries}",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Guest Students: ",
                                                      style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color.fromRGBO(102, 102, 102, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      createAssessment.assessmentSettings!.allowGuestStudent!?"Allowed":"Not Allowed",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Answer Sheet in Practice: ",
                                                      style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color.fromRGBO(102, 102, 102, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      createAssessment.assessmentSettings!.showAnswerSheetDuringPractice!?"Viewable":"Not Viewable",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Published in LOOQ: ",
                                                      style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color.fromRGBO(102, 102, 102, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      createAssessment.assessmentSettings!.avalabilityForPractice!?"Yes":"No",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Advisor Name: ",
                                                      style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color.fromRGBO(102, 102, 102, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      createAssessment.assessmentSettings!.showAdvisorName!?createAssessment.assessmentSettings!.advisorName!:"-",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Advisor Email: ",
                                                      style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color.fromRGBO(102, 102, 102, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      createAssessment.assessmentSettings!.showAdvisorEmail!?createAssessment.assessmentSettings!.advisorEmail!:"-",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.015),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Whatsapp Group Link: ",
                                                      style: TextStyle(
                                                        fontSize: height * 0.016,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color.fromRGBO(102, 102, 102, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      "-",
                                                      style: TextStyle(
                                                          fontSize: height * 0.016,
                                                          fontFamily: "Inter",
                                                          color: const Color.fromRGBO(102, 102, 102, 1),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * 0.08,
                                          width: width,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color.fromRGBO(153, 153, 153, 0.5),),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left : width * 0.03,top: height * 0.03),
                                                child: Text(
                                                  "Questions",
                                                  style: TextStyle(
                                                      fontSize: height * 0.022,
                                                      fontFamily: "Inter",
                                                      color:
                                                      const Color.fromRGBO(28, 78, 80, 1),
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      for(int i=0;i<questionList!.length;i++)
                                        QuestionCard(width: width, height: height, question: questionList![i],index: i,)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Padding(
                                padding: EdgeInsets.only(right:width * 0.02,left: width * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                        minimumSize: const Size(280, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(39),
                                        ),
                                      ),
                                      onPressed: () async {
                                        Provider.of<QuestionPrepareProviderFinal>(context,
                                            listen: false)
                                            .reSetQuestionList();
                                        Provider.of<EditAssessmentProvider>(context,
                                            listen: false)
                                            .resetAssessment();
                                        Provider.of<CreateAssessmentProvider>(context,
                                            listen: false)
                                            .resetAssessment();
                                        Navigator.of(context).pushNamedAndRemoveUntil('/assessmentLandingPage', ModalRoute.withName('/teacherSelectionPage'));

                                      },
                                      child: Text(

                                        //AppLocalizations.of(context)!.qn_button,
                                        'Go to My Assessments',
                                        style: TextStyle(
                                            fontSize: height * 0.025,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),

                                ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )));
          }

        }
    );
  }
}

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    super.key,
    required this.width,
    required this.height,
    required this.question,
    required this.index
  });

  final double width;
  final double height;
  final questionModel.Question question;
  final int index;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String ans='';

  @override
  void initState() {
    // TODO: implement initState
    if(widget.question.questionType=="MCQ"){
      for(int i=0;i<widget.question.choices!.length;i++){
        if(widget.question.choices![i].rightChoice!){
          ans=ans + widget.question.choices![i].choiceText!;
        }
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(82, 165, 160, 0.2),),
          borderRadius: BorderRadius.all(
              Radius.circular(10)),
          color: Color.fromRGBO(82, 165, 160, 0.07),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only( left : widget.width * 0.03),
                  child: Text(
                    //AppLocalizations.of(context)!.my_qn_bank,
                    "${widget.index+1}  ${widget.question.questionType}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color.fromRGBO(82, 165, 160, 1),
                      fontSize: widget.height * 0.018,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(15)),
                    color: Color.fromRGBO(28, 78, 80, 1),
                  ),
                  height: widget.height * 0.04,
                  width: webWidth * 0.13,
                  child: Center(
                    child: Text(
                      "+${widget.question.questionMark}",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge
                          ?.merge(TextStyle(
                          color:
                          const Color.fromRGBO(
                              255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontWeight:
                          FontWeight.w400,
                          fontSize:
                          widget.height * 0.02)),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: widget.height * 0.01),
            Padding(
              padding: EdgeInsets.only( left : widget.width * 0.03),
              child: Text(
                //AppLocalizations.of(context)!.my_qn_bank,
                "${widget.question.question}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color.fromRGBO(51, 51, 51, 1),
                  fontSize: widget.height * 0.016,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: widget.height * 0.01),
            Padding(
              padding: EdgeInsets.only( left : widget.width * 0.03),
              child: Text(
                //AppLocalizations.of(context)!.my_qn_bank,
                "Answer: $ans",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color.fromRGBO(82, 165, 160, 1),
                  fontSize: widget.height * 0.018,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: widget.height * 0.01),
            Padding(
              padding: EdgeInsets.only( left : widget.width * 0.03),
              child: Text(
                //AppLocalizations.of(context)!.my_qn_bank,
                "Advisor:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color.fromRGBO(82, 165, 160, 1),
                  fontSize: widget.height * 0.018,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: widget.height * 0.01),
            Padding(
              padding: EdgeInsets.only( left : widget.width * 0.03),
              child: Text(
                //AppLocalizations.of(context)!.my_qn_bank,
                "${widget.question.advisorText}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color.fromRGBO(51, 51, 51, 1),
                  fontSize: widget.height * 0.016,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: widget.height * 0.01),
            Padding(
              padding: EdgeInsets.only( left : widget.width * 0.03),
              child: Row(
                children: [
                  Text(
                    //AppLocalizations.of(context)!.my_qn_bank,
                    "URL: ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color.fromRGBO(51, 51, 51, 1),
                      fontSize: widget.height * 0.016,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      //AppLocalizations.of(context)!.my_qn_bank,
                      "${widget.question.advisorUrl}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: const Color.fromRGBO(58, 137, 210, 1),
                        fontSize: widget.height * 0.016,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: widget.height * 0.01),
          ],
        ),
      ),
    );
  }
}

