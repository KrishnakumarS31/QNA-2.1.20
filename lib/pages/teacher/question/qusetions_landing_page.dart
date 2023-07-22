import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/Teacher/question_entity.dart';
import '../../../Components/custom_incorrect_popup.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import '../../../Entity/Teacher/response_entity.dart';
import '../../../Entity/user_details.dart';
import '../../../Providers/LanguageChangeProvider.dart';
import '../../../Providers/question_prepare_provider_final.dart';
import '../../../Services/qna_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_global_question_popup.dart';
import 'edit_question_popup.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:qna_test/DataSource/design.dart';

class TeacherQuestionBank extends StatefulWidget {
  const TeacherQuestionBank({
    Key? key,
  }) : super(key: key);



  @override
  TeacherQuestionBankState createState() => TeacherQuestionBankState();
}

class TeacherQuestionBankState extends State<TeacherQuestionBank> {
  bool agree = true;
  int pageNumber = 1;
  int globalPageLimit = 10;
  int globalPageNumber = 1;
  List<Question> questionList = [];
  String searchVal = '';
  TextEditingController teacherQuestionBankSearchController =
  TextEditingController();
  SharedPreferences? loginData;
  UserDetails userDetails=UserDetails();
  bool onlyMyQuestion = true;
  bool myQuestion =true;
  int questionStart=0;
  List<Question>? questions = [];
  QuestionResponse? questionResponse;
  //-----------------------------------------------------


  @override
  void initState() {
    super.initState();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    getInitData('');
  }

  getInitData(String search) async {
    ResponseEntity responseEntity =
    await QnaService.getQuestionBankService(10, pageNumber, search,userDetails);
    List<Question>? questions;
    if (responseEntity.code == 200) {
      questionResponse = QuestionResponse.fromJson(responseEntity.data);
      questions = questionResponse?.questions;
    }
    else{
      setState(() {
        questionStart=questionStart-10;
      });
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: CustomDialog(
            title:
            AppLocalizations.of(context)!.alert_popup,
            //'Alert',
            content:
            AppLocalizations.of(context)!.no_question_found,
            //'No Questions Found.',
            button:
            AppLocalizations.of(context)!.retry,
            //"Retry",
          ),
        ),
      );
    }
    setState(() {
      questionList=[];
      questionList.addAll(questions!);
      pageNumber++;
      searchVal = search;
    });
    //Navigator.of(context).pop();
  }

  getData(String search) async {
    ResponseEntity responseEntity =
    await QnaService.getQuestionBankService(10, pageNumber, search,userDetails);
    QuestionResponse questionResponses;
    questionResponses = QuestionResponse.fromJson(responseEntity.data);
    print(responseEntity.toString());
    if (questionResponses.questions!.isNotEmpty) {
      questions = questionResponses.questions;
      setState(() {
        questionResponse=questionResponses;
        myQuestion=true;
        //questionList=[];
        questionList.addAll(questions!);
        pageNumber++;
        searchVal = search;
        questionResponses;
      });
    }
    else{
      setState(() {
        questionStart=questionStart-10;
      });
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: CustomDialog(
            title:
            AppLocalizations.of(context)!.alert_popup,
            //'Alert',
            content:
            AppLocalizations.of(context)!.no_question_found,
            //'No Questions Found.',
            button:
            AppLocalizations.of(context)!.retry,
            //"Retry",
          ),
        ),
      );
    }

    //Navigator.of(context).pop();
  }

  searchGlobalQuestion() async {
    print("inside global search");
    List<Question>? questions = [];
    ResponseEntity response =
    await QnaService.getSearchQuestion(10, pageNumber, teacherQuestionBankSearchController.text,userDetails);
    questionResponse = QuestionResponse.fromJson(response.data);
    if(questionResponse!.questions!.isNotEmpty){
      questions = questionResponse?.questions;
    }
    else{
      setState(() {
        questionStart=questionStart-10;
      });
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: CustomDialog(
            title:
            AppLocalizations.of(context)!.alert_popup,
            //'Alert',
            content:
            AppLocalizations.of(context)!.no_question_found,
            //'No Questions Found.',
            button:
            AppLocalizations.of(context)!.retry,
            //"Retry",
          ),
        ),
      );
    }

    setState(() {
      questionResponse;
      myQuestion=false;
      //questionList=[];
      questionList.addAll(questions!);
      //globalPageLimit +=10;
      pageNumber++;
      searchVal = teacherQuestionBankSearchController.text;
      print(questionList.length);
    });
    //Navigator.of(context).pop();
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
                backgroundColor: Colors.white,
                appBar:
                AppBar(
                  iconTheme: IconThemeData(color: appBarChevronColor,size: height * 0.05),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: height * 0.06,
                      color: appBarChevronColor,
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
                          //AppLocalizations.of(context)!.my_qns,
                          "Question Bank",
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
                endDrawer: const EndDrawerMenuTeacher(),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.023,
                          left: height * 0.045,
                          right: height * 0.045
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            //AppLocalizations.of(context)!.lib_online_qn,
                            "Search Questions ",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.0175,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: height * 0.005),
                          TextField(
                            onChanged: (t){
                              setState(() {
                              });
                            },
                            controller: teacherQuestionBankSearchController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintStyle: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 0.3),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: height * 0.016),
                              hintText: "Subject, Topic, Degree",
                              suffixIcon:
                              Column(children: [
                                Container(
                                    height: height * 0.035,
                                    width: width * 0.07,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // borderRadius:
                                      // BorderRadius.all(Radius.circular(100)),
                                      color: teacherQuestionBankSearchController.text.isEmpty?
                                      const Color.fromRGBO(153, 153, 153, 0.5):const Color.fromRGBO(82, 165, 160, 1),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        iconSize: height * 0.020,
                                        color: const Color.fromRGBO(255, 255, 255, 1),
                                        onPressed: () {
                                          setState(() {
                                            questionStart=0;
                                            questionList=[];
                                            pageNumber=1;
                                          });
                                          onlyMyQuestion?
                                          getData(teacherQuestionBankSearchController.text):
                                          searchGlobalQuestion();
                                        },
                                        icon: const Icon(Icons.search),
                                      ),
                                    )),
                              ]
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                //AppLocalizations.of(context)!.lib_online_qn,
                                "Show only my questions ",
                                style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: height * 0.016,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              FlutterSwitch(
                                activeColor: const Color
                                    .fromRGBO(
                                    82, 165, 160, 1),
                                inactiveColor:
                                const Color
                                    .fromRGBO(
                                    217,
                                    217,
                                    217,
                                    1),
                                width: 65.0,
                                height: 35.0,
                                value: onlyMyQuestion,
                                borderRadius: 30.0,
                                onToggle: (val) {
                                  setState(() {
                                    onlyMyQuestion = val;
                                    questionStart=0;
                                    pageNumber=1;
                                    questionList=[];
                                  });
                                  onlyMyQuestion?
                                  getData(teacherQuestionBankSearchController.text):
                                  searchGlobalQuestion();
                                },
                              ),

                            ],
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            //AppLocalizations.of(context)!.my_qn_bank,
                            "Tap the Question to view ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: const Color.fromRGBO(153, 153, 153, 1),
                              fontSize: height * 0.016,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Container(
                            height: height * 0.55,
                            width: width ,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10)),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  for (int i=questionStart;i<questionList.length;i++)
                                    Question_Card(height: height, width: width,question: questionList[i],myQuestion: myQuestion),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left:width *  0.02),
                                        child: Text(
                                          'Showing ${questionStart + 1} to ${questionStart+10 <questionList.length?questionStart+10:questionList.length} of ${questionResponse?.total_count}',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016),
                                        ),
                                      ),
                                      SizedBox(width: width * 0.25),
                                      Wrap(
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  if(questionStart==0){

                                                  }
                                                  else if(questionResponse!.total_count==questionList.length){
                                                    setState(() {
                                                      pageNumber--;
                                                      questionStart=questionStart-10;
                                                      questionList.removeRange(questionList.length-(questionResponse!.total_count!%10), questionList.length);
                                                    });
                                                  }
                                                  else if(questionList.length>10){
                                                    setState(() {
                                                      pageNumber--;
                                                      questionStart=questionStart-10;
                                                      questionList.removeRange(questionList.length-10, questionList.length);
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  height: height * 0.03,
                                                  width: width * 0.09,
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
                                                  width: width * 0.09,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(5)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '${questionStart==0?1:((questionStart/10)+1).toInt()}',
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
                                                  setState(() {
                                                    questionStart=questionStart+10;
                                                  });

                                                  onlyMyQuestion?
                                                  getData(teacherQuestionBankSearchController.text)
                                                      :searchGlobalQuestion();
                                                },
                                                child: Container(
                                                  height: height * 0.03,
                                                  width: width * 0.09,
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
                                      SizedBox(height: height * 0.05,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(children: [
                            SizedBox(height: height * 0.05),
                            Center(
                              child: SizedBox(
                                width: width * 0.8,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Colors.white,
                                      minimumSize: Size(width * 0.025, height * 0.05),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(39),
                                      ),
                                      side: const BorderSide(
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      )),
                                  onPressed: () {
                                    Provider.of<QuestionPrepareProviderFinal>(context,
                                        listen: false).reSetQuestionList();
                                    Navigator.pushNamed(context, '/createNewQuestion');
                                  },
                                  child: Text(
                                    //AppLocalizations.of(context)!.prepare_new_qn,
                                    'Create New Questions',
                                    style: TextStyle(
                                        fontSize: height * 0.025,
                                        fontFamily: "Inter",
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                          ]),
                        ],
                      )),
                ),
              ));
        }
        else if(constraints.maxWidth > 960)
        {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                appBar:
                AppBar(
                  iconTheme: IconThemeData(color: appBarChevronColor,size: height * 0.05),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: height * 0.06,
                      color: appBarChevronColor,
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
                          //AppLocalizations.of(context)!.my_qns,
                          "Question Bank",
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
                endDrawer: const EndDrawerMenuTeacher(),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.023,
                          left: height * 0.5,
                          right: height * 0.5
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            //AppLocalizations.of(context)!.lib_online_qn,
                            "Search Questions ",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.0175,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: height * 0.005),
                          TextField(
                            onChanged: (t){
                              setState(() {
                              });
                            },
                            controller: teacherQuestionBankSearchController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintStyle: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 0.3),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: height * 0.016),
                              hintText: "Subject, Topic, Degree",
                              suffixIcon:
                              Column(children: [
                                Container(
                                    height: height * 0.05,
                                    width: width * 0.07,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // borderRadius:
                                      // BorderRadius.all(Radius.circular(100)),
                                      color: teacherQuestionBankSearchController.text.isEmpty?
                                      const Color.fromRGBO(153, 153, 153, 0.5):const Color.fromRGBO(82, 165, 160, 1),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        iconSize: height * 0.020,
                                        color: const Color.fromRGBO(255, 255, 255, 1),
                                        onPressed: () {
                                          setState(() {
                                            questionStart=0;
                                            questionList=[];
                                            pageNumber=1;
                                          });
                                          onlyMyQuestion?
                                          getData(teacherQuestionBankSearchController.text):
                                          searchGlobalQuestion();
                                        },
                                        icon: const Icon(Icons.search),
                                      ),
                                    )),
                              ]
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                //AppLocalizations.of(context)!.lib_online_qn,
                                "Show only my questions ",
                                style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: height * 0.016,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              FlutterSwitch(
                                activeColor: const Color
                                    .fromRGBO(
                                    82, 165, 160, 1),
                                inactiveColor:
                                const Color
                                    .fromRGBO(
                                    217,
                                    217,
                                    217,
                                    1),
                                width: 65.0,
                                height: 35.0,
                                value: onlyMyQuestion,
                                borderRadius: 30.0,
                                onToggle: (val) {
                                  setState(() {
                                    onlyMyQuestion = val;
                                    questionStart=0;
                                    pageNumber=1;
                                    questionList=[];
                                  });
                                  onlyMyQuestion?
                                  getData(teacherQuestionBankSearchController.text):
                                  searchGlobalQuestion();
                                },
                              ),

                            ],
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            //AppLocalizations.of(context)!.my_qn_bank,
                            "Tap the Question to view ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: const Color.fromRGBO(153, 153, 153, 1),
                              fontSize: height * 0.016,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Container(
                            height: height * 0.55,
                            width: width ,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10)),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  for (int i=questionStart;i<questionList.length;i++)
                                    Question_Card(height: height, width: width,question: questionList[i],myQuestion: myQuestion),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left:height * 0.01),
                                        child: Text(
                                          'Showing ${questionStart + 1} to ${questionStart+10 <questionList.length?questionStart+10:questionList.length} of ${questionResponse?.total_count}',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016),
                                        ),
                                      ),
                                      SizedBox(width: height * 0.28),
                                      Wrap(
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  if(questionStart==0){

                                                  }
                                                  else if(questionResponse!.total_count==questionList.length){
                                                    setState(() {
                                                      pageNumber--;
                                                      questionStart=questionStart-10;
                                                      questionList.removeRange(questionList.length-(questionResponse!.total_count!%10), questionList.length);
                                                    });
                                                  }
                                                  else if(questionList.length>10){
                                                    setState(() {
                                                      pageNumber--;
                                                      questionStart=questionStart-10;
                                                      questionList.removeRange(questionList.length-10, questionList.length);
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  height: height * 0.03,
                                                  width: height * 0.09,
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
                                                  width: height * 0.07,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(5)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '${questionStart==0?1:((questionStart/10)+1).toInt()}',
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
                                                  setState(() {
                                                    questionStart=questionStart+10;
                                                  });

                                                  onlyMyQuestion?
                                                  getData(teacherQuestionBankSearchController.text)
                                                      :searchGlobalQuestion();
                                                },
                                                child: Container(
                                                  height: height * 0.03,
                                                  width: height * 0.09,
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
                                      SizedBox(height: height * 0.05,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(children: [
                            SizedBox(height: height * 0.05),
                            Center(
                              child: SizedBox(
                                width: width * 0.8,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Colors.white,
                                      minimumSize: Size(width * 0.025, height * 0.05),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(39),
                                      ),
                                      side: const BorderSide(
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      )),
                                  onPressed: () {
                                    Provider.of<QuestionPrepareProviderFinal>(context,
                                        listen: false).reSetQuestionList();
                                    Navigator.pushNamed(context, '/createNewQuestion');
                                  },
                                  child: Text(
                                    //AppLocalizations.of(context)!.prepare_new_qn,
                                    'Create New Questions',
                                    style: TextStyle(
                                        fontSize: height * 0.025,
                                        fontFamily: "Inter",
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                          ]),
                        ],
                      )),
                ),
              ));
        }
        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                appBar:
                AppBar(
                  iconTheme: IconThemeData(color: appBarChevronColor,size: height * 0.05),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: height * 0.06,
                      color: appBarChevronColor,
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
                          //AppLocalizations.of(context)!.my_qns,
                          "Question Bank",
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

                endDrawer: const EndDrawerMenuTeacher(),
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
                          Text(
                            //AppLocalizations.of(context)!.lib_online_qn,
                            "Search Questions ",
                            style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: height * 0.016,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: height * 0.005),
                          TextField(
                            controller: teacherQuestionBankSearchController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              //floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintStyle: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 0.3),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: height * 0.016),
                              hintText: "Subject, Topic, Degree",
                              suffixIcon:
                              Column(children: [
                                Container(
                                    height: height * 0.053,
                                    width: width * 0.1,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      // borderRadius:
                                      // BorderRadius.all(Radius.circular(100)),
                                      color: Color.fromRGBO(153, 153, 153, 0.5),
                                    ),
                                    child: IconButton(
                                      iconSize: height * 0.025,
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      onPressed: () {
                                        questionList = [];
                                        pageNumber = 1;
                                        agree
                                            ? getData(
                                            teacherQuestionBankSearchController
                                                .text)

                                            :
                                        Navigator.pushNamed(
                                          context,
                                          '/teacherLooqQuestionBank',
                                          arguments: teacherQuestionBankSearchController
                                              .text,
                                        ).then((value) =>
                                            teacherQuestionBankSearchController
                                                .clear());
                                      },
                                      icon: const Icon(Icons.search),
                                    )),
                              ]
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                              ),
                            ),
                          ),

                          SizedBox(height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                //AppLocalizations.of(context)!.lib_online_qn,
                                "Show only my questions ",
                                style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: height * 0.016,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              FlutterSwitch(
                                activeColor: const Color
                                    .fromRGBO(
                                    82, 165, 160, 1),
                                inactiveColor:
                                const Color
                                    .fromRGBO(
                                    217,
                                    217,
                                    217,
                                    1),
                                width: 65.0,
                                height: 35.0,
                                value: onlyMyQuestion,
                                borderRadius: 30.0,
                                onToggle: (val) {
                                  setState(() {
                                    onlyMyQuestion = val;
                                    questionStart=0;
                                    pageNumber=1;
                                    questionList=[];
                                  });
                                  onlyMyQuestion?
                                  getData(teacherQuestionBankSearchController.text):
                                  searchGlobalQuestion();
                                },
                              ),

                            ],
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            //AppLocalizations.of(context)!.my_qn_bank,
                            "Tap the Question to view ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: const Color.fromRGBO(153, 153, 153, 1),
                              fontSize: height * 0.016,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Container(
                            height: height * 0.55,
                            width: width * 0.9,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10)),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  for (int i=questionStart;i<questionList.length;i++)
                                    Question_Card(height: height, width: width,question: questionList[i],myQuestion: myQuestion),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Showing ${questionStart + 1} to ${questionStart+10 <questionList.length?questionStart+10:questionList.length} of ${questionResponse?.total_count ?? 0}',
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
                                                  if(questionStart==0){

                                                  }
                                                  else if(questionResponse!.total_count==questionList.length){
                                                    setState(() {
                                                      pageNumber--;
                                                      questionStart=questionStart-10;
                                                      questionList.removeRange(questionList.length-(questionResponse!.total_count!%10), questionList.length);
                                                    });
                                                  }
                                                  else if(questionList.length>10){
                                                    setState(() {
                                                      pageNumber--;
                                                      questionStart=questionStart-10;
                                                      questionList.removeRange(questionList.length-10, questionList.length);
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
                                                      '${questionStart==0?1:((questionStart/10)+1).toInt()}',
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
                                                  setState(() {
                                                    questionStart=questionStart+10;
                                                  });

                                                  onlyMyQuestion?
                                                  getData(teacherQuestionBankSearchController.text)
                                                      :searchGlobalQuestion();
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
                          ),


                          Column(children: [

                            SizedBox(height: height * 0.02),

                            Center(
                              child: SizedBox(
                                width: width * 0.8,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Colors.white,
                                      minimumSize: const Size(280, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(39),
                                      ),
                                      side: const BorderSide(
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      )),
                                  onPressed: () {
                                    Provider.of<QuestionPrepareProviderFinal>(context,
                                        listen: false).reSetQuestionList();
                                    Navigator.pushNamed(context, '/createNewQuestion');
                                  },
                                  child: Text(
                                    //AppLocalizations.of(context)!.prepare_new_qn,
                                    'Create New Questions',
                                    style: TextStyle(
                                        fontSize: height * 0.025,
                                        fontFamily: "Inter",
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                          ]),
                        ],
                      )),
                ),
              ));
        }
      },
    );
  }
}

class Question_Card extends StatefulWidget {
  const Question_Card({
    super.key,
    required this.height,
    required this.width,
    required this.question,
    required this.myQuestion
  });

  final double height;
  final double width;
  final Question question;
  final bool myQuestion;

  @override
  State<Question_Card> createState() => _Question_CardState();
}

class _Question_CardState extends State<Question_Card> {

  showQuestionPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditQuestionPopUp(
          question: widget.question,
        );
      },
    );
  }
  showGlobalQuestionPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditGlobalQuestionPopUp(
          question: widget.question,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.myQuestion?
          showQuestionPreview(context):
          showGlobalQuestionPreview(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: widget.width > 500 ? widget.height * 0.19 :widget.height * 0.22,
            width: widget.width * 0.85,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(82, 165, 160, 0.2),),
              borderRadius: const BorderRadius.all(
                  Radius.circular(10)),
              color: const Color.fromRGBO(82, 165, 160, 0.07),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      //AppLocalizations.of(context)!.my_qn_bank,
                      "${widget.question.subject} | ${widget.question.topic}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontSize: widget.height * 0.016,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: widget.height * 0.01),
                  SizedBox(
                    child: Text(
                      //AppLocalizations.of(context)!.my_qn_bank,
                      "${widget.question.degreeStudent}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontSize: widget.height * 0.016,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  //SizedBox(height: height * 0.01),
                  const Divider(
                    thickness: 2,
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                  ),
                  //SizedBox(height: height * 0.005),
                  SizedBox(
                    child: Text(
                      //AppLocalizations.of(context)!.my_qn_bank,
                      "${widget.question.questionType}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontSize: widget.height * 0.016,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: widget.height * 0.01),
                  SizedBox(
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
                ],
              ),),
          ),
        ),
      ),
    );
  }
}

class QuestionPreview extends StatelessWidget {
  const QuestionPreview({
    Key? key,
    required this.height,
    required this.width,
    required this.question,

  }) : super(key: key);

  final double height;
  final double width;
  final Question question;


  @override
  Widget build(BuildContext context) {
    String answer = '';
    if (question.choices == null) {
      question.choices = [];
    } else {
      for (int i = 0; i < question.choices!.length; i++) {
        answer = '$answer ${question.choices![i].choiceText}';
      }
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context,
                  '/questionEdit',
                  arguments: question
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: const Color.fromRGBO(82, 165, 160, 0.08),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        height: height * 0.04,
                        width: width * 0.95,
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.02, left: width * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    question.subject!,
                                    style: TextStyle(
                                        fontSize: height * 0.017,
                                        fontFamily: "Inter",
                                        color: const Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "  |  ${question.topic} - ${question.semester}",
                                    style: TextStyle(
                                        fontSize: height * 0.015,
                                        fontFamily: "Inter",
                                        color: const Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Text(
                                question.degreeStudent!,
                                style: TextStyle(
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.02, left: width * 0.02),
                          child: Text(
                            '${question.questionType}',
                            style: TextStyle(
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.02, left: width * 0.02),
                          child: Text(
                            question.question!,
                            style: TextStyle(
                                fontSize: height * 0.0175,
                                fontFamily: "Inter",
                                color: const Color.fromRGBO(51, 51, 51, 1),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      const Divider()
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
