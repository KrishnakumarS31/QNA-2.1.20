import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Components/custom_incorrect_popup.dart';
import '../Components/end_drawer_menu_student.dart';
import '../Components/today_date.dart';
import '../Entity/Teacher/get_assessment_header.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Entity/question_paper_model.dart';
import '../EntityModel/user_data_model.dart';
import '../Services/qna_service.dart';
class StudentAssessment extends StatefulWidget {
  StudentAssessment(
      {Key? key,
        required this.usedData})
      : super(key: key);

  UserDataModel? usedData;

  @override
  StudentAssessmentState createState() => StudentAssessmentState();
}

class StudentAssessmentState extends State<StudentAssessment> {
  TextEditingController assessmentIdController = TextEditingController();
  ResponseEntity assessmentvalues = ResponseEntity();
  GetAssessmentHeaderModel assessmentHeaderValues = GetAssessmentHeaderModel();
  var formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  late QuestionPaperModel values;
  UserDataModel userDataModel = UserDataModel(code: 0, message: '');
  String name = "Student";
  String email = "Student@gmail.com";
  String assessmentId = "";
  late int userId;
  bool _searchPressed = false;
  bool _notPressedYes = false;
  bool _notPressedNo = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      userId = widget.usedData!.data!.id;
      name = widget.usedData!.data!.firstName;
      email = widget.usedData!.data!.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                //extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon:  Icon(
                        Icons.chevron_left,
                        size: width * 0.08,
                        color: Colors.black,
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
                    iconTheme: IconThemeData(color: Colors.black,size: width * 0.08),
                  ),
                  endDrawer: EndDrawerMenuStudent(),
                  body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.050,
                              left: height * 0.040,
                              right: height * 0.040
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: width * 0.4),
                                // Container(
                                //   width: width,
                                //   margin: EdgeInsets.only(left: width * 0.1),
                                //child: Column(children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context)!.welcome,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.035),
                                  ),
                                ),
                                // SizedBox(
                                //   height: height * 0.001,
                                // ),
                                SizedBox(
                                  width: width,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        name,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyLarge
                                            ?.merge(TextStyle(
                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.03)),
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.08,
                                ),
                                //]),
                                // ),
                                // Container(
                                //   //margin: const EdgeInsets.only(left: 10,right: 50),
                                //   padding: const EdgeInsets.only(left: 30, right: 30),
                                //child:
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: AppLocalizations.of(context)!
                                                    .enter_assId,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: height * 0.020),
                                              ),
                                            ])),
                                      ),
                                      SizedBox(
                                        height: height * 0.0016,
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(right: height * 0.045),
                                              child: Form(
                                                  key: formKey,
                                                  autovalidateMode:
                                                  AutovalidateMode.disabled,
                                                  child: SizedBox(
                                                    width:width * 0.9,
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          return value!.length < 8
                                                              ? AppLocalizations.of(
                                                              context)!
                                                              .valid_assId
                                                              : null;
                                                        },
                                                        controller: assessmentIdController,
                                                        onChanged: (val) {
                                                          formKey.currentState!
                                                              .validate();
                                                        },
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(
                                                              RegExp('[a-zA-Z0-9]')),
                                                        ],
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          helperStyle: TextStyle(
                                                              color: Colors.blue,
                                                              // Color.fromRGBO(
                                                              //     102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: AppLocalizations.of(
                                                              context)!
                                                              .assessment_id,
                                                          suffixIcon: GestureDetector(
                                                            onTap: () async {
                                                              assessmentvalues = await QnaService.getAssessmentHeader(assessmentIdController.text);
                                                              if(assessmentvalues.code == 200) {
                                                                setState(() {
                                                                  assessmentHeaderValues =
                                                                      GetAssessmentHeaderModel
                                                                          .fromJson(
                                                                          assessmentvalues
                                                                              .data);
                                                                  _searchPressed = true;
                                                                });
                                                              }
                                                              else{
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type:
                                                                    PageTransitionType.rightToLeft,
                                                                    child: CustomDialog(
                                                                      title: '${values.message}',
                                                                      content: '',
                                                                      button:
                                                                      AppLocalizations.of(context)!
                                                                          .retry,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            child: IconButton(
                                                              onPressed: () async {
                                                                assessmentvalues = await QnaService.getAssessmentHeader(assessmentIdController.text);
                                                                if(assessmentvalues.code == 200) {
                                                                  setState(() {
                                                                    assessmentHeaderValues =
                                                                        GetAssessmentHeaderModel
                                                                            .fromJson(
                                                                            assessmentvalues
                                                                                .data);
                                                                    _searchPressed = true;
                                                                  });
                                                                }
                                                                else if (assessmentvalues.code == 400) {
                                                                  Navigator.push(
                                                                    context,
                                                                    PageTransition(
                                                                      type:
                                                                      PageTransitionType.rightToLeft,
                                                                      child: CustomDialog(
                                                                        title: '${assessmentvalues.message}',
                                                                        content: '',
                                                                        button:
                                                                        AppLocalizations.of(context)!
                                                                            .retry,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              color:  const Color.fromRGBO(82, 165, 160, 1),
                                                              icon: const Icon(Icons.search_rounded),),
                                                          ),
                                                          // prefixIcon:
                                                          // const Icon(
                                                          //     Icons.event_note_outlined,
                                                          //     color: Color.fromRGBO(
                                                          //         82, 165, 160, 1)),
                                                        )),
                                                  )
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ]),
                                SizedBox(height: width * 0.1,),
                                _searchPressed ?
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      width: width * 0.79,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromRGBO(82, 165, 160, 0.2)
                                        ),
                                      ),
                                      child: Column(
                                          children:[
                                            Container(
                                              height: height * 0.1087,
                                              width: width * 0.79,
                                              decoration: BoxDecoration(
                                                //borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
                                                              assessmentHeaderValues.subject ?? "",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                                fontSize: height * 0.0175,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            Text(
                                                              " | ${assessmentHeaderValues.topic ?? " "}",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                                fontSize: height * 0.0175,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
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
                                                              assessmentHeaderValues.subTopic ?? "",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                                fontSize: height * 0.0175,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            Text(
                                                              " | ${assessmentHeaderValues.getAssessmentModelClass}",
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
                                                              Text("${assessmentIdController.text}",
                                                                style: TextStyle(
                                                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                                                  fontSize: height * 0.015,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ],),
                                                          Text(
                                                            assessmentHeaderValues.assessmentStartdate != 0 && assessmentHeaderValues.assessmentStartdate !=null ? convertDate(assessmentHeaderValues.assessmentStartdate) : " ",
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
                                            ),
                                            SizedBox(height: width *0.05),
                                            Column(
                                              children: [
                                                Padding(
                                                  //alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.only(left: height * 0.01),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width: width,
                                                          child: Text("Is this the assessment you want to take?"
                                                            ,style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontSize: height * 0.0195,
                                                              fontFamily: "Inter",
                                                              fontWeight: FontWeight.w400,
                                                            ), ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                                SizedBox(height: width * 0.05),
                                                SizedBox(
                                                  width:width,
                                                  child: Padding(
                                                    //alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.only(left: height * 0.01),
                                                    child: Text("Please note, once you start a test, you"
                                                      ,style: TextStyle(
                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                        fontSize: height * 0.0195,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                      ), ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:width,
                                                  child: Padding(
                                                    //alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.only(left: height * 0.01),
                                                    child: Text("must complete it."
                                                      ,style: TextStyle(
                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                        fontSize: height * 0.0195,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                      ), ),
                                                  ),
                                                ),
                                                SizedBox(height: height * 0.03)
                                                ,                                     Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: _notPressedYes ?
                                                        const Color.fromRGBO(82, 165, 160, 1) : Colors.white,
                                                        minimumSize: const Size(90, 35),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(39),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        setState(() {
                                                          _notPressedYes = true;
                                                          _notPressedNo = false;
                                                        });
                                                        values = await QnaService.getQuestion(
                                                            assessmentId: assessmentIdController.text);
                                                        if (assessmentIdController.text.length >= 8) {
                                                          if (values.code == 200) {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/studQuestion',
                                                                arguments: [
                                                                  assessmentIdController.text,
                                                                  values,name,
                                                                  null,
                                                                  false
                                                                ]);
                                                          }
                                                        }
                                                        else {
                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type: PageTransitionType.rightToLeft,
                                                              child: CustomDialog(
                                                                title: '${values.message}',
                                                                content: '',
                                                                button:
                                                                AppLocalizations.of(context)!
                                                                    .retry,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Text(
                                                        AppLocalizations.of(context)!.yes,
                                                        style: TextStyle(
                                                            color: _notPressedYes ?
                                                            Colors.white : const Color.fromRGBO(82, 165, 160, 1) ,
                                                            fontSize: height * 0.02,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: _notPressedNo ?
                                                        const Color.fromRGBO(82, 165, 160, 1) : Colors.white,
                                                        minimumSize: const Size(90, 35),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(39),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _notPressedNo = true;
                                                          _notPressedYes = false;
                                                          _searchPressed = false;
                                                        });

                                                      },
                                                      child: Text(
                                                        AppLocalizations.of(context)!.no,
                                                        style: TextStyle(
                                                            color: _notPressedNo ?
                                                            Colors.white : const Color.fromRGBO(82, 165, 160, 1) ,
                                                            fontSize: height * 0.02,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                    SizedBox(height: height * 0.09)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ])

                                  ),
                                )
                                    : const SizedBox(),
                              ])))));
        }
        else if(constraints.maxWidth > 960)
        {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                //extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon:  const Icon(
                        Icons.chevron_left,
                        size: 40.0,
                        color: Colors.black,
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
                    iconTheme: const IconThemeData(color: Colors.black,size: 40.0),
                  ),
                  endDrawer: EndDrawerMenuStudent(),
                  body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.050,
                              left: height * 0.5,
                              right: height * 0.5
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: width * 0.4),
                                // Container(
                                //   width: width,
                                //   margin: EdgeInsets.only(left: width * 0.1),
                                //child: Column(children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context)!.welcome,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.035),
                                  ),
                                ),
                                // SizedBox(
                                //   height: height * 0.001,
                                // ),
                                SizedBox(
                                  width: width,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        name,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyLarge
                                            ?.merge(TextStyle(
                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.03)),
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.08,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: AppLocalizations.of(context)!
                                                    .enter_assId,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: height * 0.020),
                                              ),
                                            ])),
                                      ),
                                      SizedBox(
                                        height: height * 0.0016,
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(right: height * 0.045),
                                              child: Form(
                                                  key: formKey,
                                                  autovalidateMode:
                                                  AutovalidateMode.disabled,
                                                  child: SizedBox(
                                                    width:width * 0.9,
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          return value!.length < 8
                                                              ? AppLocalizations.of(
                                                              context)!
                                                              .valid_assId
                                                              : null;
                                                        },
                                                        controller: assessmentIdController,
                                                        onChanged: (val) {
                                                          formKey.currentState!
                                                              .validate();
                                                        },
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(
                                                              RegExp('[a-zA-Z0-9]')),
                                                        ],
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          helperStyle: TextStyle(
                                                              color: const Color.fromRGBO(
                                                                  102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: AppLocalizations.of(
                                                              context)!
                                                              .assessment_id,
                                                          suffixIcon: GestureDetector(

                                                            onTap: () async {
                                                              assessmentvalues = await QnaService.getAssessmentHeader(assessmentIdController.text);
                                                              if(assessmentvalues.code == 200) {
                                                                setState(() {
                                                                  assessmentHeaderValues =
                                                                      GetAssessmentHeaderModel
                                                                          .fromJson(
                                                                          assessmentvalues
                                                                              .data);
                                                                  _searchPressed = true;
                                                                });
                                                              }
                                                              else{
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type:
                                                                    PageTransitionType.rightToLeft,
                                                                    child: CustomDialog(
                                                                      title: '${values.message}',
                                                                      content: '',
                                                                      button:
                                                                      AppLocalizations.of(context)!
                                                                          .retry,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            child: IconButton( onPressed: () async {
                                                              assessmentvalues = await QnaService.getAssessmentHeader(assessmentIdController.text);
                                                              if(assessmentvalues.code == 200) {
                                                                setState(() {
                                                                  assessmentHeaderValues =
                                                                      GetAssessmentHeaderModel
                                                                          .fromJson(
                                                                          assessmentvalues
                                                                              .data);
                                                                  _searchPressed = true;
                                                                });
                                                              }
                                                              else if (assessmentvalues.code == 400) {
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type:
                                                                    PageTransitionType.rightToLeft,
                                                                    child: CustomDialog(
                                                                      title: '${assessmentvalues.message}',
                                                                      content: '',
                                                                      button:
                                                                      AppLocalizations.of(context)!
                                                                          .retry,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                              color:  const Color.fromRGBO(82, 165, 160, 1),
                                                              icon: const Icon(Icons.search_rounded),),
                                                          ),
                                                          // prefixIcon:
                                                          // const Icon(
                                                          //     Icons.event_note_outlined,
                                                          //     color: Color.fromRGBO(
                                                          //         82, 165, 160, 1)),
                                                        )),
                                                  )
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ]),
                                SizedBox(height: width * 0.05),
                                _searchPressed ?
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      width: width * 0.48,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromRGBO(82, 165, 160, 0.2)
                                        ),
                                      ),
                                      child: Column(
                                          children:[
                                            Container(
                                              height: height * 0.1087,
                                              width: width * 0.48,
                                              decoration: BoxDecoration(
                                                //borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
                                                    EdgeInsets.only(left: width * 0.01, right: width * 0.01),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              assessmentHeaderValues.subject ?? "",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                                fontSize: height * 0.0175,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            Text(
                                                              " | ${assessmentHeaderValues.topic ?? " "}",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                                fontSize: height * 0.0175,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.only(left: width * 0.01, right: width * 0.01),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              assessmentHeaderValues.subTopic ?? "",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                                fontSize: height * 0.0175,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            Text(
                                                              " | ${assessmentHeaderValues.getAssessmentModelClass}",
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
                                                    padding: EdgeInsets.only(left: width * 0.01, right: width * 0.01),
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
                                                              Text("${assessmentIdController.text}",
                                                                style: TextStyle(
                                                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                                                  fontSize: height * 0.015,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ],),
                                                          Text(
                                                            assessmentHeaderValues.assessmentStartdate != 0 && assessmentHeaderValues.assessmentStartdate !=null ? convertDate(assessmentHeaderValues.assessmentStartdate) : " ",
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
                                            ),
                                            SizedBox(height: width *0.02),
                                            Column(
                                              children: [
                                                Padding(
                                                  //alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.only(left: height * 0.01),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width: width,
                                                          child: Text("Is this the assessment you want to take?"
                                                            ,style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontSize: height * 0.0195,
                                                              fontFamily: "Inter",
                                                              fontWeight: FontWeight.w400,
                                                            ), ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                                SizedBox(height: width * 0.02),
                                                SizedBox(
                                                  width:width,
                                                  child: Padding(
                                                    //alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.only(left: height * 0.01),
                                                    child: Text("Please note, once you start a test, you"
                                                      ,style: TextStyle(
                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                        fontSize: height * 0.0195,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                      ), ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:width,
                                                  child: Padding(
                                                    //alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.only(left: height * 0.01),
                                                    child: Text("must complete it."
                                                      ,style: TextStyle(
                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                        fontSize: height * 0.0195,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                      ), ),
                                                  ),
                                                ),
                                                SizedBox(height: height * 0.02),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: _notPressedYes ?
                                                        const Color.fromRGBO(82, 165, 160, 1) : Colors.white,
                                                        minimumSize: const Size(90, 35),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(39),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        setState(() {
                                                          _notPressedYes = true;
                                                          _notPressedNo = false;
                                                        });
                                                        values = await QnaService.getQuestion(
                                                            assessmentId: assessmentIdController.text);
                                                        if (assessmentIdController.text.length >= 8) {
                                                          if (values.code == 200) {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/studQuestion',
                                                                arguments: [
                                                                  assessmentIdController.text,
                                                                  values,
                                                                  name,
                                                                  null,
                                                                  false
                                                                ]);
                                                          }
                                                        }
                                                        else {
                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type: PageTransitionType.rightToLeft,
                                                              child: CustomDialog(
                                                                title: '${values.message}',
                                                                content: '',
                                                                button:
                                                                AppLocalizations.of(context)!
                                                                    .retry,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Text(
                                                        AppLocalizations.of(context)!.yes,
                                                        style: TextStyle(
                                                            color: _notPressedYes ?
                                                            Colors.white : const Color.fromRGBO(82, 165, 160, 1) ,
                                                            fontSize: height * 0.02,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: _notPressedNo ?
                                                        const Color.fromRGBO(82, 165, 160, 1) : Colors.white,
                                                        minimumSize: const Size(90, 35),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(39),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _notPressedNo = true;
                                                          _notPressedYes = false;
                                                          _searchPressed = false;
                                                        });

                                                      },
                                                      child: Text(
                                                        AppLocalizations.of(context)!.no,
                                                        style: TextStyle(
                                                            color: _notPressedNo ?
                                                            Colors.white : const Color.fromRGBO(82, 165, 160, 1) ,
                                                            fontSize: height * 0.02,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                    SizedBox(height: width * 0.05),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ])

                                  ),
                                )
                                    : const SizedBox(),
                              ])))));
        }
        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                //extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon:  Icon(
                        Icons.chevron_left,
                        size: width * 0.08,
                        color: Colors.black,
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
                    iconTheme: IconThemeData(color: Colors.black,size: width * 0.08),
                  ),
                  endDrawer: EndDrawerMenuStudent(),
                  body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.050,
                              left: height * 0.040,
                              right: height * 0.040
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: width * 0.4),
                                // Container(
                                //   width: width,
                                //   margin: EdgeInsets.only(left: width * 0.1),
                                //child: Column(children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context)!.welcome,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.035),
                                  ),
                                ),
                                // SizedBox(
                                //   height: height * 0.001,
                                // ),
                                SizedBox(
                                  width: width,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        name,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyLarge
                                            ?.merge(TextStyle(
                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.03)),
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.08,
                                ),
                                //]),
                                // ),
                                // Container(
                                //   //margin: const EdgeInsets.only(left: 10,right: 50),
                                //   padding: const EdgeInsets.only(left: 30, right: 30),
                                //child:
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: AppLocalizations.of(context)!
                                                    .enter_assId,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: height * 0.020),
                                              ),
                                            ])),
                                      ),
                                      SizedBox(
                                        height: height * 0.0016,
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(right: height * 0.045),
                                              child: Form(
                                                  key: formKey,
                                                  autovalidateMode:
                                                  AutovalidateMode.disabled,
                                                  child: SizedBox(
                                                    width:width * 0.9,
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          return value!.length < 8
                                                              ? AppLocalizations.of(
                                                              context)!
                                                              .valid_assId
                                                              : null;
                                                        },
                                                        controller: assessmentIdController,
                                                        onChanged: (val) {
                                                          formKey.currentState!
                                                              .validate();
                                                        },
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(
                                                              RegExp('[a-zA-Z0-9]')),
                                                        ],
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          helperStyle: TextStyle(
                                                              color: Colors.blue,
                                                              // Color.fromRGBO(
                                                              //     102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: AppLocalizations.of(
                                                              context)!
                                                              .assessment_id,
                                                          suffixIcon: GestureDetector(
                                                            onTap: () async {
                                                              assessmentvalues = await QnaService.getAssessmentHeader(assessmentIdController.text);
                                                              if(assessmentvalues.code == 200) {
                                                                setState(() {
                                                                  assessmentHeaderValues =
                                                                      GetAssessmentHeaderModel
                                                                          .fromJson(
                                                                          assessmentvalues
                                                                              .data);
                                                                  _searchPressed = true;
                                                                });
                                                              }
                                                              else{
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type:
                                                                    PageTransitionType.rightToLeft,
                                                                    child: CustomDialog(
                                                                      title: '${values.message}',
                                                                      content: '',
                                                                      button:
                                                                      AppLocalizations.of(context)!
                                                                          .retry,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            child: IconButton(
                                                              onPressed: () async {
                                                                assessmentvalues = await QnaService.getAssessmentHeader(assessmentIdController.text);
                                                                if(assessmentvalues.code == 200) {
                                                                  setState(() {
                                                                    assessmentHeaderValues =
                                                                        GetAssessmentHeaderModel
                                                                            .fromJson(
                                                                            assessmentvalues
                                                                                .data);
                                                                    _searchPressed = true;
                                                                  });
                                                                }
                                                                else if (assessmentvalues.code == 400) {
                                                                  Navigator.push(
                                                                    context,
                                                                    PageTransition(
                                                                      type:
                                                                      PageTransitionType.rightToLeft,
                                                                      child: CustomDialog(
                                                                        title: '${assessmentvalues.message}',
                                                                        content: '',
                                                                        button:
                                                                        AppLocalizations.of(context)!
                                                                            .retry,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              color:  const Color.fromRGBO(82, 165, 160, 1),
                                                              icon: const Icon(Icons.search_rounded),),
                                                          ),
                                                          // prefixIcon:
                                                          // const Icon(
                                                          //     Icons.event_note_outlined,
                                                          //     color: Color.fromRGBO(
                                                          //         82, 165, 160, 1)),
                                                        )),
                                                  )
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ]),
                                SizedBox(height: width * 0.1,),
                                _searchPressed ?
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      width: width * 0.79,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromRGBO(82, 165, 160, 0.2)
                                        ),
                                      ),
                                      child: Column(
                                          children:[
                                            Container(
                                              height: height * 0.1087,
                                              width: width * 0.79,
                                              decoration: BoxDecoration(
                                                //borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
                                                              assessmentHeaderValues.subject ?? "",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                                fontSize: height * 0.0175,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            Text(
                                                              " | ${assessmentHeaderValues.topic ?? " "}",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                                fontSize: height * 0.0175,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
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
                                                              assessmentHeaderValues.subTopic ?? "",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                                fontSize: height * 0.0175,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            Text(
                                                              " | ${assessmentHeaderValues.getAssessmentModelClass}",
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
                                                              Text("${assessmentIdController.text}",
                                                                style: TextStyle(
                                                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                                                  fontSize: height * 0.015,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ],),
                                                          Text(
                                                            assessmentHeaderValues.assessmentStartdate != 0 && assessmentHeaderValues.assessmentStartdate !=null ? convertDate(assessmentHeaderValues.assessmentStartdate) : " ",
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
                                            ),
                                            SizedBox(height: width *0.05),
                                            Column(
                                              children: [
                                                Padding(
                                                  //alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.only(left: height * 0.01),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width: width,
                                                          child: Text("Is this the assessment you want to take?"
                                                            ,style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontSize: height * 0.0195,
                                                              fontFamily: "Inter",
                                                              fontWeight: FontWeight.w400,
                                                            ), ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                                SizedBox(height: width * 0.05),
                                                SizedBox(
                                                  width:width,
                                                  child: Padding(
                                                    //alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.only(left: height * 0.01),
                                                    child: Text("Please note, once you start a test, you"
                                                      ,style: TextStyle(
                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                        fontSize: height * 0.0195,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                      ), ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:width,
                                                  child: Padding(
                                                    //alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.only(left: height * 0.01),
                                                    child: Text("must complete it."
                                                      ,style: TextStyle(
                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                        fontSize: height * 0.0195,
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                      ), ),
                                                  ),
                                                ),
                                                SizedBox(height: height * 0.03)
                                                ,                                     Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: _notPressedYes ?
                                                        const Color.fromRGBO(82, 165, 160, 1) : Colors.white,
                                                        minimumSize: const Size(90, 35),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(39),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        setState(() {
                                                          _notPressedYes = true;
                                                          _notPressedNo = false;
                                                        });
                                                        values = await QnaService.getQuestion(
                                                            assessmentId: assessmentIdController.text);
                                                        if (assessmentIdController.text.length >= 8) {
                                                          if (values.code == 200) {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/studQuestion',
                                                                arguments: [
                                                                  assessmentIdController.text,
                                                                  values,
                                                                  name,
                                                                  null,
                                                                  false
                                                                ]);
                                                          }
                                                        }
                                                        else {
                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type: PageTransitionType.rightToLeft,
                                                              child: CustomDialog(
                                                                title: '${values.message}',
                                                                content: '',
                                                                button:
                                                                AppLocalizations.of(context)!
                                                                    .retry,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Text(
                                                        AppLocalizations.of(context)!.yes,
                                                        style: TextStyle(
                                                            color: _notPressedYes ?
                                                            Colors.white : const Color.fromRGBO(82, 165, 160, 1) ,
                                                            fontSize: height * 0.02,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: _notPressedNo ?
                                                        const Color.fromRGBO(82, 165, 160, 1) : Colors.white,
                                                        minimumSize: const Size(90, 35),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(39),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _notPressedNo = true;
                                                          _notPressedYes = false;
                                                          _searchPressed = false;
                                                        });

                                                      },
                                                      child: Text(
                                                        AppLocalizations.of(context)!.no,
                                                        style: TextStyle(
                                                            color: _notPressedNo ?
                                                            Colors.white : const Color.fromRGBO(82, 165, 160, 1) ,
                                                            fontSize: height * 0.02,
                                                            fontFamily: "Inter",
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                    SizedBox(height: height * 0.09)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ])

                                  ),
                                )
                                    : const SizedBox(),
                              ])))));
        }
      },
    );
  }
}
