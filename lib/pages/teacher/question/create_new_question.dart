import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher/question/question_preview.dart';
import '../../../Entity/Teacher/choice_entity.dart';
import '../../../Entity/Teacher/question_entity.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../Providers/question_prepare_provider_final.dart';

Color textColor = const Color.fromRGBO(48, 145, 139, 1);

class CreateNewQuestion extends StatefulWidget {
  const CreateNewQuestion(
      {Key? key})
      : super(key: key);



  @override
  CreateNewQuestionState createState() => CreateNewQuestionState();
}

class CreateNewQuestionState extends State<CreateNewQuestion> {
  String _groupValue = 'MCQ';
  IconData radioIcon = Icons.radio_button_off_outlined;
  late int _count;
  Question demoQuestionModel = Question();
  Choice choice = Choice();
  TextEditingController subjectController = TextEditingController();
  TextEditingController adviceController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  bool? x;
  late List<Map<String, dynamic>> _values;
  IconData showIcon = Icons.arrow_circle_up_outlined;
  String _questionTypeValue = 'MCQ';

  ValueChanged<String?> _valueChangedHandler(BuildContext context,double height) {
    return (value) {
      if(chooses.isEmpty){
        setState(() => _groupValue = value!);
      }
      else if(value=='Descriptive'){
        showAlertDialog(context,height,value);
      }
      else{
        setState(() => _groupValue = value!);
      }
    };
  }

  showAlertDialog(BuildContext context, double height,String? value) {
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
        AppLocalizations.of(context)!
            .no,
        //'No',
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
        AppLocalizations.of(context)!
            .yes,
        //'Yes',
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
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.info,
            color: Color.fromRGBO(238, 71, 0, 1),
          ),
          Text(
            AppLocalizations.of(context)!
                .alert_popup,
            //'Alert',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        AppLocalizations.of(context)!
            .want_to_clear_qn,
        //'Are you sure you want to clear this Question and Choices?',
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

  List<TextEditingController> chooses = [];
  List<bool> radioList = [];
  final _formKey = GlobalKey<FormState>();
  Question finalQuestion = Question();
  late SharedPreferences loginData;
  List<Choice> tempChoiceList = [];
  final formKey = GlobalKey<FormState>();
  final questionFormKey = GlobalKey<FormState>();

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
        return TeacherQuestionPreview(
          finalQuestion: finalQuestion,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    subjectController.text='';
    semesterController.text='';
    _count = 0;
    _values = [];
    demoQuestionModel.choices?.add(choice);
    setData();
  }

  setData() async {
    loginData = await SharedPreferences.getInstance();
    List<Question> quesList =Provider.of<QuestionPrepareProviderFinal>(context,
        listen: false).getAllQuestion;
    if(quesList.isNotEmpty){
      setState(() {
        subjectController.text=quesList[0].subject??'';
        topicController.text=quesList[0].topic??'';
        degreeController.text=quesList[0].semester??'';
        semesterController.text=quesList[0].degreeStudent??'';
      });
    }
    setState(() {
      finalQuestion.questionType = 'MCQ';
    });
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
                  endDrawer: const EndDrawerMenuTeacher(),
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black,size: height * 0.05),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: height * 0.06,
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
                            //AppLocalizations.of(context)!.my_qns,
                            "New Question",
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
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.023,
                          left: height * 0.045,
                          right: height * 0.045,
                          bottom: height * 0.023
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                height: height * 0.75,
                                width: width * 0.93,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child:
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: height * 0.023,
                                        left: height * 0.023,
                                        right: height * 0.023
                                    ),
                                    child: Column(
                                      children: [
                                        showIcon==Icons.arrow_circle_down_outlined?
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),

                                              ),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.subject_topic,
                                                          "Question Details",
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: height * 0.020)),
                                                    ),
                                                    // SizedBox(width: width * 0.25),
                                                    // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                    IconButton(
                                                      icon: Icon(
                                                        showIcon,
                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                        size: height * 0.03,
                                                      ),
                                                      onPressed: () {
                                                        changeIcon(showIcon);
                                                      },
                                                    )
                                                  ]),
                                            ),
                                            //Question type container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left:width * 0.02,top:width * 0.02),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Question Type",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Transform.scale(
                                                              scale: width * 0.002,
                                                              child: Radio(
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                value: "MCQ", groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                            ),
                                                            Expanded(
                                                              child: Text('MCQ',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.016)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Transform.scale(
                                                              scale:width * 0.002,
                                                              child: Radio(
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                value: "Survey", groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                            ),
                                                            Expanded(
                                                              child: Text('Survey',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.016)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Transform.scale(
                                                              scale: width * 0.002,
                                                              child: Radio(
                                                                value: "Descriptive",
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                            ),
                                                            Expanded(
                                                              child: Text('Descriptive',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.016)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height:50.0),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),

                                            //Question container
                                            Form(
                                              key:questionFormKey,
                                              child: Container(
                                                width: width * 0.9,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(10)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top:width * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.subject_topic,
                                                          "Question",
                                                          //textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: height * 0.020)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right : width * 0.02),
                                                      child: TextFormField(
                                                        controller: questionController,
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (val) {
                                                          questionFormKey.currentState!.validate();

                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Question";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          //errorText: question ? "Enter Question" : null,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type Question here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(left: width * 0.02),
                                                    //   child: Text(
                                                    //     //AppLocalizations.of(context)!.subject_topic,
                                                    //       "Answer",
                                                    //       //textAlign: TextAlign.left,
                                                    //       style: TextStyle(
                                                    //           color: const Color.fromRGBO(28, 78, 80, 1),
                                                    //           fontFamily: 'Inter',
                                                    //           fontWeight: FontWeight.w600,
                                                    //           fontSize: height * 0.020)),
                                                    // ),
                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0)
                                                        :  _questionTypeValue=="Survey"
                                                        ?
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: width * 0.01),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.02,
                                                          ),
                                                          // Text(
                                                          //   AppLocalizations.of(context)!.delete,
                                                          //   //"Delete",
                                                          //   style: TextStyle(
                                                          //     color: const Color.fromRGBO(51, 51, 51, 1),
                                                          //     fontSize: height * 0.016,
                                                          //     fontFamily: "Inter",
                                                          //     fontWeight: FontWeight.w500,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    )
                                                        :
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.13,
                                                            child: Text(
                                                              textAlign: TextAlign.right,
                                                              AppLocalizations.of(context)!.correct_answer,
                                                              //"Correct\nAnswer",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(51, 51, 51, 1),
                                                                fontSize: height * 0.014,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.11,
                                                            // child: Text(
                                                            //   AppLocalizations.of(context)!.delete,
                                                            //   textAlign: TextAlign.center,
                                                            //   //"Delete",
                                                            //   style: TextStyle(
                                                            //     color: const Color.fromRGBO(51, 51, 51, 1),
                                                            //     fontSize: height * 0.014,
                                                            //     fontFamily: "Inter",
                                                            //     fontWeight: FontWeight.w500,
                                                            //   ),
                                                            // ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0,)
                                                        : _questionTypeValue=="Survey"
                                                        ?
                                                    Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          for (int i = 0; i < chooses.length; i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: height * 0.02,
                                                                  left: width * 0.02,top:width * 0.02),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i))),
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
                                                                    icon:  Icon(
                                                                      size: height * 0.03,
                                                                      Icons.delete_outline,
                                                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.04,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    )
                                                        :
                                                    Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          for (int i = 0; i < chooses.length; i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: height * 0.02,
                                                                left: 8,),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i))),
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
                                                                    width: width * 0.13,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        _onRadioChange(i);
                                                                      },
                                                                      icon: Icon(
                                                                        size:height * 0.03,
                                                                        radioList[i]
                                                                            ? Icons.radio_button_checked_outlined
                                                                            : Icons
                                                                            .radio_button_unchecked_outlined,
                                                                        color:
                                                                        const Color.fromRGBO(82, 165, 160, 1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.11,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        removeItem(i);
                                                                      },
                                                                      icon:  Icon(
                                                                        size:height * 0.03,
                                                                        Icons.delete_outline,
                                                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),


                                                    _questionTypeValue=="Descriptive"
                                                        ?
                                                    SizedBox()
                                                    // Padding(
                                                    //     padding: EdgeInsets.only(left: width * 0.02,bottom: width * 0.02,right: width * 0.02),
                                                    //     child: TextField(
                                                    //         controller: answerController,
                                                    //         keyboardType: TextInputType.text,
                                                    //         decoration: InputDecoration(
                                                    //           hintStyle: TextStyle(
                                                    //               color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                    //               fontFamily: 'Inter',
                                                    //               fontWeight: FontWeight.w400,
                                                    //               fontSize: height * 0.016),
                                                    //           hintText: "Type Answer here",
                                                    //           enabledBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //           focusedBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //         ))):
                                                        :
                                                    Padding(
                                                      padding: EdgeInsets.only(left:width * 0.02),
                                                      child: TextButton(
                                                        child: Text(
                                                          //AppLocalizations.of(context)!.subject_topic,
                                                          "+Add choice",
                                                          //textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(82, 165, 160, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              decoration: TextDecoration.underline,
                                                              fontSize: height * 0.020),
                                                        ),
                                                        onPressed: (){
                                                          addField();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),

                                            //Advisor Container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left:width * 0.02,top: width * 0.02),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Advisor",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                    child: TextField(
                                                      controller: adviceController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "Suggest what to study if answered incorrectly",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                    child: TextField(
                                                      controller: urlController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "URL - Any reference (Optional)",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),
                                          ],
                                        )
                                            :
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Form(
                                              key: formKey,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(10)),
                                                ),
                                                child: Wrap(
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: width * 0.02),
                                                            child: Text(
                                                              //AppLocalizations.of(context)!.subject_topic,
                                                                "Question Details",
                                                                style: TextStyle(
                                                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: height * 0.020)),
                                                          ),
                                                          // SizedBox(width: width * 0.25),
                                                          // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                          IconButton(
                                                            icon: Icon(
                                                              showIcon,
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              size: height * 0.03,
                                                            ),
                                                            onPressed: () {
                                                              changeIcon(showIcon);
                                                            },
                                                          )
                                                        ]),
                                                    const Divider(thickness: 2,),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Subject",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                      child: TextFormField(
                                                        controller: subjectController,
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (val) {
                                                          formKey.currentState!.validate();

                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Subject";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          //errorText: subject ? "Enter Subject" : null,
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Topic",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                      child: TextFormField(
                                                        controller: topicController,
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (val) {
                                                          formKey.currentState!.validate();

                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Topic";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          //errorText: topic ? "Enter Topic" : null,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Degree",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                      child: TextFormField(
                                                        controller: degreeController,
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (val) {
                                                          formKey.currentState!.validate();

                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Degree";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          //errorText: degree ? "Enter Degree" : null,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Semester (optional)",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                      child: TextField(
                                                        controller: semesterController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: height * 0.1,)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),

                                            //Question type container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left:width * 0.02,top:width * 0.02),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Question Type",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Transform.scale(
                                                              scale: width * 0.002,
                                                              child: Radio(
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                value: "MCQ", groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                            ),
                                                            Expanded(
                                                              child: Text('MCQ',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.016)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Transform.scale(
                                                              scale:width * 0.002,
                                                              child: Radio(
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                value: "Survey", groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                            ),
                                                            Expanded(
                                                              child: Text('Survey',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.016)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Transform.scale(
                                                              scale: width * 0.002,
                                                              child: Radio(
                                                                value: "Descriptive",
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                            ),
                                                            Expanded(
                                                              child: Text('Descriptive',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.016)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height:50.0),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),

                                            //Question container
                                            Form(
                                              key:questionFormKey,
                                              child: Container(
                                                width: width * 0.9,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(10)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top:width * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.subject_topic,
                                                          "Question",
                                                          //textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: height * 0.020)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right : width * 0.02),
                                                      child: TextFormField(
                                                        controller: questionController,
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (val) {
                                                          questionFormKey.currentState!.validate();

                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Question";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          //errorText: question ? "Enter Question" : null,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type Question here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(left: width * 0.02),
                                                    //   child: Text(
                                                    //     //AppLocalizations.of(context)!.subject_topic,
                                                    //       "Answer",
                                                    //       //textAlign: TextAlign.left,
                                                    //       style: TextStyle(
                                                    //           color: const Color.fromRGBO(28, 78, 80, 1),
                                                    //           fontFamily: 'Inter',
                                                    //           fontWeight: FontWeight.w600,
                                                    //           fontSize: height * 0.020)),
                                                    // ),
                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0)
                                                        :  _questionTypeValue=="Survey"
                                                        ?
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: width * 0.01),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.02,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                        :
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.13,
                                                            child: Text(
                                                              textAlign: TextAlign.right,
                                                              AppLocalizations.of(context)!.correct_answer,
                                                              //"Correct\nAnswer",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(51, 51, 51, 1),
                                                                fontSize: height * 0.014,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.11,
                                                            // child: Text(
                                                            //   AppLocalizations.of(context)!.delete,
                                                            //   textAlign: TextAlign.center,
                                                            //   //"Delete",
                                                            //   style: TextStyle(
                                                            //     color: const Color.fromRGBO(51, 51, 51, 1),
                                                            //     fontSize: height * 0.014,
                                                            //     fontFamily: "Inter",
                                                            //     fontWeight: FontWeight.w500,
                                                            //   ),
                                                            // ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0,)
                                                        : _questionTypeValue=="Survey"
                                                        ?
                                                    Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          for (int i = 0; i < chooses.length; i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: height * 0.02,
                                                                  left: width * 0.02,top:width * 0.02),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i),style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: height * 0.018),
                                                                        )),
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
                                                                    icon:  Icon(
                                                                      size: height * 0.03,
                                                                      Icons.delete_outline,
                                                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.04,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    )
                                                        :
                                                    Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          for (int i = 0; i < chooses.length; i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: height * 0.02,
                                                                left: 8,),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i),
                                                                        style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: height * 0.018),
                                                                      )),
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
                                                                    width: width * 0.13,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        _onRadioChange(i);
                                                                      },
                                                                      icon: Icon(
                                                                        size:height * 0.03,
                                                                        radioList[i]
                                                                            ? Icons.radio_button_checked_outlined
                                                                            : Icons
                                                                            .radio_button_unchecked_outlined,
                                                                        color:
                                                                        const Color.fromRGBO(82, 165, 160, 1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.11,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        removeItem(i);
                                                                      },
                                                                      icon:  Icon(
                                                                        size:height * 0.03,
                                                                        Icons.delete_outline,
                                                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),


                                                    _questionTypeValue=="Descriptive"
                                                        ?
                                                    SizedBox()
                                                    // Padding(
                                                    //     padding: EdgeInsets.only(left: width * 0.02,bottom: width * 0.02,right: width * 0.02),
                                                    //     child: TextField(
                                                    //         controller: answerController,
                                                    //         keyboardType: TextInputType.text,
                                                    //         decoration: InputDecoration(
                                                    //           hintStyle: TextStyle(
                                                    //               color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                    //               fontFamily: 'Inter',
                                                    //               fontWeight: FontWeight.w400,
                                                    //               fontSize: height * 0.016),
                                                    //           hintText: "Type Answer here",
                                                    //           enabledBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //           focusedBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //         )))
                                                        :
                                                    Padding(
                                                      padding: EdgeInsets.only(left:width * 0.02),
                                                      child: TextButton(
                                                        child: Text(
                                                          //AppLocalizations.of(context)!.subject_topic,
                                                          "+Add choice",
                                                          //textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(82, 165, 160, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              decoration: TextDecoration.underline,
                                                              fontSize: height * 0.020),
                                                        ),
                                                        onPressed: (){
                                                          addField();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),

                                            //Advisor Container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left:width * 0.02,top: width * 0.02),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Advisor",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                    child: TextField(
                                                      controller: adviceController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "Suggest what to study if answered incorrectly",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                    child: TextField(
                                                      controller: urlController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "URL - Any reference (Optional)",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ),
                          ),
                          SizedBox(height:height * 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        subjectController.clear();
                                        topicController.clear();
                                        degreeController.clear();
                                        semesterController.clear();
                                        _questionTypeValue="MCQ";
                                        questionController.clear();
                                        answerController.clear();
                                        tempChoiceList=[];
                                        chooses=[];
                                        radioList=[];
                                        adviceController.clear();
                                        urlController.clear();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: Colors.white, // <-- Button color
                                    ),
                                    child: Icon(size:width * 0.04,Icons.refresh, color: const Color.fromRGBO(82, 165, 160, 1),),
                                  ),
                                  SizedBox(height: width * 0.005),
                                  Text(
                                    //AppLocalizations.of(context)!.subject_topic,
                                      "Clear All",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      bool val = true;
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
                                      finalQuestion.semester =
                                          semesterController.text;
                                      finalQuestion.degreeStudent =
                                          degreeController.text;
                                      finalQuestion.choices =
                                          tempChoiceList;
                                      finalQuestion.questionType =
                                          _questionTypeValue;


                                      if (_groupValue == 'Descriptive') {
                                        finalQuestion.choices = [];
                                      }

                                      if(_groupValue == 'MCQ') {
                                        var values = finalQuestion.choices!.where((element) => element.rightChoice == true);

                                        if(values.isEmpty)
                                        {
                                          setState(() {
                                            val = false;
                                          });
                                          showDialogBox();
                                        }
                                        // print(contain);
                                        // if(contain == false)
                                        //   {
                                        //     print("INSIDE FALSE");
                                        //   }
                                        // else if(contain == true)
                                        //   {
                                        //     print("INSIDE TRUE");
                                        //   }
                                      }

                                      if(formKey.currentState!
                                          .validate() && questionFormKey.currentState!.validate() && val == true)  {
                                        showQuestionPreview(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: Colors.white, // <-- Button color
                                    ),
                                    child: Icon(size:width * 0.04,Icons.search, color: const Color.fromRGBO(82, 165, 160, 1),),
                                  ),
                                  SizedBox(height: width * 0.005),
                                  Text(
                                    //AppLocalizations.of(context)!.subject_topic,
                                      "Preview Question",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Question question = Question();
                                      question.subject=subjectController.text;
                                      question.topic=topicController.text;
                                      question.degreeStudent=degreeController.text;
                                      question.semester=semesterController.text;
                                      question.questionType=_questionTypeValue;
                                      question.question=questionController.text;
                                      question.choices=tempChoiceList;
                                      question.advisorText=adviceController.text;
                                      question.advisorUrl=urlController.text;
                                      Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(question);


                                      if(formKey.currentState!.validate() && questionFormKey.currentState!.validate()) {
                                        Navigator.pushNamed(
                                          context,
                                          '/inprogressQuestionBank',
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color.fromRGBO(82, 165, 160, 1),// <-- Button color
                                    ),
                                    child: Icon(size:width * 0.04,Icons.arrow_forward_outlined, color: Colors.white),
                                  ),
                                  SizedBox(height: width * 0.005),
                                  Text(
                                    //AppLocalizations.of(context)!.subject_topic,
                                      "Continue",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),

                    ),
                  )));
        }
        else if(constraints.maxWidth > 960)
        {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.white,
                  endDrawer: const EndDrawerMenuTeacher(),
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black,size: height * 0.05),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: height * 0.06,
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
                            //AppLocalizations.of(context)!.my_qns,
                            "New Question",
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
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.023,
                          left: height * 0.5,
                          right: height * 0.5,
                          bottom: height * 0.023
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                height: height * 0.75,
                                width: width * 0.93,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child:
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: height * 0.023,
                                        left: height * 0.023,
                                        right: height * 0.023
                                    ),
                                    child: Column(
                                      children: [
                                        showIcon==Icons.expand_circle_down_outlined?
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Wrap(
                                                children: [
                                                  Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: width * 0.02),
                                                          child: Text(
                                                            //AppLocalizations.of(context)!.subject_topic,
                                                              "Question Details",
                                                              style: TextStyle(
                                                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: height * 0.020)),
                                                        ),
                                                        // SizedBox(width: width * 0.25),
                                                        // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                        IconButton(
                                                          icon: Icon(
                                                            showIcon,
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            size: height * 0.03,
                                                          ),
                                                          onPressed: () {
                                                            changeIcon(showIcon);
                                                          },
                                                        )
                                                      ]),
                                                  const Divider(thickness: 2,),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),

                                            //Question type container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02,top: width * 0.02),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Question Type",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left:height * 0.02),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              Radio(
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                value: "MCQ", groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                              Expanded(
                                                                child: Text('MCQ',
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: height * 0.016)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              Radio(
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                value: "Survey", groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                              Expanded(
                                                                child: Text('Survey',
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: height * 0.016)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              Radio(
                                                                value: "Descriptive",
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                              Expanded(
                                                                child: Text('Descriptive',
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: height * 0.016)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),

                                            //Question container
                                            Form(
                                              key: questionFormKey,
                                              child: Container(
                                                width: width * 0.9,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(10)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top:width * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.subject_topic,
                                                          "Question",
                                                          //textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: height * 0.020)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                      child: TextFormField(
                                                        controller: questionController,
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (val) {
                                                          questionFormKey.currentState!.validate();

                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Question";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type Question here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(left: width * 0.02),
                                                    //   child: Text(
                                                    //     //AppLocalizations.of(context)!.subject_topic,
                                                    //       "Answer",
                                                    //       //textAlign: TextAlign.left,
                                                    //       style: TextStyle(
                                                    //           color: const Color.fromRGBO(28, 78, 80, 1),
                                                    //           fontFamily: 'Inter',
                                                    //           fontWeight: FontWeight.w600,
                                                    //           fontSize: height * 0.020)),
                                                    // ),
                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0)
                                                        :  _questionTypeValue=="Survey"
                                                        ? Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top:7.0),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                        :Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment.centerLeft,
                                                            //width: width * 0.11,
                                                            child: Text(
                                                              textAlign: TextAlign.right,
                                                              AppLocalizations.of(context)!.correct_answer,
                                                              //"Correct\nAnswer",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(51, 51, 51, 1),
                                                                fontSize: height * 0.014,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.11,
                                                            // child: Text(
                                                            //   AppLocalizations.of(context)!.delete,
                                                            //   textAlign: TextAlign.center,
                                                            //   //"Delete",
                                                            //   style: TextStyle(
                                                            //     color: const Color.fromRGBO(51, 51, 51, 1),
                                                            //     fontSize: height * 0.014,
                                                            //     fontFamily: "Inter",
                                                            //     fontWeight: FontWeight.w500,
                                                            //   ),
                                                            // ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0,)
                                                        : _questionTypeValue=="Survey"
                                                        ? Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          for (int i = 0; i < chooses.length; i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: height * 0.01,
                                                                  left: width * 0.02),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i),
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: height * 0.018),
                                                                      )),
                                                                  Align(
                                                                    alignment:Alignment.centerLeft,
                                                                    child: SizedBox(
                                                                      height: height * 0.01,
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
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.01,
                                                                  ),
                                                                  IconButton(
                                                                    onPressed: () {
                                                                      removeItem(i);
                                                                    },
                                                                    icon: Icon(
                                                                      size:height * 0.03,
                                                                      Icons.delete_outline,
                                                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.04,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    )
                                                        :
                                                    Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          for (int i = 0; i < chooses.length; i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: height * 0.02,
                                                                left: width * 0.02,),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i),
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: height * 0.018),
                                                                      )),
                                                                  Align(
                                                                    alignment:Alignment.centerLeft,
                                                                    child: SizedBox(
                                                                      height: height * 0.05,
                                                                      width : width * 0.18,
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
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.1,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        _onRadioChange(i);
                                                                      },
                                                                      icon: Icon(
                                                                        size:height * 0.03,
                                                                        radioList[i]
                                                                            ? Icons.radio_button_checked_outlined
                                                                            : Icons
                                                                            .radio_button_unchecked_outlined,
                                                                        color:
                                                                        const Color.fromRGBO(82, 165, 160, 1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.05,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        removeItem(i);
                                                                      },
                                                                      icon: Icon(
                                                                        size:height * 0.03,
                                                                        Icons.delete_outline,
                                                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),


                                                    _questionTypeValue=="Descriptive"
                                                        ?
                                                    SizedBox()
                                                    // Padding(
                                                    //     padding: EdgeInsets.only(left: width * 0.02,bottom: width * 0.02,right: width * 0.02),
                                                    //     child: TextField(
                                                    //         controller: answerController,
                                                    //         keyboardType: TextInputType.text,
                                                    //         decoration: InputDecoration(
                                                    //           hintStyle: TextStyle(
                                                    //               color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                    //               fontFamily: 'Inter',
                                                    //               fontWeight: FontWeight.w400,
                                                    //               fontSize: height * 0.016),
                                                    //           hintText: "Type Answer here",
                                                    //           enabledBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //           focusedBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //         )))
                                                        :
                                                    Padding(
                                                      padding: EdgeInsets.only(left:width * 0.02),
                                                      child: TextButton(
                                                        child: Text(
                                                          //AppLocalizations.of(context)!.subject_topic,
                                                          "+Add choice",
                                                          //textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(82, 165, 160, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              decoration: TextDecoration.underline,
                                                              fontSize: height * 0.020),
                                                        ),
                                                        onPressed: (){
                                                          addField();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),

                                            //Advisor Container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left:width * 0.02,top:width*0.02),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Advisor",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02,right:width * 0.02),
                                                    child: TextField(
                                                      controller: adviceController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "Suggest what to study if answered incorrectly",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02,right:width * 0.02),
                                                    child: TextField(
                                                      controller: urlController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "URL - Any reference (Optional)",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),
                                          ],
                                        )
                                            :
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Form(
                                              key: formKey,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(10)),
                                                ),
                                                child: Wrap(
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: width * 0.02),
                                                            child: Text(
                                                              //AppLocalizations.of(context)!.subject_topic,
                                                                "Question Details",
                                                                style: TextStyle(
                                                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: height * 0.020)),
                                                          ),
                                                          // SizedBox(width: width * 0.25),
                                                          // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                          IconButton(
                                                            icon: Icon(
                                                              showIcon,
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              size: height * 0.03,
                                                            ),
                                                            onPressed: () {
                                                              changeIcon(showIcon);
                                                            },
                                                          )
                                                        ]),
                                                    const Divider(thickness: 2,),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Subject",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                      child: TextFormField(
                                                        controller: subjectController,
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (val) {
                                                          formKey.currentState!.validate();

                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Subject";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Topic",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                      child: TextFormField(
                                                        controller: topicController,
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (val) {
                                                          formKey.currentState!.validate();

                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Topic";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Degree",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                      child: TextFormField(
                                                        controller: degreeController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                        onChanged: (val) {
                                                          formKey.currentState!.validate();
                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Degree";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Semester (optional)",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                      child: TextField(
                                                        controller: semesterController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: height * 0.1,)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),

                                            //Question type container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02,top: width * 0.02),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Question Type",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left:height * 0.02),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              Radio(
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                value: "MCQ", groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                              Expanded(
                                                                child: Text('MCQ',
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: height * 0.016)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              Radio(
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                value: "Survey", groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                              Expanded(
                                                                child: Text('Survey',
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: height * 0.016)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              Radio(
                                                                value: "Descriptive",
                                                                activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                groupValue: _questionTypeValue, onChanged: (value){
                                                                setState(() {
                                                                  _questionTypeValue = value.toString();
                                                                });
                                                              },),
                                                              Expanded(
                                                                child: Text('Descriptive',
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: height * 0.016)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),

                                            //Question container
                                            Form(
                                              key:questionFormKey,
                                              child: Container(
                                                width: width * 0.9,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(10)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top:width * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.subject_topic,
                                                          "Question",
                                                          //textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: height * 0.020)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,right: width * 0.02),
                                                      child: TextFormField(
                                                        controller: questionController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type Question here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                        onChanged: (val) {
                                                          questionFormKey.currentState!.validate();

                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Question";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(left: width * 0.02),
                                                    //   child: Text(
                                                    //     //AppLocalizations.of(context)!.subject_topic,
                                                    //       "Answer",
                                                    //       //textAlign: TextAlign.left,
                                                    //       style: TextStyle(
                                                    //           color: const Color.fromRGBO(28, 78, 80, 1),
                                                    //           fontFamily: 'Inter',
                                                    //           fontWeight: FontWeight.w600,
                                                    //           fontSize: height * 0.020)),
                                                    // ),
                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0)
                                                        :  _questionTypeValue=="Survey"
                                                        ?
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top:5.0),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.02,
                                                          ),
                                                          // Text(
                                                          //   AppLocalizations.of(context)!.delete,
                                                          //   //"Delete",
                                                          //   style: TextStyle(
                                                          //     color: const Color.fromRGBO(51, 51, 51, 1),
                                                          //     fontSize: height * 0.016,
                                                          //     fontFamily: "Inter",
                                                          //     fontWeight: FontWeight.w500,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    )
                                                        :
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment.center,
                                                            //width: width * 0.11,
                                                            child: Text(
                                                              textAlign: TextAlign.right,
                                                              AppLocalizations.of(context)!.correct_answer,
                                                              //"Correct\nAnswer",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(51, 51, 51, 1),
                                                                fontSize: height * 0.014,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.11,
                                                            // child: Text(
                                                            //   AppLocalizations.of(context)!.delete,
                                                            //   textAlign: TextAlign.center,
                                                            //   //"Delete",
                                                            //   style: TextStyle(
                                                            //     color: const Color.fromRGBO(51, 51, 51, 1),
                                                            //     fontSize: height * 0.014,
                                                            //     fontFamily: "Inter",
                                                            //     fontWeight: FontWeight.w500,
                                                            //   ),
                                                            // ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0,)
                                                        : _questionTypeValue=="Survey"
                                                        ?
                                                    Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          for (int i = 0; i < chooses.length; i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: height * 0.02,
                                                                  left: width * 0.02,top:height * 0.01),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i),
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: height * 0.018),
                                                                      )),
                                                                  Align(
                                                                    alignment:Alignment.centerLeft,
                                                                    child: SizedBox(
                                                                      height: height * 0.05,
                                                                      width : width * 0.18,
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
                                                                  ),
                                                                  SizedBox(width: width *0.03),
                                                                  SizedBox(
                                                                    width: width * 0.05,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        removeItem(i);
                                                                      },
                                                                      icon: Icon(
                                                                        size:height * 0.03,
                                                                        Icons.delete_outline,
                                                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    )
                                                        :
                                                    Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          for (int i = 0; i < chooses.length; i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: height * 0.02,
                                                                left: width * 0.02,),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i),
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: height * 0.018),
                                                                      )),
                                                                  Align(
                                                                    alignment:Alignment.centerLeft,
                                                                    child: SizedBox(
                                                                      height: height * 0.05,
                                                                      width : width * 0.18,
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
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.1,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        _onRadioChange(i);
                                                                      },
                                                                      icon: Icon(
                                                                        size:height * 0.03,
                                                                        radioList[i]
                                                                            ? Icons.radio_button_checked_outlined
                                                                            : Icons
                                                                            .radio_button_unchecked_outlined,
                                                                        color:
                                                                        const Color.fromRGBO(82, 165, 160, 1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.05,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        removeItem(i);
                                                                      },
                                                                      icon: Icon(
                                                                        size:height * 0.03,
                                                                        Icons.delete_outline,
                                                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),


                                                    _questionTypeValue=="Descriptive"
                                                        ?
                                                    SizedBox()
                                                    // Padding(
                                                    //     padding: EdgeInsets.only(left: width * 0.02,bottom: width * 0.02,right: width * 0.02),
                                                    //     child: TextField(
                                                    //         controller: answerController,
                                                    //         keyboardType: TextInputType.text,
                                                    //         decoration: InputDecoration(
                                                    //           hintStyle: TextStyle(
                                                    //               color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                    //               fontFamily: 'Inter',
                                                    //               fontWeight: FontWeight.w400,
                                                    //               fontSize: height * 0.016),
                                                    //           hintText: "Type Answer here",
                                                    //           enabledBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //           focusedBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //         )))
                                                        :
                                                    Padding(
                                                      padding: EdgeInsets.only(left:width * 0.02),
                                                      child: TextButton(
                                                        child: Text(
                                                          //AppLocalizations.of(context)!.subject_topic,
                                                          "+Add choice",
                                                          //textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(82, 165, 160, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              decoration: TextDecoration.underline,
                                                              fontSize: height * 0.020),
                                                        ),
                                                        onPressed: (){
                                                          addField();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),

                                            //Advisor Container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left:width * 0.02,top:width*0.02),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Advisor",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02,right:width * 0.02),
                                                    child: TextField(
                                                      controller: adviceController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "Suggest what to study if answered incorrectly",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02,right:width * 0.02),
                                                    child: TextField(
                                                      controller: urlController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "URL - Any reference (Optional)",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ),
                          ),
                          SizedBox(height:height * 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        subjectController.clear();
                                        topicController.clear();
                                        degreeController.clear();
                                        semesterController.clear();
                                        _questionTypeValue="MCQ";
                                        questionController.clear();
                                        answerController.clear();
                                        tempChoiceList=[];
                                        chooses=[];
                                        radioList=[];
                                        adviceController.clear();
                                        urlController.clear();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: Colors.white, // <-- Button color
                                    ),
                                    child: Icon(size:height * 0.05,Icons.refresh, color: const Color.fromRGBO(82, 165, 160, 1),),
                                  ),
                                  SizedBox(height: width * 0.005),
                                  Text(
                                    //AppLocalizations.of(context)!.subject_topic,
                                      "Clear All",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      bool val = true;
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
                                      finalQuestion.semester =
                                          semesterController.text;
                                      finalQuestion.degreeStudent =
                                          degreeController.text;
                                      finalQuestion.choices =
                                          tempChoiceList;
                                      finalQuestion.questionType =
                                          _questionTypeValue;
                                      if (_groupValue == 'Descriptive') {
                                        finalQuestion.choices = [];
                                      }

                                      if(_groupValue == 'MCQ') {
                                        var values = finalQuestion.choices!.where((element) => element.rightChoice == true);

                                        if(values.isEmpty)
                                        {
                                          setState(() {
                                            val = false;
                                          });
                                          showDialogBox();
                                        }
                                        // print(contain);
                                        // if(contain == false)
                                        //   {
                                        //     print("INSIDE FALSE");
                                        //   }
                                        // else if(contain == true)
                                        //   {
                                        //     print("INSIDE TRUE");
                                        //   }
                                      }

                                      if(formKey.currentState!.validate() && questionFormKey.currentState!.validate() && val == true) {
                                        showQuestionPreview(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: Colors.white, // <-- Button color
                                    ),
                                    child: Icon(size:height * 0.05,Icons.search, color: const Color.fromRGBO(82, 165, 160, 1),),
                                  ),
                                  SizedBox(height: width * 0.005),
                                  Text(
                                    //AppLocalizations.of(context)!.subject_topic,
                                      "Preview Question",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Question question = Question();
                                      question.subject=subjectController.text;
                                      question.topic=topicController.text;
                                      question.degreeStudent=degreeController.text;
                                      question.semester=semesterController.text;
                                      question.questionType=_questionTypeValue;
                                      question.question=questionController.text;
                                      question.choices=tempChoiceList;
                                      question.advisorText=adviceController.text;
                                      question.advisorUrl=urlController.text;
                                      Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(question);
                                      if(formKey.currentState!.validate() && questionFormKey.currentState!.validate()){
                                        Navigator.pushNamed(
                                          context,
                                          '/inprogressQuestionBank',
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color.fromRGBO(82, 165, 160, 1),// <-- Button color
                                    ),
                                    child: Icon(size:height * 0.05,Icons.arrow_forward_outlined, color: Colors.white),
                                  ),
                                  SizedBox(height: width * 0.005),
                                  Text(
                                    //AppLocalizations.of(context)!.subject_topic,
                                      "Continue",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),

                    ),
                  )));
        }
        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.white,
                  endDrawer: const EndDrawerMenuTeacher(),
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black,size: height * 0.05),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: height * 0.06,
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
                            //AppLocalizations.of(context)!.my_qns,
                            "New Question",
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
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                height: height * 0.7,
                                width: width * 0.93,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child:
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        showIcon==Icons.arrow_circle_down_outlined
                                            ?
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),

                                              ),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.subject_topic,
                                                          "Question Details",
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: height * 0.020)),
                                                    ),
                                                    // SizedBox(width: width * 0.25),
                                                    // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                    IconButton(
                                                      icon: Icon(
                                                        showIcon,
                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                        size: height * 0.03,
                                                      ),
                                                      onPressed: () {
                                                        changeIcon(showIcon);
                                                      },
                                                    )
                                                  ]),
                                            ),
                                            //Question type container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Question Type",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Radio(
                                                              activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                              value: "MCQ", groupValue: _questionTypeValue, onChanged: (value){
                                                              setState(() {
                                                                _questionTypeValue = value.toString();
                                                              });
                                                            },),
                                                            Expanded(
                                                              child: Text('MCQ',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.014)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Radio(
                                                              activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                              value: "Survey", groupValue: _questionTypeValue, onChanged: (value){
                                                              setState(() {
                                                                _questionTypeValue = value.toString();
                                                              });
                                                            },),
                                                            Expanded(
                                                              child: Text('Survey',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.014)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Radio(
                                                              value: "Descriptive",
                                                              activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                              groupValue: _questionTypeValue, onChanged: (value){
                                                              setState(() {
                                                                _questionTypeValue = value.toString();
                                                              });
                                                            },),
                                                            Expanded(
                                                              child: Text('Descriptive',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.014)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),

                                            //Question container
                                            Form(
                                              key:questionFormKey,
                                              child: Container(
                                                width: width * 0.9,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(10)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.subject_topic,
                                                          "Question",
                                                          //textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: height * 0.020)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                      child: TextFormField(
                                                        controller: questionController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type Question here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                        onChanged: (val) {
                                                          questionFormKey.currentState!.validate();

                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Question";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    // Padding(
                                                    //   padding: const EdgeInsets.all(8.0),
                                                    //   child: Text(
                                                    //     //AppLocalizations.of(context)!.subject_topic,
                                                    //       "Answer",
                                                    //       //textAlign: TextAlign.left,
                                                    //       style: TextStyle(
                                                    //           color: const Color.fromRGBO(28, 78, 80, 1),
                                                    //           fontFamily: 'Inter',
                                                    //           fontWeight: FontWeight.w600,
                                                    //           fontSize: height * 0.020)),
                                                    // ),
                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0)
                                                        :  _questionTypeValue=="Survey"
                                                        ? Padding(
                                                      padding: const EdgeInsets.all(8.0),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.02,
                                                          ),
                                                          // Text(
                                                          //   AppLocalizations.of(context)!.delete,
                                                          //   //"Delete",
                                                          //   style: TextStyle(
                                                          //     color: const Color.fromRGBO(51, 51, 51, 1),
                                                          //     fontSize: height * 0.016,
                                                          //     fontFamily: "Inter",
                                                          //     fontWeight: FontWeight.w500,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    )
                                                        :Padding(
                                                      padding: const EdgeInsets.all(8.0),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.13,
                                                            child: Text(
                                                              textAlign: TextAlign.right,
                                                              AppLocalizations.of(context)!.correct_answer,
                                                              //"Correct\nAnswer",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(51, 51, 51, 1),
                                                                fontSize: height * 0.014,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.11,
                                                            // child: Text(
                                                            //   AppLocalizations.of(context)!.delete,
                                                            //   textAlign: TextAlign.center,
                                                            //   //"Delete",
                                                            //   style: TextStyle(
                                                            //     color: const Color.fromRGBO(51, 51, 51, 1),
                                                            //     fontSize: height * 0.014,
                                                            //     fontFamily: "Inter",
                                                            //     fontWeight: FontWeight.w500,
                                                            //   ),
                                                            // ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0,)
                                                        : _questionTypeValue=="Survey"
                                                        ? Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          for (int i = 0; i < chooses.length; i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: height * 0.02,
                                                                left: 8,),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i))),
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
                                                                  SizedBox(
                                                                    width: width * 0.04,
                                                                  ),
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
                                                                left: 8,),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i))),
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
                                                                    width: width * 0.13,
                                                                    child: IconButton(
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
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.11,
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


                                                    _questionTypeValue=="Descriptive"
                                                        ?
                                                    SizedBox()
                                                    // Padding(
                                                    //     padding: EdgeInsets.only(left: width * 0.02,bottom: width * 0.02),
                                                    //     child: TextField(
                                                    //         controller: answerController,
                                                    //         keyboardType: TextInputType.text,
                                                    //         decoration: InputDecoration(
                                                    //           hintStyle: TextStyle(
                                                    //               color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                    //               fontFamily: 'Inter',
                                                    //               fontWeight: FontWeight.w400,
                                                    //               fontSize: height * 0.016),
                                                    //           hintText: "Type Answer here",
                                                    //           enabledBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //           focusedBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //         )))
                                                        :
                                                    TextButton(
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.subject_topic,
                                                        "+Add choice",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            decoration: TextDecoration.underline,
                                                            fontSize: height * 0.020),
                                                      ),
                                                      onPressed: (){
                                                        addField();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),

                                            //Advisor Container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Advisor",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02),
                                                    child: TextField(
                                                      controller: adviceController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "Suggest what to study if answered incorrectly",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02),
                                                    child: TextField(
                                                      controller: urlController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "URL - Any reference (Optional)",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),

                                          ],
                                        )
                                            :
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Form(
                                              key: formKey,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                  // borderRadius: BorderRadius.all(
                                                  //     Radius.circular(10)),
                                                ),
                                                child: Wrap(
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: width * 0.02),
                                                            child: Text(
                                                              //AppLocalizations.of(context)!.subject_topic,
                                                                "Question Details",
                                                                style: TextStyle(
                                                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: height * 0.020)),
                                                          ),
                                                          // SizedBox(width: width * 0.25),
                                                          // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                          IconButton(
                                                            icon: Icon(
                                                              showIcon,
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              size: height * 0.03,
                                                            ),
                                                            onPressed: () {
                                                              changeIcon(showIcon);
                                                            },
                                                          )
                                                        ]),
                                                    const Divider(thickness: 2,),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Subject",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                      child: TextFormField(
                                                        controller: subjectController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                        onChanged: (val) {
                                                          formKey.currentState!.validate();

                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Subject";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Topic",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                      child: TextFormField(
                                                        controller: topicController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                        onChanged: (val) {
                                                          formKey.currentState!.validate();
                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Topic";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Degree",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                      child: TextFormField(
                                                        controller: degreeController,
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (val) {
                                                          formKey.currentState!.validate();
                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Degree";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                        "Semester (optional)",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                          fontSize: height * 0.02,
                                                          fontFamily: "Inter",
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                      child: TextField(
                                                        controller: semesterController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: height * 0.1,)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),

                                            //Question type container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Question Type",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Radio(
                                                              activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                              value: "MCQ", groupValue: _questionTypeValue, onChanged: (value){
                                                              setState(() {
                                                                _questionTypeValue = value.toString();
                                                              });
                                                            },),
                                                            Expanded(
                                                              child: Text('MCQ',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.014)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Radio(
                                                              activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                              value: "Survey", groupValue: _questionTypeValue, onChanged: (value){
                                                              setState(() {
                                                                _questionTypeValue = value.toString();
                                                              });
                                                            },),
                                                            Expanded(
                                                              child: Text('Survey',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.014)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            Radio(
                                                              value: "Descriptive",
                                                              activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                              groupValue: _questionTypeValue, onChanged: (value){
                                                              setState(() {
                                                                _questionTypeValue = value.toString();
                                                              });
                                                            },),
                                                            Expanded(
                                                              child: Text('Descriptive',
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: height * 0.014)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),

                                            //Question container
                                            Form(
                                              key:questionFormKey,
                                              child: Container(
                                                width: width * 0.9,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.subject_topic,
                                                          "Question",
                                                          //textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: height * 0.020)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                      child: TextFormField(
                                                        controller: questionController,
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (val) {
                                                          questionFormKey.currentState?.validate();
                                                        },
                                                        validator: (value) {
                                                          if (value == "")
                                                          {
                                                            return "Enter Question";
                                                          } else {
                                                            return null;
                                                          }
                                                        } ,
                                                        decoration: InputDecoration(
                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                          hintStyle: TextStyle(
                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                          hintText: "Type Question here",
                                                          enabledBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          focusedBorder: const UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                          ),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: const BorderSide(
                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                          // border: OutlineInputBorder(
                                                          //     borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    // Padding(
                                                    //   padding: const EdgeInsets.all(8.0),
                                                    //   child: Text(
                                                    //     //AppLocalizations.of(context)!.subject_topic,
                                                    //       "Answer",
                                                    //       //textAlign: TextAlign.left,
                                                    //       style: TextStyle(
                                                    //           color: const Color.fromRGBO(28, 78, 80, 1),
                                                    //           fontFamily: 'Inter',
                                                    //           fontWeight: FontWeight.w600,
                                                    //           fontSize: height * 0.020)),
                                                    // ),
                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0)
                                                        :  _questionTypeValue=="Survey"
                                                        ? Padding(
                                                      padding: const EdgeInsets.all(8.0),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.02,
                                                          ),
                                                          // Text(
                                                          //   AppLocalizations.of(context)!.delete,
                                                          //   //"Delete",
                                                          //   style: TextStyle(
                                                          //     color: const Color.fromRGBO(51, 51, 51, 1),
                                                          //     fontSize: height * 0.016,
                                                          //     fontFamily: "Inter",
                                                          //     fontWeight: FontWeight.w500,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    )
                                                        :Padding(
                                                      padding: const EdgeInsets.all(8.0),
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
                                                                  fontSize: height * 0.014,
                                                                  fontFamily: "Inter",
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.13,
                                                            child: Text(
                                                              textAlign: TextAlign.right,
                                                              AppLocalizations.of(context)!.correct_answer,
                                                              //"Correct\nAnswer",
                                                              style: TextStyle(
                                                                color: const Color.fromRGBO(51, 51, 51, 1),
                                                                fontSize: height * 0.014,
                                                                fontFamily: "Inter",
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.11,
                                                            // child: Text(
                                                            //   AppLocalizations.of(context)!.delete,
                                                            //   textAlign: TextAlign.center,
                                                            //   //"Delete",
                                                            //   style: TextStyle(
                                                            //     color: const Color.fromRGBO(51, 51, 51, 1),
                                                            //     fontSize: height * 0.014,
                                                            //     fontFamily: "Inter",
                                                            //     fontWeight: FontWeight.w500,
                                                            //   ),
                                                            // ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    _questionTypeValue=="Descriptive"
                                                        ? const SizedBox(height: 0,)
                                                        : _questionTypeValue=="Survey"
                                                        ?
                                                    Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          for (int i = 0; i < chooses.length; i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: height * 0.02,
                                                                left: 8,),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i))),
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
                                                                  SizedBox(
                                                                    width: width * 0.04,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    )
                                                        :
                                                    Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          for (int i = 0; i < chooses.length; i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: height * 0.02,
                                                                left: 8,),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  SizedBox(
                                                                      width: width * 0.05,
                                                                      child: Text(String.fromCharCode(97+i))),
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
                                                                    width: width * 0.13,
                                                                    child: IconButton(
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
                                                                  ),
                                                                  SizedBox(
                                                                    width: width * 0.11,
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


                                                    _questionTypeValue=="Descriptive"
                                                        ?
                                                    SizedBox()
                                                    // Padding(
                                                    //     padding: EdgeInsets.only(left: width * 0.02,bottom: width * 0.02),
                                                    //     child: TextField(
                                                    //         controller: answerController,
                                                    //         keyboardType: TextInputType.text,
                                                    //         decoration: InputDecoration(
                                                    //           hintStyle: TextStyle(
                                                    //               color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                    //               fontFamily: 'Inter',
                                                    //               fontWeight: FontWeight.w400,
                                                    //               fontSize: height * 0.016),
                                                    //           hintText: "Type Answer here",
                                                    //           enabledBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //           focusedBorder: const UnderlineInputBorder(
                                                    //             borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                    //           ),
                                                    //         )))
                                                        :
                                                    TextButton(
                                                      child: Text(
                                                        //AppLocalizations.of(context)!.subject_topic,
                                                        "+Add choice",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            decoration: TextDecoration.underline,
                                                            fontSize: height * 0.020),
                                                      ),
                                                      onPressed: (){
                                                        addField();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),

                                            //Advisor Container
                                            Container(
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                                // borderRadius: BorderRadius.all(
                                                //     Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      //AppLocalizations.of(context)!.subject_topic,
                                                        "Advisor",
                                                        //textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: height * 0.020)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02),
                                                    child: TextField(
                                                      controller: adviceController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "Suggest what to study if answered incorrectly",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: width * 0.02),
                                                    child: TextField(
                                                      controller: urlController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                        hintText: "URL - Any reference (Optional)",
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                        ),
                                                        // focusedBorder: OutlineInputBorder(
                                                        //     borderSide: const BorderSide(
                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.circular(15)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ),
                          ),
                          SizedBox(height:height * 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        subjectController.clear();
                                        topicController.clear();
                                        degreeController.clear();
                                        semesterController.clear();
                                        _questionTypeValue="MCQ";
                                        questionController.clear();
                                        answerController.clear();
                                        tempChoiceList=[];
                                        chooses=[];
                                        radioList=[];
                                        adviceController.clear();
                                        urlController.clear();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: Colors.white, // <-- Button color
                                    ),
                                    child: const Icon(Icons.refresh, color: Color.fromRGBO(82, 165, 160, 1),),
                                  ),
                                  Text(
                                    //AppLocalizations.of(context)!.subject_topic,
                                      "Clear All",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      bool val = true;
                                      finalQuestion.question = questionController.text;
                                      finalQuestion.advisorText = adviceController.text;
                                      finalQuestion.advisorUrl = urlController.text;
                                      finalQuestion.subject = subjectController.text;
                                      finalQuestion.topic = topicController.text;
                                      finalQuestion.semester = semesterController.text;
                                      finalQuestion.degreeStudent = degreeController.text;
                                      finalQuestion.choices = tempChoiceList;
                                      finalQuestion.questionType = _questionTypeValue;

                                      if (_groupValue == 'Descriptive') {
                                        finalQuestion.choices = [];
                                      }
                                      if(_groupValue == 'MCQ') {
                                         var values = finalQuestion.choices!.where((element) => element.rightChoice == true);

                                          if(values.isEmpty)
                                            {
                                              setState(() {
                                                val = false;
                                              });
                                             showDialogBox();
                                            }
                                          // print(contain);
                                          // if(contain == false)
                                          //   {
                                          //     print("INSIDE FALSE");
                                          //   }
                                          // else if(contain == true)
                                          //   {
                                          //     print("INSIDE TRUE");
                                          //   }
                                        }

                                      if(formKey.currentState!.validate() && questionFormKey.currentState!.validate() && val == true) {
                                        showQuestionPreview(context);
                                      }

                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: Colors.white, // <-- Button color
                                    ),
                                    child: const Icon(Icons.search, color: Color.fromRGBO(82, 165, 160, 1),),
                                  ),
                                  Text(
                                    //AppLocalizations.of(context)!.subject_topic,
                                      "Preview Question",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Question question = Question();
                                      question.subject=subjectController.text;
                                      question.topic=topicController.text;
                                      question.degreeStudent=degreeController.text;
                                      question.semester=semesterController.text;
                                      question.questionType=_questionTypeValue;
                                      question.question=questionController.text;
                                      question.choices=tempChoiceList;
                                      question.advisorText=adviceController.text;
                                      question.advisorUrl=urlController.text;
                                      Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(question);
                                     
                                      if(formKey.currentState!.validate() && questionFormKey.currentState!.validate()) {
                                        Navigator.pushNamed(
                                          context,
                                          '/inprogressQuestionBank',
                                        );
                                      }

                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color.fromRGBO(82, 165, 160, 1),// <-- Button color
                                    ),
                                    child: const Icon(Icons.arrow_forward_outlined, color: Colors.white),
                                  ),
                                  Text(
                                    //AppLocalizations.of(context)!.subject_topic,
                                      "Continue",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),

                    ),
                  )));
        }
      },
    );
  }

  changeIcon(IconData pramIcon) {
    if (pramIcon == Icons.arrow_circle_down_outlined) {
      setState(() {
        showIcon = Icons.arrow_circle_up_outlined;
      });
    } else {
      setState(() {
        showIcon = Icons.arrow_circle_down_outlined;
      });
    }
  }

  _onRadioChange(int key) {
    setState(() {
      radioList[key] = !radioList[key];
      tempChoiceList[key].rightChoice = radioList[key];
    });
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) =>  AlertDialog(
        title: Text(
          "Alert",
          //"NO CONNECTION",
          style: const TextStyle(
            color: Color.fromRGBO(82, 165, 160, 1),
            fontSize: 25,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          "Please enter one correct choice",
          //"Please check your internet connectivity",
          style: const TextStyle(
            color: Color.fromRGBO(82, 165, 160, 1),
            fontSize: 16,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          const SizedBox(width: 400 * 0.020),
          Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color.fromRGBO(255, 255, 255, 1),
                  minimumSize: const Size(90, 30),
                  side: const BorderSide(
                    width: 1.5,
                    color: Color.fromRGBO(82, 165, 160, 1),
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.ok_caps,
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 400 * 0.018,
                        color:
                        Color.fromRGBO(82, 165, 160, 1),
                        fontWeight: FontWeight.w500)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
          const SizedBox(width: 400 * 0.005),
        ],
      ));
}
