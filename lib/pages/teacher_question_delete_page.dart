import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Providers/new_question_provider.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Components/custom_radio_option.dart';
import '../Entity/Teacher/choice_entity.dart';
import '../Entity/Teacher/question_entity.dart';
import '../Providers/question_prepare_provider.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Providers/question_prepare_provider_final.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../DataSource/http_url.dart';

class TeacherQuesDelete extends StatefulWidget {
  TeacherQuesDelete({
    Key? key,
    required this.quesNum,
    required this.finalQuestion,
    required this.assessment
  }) : super(key: key);

  final int quesNum;
  final Question finalQuestion;
  bool assessment;

  @override
  TeacherQuesDeleteState createState() => TeacherQuesDeleteState();
}

class TeacherQuesDeleteState extends State<TeacherQuesDelete> {
  String? _groupValue;
  List<Choice>? selected = [];
  TextEditingController subjectController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController adviceController = TextEditingController();
  TextEditingController subtopicController = TextEditingController();
  TextEditingController classRoomController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  IconData showIcon = Icons.arrow_circle_up_outlined;
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  List<Choice> tempChoiceList = [];

  ValueChanged<String?> _valueChangedHandler(BuildContext context,double height) {
    return (value) {
      if(value=='Descriptive'){
        showAlertDesDialog(context,height,value);
      }
      else{
        setState(() => _groupValue = value!);
      }
    };
  }

  showAlertDesDialog(BuildContext context, double height,String? value) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        'No',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        setState(() {
          chooses.clear();
          radioList.clear();
          tempChoiceList.clear();
          questionController.text='';
          _groupValue = value!;
        });
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.info,
            color: Color.fromRGBO(238, 71, 0, 1),
          ),
          Text(
            'Alert',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to clear this Question and Choices?',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontWeight: FontWeight.w400),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final List<TextEditingController> chooses = [];
  final List<bool> radioList = [];
  final _formKey = GlobalKey<FormState>();

  _onRadioChange(int key) {
    setState(() {
      radioList[key] = !radioList[key];
      tempChoiceList[key].rightChoice = radioList[key];
    });
  }

  addField() {
    setState(() {
      tempChoiceList.add(Choice(choiceText: '', rightChoice: false));
      chooses.add(TextEditingController());
      radioList.add(false);
    });
  }

  removeItem(i) {
    setState(() {
      chooses.removeAt(i);
      radioList.removeAt(i);
      tempChoiceList.removeAt(i);
    });
  }

  showAlertDialog(BuildContext context, double height) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        'No',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        if(Provider.of<QuestionPrepareProviderFinal>(context, listen: false).getAllQuestion.isEmpty){
          Provider.of<NewQuestionProvider>(context, listen: false)
              .deleteQuestionList(widget.quesNum);
          Provider.of<QuestionPrepareProvider>(context, listen: false)
              .deleteQuestionList(widget.quesNum);
          if(Provider.of<NewQuestionProvider>(context, listen: false).getAllQuestion.isEmpty){
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 5;
            });
          }
          else{
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 5;
            });
          }
        }
        else{
          Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
              .deleteQuestionList(widget.quesNum);
          if(Provider.of<QuestionPrepareProviderFinal>(context, listen: false).getAllQuestion.isEmpty){
            Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'));
            //Navigator.pushNamed(context, '/teacherQuestionBank');
          }
          else{
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 5;
            });
          }

          // Navigator.push(
          //   context,
          //   PageTransition(
          //     type: PageTransitionType.rightToLeft,
          //     child: TeacherAddMyQuestionBank(assessment: false,),
          //   ),
          // );
        }

      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.info,
            color: Color.fromRGBO(238, 71, 0, 1),
          ),
          Text(
            'Confirm',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to delete this Question?',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontWeight: FontWeight.w400),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _groupValue = widget.finalQuestion.questionType;
    subjectController.text = widget.finalQuestion.subject!;
    topicController.text = widget.finalQuestion.topic!;
    subtopicController.text = widget.finalQuestion.subTopic!;
    classRoomController.text = widget.finalQuestion.datumClass!;
    questionController.text = widget.finalQuestion.question!;
    urlController.text = widget.finalQuestion.advisorUrl!;
    adviceController.text = widget.finalQuestion.advisorText!;
    selected = widget.finalQuestion.choices;
    for (int i = 0; i < widget.finalQuestion.choices!.length; i++) {
      chooses.add(TextEditingController());
      chooses[i].text = widget.finalQuestion.choices![i].choiceText!;
      radioList.add(false);
      tempChoiceList.add(widget.finalQuestion.choices![i]);
      if (widget.finalQuestion.choices![i].rightChoice!) {
        radioList[i] = true;
        widget.finalQuestion.choices![i].rightChoice=true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > webWidth) {
            return Center(
              child: SizedBox(
                  width: webWidth,
                child: WillPopScope(
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
                              Navigator.of(context).pop();
                            },
                          ),
                          toolbarHeight: height * 0.100,
                          centerTitle: true,
                          title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "EDIT QUESTION",
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
                                  left: height * 0.02,
                                  right: height * 0.023),
                              child: Column(children: [
                                SizedBox(height: height * 0.005),
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  //width: 335,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      MyRadioOption<String>(
                                        icon: Icons.check_box_outlined,
                                        value: 'MCQ',
                                        groupValue: _groupValue,
                                        onChanged: _valueChangedHandler(context, height),
                                        label: 'MCQ',
                                      ),
                                      MyRadioOption<String>(
                                        icon: Icons.account_tree_outlined,
                                        value: 'Survey',
                                        groupValue: _groupValue,
                                        onChanged: _valueChangedHandler(context, height),
                                        label: 'Survey',
                                      ),
                                      MyRadioOption<String>(
                                        icon: Icons.library_books_sharp,
                                        value: 'Descriptive',
                                        groupValue: _groupValue,
                                        onChanged: _valueChangedHandler(context, height),
                                        label: 'Descriptive',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            showAlertDialog(context, height);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: height * 0.028,
                                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                                ),
                                                onPressed: () {
                                                  showAlertDialog(context, height);
                                                },
                                              ),
                                              Text(
                                                "Delete",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      28, 78, 80, 1),
                                                  fontSize: height * 0.018,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              subjectController.text = '';
                                              topicController.text = '';
                                              subtopicController.text = '';
                                              classRoomController.text = '';
                                              questionController.text = '';
                                              urlController.text = '';
                                              adviceController.text = '';
                                              radioList.clear();
                                              chooses.clear();
                                              //selected='';
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.clear_sharp,
                                                  size: height * 0.028,
                                                  color: const Color.fromRGBO(
                                                      28, 78, 80, 1),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    subjectController.text = '';
                                                    topicController.text = '';
                                                    subtopicController.text = '';
                                                    classRoomController.text = '';
                                                    questionController.text = '';
                                                    urlController.text = '';
                                                    adviceController.text = '';
                                                    radioList.clear();
                                                    chooses.clear();
                                                    //selected='';
                                                  });
                                                },
                                              ),
                                              Text(
                                                "Clear All",
                                                style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      28, 78, 80, 1),
                                                  fontSize: height * 0.018,
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ]),
                                SizedBox(height: height * 0.001),
                                Container(
                                  //width: width * 10,
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color.fromRGBO(82, 165, 160, 1)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:
                                    showIcon == Icons.expand_circle_down_outlined ?
                                    Container(
                                      //height: height * 0.060,
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              //SizedBox(width: width * 0.10),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: webWidth * 0.02,
                                                    left: webWidth * 0.02),
                                                child: Text("Subject and Topic",
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: height * 0.020)),
                                              ),
                                              //SizedBox(width: width >700?width * 0.85:width * 0.25),
                                              IconButton(
                                                icon: Icon(
                                                  showIcon,
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  size: height * 0.03,
                                                ),
                                                onPressed: () {
                                                  changeIcon(showIcon);
                                                },
                                              )
                                            ])) :
                                    Column(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            //height: height * 0.060,
                                              color: const Color.fromRGBO(82, 165, 160, 1),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    //SizedBox(width: width * 0.10),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          right: webWidth * 0.02,
                                                          left: webWidth * 0.02),
                                                      child: Text("Subject and Topic",
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(
                                                                  255, 255, 255, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: height * 0.020)),
                                                    ),
                                                    //SizedBox(width: width >700?width * 0.85:width * 0.25),
                                                    IconButton(
                                                      icon: Icon(
                                                        showIcon,
                                                        color: const Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                        size: height * 0.03,
                                                      ),
                                                      onPressed: () {
                                                        changeIcon(showIcon);
                                                      },
                                                    )
                                                  ])),
                                          SizedBox(height: height * 0.010),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10, right: 10, top: 20, bottom: 20),
                                              child: Column(children: [
                                                TextFormField(
                                                    controller: subjectController,
                                                    keyboardType: TextInputType.text,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: height * 0.018),
                                                    decoration: InputDecoration(
                                                      labelText: "SUBJECT",
                                                      floatingLabelBehavior:
                                                      FloatingLabelBehavior.always,
                                                      labelStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              51, 51, 51, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: height * 0.015),
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: height * 0.02),
                                                      hintText: "Type Subject Here",
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color: Color.fromRGBO(
                                                                  82, 165, 160, 1)),
                                                          borderRadius:
                                                          BorderRadius.circular(15)),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(15)),
                                                    )),
                                                SizedBox(height: height * 0.015),
                                                TextFormField(
                                                    controller: topicController,
                                                    keyboardType: TextInputType.text,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: height * 0.018),
                                                    decoration: InputDecoration(
                                                      labelText: "TOPIC",
                                                      floatingLabelBehavior:
                                                      FloatingLabelBehavior.always,
                                                      labelStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              51, 51, 51, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: height * 0.015),
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: height * 0.02),
                                                      hintText: "Type Topic Here",
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color: Color.fromRGBO(
                                                                  82, 165, 160, 1)),
                                                          borderRadius:
                                                          BorderRadius.circular(15)),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(15)),
                                                    )),
                                                SizedBox(height: height * 0.015),
                                                TextFormField(
                                                    controller: subtopicController,
                                                    keyboardType: TextInputType.text,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: height * 0.018),
                                                    decoration: InputDecoration(
                                                      labelText: AppLocalizations.of(
                                                          context)!.sub_topic_optional,
                                                      //'SEMESTER (Section)',
                                                      floatingLabelBehavior:
                                                      FloatingLabelBehavior.always,
                                                      labelStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              51, 51, 51, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: height * 0.015),
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: height * 0.02),
                                                      hintText: 'Type SEMESTER (Section) Here',
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color: Color.fromRGBO(
                                                                  82, 165, 160, 1)),
                                                          borderRadius:
                                                          BorderRadius.circular(15)),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(15)),
                                                    )),
                                                SizedBox(height: height * 0.015),
                                                TextFormField(
                                                    controller: classRoomController,
                                                    keyboardType: TextInputType.text,
                                                    style: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: height * 0.018),
                                                    decoration: InputDecoration(
                                                      labelText: "DEGREE (Class)",
                                                      floatingLabelBehavior:
                                                      FloatingLabelBehavior.always,
                                                      labelStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              51, 51, 51, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: height * 0.015),
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: height * 0.02),
                                                      hintText: "Type Here",
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color: Color.fromRGBO(
                                                                  82, 165, 160, 1)),
                                                          borderRadius:
                                                          BorderRadius.circular(15)),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(15)),
                                                    )),
                                              ])),
                                          SizedBox(height: height * 0.010),
                                        ]),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(
                                      left: webWidth * 0.05, right: webWidth * 0.04),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Text(
                                          "Question",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.025,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: webWidth * 0.03),
                                        const Expanded(child: Divider()),
                                      ]),
                                      SizedBox(height: height * 0.010),
                                      TextFormField(
                                        maxLines: 5,
                                        controller: questionController,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: height * 0.018),
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                              color: const Color.fromRGBO(51, 51, 51, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: height * 0.015),
                                          hintStyle: TextStyle(
                                              color:
                                              const Color.fromRGBO(102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.02),
                                          hintText: "Type Question Here",
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color.fromRGBO(82, 165, 160, 1)),
                                              borderRadius: BorderRadius.circular(15)),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5)),
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            widget.finalQuestion.question = val;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.010),


                                _groupValue == "Descriptive"
                                    ? const SizedBox(height: 0)
                                    : _groupValue == "Survey"
                                    ? Container(
                                  margin: const EdgeInsets.only(
                                      left: webWidth * 0.05, right: webWidth * 0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            AppLocalizations.of(context)!.choices,
                                            //"Choices",
                                            style: TextStyle(
                                              color:
                                              const Color.fromRGBO(51, 51, 51, 1),
                                              fontSize: height * 0.016,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: webWidth * 0.02,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.delete,
                                        //"Delete",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: height * 0.016,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                    : Container(
                                  margin: const EdgeInsets.only(
                                      left: webWidth * 0.05, right: webWidth * 0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            AppLocalizations.of(context)!.choices,
                                            //"Choices",
                                            style: TextStyle(
                                              color:
                                              const Color.fromRGBO(51, 51, 51, 1),
                                              fontSize: height * 0.016,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: webWidth * 0.15,
                                        child: Text(
                                          AppLocalizations.of(context)!.correct_answer,
                                          textAlign: TextAlign.center,
                                          //"Correct\nAnswer",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(51, 51, 51, 1),
                                            fontSize: height * 0.016,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: webWidth * 0.12,
                                        child: Text(
                                          AppLocalizations.of(context)!.delete,
                                          textAlign: TextAlign.center,
                                          //"Delete",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(51, 51, 51, 1),
                                            fontSize: height * 0.016,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                SizedBox(height: height * 0.010),


                                _groupValue == "Descriptive"
                                    ? const SizedBox(height: 0,)
                                    : _groupValue == "Survey"
                                    ? Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      for (int i = 0; i < chooses.length; i++)
                                        Padding(
                                          padding: EdgeInsets.only(bottom: height * 0.02),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller: chooses[i],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.018),
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.always,
                                                    hintStyle: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: height * 0.02),
                                                    hintText: AppLocalizations.of(context)!
                                                        .type_op_here,
                                                    //"Type Option Here",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(5)),
                                                  ),
                                                  onChanged: (val) {
                                                    tempChoiceList[i].choiceText = val;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: webWidth * 0.01,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  removeItem(i);
                                                },
                                                icon: const Icon(
                                                  Icons.delete_outline,
                                                  color: Color.fromRGBO(82, 165, 160, 1),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: webWidth * 0.02,
                                              )

                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                )
                                    : Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      for (int i = 0; i < chooses.length; i++)
                                        Padding(
                                          padding: EdgeInsets.only(bottom: height * 0.02,
                                              left: webWidth * 0.04,
                                              right: webWidth * 0.04),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller: chooses[i],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.018),
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.always,
                                                    hintStyle: TextStyle(
                                                        color: const Color.fromRGBO(
                                                            102, 102, 102, 0.3),
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: height * 0.02),
                                                    hintText: AppLocalizations.of(context)!
                                                        .type_op_here,
                                                    //"Type Option Here",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(5)),
                                                  ),
                                                  onChanged: (val) {
                                                    tempChoiceList[i].choiceText = val;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: webWidth * 0.15,
                                                child: IconButton(
                                                  onPressed: () {
                                                    _onRadioChange(i);
                                                  },
                                                  icon: Icon(
                                                    radioList[i]
                                                        ? Icons
                                                        .radio_button_checked_outlined
                                                        : Icons
                                                        .radio_button_unchecked_outlined,
                                                    color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: webWidth * 0.12,
                                                child: IconButton(
                                                  onPressed: () {
                                                    removeItem(i);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete_outline,
                                                    color: Color.fromRGBO(82, 165, 160, 1),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                ),


                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _groupValue == "Descriptive"
                                          ? const SizedBox(height: 0)
                                          : TextButton(
                                        onPressed: () {
                                          addField();
                                        },
                                        child: Text(
                                          "Add more choice",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                            fontSize: height * 0.0225,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height * 0.020),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.only(
                                            left: webWidth * 0.05, right: webWidth * 0.04),
                                        child: Row(children: [
                                          Text(
                                            "Advisor",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(82, 165, 160, 1),
                                              fontSize: height * 0.025,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(width: webWidth * 0.03),
                                          const Expanded(child: Divider()),
                                        ]),
                                      )
                                    ]),
                                SizedBox(height: height * 0.020),
                                TextFormField(
                                  controller: adviceController,
                                  style: TextStyle(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: height * 0.018),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        color: const Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: height * 0.015),
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                    hintText:
                                    "Suggest what to study if answered incorrectly",
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      widget.finalQuestion.advisorText = val;
                                    });
                                  },
                                ),
                                SizedBox(height: height * 0.020),
                                TextFormField(
                                  controller: urlController,
                                  style: TextStyle(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: height * 0.018),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        color: const Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: height * 0.015),
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.02),
                                    hintText: "URL - Any reference (Optional)",
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      widget.finalQuestion.advisorUrl = val;
                                    });
                                  },
                                ),
                                SizedBox(height: height * 0.030),
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        const Color.fromRGBO(82, 165, 160, 1),
                                        maximumSize: const Size(280, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(39),
                                        ),
                                      ),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                const Color.fromRGBO(255, 255, 255, 1),
                                              ),
                                              onPressed: () {
                                                if (questionController.text == '' ||
                                                    subjectController.text == '' ||
                                                    classRoomController.text == '') {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.rightToLeft,
                                                      child: CustomDialog(
                                                        title: "Alert",
                                                        //'Wrong password',
                                                        content:
                                                        "Enter Subject, Class and Question",
                                                        //'please enter the correct password',
                                                        button: "Retry",
                                                      ),
                                                    ),
                                                  );
                                                }
                                                else if (_groupValue == 'MCQ' &&
                                                    chooses.isEmpty) {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.rightToLeft,
                                                      child: CustomDialog(
                                                        title: "Alert",
                                                        //'Wrong password',
                                                        content:
                                                        "At least one choice must be added",
                                                        //'please enter the correct password',
                                                        button: "Retry",
                                                      ),
                                                    ),
                                                  );
                                                }
                                                else {
                                                  setState(() {
                                                    List<Choice> temp = [];
                                                    for (int i = 0;
                                                    i < chooses.length;
                                                    i++) {
                                                      Choice ch = Choice();
                                                      temp.add(ch);
                                                      temp[i].choiceText = chooses[i].text;
                                                      temp[i].rightChoice = false;
                                                      if (radioList[i]) {
                                                        temp[i].rightChoice = radioList[i];
                                                      }
                                                    }
                                                    widget.finalQuestion.questionType =
                                                        _groupValue;
                                                    widget.finalQuestion.subject =
                                                        subjectController.text;
                                                    widget.finalQuestion.topic =
                                                        topicController.text;
                                                    widget.finalQuestion.subTopic =
                                                        subtopicController.text;
                                                    widget.finalQuestion.datumClass =
                                                        classRoomController.text;
                                                    widget.finalQuestion.question =
                                                        questionController.text;
                                                    widget.finalQuestion.choices = selected;
                                                    widget.finalQuestion.advisorText =
                                                        adviceController.text;
                                                    widget.finalQuestion.advisorUrl =
                                                        urlController.text;
                                                    widget.finalQuestion.choices = temp;
                                                    List<Question> t =
                                                        Provider
                                                            .of<
                                                            QuestionPrepareProviderFinal>(
                                                            context,
                                                            listen: false)
                                                            .getAllQuestion;
                                                    t.isEmpty ?
                                                    Provider.of<NewQuestionProvider>(
                                                        context,
                                                        listen: false).updateQuestionList(
                                                        widget.quesNum,
                                                        widget.finalQuestion) :
                                                    Provider.of<
                                                        QuestionPrepareProviderFinal>(
                                                        context, listen: false)
                                                        .updateQuestionList(widget.quesNum,
                                                        widget.finalQuestion);
                                                  });
                                                  widget.assessment ?
                                                  Navigator.of(context)
                                                      .popAndPushNamed(
                                                      '/teacherAddMyQuestionBankForAssessment',
                                                      arguments: widget.assessment) :
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                      '/teacherAddMyQuestionBank',
                                                      arguments: widget.assessment);
                                                }
                                              },
                                              child: const Text("Save"),
                                            ),
                                          ]),
                                      onPressed: () {
                                        if (questionController.text == '' ||
                                            subjectController.text == '' ||
                                            classRoomController.text == '') {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: CustomDialog(
                                                title: "Alert",
                                                //'Wrong password',
                                                content:
                                                "Enter Subject, Class and Question",
                                                //'please enter the correct password',
                                                button: "Retry",
                                              ),
                                            ),
                                          );
                                        }
                                        else if (_groupValue == 'MCQ' && chooses.isEmpty) {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: CustomDialog(
                                                title: "Alert",
                                                //'Wrong password',
                                                content:
                                                "At least one choice must be added",
                                                //'please enter the correct password',
                                                button: "Retry",
                                              ),
                                            ),
                                          );
                                        }
                                        else {
                                          setState(() {
                                            List<Choice> temp = [];
                                            for (int i = 0;
                                            i < chooses.length;
                                            i++) {
                                              Choice ch = Choice();
                                              temp.add(ch);
                                              temp[i].choiceText = chooses[i].text;
                                              temp[i].rightChoice = false;
                                              if (radioList[i]) {
                                                temp[i].rightChoice = radioList[i];
                                              }
                                            }
                                            widget.finalQuestion.questionType =
                                                _groupValue;
                                            widget.finalQuestion.subject =
                                                subjectController.text;
                                            widget.finalQuestion.topic =
                                                topicController.text;
                                            widget.finalQuestion.subTopic =
                                                subtopicController.text;
                                            widget.finalQuestion.datumClass =
                                                classRoomController.text;
                                            widget.finalQuestion.question =
                                                questionController.text;
                                            widget.finalQuestion.choices = selected;
                                            widget.finalQuestion.advisorText =
                                                adviceController.text;
                                            widget.finalQuestion.advisorUrl =
                                                urlController.text;
                                            widget.finalQuestion.choices = temp;
                                            List<Question> t =
                                                Provider
                                                    .of<
                                                    QuestionPrepareProviderFinal>(
                                                    context,
                                                    listen: false)
                                                    .getAllQuestion;
                                            Provider.of<
                                                QuestionPrepareProviderFinal>(
                                                context,
                                                listen: false)
                                                .updateQuestionList(widget.quesNum,
                                                widget.finalQuestion);
                                          });

                                          Navigator.of(context)
                                              .pushNamed(
                                              '/teacherAddMyQuestionBank',
                                              arguments: widget.assessment);
                                        }
                                      }),
                                ),
                              ]),
                            )))),
              ),
            );
          }
          else{
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
                          Navigator.of(context).pop();
                        },
                      ),
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "EDIT QUESTION",
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
                              left: height * 0.02,
                              right: height * 0.023),
                          child: Column(children: [
                            SizedBox(height: height * 0.005),
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              //width: 335,
                              decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                                border: Border.all(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  MyRadioOption<String>(
                                    icon: Icons.check_box_outlined,
                                    value: 'MCQ',
                                    groupValue: _groupValue,
                                    onChanged: _valueChangedHandler(context, height),
                                    label: 'MCQ',
                                  ),
                                  MyRadioOption<String>(
                                    icon: Icons.account_tree_outlined,
                                    value: 'Survey',
                                    groupValue: _groupValue,
                                    onChanged: _valueChangedHandler(context, height),
                                    label: 'Survey',
                                  ),
                                  MyRadioOption<String>(
                                    icon: Icons.library_books_sharp,
                                    value: 'Descriptive',
                                    groupValue: _groupValue,
                                    onChanged: _valueChangedHandler(context, height),
                                    label: 'Descriptive',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context, height);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              size: height * 0.028,
                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                            ),
                                            onPressed: () {
                                              showAlertDialog(context, height);
                                            },
                                          ),
                                          Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                              fontSize: height * 0.018,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          subjectController.text = '';
                                          topicController.text = '';
                                          subtopicController.text = '';
                                          classRoomController.text = '';
                                          questionController.text = '';
                                          urlController.text = '';
                                          adviceController.text = '';
                                          radioList.clear();
                                          chooses.clear();
                                          //selected='';
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.clear_sharp,
                                              size: height * 0.028,
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                subjectController.text = '';
                                                topicController.text = '';
                                                subtopicController.text = '';
                                                classRoomController.text = '';
                                                questionController.text = '';
                                                urlController.text = '';
                                                adviceController.text = '';
                                                radioList.clear();
                                                chooses.clear();
                                                //selected='';
                                              });
                                            },
                                          ),
                                          Text(
                                            "Clear All",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  28, 78, 80, 1),
                                              fontSize: height * 0.018,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                            SizedBox(height: height * 0.001),
                            Container(
                              //width: width * 10,
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:
                                showIcon == Icons.expand_circle_down_outlined ?
                                Container(
                                  //height: height * 0.060,
                                    color: const Color.fromRGBO(82, 165, 160, 1),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          //SizedBox(width: width * 0.10),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.02,
                                                left: width * 0.02),
                                            child: Text("Subject and Topic",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: height * 0.020)),
                                          ),
                                          //SizedBox(width: width >700?width * 0.85:width * 0.25),
                                          IconButton(
                                            icon: Icon(
                                              showIcon,
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              size: height * 0.03,
                                            ),
                                            onPressed: () {
                                              changeIcon(showIcon);
                                            },
                                          )
                                        ])) :
                                Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        //height: height * 0.060,
                                          color: const Color.fromRGBO(82, 165, 160, 1),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                //SizedBox(width: width * 0.10),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: width * 0.02,
                                                      left: width * 0.02),
                                                  child: Text("Subject and Topic",
                                                      style: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: height * 0.020)),
                                                ),
                                                //SizedBox(width: width >700?width * 0.85:width * 0.25),
                                                IconButton(
                                                  icon: Icon(
                                                    showIcon,
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    size: height * 0.03,
                                                  ),
                                                  onPressed: () {
                                                    changeIcon(showIcon);
                                                  },
                                                )
                                              ])),
                                      SizedBox(height: height * 0.010),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, top: 20, bottom: 20),
                                          child: Column(children: [
                                            TextFormField(
                                                controller: subjectController,
                                                keyboardType: TextInputType.text,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: height * 0.018),
                                                decoration: InputDecoration(
                                                  labelText: "SUBJECT",
                                                  floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                  labelStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: height * 0.015),
                                                  hintStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                  hintText: "Type Subject Here",
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          color: Color.fromRGBO(
                                                              82, 165, 160, 1)),
                                                      borderRadius:
                                                      BorderRadius.circular(15)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(15)),
                                                )),
                                            SizedBox(height: height * 0.015),
                                            TextFormField(
                                                controller: topicController,
                                                keyboardType: TextInputType.text,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: height * 0.018),
                                                decoration: InputDecoration(
                                                  labelText: "TOPIC",
                                                  floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                  labelStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: height * 0.015),
                                                  hintStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                  hintText: "Type Topic Here",
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          color: Color.fromRGBO(
                                                              82, 165, 160, 1)),
                                                      borderRadius:
                                                      BorderRadius.circular(15)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(15)),
                                                )),
                                            SizedBox(height: height * 0.015),
                                            TextFormField(
                                                controller: subtopicController,
                                                keyboardType: TextInputType.text,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: height * 0.018),
                                                decoration: InputDecoration(
                                                  labelText: AppLocalizations.of(
                                                      context)!.sub_topic_optional,
                                                  //'SEMESTER (Section)',
                                                  floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                  labelStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: height * 0.015),
                                                  hintStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                  hintText: 'Type SEMESTER (Section) Here',
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          color: Color.fromRGBO(
                                                              82, 165, 160, 1)),
                                                      borderRadius:
                                                      BorderRadius.circular(15)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(15)),
                                                )),
                                            SizedBox(height: height * 0.015),
                                            TextFormField(
                                                controller: classRoomController,
                                                keyboardType: TextInputType.text,
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: height * 0.018),
                                                decoration: InputDecoration(
                                                  labelText: "DEGREE (Class)",
                                                  floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                  labelStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          51, 51, 51, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: height * 0.015),
                                                  hintStyle: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          102, 102, 102, 0.3),
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.02),
                                                  hintText: "Type Here",
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          color: Color.fromRGBO(
                                                              82, 165, 160, 1)),
                                                      borderRadius:
                                                      BorderRadius.circular(15)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(15)),
                                                )),
                                          ])),
                                      SizedBox(height: height * 0.010),
                                    ]),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                  left: width * 0.05, right: width * 0.04),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Text(
                                      "Question",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontSize: height * 0.025,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.03),
                                    const Expanded(child: Divider()),
                                  ]),
                                  SizedBox(height: height * 0.010),
                                  TextFormField(
                                    maxLines: 5,
                                    controller: questionController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: height * 0.018),
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      labelStyle: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: height * 0.015),
                                      hintStyle: TextStyle(
                                          color:
                                          const Color.fromRGBO(102, 102, 102, 0.3),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.02),
                                      hintText: "Type Question Here",
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromRGBO(82, 165, 160, 1)),
                                          borderRadius: BorderRadius.circular(15)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5)),
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        widget.finalQuestion.question = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.010),


                            _groupValue == "Descriptive"
                                ? const SizedBox(height: 0)
                                : _groupValue == "Survey"
                                ? Container(
                              margin: EdgeInsets.only(
                                  left: width * 0.05, right: width * 0.04),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppLocalizations.of(context)!.choices,
                                        //"Choices",
                                        style: TextStyle(
                                          color:
                                          const Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: height * 0.016,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.delete,
                                    //"Delete",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(51, 51, 51, 1),
                                      fontSize: height * 0.016,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : Container(
                              margin: EdgeInsets.only(
                                  left: width * 0.05, right: width * 0.04),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppLocalizations.of(context)!.choices,
                                        //"Choices",
                                        style: TextStyle(
                                          color:
                                          const Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: height * 0.016,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.15,
                                    child: Text(
                                      AppLocalizations.of(context)!.correct_answer,
                                      textAlign: TextAlign.center,
                                      //"Correct\nAnswer",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(51, 51, 51, 1),
                                        fontSize: height * 0.016,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.12,
                                    child: Text(
                                      AppLocalizations.of(context)!.delete,
                                      textAlign: TextAlign.center,
                                      //"Delete",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(51, 51, 51, 1),
                                        fontSize: height * 0.016,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            SizedBox(height: height * 0.010),


                            _groupValue == "Descriptive"
                                ? const SizedBox(height: 0,)
                                : _groupValue == "Survey"
                                ? Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  for (int i = 0; i < chooses.length; i++)
                                    Padding(
                                      padding: EdgeInsets.only(bottom: height * 0.02),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: chooses[i],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.018),
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                                hintStyle: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 0.3),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: height * 0.02),
                                                hintText: AppLocalizations.of(context)!
                                                    .type_op_here,
                                                //"Type Option Here",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                              ),
                                              onChanged: (val) {
                                                tempChoiceList[i].choiceText = val;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.01,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              removeItem(i);
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Color.fromRGBO(82, 165, 160, 1),
                                            ),
                                          ),
                                          width > 700
                                              ? SizedBox(
                                            width: width * 0.02,
                                          )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            )
                                : Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  for (int i = 0; i < chooses.length; i++)
                                    Padding(
                                      padding: EdgeInsets.only(bottom: height * 0.02,
                                          left: width * 0.04,
                                          right: width * 0.04),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: chooses[i],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.018),
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                                hintStyle: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 0.3),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: height * 0.02),
                                                hintText: AppLocalizations.of(context)!
                                                    .type_op_here,
                                                //"Type Option Here",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                              ),
                                              onChanged: (val) {
                                                tempChoiceList[i].choiceText = val;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.15,
                                            child: IconButton(
                                              onPressed: () {
                                                _onRadioChange(i);
                                              },
                                              icon: Icon(
                                                radioList[i]
                                                    ? Icons
                                                    .radio_button_checked_outlined
                                                    : Icons
                                                    .radio_button_unchecked_outlined,
                                                color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.12,
                                            child: IconButton(
                                              onPressed: () {
                                                removeItem(i);
                                              },
                                              icon: const Icon(
                                                Icons.delete_outline,
                                                color: Color.fromRGBO(82, 165, 160, 1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),


                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _groupValue == "Descriptive"
                                      ? const SizedBox(height: 0)
                                      : TextButton(
                                    onPressed: () {
                                      addField();
                                    },
                                    child: Text(
                                      "Add more choice",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontSize: height * 0.0225,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.020),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        left: width * 0.05, right: width * 0.04),
                                    child: Row(children: [
                                      Text(
                                        "Advisor",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(82, 165, 160, 1),
                                          fontSize: height * 0.025,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: width * 0.03),
                                      const Expanded(child: Divider()),
                                    ]),
                                  )
                                ]),
                            SizedBox(height: height * 0.020),
                            TextFormField(
                              controller: adviceController,
                              style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: height * 0.018),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelStyle: TextStyle(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.015),
                                hintStyle: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.02),
                                hintText:
                                "Suggest what to study if answered incorrectly",
                              ),
                              onChanged: (val) {
                                setState(() {
                                  widget.finalQuestion.advisorText = val;
                                });
                              },
                            ),
                            SizedBox(height: height * 0.020),
                            TextFormField(
                              controller: urlController,
                              style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: height * 0.018),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelStyle: TextStyle(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.015),
                                hintStyle: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.02),
                                hintText: "URL - Any reference (Optional)",
                              ),
                              onChanged: (val) {
                                setState(() {
                                  widget.finalQuestion.advisorUrl = val;
                                });
                              },
                            ),
                            SizedBox(height: height * 0.030),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    const Color.fromRGBO(82, 165, 160, 1),
                                    maximumSize: const Size(280, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(39),
                                    ),
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                            const Color.fromRGBO(255, 255, 255, 1),
                                          ),
                                          onPressed: () {
                                            if (questionController.text == '' ||
                                                subjectController.text == '' ||
                                                classRoomController.text == '') {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.rightToLeft,
                                                  child: CustomDialog(
                                                    title: "Alert",
                                                    //'Wrong password',
                                                    content:
                                                    "Enter Subject, Class and Question",
                                                    //'please enter the correct password',
                                                    button: "Retry",
                                                  ),
                                                ),
                                              );
                                            }
                                            else if (_groupValue == 'MCQ' &&
                                                chooses.isEmpty) {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.rightToLeft,
                                                  child: CustomDialog(
                                                    title: "Alert",
                                                    //'Wrong password',
                                                    content:
                                                    "At least one choice must be added",
                                                    //'please enter the correct password',
                                                    button: "Retry",
                                                  ),
                                                ),
                                              );
                                            }
                                            else {
                                              setState(() {
                                                List<Choice> temp = [];
                                                for (int i = 0;
                                                i < chooses.length;
                                                i++) {
                                                  Choice ch = Choice();
                                                  temp.add(ch);
                                                  temp[i].choiceText = chooses[i].text;
                                                  temp[i].rightChoice = false;
                                                  if (radioList[i]) {
                                                    temp[i].rightChoice = radioList[i];
                                                  }
                                                }
                                                widget.finalQuestion.questionType =
                                                    _groupValue;
                                                widget.finalQuestion.subject =
                                                    subjectController.text;
                                                widget.finalQuestion.topic =
                                                    topicController.text;
                                                widget.finalQuestion.subTopic =
                                                    subtopicController.text;
                                                widget.finalQuestion.datumClass =
                                                    classRoomController.text;
                                                widget.finalQuestion.question =
                                                    questionController.text;
                                                widget.finalQuestion.choices = selected;
                                                widget.finalQuestion.advisorText =
                                                    adviceController.text;
                                                widget.finalQuestion.advisorUrl =
                                                    urlController.text;
                                                widget.finalQuestion.choices = temp;
                                                List<Question> t =
                                                    Provider
                                                        .of<
                                                        QuestionPrepareProviderFinal>(
                                                        context,
                                                        listen: false)
                                                        .getAllQuestion;
                                                t.isEmpty ?
                                                Provider.of<NewQuestionProvider>(
                                                    context,
                                                    listen: false).updateQuestionList(
                                                    widget.quesNum,
                                                    widget.finalQuestion) :
                                                Provider.of<
                                                    QuestionPrepareProviderFinal>(
                                                    context, listen: false)
                                                    .updateQuestionList(widget.quesNum,
                                                    widget.finalQuestion);
                                              });
                                              widget.assessment ?
                                              Navigator.of(context)
                                                  .popAndPushNamed(
                                                  '/teacherAddMyQuestionBankForAssessment',
                                                  arguments: widget.assessment) :
                                              Navigator.of(context)
                                                  .pushNamed(
                                                  '/teacherAddMyQuestionBank',
                                                  arguments: widget.assessment);
                                            }
                                          },
                                          child: const Text("Save"),
                                        ),
                                      ]),
                                  onPressed: () {
                                    if (questionController.text == '' ||
                                        subjectController.text == '' ||
                                        classRoomController.text == '') {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title: "Alert",
                                            //'Wrong password',
                                            content:
                                            "Enter Subject, Class and Question",
                                            //'please enter the correct password',
                                            button: "Retry",
                                          ),
                                        ),
                                      );
                                    }
                                    else if (_groupValue == 'MCQ' && chooses.isEmpty) {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title: "Alert",
                                            //'Wrong password',
                                            content:
                                            "At least one choice must be added",
                                            //'please enter the correct password',
                                            button: "Retry",
                                          ),
                                        ),
                                      );
                                    }
                                    else {
                                      setState(() {
                                        List<Choice> temp = [];
                                        for (int i = 0;
                                        i < chooses.length;
                                        i++) {
                                          Choice ch = Choice();
                                          temp.add(ch);
                                          temp[i].choiceText = chooses[i].text;
                                          temp[i].rightChoice = false;
                                          if (radioList[i]) {
                                            temp[i].rightChoice = radioList[i];
                                          }
                                        }
                                        widget.finalQuestion.questionType =
                                            _groupValue;
                                        widget.finalQuestion.subject =
                                            subjectController.text;
                                        widget.finalQuestion.topic =
                                            topicController.text;
                                        widget.finalQuestion.subTopic =
                                            subtopicController.text;
                                        widget.finalQuestion.datumClass =
                                            classRoomController.text;
                                        widget.finalQuestion.question =
                                            questionController.text;
                                        widget.finalQuestion.choices = selected;
                                        widget.finalQuestion.advisorText =
                                            adviceController.text;
                                        widget.finalQuestion.advisorUrl =
                                            urlController.text;
                                        widget.finalQuestion.choices = temp;
                                        List<Question> t =
                                            Provider
                                                .of<
                                                QuestionPrepareProviderFinal>(
                                                context,
                                                listen: false)
                                                .getAllQuestion;
                                        Provider.of<
                                            QuestionPrepareProviderFinal>(
                                            context,
                                            listen: false)
                                            .updateQuestionList(widget.quesNum,
                                            widget.finalQuestion);
                                      });

                                      Navigator.of(context)
                                          .pushNamed(
                                          '/teacherAddMyQuestionBank',
                                          arguments: widget.assessment);
                                    }
                                  }),
                            ),
                          ]),
                        ))));
          }

  }
  );
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
}

class ChooseWidget extends StatefulWidget {
  const ChooseWidget({
    Key? key,
    required this.question,
    required this.height,
    required this.width,
    required this.selected,
  }) : super(key: key);

  final Question question;
  final List<Choice>? selected;
  final double height;
  final double width;

  @override
  State<ChooseWidget> createState() => _ChooseWidgetState();
}

class _ChooseWidgetState extends State<ChooseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int j = 0; j < widget.question.choices!.length; j++)
          MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.question.choices![j].rightChoice!) {
                      widget.question.choices![j].rightChoice = false;
                    } else {
                      widget.question.choices![j].rightChoice = true;
                    }
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: widget.height * 0.013),
                  child: Container(
                      width: widget.width * 0.744,
                      height: widget.height * 0.0412,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: const Color.fromRGBO(209, 209, 209, 1)),
                        color: (widget.question.choices![j].rightChoice!)
                            ? const Color.fromRGBO(82, 165, 160, 1)
                            : const Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: widget.width * 0.02,
                            ),
                            Expanded(
                              child: Text(
                                widget.question.choices![j].choiceText!,
                                style: TextStyle(
                                  color: (widget.question.choices![j].rightChoice!)
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: widget.height * 0.0162,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ])),
                ),
              ))
      ],
    );
  }
}
