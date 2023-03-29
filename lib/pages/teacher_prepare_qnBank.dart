import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_qn_preview.dart';
import '../Components/custom_radio_option.dart';
import '../Entity/Teacher/choice_entity.dart';
import '../Entity/Teacher/question_entity.dart';
import '../Providers/question_prepare_provider.dart';
import '../Components/end_drawer_menu_teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

Color textColor = const Color.fromRGBO(48, 145, 139, 1);

class TeacherPrepareQnBank extends StatefulWidget {
  const TeacherPrepareQnBank(
      {Key? key,
      this.assessment,
      required this.setLocale,
      this.assessmentStatus})
      : super(key: key);

  final bool? assessment;
  final String? assessmentStatus;
  final void Function(Locale locale) setLocale;

  @override
  TeacherPrepareQnBankState createState() => TeacherPrepareQnBankState();
}

class TeacherPrepareQnBankState extends State<TeacherPrepareQnBank> {
  String _groupValue = 'MCQ';
  IconData radioIcon = Icons.radio_button_off_outlined;
  late int _count;
  Question demoQuestionModel = Question();
  Choice choice = Choice();
  TextEditingController subjectController = TextEditingController();
  TextEditingController adviceController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController subtopicController = TextEditingController();
  TextEditingController classRoomController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  bool? x;
  late List<Map<String, dynamic>> _values;
  IconData showIcon = Icons.expand_circle_down_outlined;

  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }

  final List<TextEditingController> chooses = [];
  final List<bool> radioList = [];
  final _formKey = GlobalKey<FormState>();
  Question finalQuestion = Question();
  late SharedPreferences loginData;
  List<Choice> tempChoiceList = [];

  addField() async {
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

  showQuestionPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String status = '';
        if (widget.assessmentStatus != null) {
          status = widget.assessmentStatus!;
        }
        return TeacherPreparePreview(
            assessment: widget.assessment,
            setLocale: widget.setLocale,
            finalQuestion: finalQuestion,
            assessmentStatus: status);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _count = 0;
    _values = [];
    demoQuestionModel.choices?.add(choice);
    setData();
  }

  setData() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      finalQuestion.questionType = 'MCQ';
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
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.prepare_qn_title,
                      //"PREPARE QUESTION",
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
                    Padding(
                      padding: EdgeInsets.only(
                          left: height * 0.02, right: height * 0.0083),
                      child: Container(
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
                              value: AppLocalizations.of(context)!.mcq,
                              //'MCQs',
                              groupValue: _groupValue,
                              onChanged: _valueChangedHandler(),
                              label: 'MCQ',
                            ),
                            MyRadioOption<String>(
                              icon: Icons.account_tree_outlined,
                              value: AppLocalizations.of(context)!.survey,
                              //'Survey',
                              groupValue: _groupValue,
                              onChanged: _valueChangedHandler(),
                              label:
                                  //AppLocalizations.of(context)!.survey,
                                  'Survey',
                            ),
                            MyRadioOption<String>(
                              icon: Icons.library_books_sharp,
                              value: "Descripitive",
                              //'Descriptive',
                              groupValue: _groupValue,
                              onChanged: _valueChangedHandler(),
                              label:
                                  //AppLocalizations.of(context)!.descriptive,
                                  'Descripitive',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Color.fromRGBO(209, 209, 209, 1),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              Text(
                                AppLocalizations.of(context)!.delete,
                                //"Delete",
                                style: TextStyle(
                                  color: const Color.fromRGBO(209, 209, 209, 1),
                                  fontSize: height * 0.018,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.close_outlined,
                                  size: 30,
                                  color: Color.fromRGBO(209, 209, 209, 1),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              Text(
                                AppLocalizations.of(context)!.clear_all,
                                //"Clear All",
                                style: TextStyle(
                                  color: const Color.fromRGBO(209, 209, 209, 1),
                                  fontSize: height * 0.018,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          )
                        ]),
                    SizedBox(height: height * 0.001),
                    Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color.fromRGBO(82, 165, 160, 1)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(children: [
                          Container(
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              child: Row(children: [
                                SizedBox(width: width * 0.10),
                                Text(
                                    AppLocalizations.of(context)!.subject_topic,
                                    //"Subject and Topic",
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: height * 0.020)),
                                SizedBox(width: width * 0.25),
                                IconButton(
                                  icon: Icon(
                                    showIcon,
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
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
                                      labelText: AppLocalizations.of(context)!
                                          .sub_caps,
                                      //"SUBJECT",
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
                                      hintText: AppLocalizations.of(context)!
                                          .sub_hint,
                                      //"Type Subject Here",
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
                                      labelText: AppLocalizations.of(context)!
                                          .topic_caps,
                                      //"TOPIC",
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
                                      hintText: AppLocalizations.of(context)!
                                          .topic_hint,
                                      //"Type Topic Here",
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
                                      labelText: AppLocalizations.of(context)!
                                          .sub_topic_caps,
                                      //'SUB TOPIC',
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
                                      hintText: AppLocalizations.of(context)!
                                          .sub_topic_hint,
                                      //'Type Sub Topic Here',
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
                                      labelText: AppLocalizations.of(context)!
                                          .class_caps,
                                      //"CLASS",
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
                                      hintText: AppLocalizations.of(context)!
                                          .type_here,
                                      //"Type Here",
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
                          left: width * 0.04, right: width * 0.04),
                      child: Column(
                        children: [
                          Row(children: [
                            Text(
                              AppLocalizations.of(context)!.qn_qn_page,
                              // "Question",
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
                              style: TextStyle(
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: height * 0.018),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: TextStyle(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.015),
                                hintStyle: TextStyle(
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.02),
                                hintText:
                                    AppLocalizations.of(context)!.type_qn_here,
                                //"Type Question Here",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              )),
                          SizedBox(height: height * 0.010),
                          Row(
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
                              Text(
                                AppLocalizations.of(context)!.correct_answer,
                                //"Correct\nAnswer",
                                style: TextStyle(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontSize: height * 0.016,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
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
                          SizedBox(height: height * 0.010),
                        ],
                      ),
                    ),
                    Form(
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
                                          color: const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
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
                                    width: width * 0.03,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _onRadioChange(i);
                                    },
                                    icon: Icon(
                                      radioList[i]
                                          ? Icons.radio_button_checked_outlined
                                          : Icons
                                              .radio_button_unchecked_outlined,
                                      color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
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
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.020),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              addField();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.add_more_choice,
                              //"Add more choice",
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
                                AppLocalizations.of(context)!.advisor,
                                //"Advisor",
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
                          hintText: AppLocalizations.of(context)!.suggest_study,
                          //"Suggest what to study if answered incorrectly",
                        )),
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
                          hintText: AppLocalizations.of(context)!.url_reference,
                          //"URL - Any reference (Optional)",
                        )),
                    SizedBox(height: height * 0.030),
                    Column(
                      children: [
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
                                        foregroundColor: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                      ),
                                      onPressed: () {
                                        List<Choice> temp = [];
                                        List<Choice> selectedTemp = [];
                                        for (int i = 0;
                                            i < chooses.length;
                                            i++) {
                                          if (radioList[i]) {
                                            //selectedTemp.add(demoQuestionModel.choices![i]);
                                          }
                                          //temp.add(demoQuestionModel.choices![i]);
                                        }
                                        demoQuestionModel.subject =
                                            subjectController.text;
                                        demoQuestionModel.topic =
                                            topicController.text;
                                        demoQuestionModel.subTopic =
                                            subtopicController.text;
                                        demoQuestionModel.datumClass =
                                            classRoomController.text;
                                        demoQuestionModel.question =
                                            questionController.text;
                                        demoQuestionModel.questionType =
                                            _groupValue;
                                        demoQuestionModel.choices =
                                            selectedTemp;
                                        demoQuestionModel.advisorText =
                                            adviceController.text;
                                        demoQuestionModel.advisorUrl =
                                            urlController.text;
                                        demoQuestionModel.choices = temp;
                                        //demoQuestionModel.questionId = ques!.length;

                                        //---------**************Actual API Integration DATA-------------
                                        finalQuestion.question =
                                            questionController.text;
                                        finalQuestion.advisorText =
                                            adviceController.text;
                                        finalQuestion.advisorUrl =
                                            urlController.text;
                                        finalQuestion.subject =
                                            subjectController.text;
                                        finalQuestion.topic =
                                            topicController.text;
                                        finalQuestion.subTopic =
                                            subtopicController.text;
                                        finalQuestion.datumClass =
                                            classRoomController.text;
                                        finalQuestion.choices = tempChoiceList;
                                        finalQuestion.questionType =
                                            _groupValue;
                                        if (_groupValue == 'Descriptive') {
                                          finalQuestion.choices = [];
                                        }
                                        showQuestionPreview(context);
                                      },
                                      child: Text(
                                          AppLocalizations.of(context)!.preview
                                          //"Preview"
                                          ),
                                    ),
                                  ]),
                              onPressed: () {}),
                        ),
                        SizedBox(height: height * 0.010),
                      ],
                    ),
                  ]),
                ))));
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

  _onRadioChange(int key) {
    setState(() {
      radioList[key] = !radioList[key];
      tempChoiceList[key].rightChoice = radioList[key];
    });
  }
}
